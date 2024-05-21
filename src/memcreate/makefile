CC = gcc
CFLAGS = -Wall -g
LDFLAGS = -lm

SOURCES = mem.c proc.c
HEADERS = list.h proc.h util.h
OBJECTS = $(SOURCES:.c=.o)

mem: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o mem $(LDFLAGS)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f mem $(OBJECTS)
