# Makefile for compiling fun.c

CC = gcc
CFLAGS = -Wall -g

all: fun bkpt

fun: fun.o block_list.o
	$(CC) $(CFLAGS) -o fun fun.o block_list.o

bkpt: bkpt.o
	$(CC) $(CFLAGS) -o bkpt bkpt.o

fun.o: fun.c 
	$(CC) $(CFLAGS) -c fun.c 

bkpt.o: bkpt.c 
	$(CC) $(CFLAGS) -c bkpt.c 

block_list.o: block_list.c
	$(CC) $(CFLAGS) -c block_list.c
	
clean:
	rm -f fun fun.o block_list.o bkpt.o bkpt
