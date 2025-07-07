
all: format run

format:
	zig fmt src

build:
	zig build

run: build
	zig build run

test: build
	zig build test

clean:
	rm -rf zig-out/ .zig-cache/