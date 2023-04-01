cmake_minimum_required(VERSION 3.23)
project(lab_1)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 -fopt-info-vec-optimized -march=native -Wall -mavx -mfma")

add_executable(lab_1 main.cpp)
