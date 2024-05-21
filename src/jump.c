#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/sched.h>
#include <linux/fs.h>
#include <linux/pid.h>
#include <linux/slab.h>
#include <asm/uaccess.h> //给set_fs用的
#include <linux/mm.h>
#include <linux/mman.h>

static char *func_table ="/home/work/code/src/table/func_table";
static char *jump_name = "/home/work/code/src/table/jump_table";
static char *call_name = "/home/work/code/src/table/recall_table";
static pid_t target_pid = -1;
module_param(target_pid, int, S_IRUGO);
struct task_struct *task;

int jmp_apply(unsigned long *offset, unsigned long *phys_addr)
{
    char buf[5] = {0xe9, 0x00, 0x00, 0x00, 0x00};
    *(unsigned int *)(buf + 1) = (unsigned int)(*offset - 5);
    //printk("jump_apply: %lx\n",*(unsigned int *)(*phys_addr));
    //memcpy((void *)(*phys_addr), buf, 5); //别删，这是头跳转的开关
    //printk("jump_apply: %lx\n",*(unsigned int *)(*phys_addr));
    return 1;
}

int call_apply(unsigned long *offset, unsigned long *phys_addr)
{   

    //printk("call_apply: %lx\n",*(unsigned int *)(*phys_addr));
    *(unsigned int *)(*phys_addr)-= (unsigned long)(*offset);
    //printk("call_apply: %lx\n",*(int *)(*phys_addr));
    return 1;
}

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

    pa = (long unsigned int)phys_to_virt(pa); //把物理地址转换成虚拟地址
    //printk("ojbk\n");
out:
    up_read(&mm->mmap_sem);
    return pa;
}

// 内核模块初始化函数
static int __init jump_init(void)
{
    char buf[256];
    char line[64];
    unsigned long offset;
    unsigned long jboffset;
    unsigned long dest,pos,sz;
    unsigned long code_addr; // 代码起始地址
    unsigned long func_addr; 
    unsigned long func_size; 
    unsigned long phy_addr;   
    struct file *call_table;
    struct file *file;//func_table
    struct file *jump_table = filp_open(jump_name,O_RDONLY, 0);
    if (IS_ERR(jump_table))
    {
        printk("读文件寄了\n");
        return 0;
    }

    call_table = filp_open(call_name,O_RDONLY, 0);
    if (IS_ERR(call_table))
    {
        printk("读文件寄了\n");
        return 0;
    }

    file = filp_open(func_table, O_RDONLY, 0);
    if (IS_ERR(file))
    {
        printk("读文件寄了\n");
        return 0;
    }
    task = pid_task(find_get_pid(target_pid), PIDTYPE_PID);
    if (task == NULL)
    {
        printk(KERN_INFO "Process with pid %d not found\n", target_pid);
        return -ESRCH;
    }

    code_addr = task->mm->start_code;
    //printk("code_address:%lx\n", code_addr);

    while (read_line(buf, sizeof(buf), file) > 0)
    {
        char name[40];
        unsigned long faddr, laddr;
        sscanf(buf, "%s %lx %lx", name, &faddr, &laddr);

        if (strcmp(name, "fun2") == 0)
        {
            //printk("找着了\n");
            func_addr = faddr;
            func_size = laddr - faddr;
        }
    }

    //printk("funcation addr:%lx size:%d\n", func_addr, func_size);

    
    read_line(line, sizeof(line), jump_table);

    
    sscanf(line, "%lx %lx %lx", &dest, &pos, &sz);

    //printk("目的：%lx 偏移：%lx 大小：%d\n", dest, pos, sz);
    
    offset = dest - code_addr - func_addr;
    jboffset = dest - code_addr - pos;
    while (read_line(buf, sizeof(buf), call_table) > 0)
    {
        unsigned long addr, op ,op2, op3;
        //printk("buf:%s\n",buf);
        sscanf(buf, "%lx: %lx %lx %lx", &addr, &op, &op2, &op3);
        /*限定地址范围*/
        if(addr < pos)
            continue;
        if(addr > pos + sz)
            break;
        //printk("%lx %lx %lx %lx", addr, op, op2, op3);
        if (op == 0xe8){
            //printk("addr:%lx op:%lx\n",addr,op);
            phy_addr =  gp_user_va_to_pa(task->mm, dest + addr - pos +1);
            call_apply(&jboffset,&phy_addr);
        }
        else if(op == 0x48){
            if(op2 == 0x8d){
                if(op3 == 0x3d || op3 == 0x85 || op3 == 0x35 || op3 == 0x05|| op3 == 0x05){
                    //printk("有3d或85或35\n");
                    phy_addr =  gp_user_va_to_pa(task->mm, dest + addr - pos +3);
                    call_apply(&jboffset,&phy_addr);
                }
            }
            else if(op2 == 0x8b){ //mov
                if(op3 == 0x05 || op3 == 0x15){
                    //printk("mov:%lx\n",(dest + addr - pos +2));
                    phy_addr =  gp_user_va_to_pa(task->mm, dest + addr - pos +3);
                    call_apply(&jboffset,&phy_addr);
                }
            }
        }
        else if(op == 0x8b){ //mov
            if(op2 == 0x05 || op2 == 0x15){
                //printk("mov:%lx\n",(dest + addr - pos +2));
                phy_addr =  gp_user_va_to_pa(task->mm, dest + addr - pos +2);
                call_apply(&jboffset,&phy_addr);
            }
        }
        else if(op == 0x89){ //mov
            if(op2 == 0x05){
                phy_addr =  gp_user_va_to_pa(task->mm, dest + addr - pos +2);
                call_apply(&jboffset,&phy_addr);
            }
        }
    }

    
    phy_addr =  gp_user_va_to_pa(task->mm, code_addr + func_addr);
    if (!phy_addr){
        printk("物理内存>_<\n");
        return -1;        
    }
    
    jmp_apply(&offset, &phy_addr);
    filp_close(file, NULL);


    return 0;
}

// 内核模块退出函数
static void __exit jump_exit(void)
{
    printk("exit\n");
}

module_init(jump_init);
module_exit(jump_exit);

MODULE_LICENSE("GPL");