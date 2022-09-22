CC=g++
CPPFLAGS=-O3

default: install

test: ./cpp/aes.o ./cpp/testbench/test.o
	$(CC) $(CPPFLAGS) -o ./bin/test ./cpp/aes.cpp ./cpp/testbench/test.cpp

install: ./cpp/aes.o ./cpp/main.o
	$(CC) $(CPPFLAGS) -o ./bin/main ./cpp/aes.cpp ./cpp/main.cpp
clean:
	rm -f ./bin/main ./bin/aes.o
