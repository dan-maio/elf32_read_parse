# common-elf-reader — standalone ARM ELF32-LE reader/parser.
#
# Produces a small static library plus an INTERFACE include target so both
# consumers (cortexm-shared-loader, shared-static-rework) can link the exact
# same parser with one API.
#
#   add_subdirectory(common-elf-reader)      # or FetchContent / submodule
#   target_link_libraries(my_loader PRIVATE common-elf-reader::elf-reader)
#
# Options:
#   SCL_HOSTED=ON   enable std::vector helpers (elf_image::collect_relocations)
#                   for host tools/tests. Leave OFF for freestanding firmware.

cmake_minimum_required(VERSION 3.16)
project(common_elf_reader LANGUAGES CXX)

option(SCL_HOSTED "Enable hosted (std::vector) helpers" OFF)

add_library(elf-reader STATIC
    src/elf-image.cpp
)
add_library(common-elf-reader::elf-reader ALIAS elf-reader)

target_include_directories(elf-reader PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_compile_features(elf-reader PUBLIC cxx_std_20)

if(SCL_HOSTED)
    target_compile_definitions(elf-reader PUBLIC SCL_HOSTED)
endif()
