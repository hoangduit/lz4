CC=gcc
CFLAGS=-I. -std=c99 -Wall -W -Wundef -Wno-implicit-function-declaration

OS := $(shell uname)
ifeq ($(OS),Linux)
EXT =
else
EXT =.exe
endif

default: lz4c

all: lz4c lz4c32 fuzzer

lz4c: lz4.c lz4hc.c bench.c xxhash.c lz4c.c
	$(CC)      -O3 $(CFLAGS) $^ -o $@$(EXT)

lz4c32: lz4.c lz4hc.c bench.c xxhash.c lz4c.c
	$(CC) -m32 -Os -march=native $(CFLAGS) $^ -o $@$(EXT)

fuzzer : lz4.c fuzzer.c
	$(CC)      -O3 $(CFLAGS) $^ -o $@$(EXT)
	
clean:
	rm -f core *.o lz4c$(EXT) lz4c32$(EXT) fuzzer$(EXT)
