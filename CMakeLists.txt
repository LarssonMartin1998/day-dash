cmake_minimum_required(VERSION 3.28)
project(day_dash)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_compile_options(-Wall -Wextra -Werror -Wshadow -Wnon-virtual-dtor -pedantic)

# Only build the tests if the BUILD_TESTS option is set
option(BUILD_TESTS "Build the testing tree." OFF)
if(BUILD_TESTS)
    enable_testing()
    include(CTest)
    add_subdirectory(tests)
else()
    add_library(${PROJECT_NAME} STATIC)

    target_include_directories(${PROJECT_NAME} PUBLIC include)

    add_subdirectory(include)
    add_subdirectory(src)
endif()
