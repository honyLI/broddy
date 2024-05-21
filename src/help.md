# 

## dump 
    打开/home/work/code/src/test/test.s
    取得函数首尾地址，写到table/func_table里

## memcreate
    使用ptrace分配内存空间,64KB

## random
    复制一份a.out > result
    读objdump -d的结果,随机化函数代码块
    生成随机化后的recall_table,存放需要修改的地址
    代码块组织成链表,生成list_table

## mmap
    获得pid filename 打开进程 找到第一个vma,把代码mmap进去
    把first vma 和 pos 和 size 写到jump_table

## jump.c
    去表recall_table读地址 
    去jump_addr里读位置
    修正地址

## sync
    给do_signal打kprobe,拦截int3指令

## inject
    用mmap分析libpthread的起始地址
    用objdump 去分析libpthread.so.0,找到pthread_create函数偏移
    使用ptreace插入一段汇编代码,调用pthread_create函数,生成线程


## 流程
    先objdump -d 生成test.s
    cp test/a.out random/result
    执行/dump/func生成函数表
    执行random目录下的fun，随机化函数
    执行/memcreate/mem pid分配内存
    然后执行/mmap/fmmap pid filename 映射函数
    打入jump.ko修正指令
    执行inject/in.sh启动线程
