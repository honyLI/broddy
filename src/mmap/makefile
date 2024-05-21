# 编译器
CC = gcc

# 编译选项
CFLAGS = -Wall -Wextra -g

# 源文件和目标文件
SRC = fmmap.c
OBJ = $(SRC:.c=.o)

# 目标可执行文件
TARGET = fmmap

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $(OBJ)

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -c $(SRC)

clean:
	rm -f $(OBJ) $(TARGET)