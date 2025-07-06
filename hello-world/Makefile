
all:
	make run

compile:
	zig build

run: compile
	zig build run

test: compile
	zig build test

clean:
	rm -rf zig-out/ .zig-cache/