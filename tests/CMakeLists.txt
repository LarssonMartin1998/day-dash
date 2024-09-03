find_package(GTest REQUIRED)

# Assuming the main build directory is available
set(MAIN_LIB_BUILD_DIR "${CMAKE_SOURCE_DIR}/build")
add_library(${PROJECT_NAME} STATIC IMPORTED)
set_target_properties(${PROJECT_NAME} PROPERTIES
    IMPORTED_LOCATION "${MAIN_LIB_BUILD_DIR}/lib${PROJECT_NAME}.a"
)

add_executable(all_tests)

target_link_libraries(all_tests PRIVATE ${PROJECT_NAME} GTest::gtest_main)

target_include_directories(all_tests PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_sources(all_tests PRIVATE test_tasks.cpp)

include(GoogleTest)
gtest_discover_tests(all_tests)
