hello: main.c
	gcc main.c -o hello

all: hello

install: hello
	mkdir -p $(PREFIX)/bin
	cp hello $(PREFIX)/bin

.PHONY: all install
