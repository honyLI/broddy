obj-m := buddy_sync.o # 编译后的二进制文件名
buddy_sync-objs := kprobe_example.o kprobe_op.o
CROSS_COMPILE=''
KDIR := /lib/modules/$(shell uname -r)/build
#EXTRA_CFLAGS += -Wno-format -Wunused-result
#EXTRA_CFLAGS += -Wunused-result
ccflags-y := -Wno-format -Wno-unused-result -Wno-int-conversion -std=gnu99
all:
	make -C $(KDIR) M=$(PWD) modules 
clean:
	rm -f *.ko *.o *.mod.o *.mod.c .*.cmd *.symvers  modul* *.mod