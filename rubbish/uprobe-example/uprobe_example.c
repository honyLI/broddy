#include <linux/module.h>
#include <linux/ptrace.h>
#include <linux/uprobes.h>
#include <linux/namei.h>
#include <linux/moduleparam.h>

static long offset;

static int handler_pre(struct uprobe_consumer *self, struct pt_regs *regs){
        printk("打上力打上力\n");
        printk("pid:%d",current->pid);
        printk("handler: arg0 = %d arg1 =%d \n", (int)regs->di, (int)regs->si);
        return 0;
}

static int handler_ret(struct uprobe_consumer *self,
                                unsigned long func,
                                struct pt_regs *regs){
        printk("ret_handler ret = %d \n", (int)regs->ax);
        return 0;
}

static struct uprobe_consumer uc = {
        .handler = handler_pre,
        .ret_handler = handler_ret,
};


static struct inode *inode;

static int __init uprobe_init(void) {
        struct path path;
        int ret;
        printk("??????????\n");
        //char *filename = "/proc/183841/mem";
        char *filename = "/home/work/code/src/test/a.out";
        //char *filename = "/home/work/code/src/random/result";
        offset = 0x11c7;
        //offset = -4096 * 16;
        ret = kern_path(filename, LOOKUP_FOLLOW, &path);
        if (ret < 0) {
                pr_err("kern_path failed, returned %d\n", ret);
                return ret;
        }

        inode = igrab(path.dentry->d_inode);
        path_put(&path);

        ret = uprobe_register(inode, offset, &uc);
        if (ret < 0) {
                pr_err("register_uprobe failed, returned %d\n", ret);
                return ret;
        }



        return 0;
}

static void __exit uprobe_exit(void) {
        uprobe_unregister(inode, offset, &uc);
}

module_init(uprobe_init);
module_exit(uprobe_exit);
MODULE_LICENSE("GPL");