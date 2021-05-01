cmake_minimum_required(VERSION 3.12)

project(test_b VERSION 1.0 LANGUAGES CXX)

add_executable(test_b src/foo.cpp)
find_package(test_a REQUIRED)

target_link_libraries(test_b PRIVATE test_a::test_a)


install(TARGETS test_b)
