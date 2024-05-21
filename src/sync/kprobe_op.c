#include "kprobe_op.h"
#include <linux/kernel.h>
pid_t tar_tid = 0;
pid_t tar_pid = 0;

/*
    pre_handler absolutely, absolutely, absolutely, absolutely cannot return a fucking non-zero value.
*/
unsigned char * ori_code, * bud_code;
unsigned long * ori_addr, * bud_addr ,* kori_addr, * kbud_addr;
unsigned long start_addr,dest_addr,offset,fun_size;
int ori_speed=0, bud_speed=0,list_num=0,bud_end=0,ori_end=0,bkpt_num=0;
int compare_sync = 1;
struct state *thread_state;
unsigned long gp_user_va_to_pa(struct mm_struct *mm, unsigned long va)
{
    //struct page *page;
    pgd_t *pgd = NULL;
    p4d_t *p4d = NULL;
    pud_t *pud = NULL;
    pmd_t *pmd = NULL;
    pte_t *pte = NULL;
    unsigned long addr = (unsigned long)va;
    unsigned long pa = 0;

    down_read(&mm->mmap_sem);
    //printk(KERN_INFO "pgd = 0x%p\n", mm->pgd);

    /* query page tables */
    if (!find_vma(mm, addr))
    {
        printk("virt_addr %08lx not available.\n", addr);
        goto out;
    }
    pgd = pgd_offset(mm, addr);
    if (pgd_none(*pgd))
    {
        printk("Not mapped in pgd.\n");
        goto out;
    }
    //printk("pgd val %lx.\n", pgd_val(*pgd));
    p4d = p4d_offset(pgd, addr);
    if (p4d_none(*p4d))
    {
        printk("Not mapped in pgd.\n");
        goto out;
    }

    //printk("p4d val %lx.\n", p4d_val(*p4d));
    pud = pud_offset(p4d, addr);
    if (pud_none(*pud))
    {
        printk("Not mapped in pud.\n");
        goto out;
    }

    //printk("pud val %lx.\n", pud_val(*pud));
    pmd = pmd_offset(pud, addr);
    if (pmd_none(*pmd))
    {
        printk("Not mapped in pmd.\n");
        goto out;
    }

    //printk("pmd val %lx.\n", pmd_val(*pmd));
    pte = pte_offset_kernel(pmd, addr);
    if (pte_none(*pte))
    {
        printk("Not mapped in pte.\n");
        goto out;
    }

    //printk("pte val %lx.\n", pte_val(*pte));
    if (!pte_present(*pte))
    {
        printk("pte not in RAM.\n");
        goto out;
    }

    pa = (pte_val(*pte) & PAGE_MASK) | (addr & ~PAGE_MASK);

    pa = phys_to_virt(pa); //turn physical to virtural
out:
    up_read(&mm->mmap_sem);
    return pa;
}


/*find the new thread pid*/
static void find_pid(pid_t pid) {
    struct pid *pid_struct;
    struct task_struct *task,*p;

    pid_struct = find_get_pid(pid);
    if (!pid_struct) {
        return ;
    }

    task = pid_task(pid_struct, PIDTYPE_PID);
    if (IS_ERR(task)) {
        return ;
    }
    for_each_thread(task, p) {
        // print thread PID and state
        //printk("LWP: %d, State: %ld\n", p->pid, p->state);
        tar_tid = p->pid;
    }
    return;
    //return task;
}

static void save_state(struct pt_regs *reg){
    thread_state = kmalloc(sizeof(struct state),GFP_KERNEL);
    thread_state->ax = reg->ax;
}

static void compare_state(struct pt_regs *reg){
    if(reg->ax == thread_state->ax){
        printk("状态一至\n");
    }else{
        printk("状态不一致 原进程ax:%llx 伴随ax:%llx\n",thread_state->ax,reg->ax);
    }
}

static int pre_handler(struct kprobe *p, struct pt_regs *regs)
{
    int i,j;
    unsigned long *sig;
    struct pt_regs * reg;
    if(current->pid != tar_pid && current->pid != tar_tid) return 0;
    
    sig = current->pending.signal.sig;
    /* ignore other signal */
    if(sig[0] != 0x10) return 0;
    for (i = 0; i < _NSIG_WORDS; ++i) {
        if (sig[i] != 0) { 
            for (j = 0; j < BITS_PER_LONG; ++j) {
                if (sig[i] & (1UL << j)) {
                    printk(KERN_INFO "Signal %d is pending\n", i * BITS_PER_LONG + j);
                }
            }
        }
    }
    /* get the user register */
    reg = (struct pt_regs*)(regs->di);
    printk("%dip = %lx, flags = 0x%lx\n",current->pid, reg->ip, regs->flags);
    
    if(tar_tid == 0 || tar_tid == tar_pid){
        find_pid(tar_pid);
    }
    if(reg -> ip >= dest_addr && reg->ip < dest_addr+fun_size){
        int num = 0;
        int result;
        for(i=0;i<bkpt_num;i++){
            if(bud_addr[i] == reg->ip-1){
                break;
            }
        }
        result = __copy_to_user(kbud_addr[i],bud_code+i,1);
        reg->ip--;
        printk("pid:%d result:%d speed:%d\n",current->pid,result,bud_speed);
        bud_speed++;
        if(bud_speed == bkpt_num) bud_end = 1;
        bud_speed = bud_speed % bkpt_num;
        while(bud_speed > ori_speed){
            if(ori_end==1){
                ori_end=0;
                break;
            }
            msleep(100);
            num++;
            if(num >= 1200){
                return 0;
            } 
            printk("buddy等 num:%d\n",num);
        }
        compare_state(reg);
        compare_sync = 1;
        sig[0] = 0x20000;
    }else if(reg -> ip >= start_addr + offset && reg->ip < start_addr+ offset+fun_size){
        int num = 0;
        int result;
        for(i=0;i<bkpt_num;i++){
            if(ori_addr[i] == reg->ip-1){
                printk("yes! i:%d addr:%lx\n",i,ori_addr[i]);
                break;
            }
        }
        result  = __copy_to_user(kori_addr[i],ori_code+i,1);
        reg->ip--;
        printk("pid:%d result:%d speed:%d code:%x ori_speed:%d bud_speed:%d\n",current->pid,result,ori_speed,ori_code[i],ori_speed,bud_speed);
        while(compare_sync == 0){
            msleep(1);
        }
        save_state(reg);
        compare_sync=0;
        ori_speed++;
        if(ori_speed == bkpt_num) ori_end = 1;
        ori_speed = ori_speed % bkpt_num;
        while(ori_speed > bud_speed){
            if(bud_end==1){
                bud_end=0;
                break;
            } 
            msleep(100);
            num++;
            if(num >= 1200){
                return 0;
            } 
            printk("原进程等 pid:%d num:%d\n",tar_pid,num);
        }
        sig[0] = 0x20000; //sig_cont
    }
    return 0;
}

static void post_handler(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
{
    //printk(KERN_INFO "post_handler: p->addr = 0x%p, flags = 0x%lx\n",
    //       p->addr, regs->flags);
    //int signal = current->pending.signal.sig[0];
    //printk(KERN_INFO "Received signal: %d\n", signal);
}

struct kprobe kprobe_sync = {
    .symbol_name   = "do_signal",
    .pre_handler   = pre_handler,
    .post_handler  = post_handler,
};


EXPORT_SYMBOL_GPL(kprobe_sync);


