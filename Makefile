CC=g++
CPPFLAGS=-O3

default: install

install: ./cpp/aes.o ./cpp/main.o
	$(CC) $(CPPFLAGS) -o ./bin/main ./cpp/aes.cpp ./cpp/main.cpp
clean:
	rm -f ./bin/main ./bin/aes.o
