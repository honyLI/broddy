CC = gcc
LDFLAGS = -pthread
test: test.c load.c
	$(CC) $(LDFLAGS) -g -o test test.c load.c

clean:
	rm -f test
