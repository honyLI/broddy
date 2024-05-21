rmmod buddy_sync.ko
make
declare -i s
s=$(ps -a | grep a.out | awk '{print $1}')
insmod buddy_sync.ko tar_pid=$s
dmesg