#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/fcntl.h>
#include <libgen.h>
#include <dirent.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/syscall.h>
#include <sys/user.h>
#include <string.h>
#include <errno.h>
#include "proc.h"
#include <libunwind-ptrace.h>

#define MAX_ERRNO 4095


void copy_regs(struct user_regs_struct *dst,
			   struct user_regs_struct *src)
{
#define COPY_REG(x) dst->x = src->x
	COPY_REG(r15);
	COPY_REG(r14);
	COPY_REG(r13);
	COPY_REG(r12);
	COPY_REG(rbp);
	COPY_REG(rbx);
	COPY_REG(r11);
	COPY_REG(r10);
	COPY_REG(r9);
	COPY_REG(r8);
	COPY_REG(rax);
	COPY_REG(rcx);
	COPY_REG(rdx);
	COPY_REG(rsi);
	COPY_REG(rdi);
#undef COPY_REG
}
/*
 * Locks process by opening /proc/<pid>/maps
 * This ensures that task_struct will not be
 * deleted in the kernel while we are working with
 * the process
 */
static int lock_process(int pid)
{
	int fd;
	char path[128];

	snprintf(path, sizeof(path), "/proc/%d/maps", pid);
	fd = open(path, O_RDONLY);
	if (fd < 0)
	{
		printf("cannot open '/proc/%d/maps'\n", pid);
		return -1;
	}
	return fd;
}

static unsigned int perms2prot(const char *perms)
{
	unsigned int prot = 0;

	if (perms[0] == 'r')
		prot |= PROT_READ;
	if (perms[1] == 'w')
		prot |= PROT_WRITE;
	if (perms[2] == 'x')
		prot |= PROT_EXEC;
	/* Ignore 'p'/'s' flag, we don't need it */
	return prot;
}

static struct vm_hole *process_add_vm_hole(process *proc,
										   unsigned long hole_start,
										   unsigned long hole_end)
{
	struct vm_hole *hole;

	hole = malloc(sizeof(*hole));
	if (hole == NULL)
		return NULL;

	memset(hole, 0, sizeof(*hole));
	hole->start = hole_start;
	hole->end = hole_end;

	list_add(&hole->list, &proc->vmaholes);

	return hole;
}

/*给proc的pid，fdmaps，is_,sendfd赋值，初始化三个表，num_objs=0*/
int process_init(process *proc,int pid)
{
	int fdmaps;

	fdmaps = lock_process(pid);
	if (fdmaps < 0)
		return -1;

	memset(proc, 0, sizeof(*proc));

	proc->pid = pid;
	proc->fdmaps = fdmaps;
	proc->memfd = -1;

	list_init(&proc->ptrace.pctxs);
	list_init(&proc->objs);
	list_init(&proc->vmaholes);
	proc->num_objs = 0;

	return 0;
}

/*把proc的memfd真正open打开/proc/pid/mem，mode是MEM_WRITE （值为1）就读写打开，不然只读打开*/
int process_mem_open(process *proc, int mode)
{
	char path[sizeof("/proc/0123456789/mem")];

	if (proc->memfd >= 0)
	{
		close(proc->memfd);
	}

	snprintf(path, sizeof(path), "/proc/%d/mem", proc->pid);
	proc->memfd = open(path, mode == MEM_WRITE ? O_RDWR : O_RDONLY);
	if (proc->memfd < 0)
	{
		printf("can't open /proc/%d/mem", proc->pid);
		return -1;
	}

	return 0;
}

/*打开proc/pid/task目录，遍历所有tid目录，把tid放到ppids数组里面，会根据大小重新分配ppids空间
返回npids地址也就是线程数*/
static int process_list_threads(process *proc,
								int **ppids,
								size_t *npids,
								size_t *alloc)
{
	DIR *dir = NULL;
	struct dirent *de;
	char path[128];
	int *pids = *ppids;

	snprintf(path, sizeof(path), "/proc/%d/task", proc->pid);
	dir = opendir(path);
	if (!dir)
	{
		goto dealloc;
	}

	*npids = 0;
	while ((de = readdir(dir)))
	{
		int *t;
		if (de->d_name[0] == '.')
			continue;

		if (*npids >= *alloc)
		{
			*alloc = *alloc ? *alloc * 2 : 1;

			t = realloc(pids, *alloc * sizeof(*pids));
			if (t == NULL)
			{
				printf("Failed to (re)allocate memory for pids\n");
				goto dealloc;
			}

			pids = t;
		}

		pids[*npids] = atoi(de->d_name);
		(*npids)++;
	}
	closedir(dir);

	*ppids = pids;

	return *npids;

dealloc:
	if (dir)
		closedir(dir);
	free(pids);
	*ppids = NULL;
	*alloc = *npids = 0;
	return -1;
}

