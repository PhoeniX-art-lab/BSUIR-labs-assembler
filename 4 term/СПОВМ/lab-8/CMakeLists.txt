cmake_minimum_required(VERSION 3.21)
project(lab_8 C)

set(CMAKE_C_STANDARD 23)
set(MYCOMPILE_FLAGS "-lpthread -lrt")
set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} ${MYCOMPILE_FLAGS}")
add_definitions(${MYCOMPILE_FLAGS})

add_executable(lab_8 main.c)
