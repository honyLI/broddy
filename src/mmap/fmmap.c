#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <elf.h>

unsigned long file_size(const char *filename)
{
    struct stat buf;
    if (stat(filename, &buf) < 0)
    {
        return 0;
    }
    return (unsigned long)buf.st_size;
}

int find_first_vma(unsigned long *start, unsigned long *end, const char *path) {
    char buf[1024];
    int fd, n;
    ssize_t read_size;
    unsigned long start_addr, end_addr;
    char *anon_str;
    
    // Open the VMA file for the given process
    fd = open(path, O_RDONLY);
    if (fd == -1) {
        perror("open");
        return -1;
    }
    
    // Read the VMA information from the file
    read_size = read(fd, buf, 1024);
    if (read_size == -1) {
        perror("read");
        close(fd);
        return -1;
    }
    
    // Parse the VMA information to find the first VMA
    n = sscanf(buf, "%lx-%lx %*s %*s %*s %*s %*s", &start_addr, &end_addr);
    if (n != 2) {
        fprintf(stderr, "Error: Failed to parse VMA information\n");
        close(fd);
        return -1;
    }
    
    // Check if the VMA region is anonymous
    anon_str = strstr(buf, "rwx");
    if (anon_str != NULL) {
        printf("First VMA range: 0x%lx - 0x%lx (anonymous region)\n", start_addr, end_addr);
    } else {
        printf("First VMA range: 0x%lx - 0x%lx (non-anonymous region)\n",start_addr, end_addr);
        return -1;
    }
    
    // Set the start and end addresses
    *start = start_addr;
    *end = end_addr;
    
    // Close the file
    close(fd);
    
    return 0;
}

int main(int argc, char *argv[]){

    if (argc < 3){
        printf("need pid and filename\n");
        return 1;
    }
    pid_t pid = atoi(argv[1]); 
    
    char * exe_name = argv[2];
    char * table_name= "/home/work/code/src/table/func_table";
    char * jump_name = "/home/work/code/src/table/jump_table";
    //char * call_name = "/home/work/code/src/table/call_table";

    FILE *func_table = fopen(table_name, "r");
    FILE *jump_table = fopen(jump_name, "rw+");
    //FILE *call_table = fopen(call_name, "rw+");
    
    char vma_path[256];
    unsigned long func_start, func_end; //where to mmap
    unsigned long func_addr;
    int func_size;     
    char line[512];    //store a line of func_table
    Elf64_Ehdr *ehdr;  //strat addr of file in mem
    char proc_path[sizeof("/proc/0123456789/mem")];

    snprintf(vma_path, 256, "/proc/%d/maps", pid);
    
    if (find_first_vma(&func_start, &func_end, vma_path) == -1) {
        fprintf(stderr, "Failed to find the patch VMA for the process\n");
        return 1;
    }
    
    int fd = open(exe_name, O_RDONLY);
    if(fd == -1 ){
        printf("elf没打开\n");
    }
    
    /*get the addr for func_addr and func_size*/
    while (fgets(line, sizeof(line), func_table)){
        char *ptr = strstr(line, "fun2");
        if (ptr == NULL) 
            continue;
        char name[64];
        unsigned long faddr , laddr;
        sscanf(line, "%s %lx %lx", name, &faddr, &laddr);
        printf("fmmap: %s %lx %lx\n",name,faddr,laddr);
        if (strcmp(name, "fun2") == 0)
        {
            func_addr = faddr;
            func_size = laddr - faddr;
            break;//防止出现找ab 结果找了abc
        }
    }

    int sz = file_size(exe_name);

    ehdr = mmap(NULL,sz,PROT_READ|PROT_WRITE, MAP_PRIVATE,fd,0);
    if (ehdr == MAP_FAILED){
        printf("映射失败力\n");
    }

    int rc = mprotect(ehdr, sz , PROT_WRITE | PROT_EXEC | PROT_READ);
    if (rc == -1)
        printf("mprotect Could not mprotect func\n");

    sprintf(proc_path, "/proc/%d/mem", pid);
    int memfd = open(proc_path, O_RDWR);
    if (memfd == -1)
    {
        printf("fail to open mem!\n");
    }

    int ret = pwrite(memfd, (void *)((char *)(ehdr) + func_addr), func_size, func_start);
    if (ret < 0)
    {
        printf("fail to load func!\n");
    }
    char pu[256];
    
    sprintf(pu,"%lx %lx %x",func_start,func_addr,func_size);
    fputs(pu,jump_table);
    munmap(ehdr,sz);
}