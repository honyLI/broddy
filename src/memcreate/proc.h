#include "list.h"


struct vm_hole
{
	unsigned long start;
	unsigned long end;
	struct list_head list;
};

typedef struct m_process
{
	/* Pid of target process */
	int pid;

	/* memory fd of /proc/<pid>/mem */
	int memfd;

	/* /proc/<pid>/maps FD, also works as lock */
	int fdmaps;

	/* Process name */
	char comm[16];

	/* List of process objects */
	struct list_head objs;
	int num_objs;

	/* List ptrace contexts (one per each thread) */
	struct
	{
        struct list_head pctxs;
	} ptrace;

	/* List of free VMA areas */
	struct list_head vmaholes;

	/* libc's base address to use as a worksheet */
	unsigned long libc_base;
}process;


struct ptrace_ctx
{
	int pid;
	int running;
	unsigned long execute_until;
	process *proc;
	struct list_head list;
};

enum
{
	MEM_READ,
	MEM_WRITE,
};

int p_allocate(process *proc, size_t sz);
int process_init(process *proc,int pid);
int process_mem_open(process *proc, int mode);
int process_parse_proc_maps(process *proc);
int process_attach(process *proc);