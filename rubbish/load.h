#include <stdio.h>
#include <elf.h>
#include <sys/stat.h>
#include <sys/mman.h>  //mmap要用
#include <stdlib.h>
#include <unistd.h> 
#include <fcntl.h>  //跟open那一坨有关
Elf64_Ehdr* loadelf(int fd);

int unload(Elf64_Ehdr* map_addr);