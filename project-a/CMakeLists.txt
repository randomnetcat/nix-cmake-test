cmake_minimum_required(VERSION 3.12)

project(test_a VERSION 1.0 LANGUAGES CXX)

add_library(test_a SHARED src/foo.cpp)

include(GNUInstallDirs)

target_include_directories(
    test_a
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

message(STATUS "INCLUDEDIR: ${CMAKE_INSTALL_INCLUDEDIR}")

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

include(GenerateExportHeader)
generate_export_header(test_a EXPORT_FILE_NAME "${CMAKE_CURRENT_SOURCE_DIR}/include/libtest_a/export_macros.h" BASE_NAME TEST_A)

find_package(fmt REQUIRED)
target_link_libraries(test_a PRIVATE fmt)

set(TEST_A_EXPORT_TARGETS_NAME "test_a-targets")

install(
    TARGETS  test_a
    EXPORT   "${TEST_A_EXPORT_TARGETS_NAME}"
    ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

set(major_version 1)
set(minor_version 0)
set(patch_version 0)
set(version "${major_version}.${minor_version}.${patch_version}")

set_property(
    TARGET test_a
    PROPERTY
        VERSION "${version}"
)

set_property(
    TARGET test_a
    PROPERTY
        SOVERSION "${major_version}"
)

set_property(
    TARGET test_a
    PROPERTY
        INTERFACE_test_a_MAJOR_VERSION "${major_version}"
)

install(DIRECTORY include/libtest_a DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

set(TEST_A_CMAKE_EXPORT_DIR "${CMAKE_INSTALL_LIBDIR}/cmake/test_a")

install(
    EXPORT "${TEST_A_EXPORT_TARGETS_NAME}"
    FILE "${TEST_A_EXPORT_TARGETS_NAME}.cmake"
    NAMESPACE test_a::
    DESTINATION "${TEST_A_CMAKE_EXPORT_DIR}"
)

message(STATUS "source: ${CMAKE_CURRENT_SOURCE_DIR}")

include(CMakePackageConfigHelpers)

configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/test_a-config.cmake"
  INSTALL_DESTINATION "${TEST_A_CMAKE_EXPORT_DIR}"
)

set_property(
    TARGET test_a
    APPEND PROPERTY
        COMPATIBLE_INTERFACE_STRING test_a_MAJOR_VERSION
)

# generate the version file for the config file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/test_a-config-version.cmake"
  VERSION "${version}"
  COMPATIBILITY AnyNewerVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/test_a-config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/test_a-config-version.cmake"
    DESTINATION "${TEST_A_CMAKE_EXPORT_DIR}"
)

