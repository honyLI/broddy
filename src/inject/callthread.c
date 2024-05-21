unsigned long long addr = 12;
long _write(long fd, char *buf, unsigned long len)
{
    long ret;
    asm volatile (
        "mov %0, %%rdi\n"
        "mov %1, %%rsi\n"
        "mov %2, %%rdx\n"
        "mov $1, %%rax\n"
        "syscall"
        :
        :"g"(fd), "g"(buf), "g"(len)
    );
    asm("mov %%rax, %0":"=r"(ret));
    return ret;
}

long _fun(){
    asm volatile(
        "pop    %rbp\n"
        "jmp *0x2fbb(%rip)\n" //<pthread_create@plt>
        //"jmp *adder\n"
    );
}

long _pthread()
{
    asm volatile (
        "sub $0x10 , %rsp \n"
        "mov %fs:0x28, %rax\n"
        "mov    %rax,-0x8(%rbp)\n"
        "xor    %eax,%eax\n"
        "lea    -0x10(%rbp),%rax\n"
        "mov    $0x0,%ecx\n"
        "lea    -0x2073(%rip),%rdx\n"  // 1189 <fun>
        "mov    $0x0,%esi\n"
        "mov    %rax,%rdi\n"
        "callq  _fun\n"
        "mov %rbp, %rsp\n"  //rsp要恢复
        "nopl   0x0(%rax)\n"
    );
}

void _exit(int status)
{
    asm(
        "mov $60, %%rax\n"
        "syscall"
        :
        :"r"(status)
    );
}

int _start(int argc,char ** argv)
{
    //_write(1, "I am HotIce0\n", sizeof("I am HotIce0\n"));
    asm volatile(
        "mov %rsi,0x2f43(%rip)\n"  //write the rsi to addr
    );
    _pthread();
    asm volatile("int3");
    _exit(0);
}

//find_system 