/*在proc->ptrace.pctxs中找有没有pid，找到返回1，不然返回0*/
static int process_has_thread_pid(process *proc, int pid)
{
	struct ptrace_ctx *pctx;

	list_for_each_entry(pctx, &proc->ptrace.pctxs, list)
	{
		if (pctx->pid == pid)
			return 1;
	}
	return 0;
}

/*看样子创建了个kpatch_ptrace_ctx,把proc添加到了p->proc,返回了p,还把p->list添加进了proc->ptrace.pctxs*/
static struct ptrace_ctx *ptrace_ctx_alloc(process *proc)
{
	struct ptrace_ctx *p;

	p = malloc(sizeof(*p));
	if (!p)
		return NULL;
	memset(p, 0, sizeof(*p));

	p->execute_until = 0UL;
	p->running = 1;
	p->proc = proc;

	list_init(&p->list);
	list_add(&p->list, &proc->ptrace.pctxs);
	return p;
}

/*
*创建了个kpatch_ptrace_ctx,把proc添加到了p->proc,返回了p,还把p->list添加进了proc->ptrace.pctxs
*用patrce跟踪线程，它会向子进程发送SIGSTOP信号，于是我们可以察看和修改子进程。等待线程停止，跳出循环。
*函数结束
*/
int kpatch_ptrace_attach_thread(process *proc, int tid)
{
	long ret;
	int status;
	struct ptrace_ctx *pctx;

	pctx = ptrace_ctx_alloc(proc);
	if (pctx == NULL)
	{
		printf("Can't alloc kpatch_ptrace_ctx");
		return -1;
	}

	pctx->pid = tid;
	printf("Attaching to %d...", pctx->pid);

	ret = ptrace(PTRACE_ATTACH, pctx->pid, NULL, NULL);
	if (ret < 0)
	{
		printf("can't attach to %d\n", pctx->pid);
		return -1;
	}

	do
	{
		ret = waitpid(tid, &status, __WALL);
		if (ret < 0)
		{
			printf("can't wait for thread\n");
			return -1;
		}

		/* We are expecting SIGSTOP */
		if (WIFSTOPPED(status) && WSTOPSIG(status) == SIGSTOP)
			break;

		/* If we got SIGTRAP because we just got out of execve, wait
		 * for the SIGSTOP
		 */
		if (WIFSTOPPED(status))
			status = (WSTOPSIG(status) == SIGTRAP) ? 0 : WSTOPSIG(status);
		else if (WIFSIGNALED(status))
			/* Resend signal */
			status = WTERMSIG(status);
		//让目标进程继续执行
		ret = ptrace(PTRACE_CONT, pctx->pid, NULL,(void *)(uintptr_t)status);

		if (ret < 0)
		{
			printf("can't cont tracee\n");
			return -1;
		}
	} while (1);

	pctx->running = 0;

	printf("OK\n");
	return 0;
}


int process_parse_proc_maps(process *proc)
{
	FILE *f;
	
	int fd, is_libc_base_set = 0;
	unsigned long hole_start = 0;
	struct vm_hole *hole = NULL;

	fd = dup(proc->fdmaps);
	if (fd < 0)
	{
		printf("unable to dup fd %d", proc->fdmaps);
		return -1;
	}

	lseek(fd, 0, SEEK_SET);
	f = fdopen(fd, "r");
	if (f == NULL)
	{
		printf("unable to fdopen %d", fd);
		close(fd);
		return -1;
	}

	do
	{
		char line[1024];
		unsigned long start, end, offset;
		unsigned int maj, min, inode;
		char perms[5], name_[256], *name = name_;
		int r;

		if (!fgets(line, sizeof(line), f))
			break;
		r = sscanf(line, "%lx-%lx %s %lx %x:%x %d %255s",
				   &start, &end, perms, &offset,
				   &maj, &min, &inode, name_);
		if (r == EOF)
		{
			printf("sscanf failed: end of file");
			goto error;
		}
		if (r != 8)
			strcpy(name, "[anonymous]");

		/* Hole must be at least 2 pages for guardians */
		if (start - hole_start > 2 * PAGE_SIZE)
		{
			hole = process_add_vm_hole(proc,
									   hole_start + PAGE_SIZE,
									   start - PAGE_SIZE);
			if (hole == NULL)
			{
				printf("Failed to add vma hole");
				goto error;
			}
		}
		hole_start = end;

		name = name[0] == '/' ? basename(name) : name;

		if (!is_libc_base_set &&
			!strncmp(basename(name), "libc", 4) &&
			perms2prot(perms) & PROT_EXEC)
		{
			proc->libc_base = start; //get libc start
			is_libc_base_set = 1;
		}

	} while (1);
	fclose(f);

	if (!is_libc_base_set)
	{
		printf("Can't find libc_base required for manipulations: %d",proc->pid);
		return -1;
	}

	return 0;

error:
	fclose(f);
	return -1;
}

