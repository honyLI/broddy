#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/uprobes.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/signal.h>

pid_t tar_pid = 305252;
pid_t tar_tid;

static struct task_struct *get_task_struct_by_pid(pid_t pid) {
    struct pid *pid_struct;
    struct task_struct *task,*p;

    pid_struct = find_get_pid(pid);
    if (!pid_struct) {
        return NULL;
    }

    task = pid_task(pid_struct, PIDTYPE_PID);
    if (IS_ERR(task)) {
        return NULL;
    }
    for_each_thread(task, p) {
        // 打印线程的 PID 和状态
        printk("  LWP: %d, State: %ld\n", p->pid, p->state);
        tar_tid = p->pid;
    }
    return task;
}


static int pre_handler(struct kprobe *p, struct pt_regs *regs)
{
    
    if(current->pid != tar_pid) return 0;
    
    unsigned long *sig = current->pending.signal.sig;
    if(sig[0] == 0) return;
    int i,j;
    for ( i = 0; i < _NSIG_WORDS; ++i) {
        if (sig[i] != 0) { // 如果该位图元素不为 0
            for (j = 0; j < BITS_PER_LONG; ++j) {
                if (sig[i] & (1UL << j)) {
                    printk(KERN_INFO "Signal %d is pending\n", i * BITS_PER_LONG + j);
                }
            }
        }
    }
    struct pt_regs * reg = (struct pt_regs*)(regs->di);
    printk(KERN_INFO "pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
           p->addr, reg->ip, regs->flags);
    printk("pid:%d",current->pid);
    printk("劳资打上力\n");
    get_task_struct_by_pid(tar_pid);

    return 0;
}

static void post_handler(struct kprobe *p, struct pt_regs *regs, unsigned long flags)
{
    //printk(KERN_INFO "post_handler: p->addr = 0x%p, flags = 0x%lx\n",
    //       p->addr, regs->flags);
    //int signal = current->pending.signal.sig[0];
    //printk(KERN_INFO "Received signal: %d\n", signal);
}

static int fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr)
{
    printk(KERN_INFO "fault_handler: p->addr = 0x%p, trap #%dn",
           p->addr, trapnr);
    return 0;
}

static struct kprobe kp = {
    .symbol_name   = "do_signal",      // 要追踪的内核函数为 do_fork
    .pre_handler   = pre_handler,    // pre_handler 回调函数
    .post_handler  = post_handler,   // post_handler 回调函数
    .fault_handler = fault_handler,  // fault_handler 回调函数
    
};

static int __init kprobe_init(void)
{
    int ret;

    ret = register_kprobe(&kp); // 调用 register_kprobe 注册追踪点
    if (ret < 0) {
        printk(KERN_INFO "register_kprobe failed, returned %d\n", ret);
        return ret;
    }

    
    printk(KERN_INFO "planted kprobe at %p\n", kp.addr);
    return 0;
}

static void __exit kprobe_exit(void)
{
    unregister_kprobe(&kp); // 调用 unregister_kprobe 注销追踪点
    printk(KERN_INFO "kprobe at %p unregistered\n", kp.addr);
}

module_init(kprobe_init) // 注册模块初始化函数
module_exit(kprobe_exit) // 注册模块退出函数
MODULE_LICENSE("GPL");
