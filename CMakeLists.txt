cmake_minimum_required(VERSION 3.29)
project(DetectChangedForMake C)

set(CMAKE_C_STANDARD 11)

add_library(DetectChangedForMake SHARED library.c)