int process_attach(process *proc)
{
	int *pids = NULL, ret;
	size_t i, npids = 0, alloc = 0, prevnpids = 0, nattempts;

	if (process_mem_open(proc, MEM_WRITE) < 0)
		return -1;

	for (nattempts = 0; nattempts < 3; nattempts++)
	{
		ret = process_list_threads(proc, &pids, &npids, &alloc);
		if (ret == -1)
			goto detach;

		if (nattempts == 0)
		{
			printf("Found %lu thread(s), attaching...\n", npids);
		}
		else
		{
			if (prevnpids == npids)
				break;
		}

		if ( npids > 1 )
		{
			printf("ERROR: nr > 1\n");
			goto dealloc;
		}
		//这是在遍历线程了
		for (i = prevnpids; i < npids; i++)
		{
			int pid = pids[i];
			//找到了换下一个
			if (process_has_thread_pid(proc, pid))
			{
				continue;
			}
			//如果没有找到
			ret = kpatch_ptrace_attach_thread(proc, pid);
			if (ret < 0)
				goto detach;
		}

		prevnpids = npids;
	}

	if (nattempts == 3)
	{
		printf("unable to catch up with process, bailing\n");
		goto detach;
	}

	printf("attached to %lu thread(s): %d", npids, pids[0]);
	for (i = 1; i < npids; i++)
		printf(", %d", pids[i]);
	printf("\n");

	free(pids);
	return 0;

detach:
	//process_detach(proc);
dealloc:
	free(pids);
	return -1;
}

int wait_for_stop(struct ptrace_ctx *pctx,
				  const void *data)
{
	int ret, status = 0, pid = (int)(uintptr_t)data ?: pctx->pid;

	while (1)
	{
		ret = ptrace(PTRACE_CONT, pctx->pid, NULL,
					 (void *)(uintptr_t)status);
		if (ret < 0)
		{
			printf("can't start tracee %d\n", pctx->pid);
			return -1;
		}

		ret = waitpid(pid, &status, __WALL);
		if (ret < 0)
		{
			printf("can't wait tracee %d\n", pid);
			return -1;
		}

		if (WIFSTOPPED(status))
		{
			if (WSTOPSIG(status) == SIGSTOP ||
				WSTOPSIG(status) == SIGTRAP)
				break;
			status = WSTOPSIG(status);
			continue;
		}

		status = WIFSIGNALED(status) ? WTERMSIG(status) : 0;
	}

	return 0;
}


static int process_mem_write_ptrace(process *proc,
										   void *src,
										   unsigned long dst,
										   size_t size)
{
	int ret;

	while (ROUND_DOWN(size, sizeof(long)) != 0)
	{
		ret = ptrace(PTRACE_POKEDATA, proc->pid, dst,
					 *(unsigned long *)src);
		if (ret)
			return -1;

		dst += sizeof(long);
		src += sizeof(long);
		size -= sizeof(long);
	}

	if (size)
	{
		unsigned long tmp;

		tmp = ptrace(PTRACE_PEEKDATA, proc->pid, dst, NULL);
		if (tmp == (unsigned long)-1 && errno)
			return -1;
		memcpy(&tmp, src, size);

		ret = ptrace(PTRACE_POKEDATA, proc->pid, dst, tmp);
		if (ret)
			return -1;
	}

	return 0;
}

int process_mem_read(process *proc,
							unsigned long src,
							void *dst,
							size_t size)
{
	ssize_t r;

	r = pread(proc->memfd, dst, size, (off_t)src);

	return r != size ? -1 : 0;
}


//用了pwrite,从src写size个字节到proc->memfd的dst偏移处
int process_mem_write(process *proc,
							 void *src,
							 unsigned long dst,
							 size_t size)
{
	static int use_pwrite = 1;
	ssize_t w;

	if (use_pwrite)
		w = pwrite(proc->memfd, src, size, (off_t)dst);
	if (w == -1 && errno == EINVAL)
	{
		use_pwrite = 0;
		return process_mem_write_ptrace(proc, src, dst, size);
	}

	return w != size ? -1 : 0;
}

