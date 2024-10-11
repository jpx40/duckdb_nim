cmake_minimum_required(VERSION 2.8.12...3.29)
project(example-c)

include_directories(libduckdb)
link_directories(libduckdb)

add_executable(example src/main.c)
target_link_libraries(example duckdb)
