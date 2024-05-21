#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include "proc.h"

int main(int argc, char *argv[]){

    if (argc < 2){
        printf("need pid\n");
        return 0;
    }
    pid_t pid = atoi(argv[1]);
    int ret = 0;
    process *proc;
    unsigned long addr = 0;
    proc = malloc(sizeof(process));
    proc->pid = pid;

    ret = process_init(proc, pid);
    if (ret < 0)
    {
        printf("cannot init process %d\n", pid);
        return ret;
    }
    ret = process_mem_open(proc, MEM_READ); //把proc->memfd open
    if (ret < 0)
        return ret;

    ret = process_parse_proc_maps(proc);
    if (ret < 0)
        return -1;
    ret = process_attach(proc);
    if (ret < 0)
        return ret;

    //int sz = ROUND_UP(file_size(filename), PAGE_SIZE);
    int sz = 4096*16;
    /*
     * Map binary as close to the original code as possible.
     * Otherwise we can't use 32-bit jumps.
     */
    addr = p_allocate(proc, sz);
    if (addr < 0)
        return ret;
    
    printf("ok\n");
}