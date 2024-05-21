#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <sys/syscall.h>

int mutex = 0;
int * mutex2;

int fun1(){
    return 1;
}

int fun3(){
    return 3;
}

int fun2(){
    int num = 2;
    int a;
    int * p = malloc(sizeof(int));
    *p = num;
    //char * s = "1234567890";
    if(a){
        printf("111\n");
    }
    else{
        printf("123\n");
    }
    pid_t tid = syscall(SYS_gettid);

    for(int i=0;i<5;i++){
        int aum = 9;
        aum = 9;
        aum = 9;
        aum = 9;
        aum = 9;
        for(int j=0;j<5;j++){
            int aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            if(aum>3){
                num++;
            }
            else{
                num--;
            }
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
        }
    }
    if(a){
        a++;
    }
    else{
        int aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
            aum = 9;
    }
    for(int i=0;i<5;i++){
        printf("%d:hhh%d\n",tid,*p);
        printf("%d:一个字符串\n",tid);
        sleep(1);
    }
    for(int i=0;i<10;i++){
        mutex++;
        printf("%d : %d\n",tid,mutex);
    }
    printf("%d : %d\n",tid,*mutex2);
    *mutex2 = 12;
    *p = 2;
    p = &mutex;
    *p = 1;
    return fun3(); 
    //return 2;
}

int main(){
    int a = 1;
    printf("%d %d %d %d %d %d %d %d %d \n",a,a,a,a,a,a,a,a,a);
    mutex2 = malloc(sizeof(int));
    *mutex2 = 4;
    //fun2();
    while(1){
        sleep(5);
        for(int i=0;i<8;i++){
            printf("%d mutex:%d\n",fun1(),mutex); 
            sleep(5); 
        }
        fun2();
    }
}