

.PHONY: duckdb clean main

all: duckdb main

clean:
	rm -rf build

duckdb:
	cd build && make

main:
	mkdir -p build
	cd build && cmake .. && make
	build/example
