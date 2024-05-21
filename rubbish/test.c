#include <pthread.h> //线程用
#include <stdint.h>
#include <assert.h>
#include "load.h"
int fun1();
int fun2();
int fun3();
int fun4();
int fun5();
int fun6();



int main(){
    char * myfile = "/home/work/code/test";
    
    Elf64_Ehdr* map_addr; //映射的起始地址
    pthread_t mythread1; //线程标识符
    pthread_t mythread2; //线程标识符
    //loadelf();

    //打开文件
    int fd = open(myfile, O_RDONLY);
    printf("%d",fd);
    assert(fd != -1);
    
    //获取本进程首地址
    unsigned long start_address;
    FILE* file = fopen("/proc/self/maps", "r");
    if (file != NULL) {
        
        fscanf(file, "%lx", &start_address);
        fclose(file);

        printf("Process Address Space Start: %lx\n", start_address);
    } else {
        printf("Failed to open /proc/self/maps\n");
    }





    map_addr = loadelf(fd);
    assert(map_addr != MAP_FAILED);

    int(* addr)() = fun1;
    //printf("size的大小:%ld\n",sb.st_size);
    printf("fun1的地址:%lx\n",addr);
    printf("fun1的地址:%lx\n",fun1);
    printf("fun2的地址:%lx\n",fun2);
    printf("map_addr的地址:%lx\n",map_addr);
    addr = (uintptr_t)(map_addr) - start_address + addr;
    printf("fun1映射后的地址:%lx\n",addr);
    
    fun1();
    //int result1 = pthread_create(&mythread1, NULL,(void*)(fun1), NULL);
    sleep(0.2);
    printf("%lx\n",addr);
    addr();
    //int result2 = pthread_create(&mythread2, NULL,(void*)(addr), NULL);
 
    //pthread_join(&mythread1, NULL);
    sleep(1);


    // 解除内存映射
    if (unload(map_addr) == -1) {
        perror("munmap");
        return 1;
    }


    // 关闭文件
    close(fd);

    return 0;

}



int fun1(){
    fun2();
    //printf("fun1\n");
    puts("hhh");
    return 3;
}

int fun2(){
    fun3();
    printf("fun2\n");
}

int fun3(){
    //printf("fun3\n");
}

int fun4(){
    printf("fun4\n");
}

int fun5(){
    printf("fun5\n");
}

int fun6(){
    printf("fun6\n");
}


