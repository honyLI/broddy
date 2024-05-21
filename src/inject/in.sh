#!/bin/bash
gcc -fpie -pie -nostdlib -o callthread callthread.c
gcc -o code_injection code_injection.c
objdump -d callthread > callthread.s
objdump -s callthread > callthread.all
declare -i s
s=$(ps -a | grep a.out | awk '{print $1}')
base=$(pmap $s | grep libpthread | awk '{print $1}'| head -n 1)
off=$(objdump -d /usr/lib/x86_64-linux-gnu/libpthread.so.0 | grep '.*<pthread_create.*:.*' |  awk '{print $1}')
sudo ./code_injection $s callthread $base $off