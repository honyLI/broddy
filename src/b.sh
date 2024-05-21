#!/bin/bash
rmmod jump.ko
make clean
make

#LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libpthread.so.0 ./test/a.out
declare -i s
s=$(ps -a | grep a.out | awk '{print $1}')

cd test
gcc test.c
objdump -d a.out > test.s
cd ..

cp test/a.out random/result

cd dump
make
cd ..

cd random
make
#objdump -d result > ori.s
cd ..

cd mmap
make
cd ..

cd memcreate
make
cd ..

./dump/func
cd random

./fun
./bkpt 0x16b0
objdump -d result > result.s
cd ..
cat random/result.s | grep -E 'rip|call' > table/recall_table
./memcreate/mem $s
#./mmap/fmmap $s test/a.out
./mmap/fmmap $s random/result
insmod jump.ko target_pid=$s
dmesg -c

cd sync
rmmod buddy_sync.ko
make
insmod buddy_sync.ko tar_pid=$s
cd ..

cd inject
./in.sh
cd ..


