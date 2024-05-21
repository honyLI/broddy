#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/uprobes.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/signal.h>
#include <linux/delay.h>
#include <asm/uaccess.h>

extern pid_t tar_pid;

extern unsigned char * ori_code, * bud_code;
extern unsigned long * ori_addr, * bud_addr ,* kori_addr, * kbud_addr;
extern unsigned long start_addr,dest_addr,offset,fun_size;
extern int list_num , bkpt_num;

extern struct kprobe kprobe_sync;

struct state
{
    unsigned long long ax;
};


unsigned long gp_user_va_to_pa(struct mm_struct *mm, unsigned long va);