int execute_remote_func(struct ptrace_ctx *pctx,
									const unsigned char *code,
									size_t codelen,
									struct user_regs_struct *pregs,
									int (*func)(struct ptrace_ctx *pctx, const void *data),
									const void *data)
{
	//porc里的第一个ptrace.pctx，syscal数组，数组长，一堆信息
	//code里就仨字节0x0f 0x05 0xcc codelen是3
	/*regs.rax = __NR_mmap(9);
	regs.rdi = 第一个vmaholes里的第一个地址;
	regs.rsi = 文件大小;
	regs.rdx = 读写执行;
	regs.r10 = MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS;
	regs.r8 = -1;
	regs.r9 = 0;*/ 
	//func 是wait_for_stop
	//data是NULL
	struct user_regs_struct orig_regs, regs;
	unsigned char orig_code[codelen];
	int ret;
	process *proc = pctx->proc;
	unsigned long libc_base = proc->libc_base;

	
	ret = ptrace(PTRACE_GETREGS, pctx->pid, NULL, &orig_regs);

	if (ret < 0)
	{
		printf("can't get regs - %d\n", pctx->pid);
		return -1;
	}
    
	/*read*/
	ret = process_mem_read(proc, libc_base, (unsigned long *)orig_code, codelen);

	if (ret < 0)
	{
		printf("can't peek original code - %d\n", pctx->pid);
		return -1;
	}
	//显然是把那仨字节写进libc_base偏移去了
	ret = process_mem_write(proc,(unsigned long *)code,libc_base,codelen);
	if (ret < 0)
	{
		printf("can't poke syscall code - %d\n", pctx->pid);
		goto poke_back;
	}

	regs = orig_regs;
	regs.rip = libc_base;
	//libc的起始地址放了个0x0f 0x05 0xcc

	copy_regs(&regs, pregs);

	ret = ptrace(PTRACE_SETREGS, pctx->pid, NULL, &regs);
	if (ret < 0)
	{
		printf("can't set regs - %d\n", pctx->pid);
		goto poke_back;
	}

	func(pctx, data);


	ptrace(PTRACE_GETREGS, pctx->pid, NULL, &regs);

	ptrace(PTRACE_SETREGS, pctx->pid, NULL, &orig_regs);


	*pregs = regs;

poke_back:
	process_mem_write(proc,(unsigned long *)orig_code,libc_base,codelen);//又把他原来的写回去了
	return ret;
}

int arch_syscall_remote(struct ptrace_ctx *pctx, int nr,
							   unsigned long arg1, unsigned long arg2, unsigned long arg3,
							   unsigned long arg4, unsigned long arg5, unsigned long arg6,
							   unsigned long *res)
{	//porc里的第一个ptrace.pctx， __NR_mmap(9),第一个vmaholes里的第一个地址，文件大小，读写执行，
	//MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS，-1,0,res里的值为0

	/*regs.rax = __NR_mmap(9);
	regs.rdi = 第一个vmaholes里的第一个地址;
	regs.rsi = 文件大小;
	regs.rdx = 读写执行;
	regs.r10 = MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS;
	regs.r8 = -1;
	regs.r9 = 0;*/
	struct user_regs_struct regs;

	unsigned char syscall[] = {
		0x0f, 0x05, /* syscall */
		0xcc,		/* int3 */
	};
	int ret;

	memset(&regs, 0, sizeof(struct user_regs_struct));
	
	regs.rax = (unsigned long)nr;
	regs.rdi = arg1;
	regs.rsi = arg2;
	regs.rdx = arg3;
	regs.r10 = arg4;
	regs.r8 = arg5;
	regs.r9 = arg6;

	ret = execute_remote_func(pctx, syscall, sizeof(syscall), &regs,wait_for_stop,NULL);
	if (ret == 0)
		*res = regs.rax;

	return ret;
}


unsigned long mmap_remote(struct ptrace_ctx *pctx,
								 unsigned long addr,
								 size_t length,
								 int prot,
								 int flags,
								 int fd,
								 off_t offset)
{	//porc里的第一个ptrace.pctx，第一个vmaholes里的第一个地址，文件大小，读写执行，
	//MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS，-1,0
	int ret;
	unsigned long res = 0;

	ret = arch_syscall_remote(pctx, __NR_mmap, (unsigned long)addr,
									 length, prot, flags, fd, offset, &res);
	if (ret < 0)
		return 0;
	if (ret == 0 && res >= (unsigned long)-MAX_ERRNO)
	{
		errno = -(long)res;
		return 0;
	}

	//返回patch_start
	return res;
}

int p_allocate(process *proc, size_t sz)
{
	unsigned long addr = list_first_entry(&(proc)->vmaholes,struct vm_hole, list)
							 ->end - sz + PAGE_SIZE;

	if (!addr)
		return -1;

	addr = mmap_remote(proc2pctx(proc),
						addr, sz,
						PROT_READ | PROT_WRITE | PROT_EXEC,
						MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (addr == 0)
	{
		printf("remote alloc memory for patch failed\n");
		return -1;
	}
	//patch_target = addr;
	//patch_start = addr;
	//patch_end = patch_start + sz;
	return 0;
}