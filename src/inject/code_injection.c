#include <features.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <elf.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/user.h>
#include <sys/ptrace.h>
#include <sys/mman.h>
#include <sys/fcntl.h>
#include <sys/wait.h>
#include <linux/limits.h>

extern int errno;

unsigned long long Base_address;

#define WORD_ALIGN(x) ((x + 7) & ~7)

typedef struct handle
{
    Elf64_Phdr *phdr;
    Elf64_Ehdr *ehdr;
    Elf64_Shdr *shdr;
    uint8_t *mem;
    char *exec;
    struct user_regs_struct user_reg;
} handle_t;

void pid_block_write(pid_t pid, void *addr_dst, void * p_res, u_int64_t u64_len);
void * pid_block_read(pid_t pid, void *addr_res, u_int64_t u64_len);

int wait_for_stop(int pid_t)
{
	int ret, status = 0, pid = pid_t;

	while (1)
	{
		ret = ptrace(PTRACE_CONT, pid, NULL,
					 (void *)(uintptr_t)status);
		if (ret < 0)
		{
			printf("can't start tracee %d\n", pid);
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

long set_breakpoint(pid_t pid, void *addr) {
    long data = ptrace(PTRACE_PEEKTEXT, pid, addr, NULL);
    if (data == -1) {
        perror("ptrace");
        exit(1);
    }

    // 保存原始指令并设置断点指令
    long int3 = (data & ~0xff) | 0xcc;
    if (ptrace(PTRACE_POKETEXT, pid, addr, int3) == -1) {
        perror("ptrace");
        exit(1);
    }
    return data;
}

void restore_instruction(pid_t pid, void *addr, long original_data) {
    if (ptrace(PTRACE_POKETEXT, pid, addr, original_data) == -1) {
        perror("ptrace");
        exit(1);
    }
}

// Injection code run for create engouth memeory to insert the sepecify elf file.
void injection_code(void * addr)//void * addr
{
    // Soft breakpoint
    asm volatile ("int3");
}
void foo2(){}

uint64_t get_injection_code_size()
{
    // calculate the injection_code size.
    return (u_int64_t)((u_int8_t *)foo2 - (u_int8_t *)injection_code);
}

// Create injection code.
void *create_injection_code()
{
    void *p_injection_code;
    // apply memory for inject code.
    p_injection_code = malloc(get_injection_code_size());// + 8
    // copy the injection code to destination memory.
    memcpy(p_injection_code, injection_code, get_injection_code_size());

    return p_injection_code;
}

int main(int argn, char **argv, char **envp)
{
    int fd, pid, i, j, stat;
    u_int8_t *p_origin_code;
    void *p_injection_code;
    handle_t h;
    struct stat st;
    u_int64_t addr_text;
    char *endptr;
    unsigned long start_addr;  //程序起始地址
    if (argn < 5) {
        printf("Usage: %s <pid> <inserted_program>\n", argv[0]);
        exit(0);
    }
    FILE *file;
    unsigned long long number;
    unsigned offset;
    // 打开文件
    file = fopen("/home/work/code/src/table/jump_table", "r");
    if (file == NULL) {
        perror("Error opening file");
        return -1;
    }

    // 读取第一个数字
    if (fscanf(file, "%llx %x", &number, &offset) != 2) {
        printf("Error reading number\n");
        fclose(file);
        return -1;
    }

    // 关闭文件
    fclose(file);
    Base_address = number + 0x1000;

    pid = atoi(argv[1]);
    h.exec = strdup(argv[2]);
    char maps_path[256];
    snprintf(maps_path, sizeof(maps_path), "/proc/%d/maps", pid);
    FILE* maps_file = fopen(maps_path, "r");

    char buf[256];
    if (!fgets(buf, sizeof(buf), maps_file)) {
        perror("fgets");
        exit(1);
    }

    // 读取第二行
    if (!fgets(buf, sizeof(buf), maps_file)) {
        perror("fgets");
        exit(1);
    }
    
    sscanf(buf, "%lx-",&start_addr);
    //-------------------------------------------------------------------------
    // Open specify ELF file.
    fd = open(h.exec, O_RDONLY);
    // Read file status.
    if (fstat(fd, &st)) { //使用 fstat 函数获取文件描述符 fd 所指向文件的信息，并将其存储在 st 结构体中。
        perror("fstat");
        exit(-1);
    }
    h.mem = (u_int8_t *)malloc(WORD_ALIGN(st.st_size));

    if (read(fd, h.mem, st.st_size) < 0) {
        perror("read");
        exit(-1);
    }
    
    // close file
    close(fd);

    h.ehdr = (Elf64_Ehdr *)h.mem;
    h.phdr = (Elf64_Phdr *)(h.mem + h.ehdr->e_phoff);
    h.shdr = (Elf64_Shdr *)(h.mem + h.ehdr->e_shoff);
    

    // Create Injection Code
    p_injection_code = create_injection_code();


    //---------------------------------------------------------------------------
    // Attach to the specify process
    if (ptrace(PTRACE_ATTACH, pid, NULL, NULL) < 0) {
        perror("PTRACE_ATTACH");
        exit(-1);
    }

    // wait for the STOPSIG
    wait(&stat);
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //long data = set_breakpoint(pid,number);
    
    /*
    long data = set_breakpoint(pid,start_addr + offset);
    if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
        perror("PTRACE_CONT");
        exit(-1);
    }
    wait(&stat);
    restore_instruction(pid,(void*)(start_addr + offset),data);
    */
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Get register from the specify process. (For change the %rip to run the injection code) 
    if (ptrace(PTRACE_GETREGS, pid, NULL, &h.user_reg) < 0) {
        perror("PTRACE_GETRES");
        exit(-1);
    }
    //我的
    
    struct user_regs_struct ori_reg;
    if (ptrace(PTRACE_GETREGS, pid, NULL, &ori_reg) < 0) {
        perror("PTRACE_GETRES");
        exit(-1);
    }
    //我的


    addr_text = h.user_reg.rip;  
    //================================================
    // Backup the origin code;
    p_origin_code = (u_int8_t *)pid_block_read(pid, (void *)addr_text, get_injection_code_size());

    // Insert injection code into specify process.
    pid_block_write(pid, (void *)addr_text, p_injection_code, get_injection_code_size());
    
    //Continue the process to run the injection_code function.
     if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
         perror("PTRACE_CONT");
         exit(-1);
    }
    
    // TRAP(int 3 0xCC)
    wait(&stat);
    
    // Recovery the injection code meory.
    pid_block_write(pid, (void *)addr_text, p_origin_code, get_injection_code_size());
    //================================================
    // Write the executable elf file to the memory start with Base_address.
    pid_block_write(pid, (void *)Base_address, (void *)h.mem, st.st_size);
    // Get user register
    if (ptrace(PTRACE_GETREGS, pid, NULL, &h.user_reg) < 0 ) {
        perror("PTRACE_GETREGS");
        exit(-1);
    }

    // Change the control flow to specify process entry point.
    h.user_reg.rip = Base_address + h.ehdr->e_entry;
    unsigned long long value = strtoul(argv[3], &endptr, 16); 
    unsigned long long offset_pt = strtoul(argv[4], &endptr, 16);
    h.user_reg.rsi = value + offset_pt;

    if (ptrace(PTRACE_SETREGS, pid, NULL, &h.user_reg) < 0) {
        perror("PTRACE_SETREGS");
        exit(-1);
    }
    //我的
    
    wait_for_stop(pid);
    if (ptrace(PTRACE_SETREGS, pid, NULL, &ori_reg) < 0) {
            perror("PTRACE_SETREGS");
            exit(-1);
        }
    // Continue the process
    if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
        perror("PTRACE_CONT");
        exit(-1);
    }
    ptrace(PTRACE_DETACH,pid,NULL, NULL);
    //我的*/
    printf("done\n");
    free(h.mem);
    exit(0);
}

// Write block memory via pid.(ptrace)
void pid_block_write(pid_t pid, void *addr_dst, void * p_res, u_int64_t u64_len)
{
    u_int8_t *p_res_cursor = (u_int8_t *)p_res,
             *p_dst_cursor = (u_int8_t *)addr_dst;
    for (; (u_int8_t *)p_res + u64_len > p_res_cursor;) {
        if (ptrace(PTRACE_POKETEXT, pid, (void *)p_dst_cursor, *(u_int64_t *)p_res_cursor) < 0) {// 64 bits system (1 word = 64bit)
            perror("PTRACE_POKETEXT");
            exit(-1);
        }
        p_res_cursor += sizeof(u_int64_t);
        p_dst_cursor += sizeof(u_int64_t);
    }
}

// Read block memory via pid.(ptrace)
void * pid_block_read(pid_t pid, void *addr_res, u_int64_t u64_len) 
{
    u_int8_t *p_dst_cursor,
             *p_res_cursor,
             *p_dst_cursor_origin;
    p_dst_cursor = p_dst_cursor_origin = (u_int8_t *)malloc(u64_len);
    p_res_cursor = (u_int8_t *)addr_res;
    for (; (u_int8_t *)addr_res + u64_len > p_res_cursor; ) {
        //
        *(u_int64_t *)p_dst_cursor = ptrace(PTRACE_PEEKTEXT, pid, (void *)p_res_cursor, NULL);
        if (errno != 0) {
            perror("PTRACE_PEEKTEXT");
            exit(-1);
        }
        p_res_cursor += sizeof(u_int64_t);
        p_dst_cursor += sizeof(u_int64_t);
    }
    return p_dst_cursor_origin;
}
