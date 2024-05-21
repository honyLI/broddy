#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/kprobes.h>
#include <linux/uprobes.h>
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/signal.h>
#include <linux/delay.h>
#include <asm/uaccess.h>
#include "kprobe_op.h"

struct list_node
{
    int no;
    unsigned long long o_addr;
    unsigned long long l_addr;
    size_t size;
    struct list_node *next;
};

char *jump_name = "/home/work/code/src/table/jump_table";
char *list_name = "/home/work/code/src/table/list_table";
char *bkpt_name = "/home/work/code/src/table/bkpt_table";
char *exe_name = "a.out";
struct list_node *list;

module_param(tar_pid, int, S_IRUGO);


/*read a line , if overread , turn back*/
int read_line(char *buf, int buf_len, struct file *fp)
{
    int ret;
    int i = 0;
    mm_segment_t old_fs;

    old_fs = get_fs();
    set_fs(KERNEL_DS);
    if (fp->f_op->read != NULL)
    {
        return -1;
    }
    ret = kernel_read(fp, buf, buf_len, &(fp->f_pos));
    set_fs(old_fs);

    if (ret <= 0)
        return ret;

    while (buf[i++] != '\n' && i < ret)
        ;

    if (i < ret)
    {
        fp->f_pos += i - ret;
    }

    if (i < buf_len)
    {
        buf[i] = 0;
    }
    return i;
}

int cal_bkpt_num(void){
    int num=0;
    char line[64];
    struct file *bkpt_table = filp_open(bkpt_name,O_RDONLY, 0);
    while (read_line(line, sizeof(line), bkpt_table) > 0){
        num++;
    }
    filp_close(bkpt_table, NULL);
    return num;
}

int insert_breakpoint(struct task_struct *task){
    int i=0;
    char line[64];
    unsigned char int3 = 0xcc;
    struct list_node *temp = list;
    struct file *bkpt_table = filp_open(bkpt_name,O_RDONLY, 0);
    while(read_line(line, sizeof(line), bkpt_table) > 0){
        int result;
        unsigned long long ori_off,bud_off;
        sscanf(line, "%llx %llx",&ori_off, &bud_off);
        ori_addr[i] = start_addr + ori_off;
        bud_addr[i] = dest_addr + bud_off;
        kori_addr[i] = gp_user_va_to_pa(task->mm,ori_addr[i]);
        kbud_addr[i] = gp_user_va_to_pa(task->mm,bud_addr[i]);
        if ( access_ok(ori_addr[i],1) ) {
            //addr accessable
            printk("read permete\n");
        }
        result = __copy_from_user(ori_code+i,kori_addr[i],1);
        if(result > 0)
        {
            printk("copy_from_user failed\n");
            return -1;
        }
        result = __copy_from_user(bud_code+i,kbud_addr[i],1);
        if(result > 0)
        {
            printk("copy_from_user failed\n");
            return -1;
        }

        result =__copy_to_user(kori_addr[i],&int3,1);
        if(result > 0)
        {
            printk("copy_to_user failed\n");
            return -1;
        }
        result =__copy_to_user(kbud_addr[i],&int3,1);
        if(result > 0)
        {
            printk("copy_to_user failed\n");
            return -1;
        }
        i++;
    }
    filp_close(bkpt_table, NULL);
    return 0;
}




static int __init kprobe_init(void)
{
    int ret;
    char line[64];
    struct task_struct *task;
    struct vm_area_struct* vma_temp;
    char tmp[50];
    char name[64];
    struct file *jump_table = filp_open(jump_name,O_RDONLY, 0);
    if (IS_ERR(jump_table))
    {
        printk("jump_table error\n");
        return 0;
    }
    if(tar_pid <= 0) return 0;

    read_line(line, sizeof(line), jump_table);
    sscanf(line, "%lx %lx %lx", &dest_addr, &offset, &fun_size);
    
    /*find the start_addr*/
    task = pid_task(find_get_pid(tar_pid), PIDTYPE_PID);
    //send_sig(SIGSTOP, task, 0);
    vma_temp = task -> mm-> mmap;
   
    while(vma_temp){
        while(!vma_temp->vm_file){
            vma_temp = vma_temp -> vm_next;
        }
        strcpy(name,file_path(vma_temp->vm_file,tmp,50));
        if(strstr(name,exe_name) > 0){
            break;
        }
        vma_temp = vma_temp -> vm_next;
    }

    start_addr = vma_temp->vm_start;
    printk("start:%lx,dest:%lx,off:%lx,size:%lx\n",start_addr,dest_addr,offset,fun_size);
    
    bkpt_num = cal_bkpt_num();
    printk("bkpt_num:%d\n",bkpt_num);

    ori_code = kmalloc(sizeof(char)*bkpt_num,GFP_KERNEL);
    bud_code = kmalloc(sizeof(char)*bkpt_num,GFP_KERNEL);
    ori_addr = kmalloc(sizeof(unsigned long)*bkpt_num,GFP_KERNEL);
    bud_addr = kmalloc(sizeof(unsigned long)*bkpt_num,GFP_KERNEL);
    kori_addr = kmalloc(sizeof(unsigned long)*bkpt_num,GFP_KERNEL);
    kbud_addr = kmalloc(sizeof(unsigned long)*bkpt_num,GFP_KERNEL);

    insert_breakpoint(task);
    printk("insert finish\n");
    /*register kprobe*/
    ret = register_kprobe(&kprobe_sync);
    if (ret < 0) {
        printk(KERN_INFO "register_kprobe failed, returned %d\n", ret);
        return ret;
    }

    //send_sig(SIGCONT, task, 0);
    return 0;
}

static void __exit kprobe_exit(void)
{
    struct list_node *cur = list;
    struct list_node *next;    
    unregister_kprobe(&kprobe_sync);
    //printk(KERN_INFO "kprobe at %p unregistered\n", kp.addr);
    kfree(ori_addr);
    kfree(ori_code);
    kfree(bud_addr);
    kfree(bud_code);
    kfree(kori_addr);
    kfree(kbud_addr);
    /*free the list*/
    while (cur != NULL) {
        next = cur->next;
        kfree(cur);
        cur = next;
    }
    list = NULL; 
}

module_init(kprobe_init)
module_exit(kprobe_exit)
MODULE_LICENSE("GPL");
