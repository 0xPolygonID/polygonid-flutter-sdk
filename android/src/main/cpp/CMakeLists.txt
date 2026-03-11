cmake_minimum_required(VERSION 3.4.1)

set (CMAKE_VERBOSE_MAKEFILE ON)
set (CMAKE_CXX_STANDARD 11)

# Define a name for this project. It will be accessible with ${PROJECT_NAME}.
project(polygonid_module)

# Create a library with the name defined for the project.
# Set it as SHARED library (will generate a .so file)
# Set the source file
add_library(
        ${PROJECT_NAME}
        SHARED
        polygonid_module.cpp
)
target_compile_options(${PROJECT_NAME} PRIVATE -Wno-unused-value)

# Import an already existing .so file
# Here, we add a dependency to the shared_library prebuilt
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/)
set(
        SHARED_PROVER_LIBRARY_SO
        ${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${CMAKE_ANDROID_ARCH_ABI}/libpolygonid.so
)
# IMPORTED allows to depends on a library file outside the project.
add_library(
        polygonid_lib
        SHARED
        IMPORTED
)
# IMPORTED_LOCATION specifies the location of the library file on disk
set_target_properties(
        polygonid_lib
        PROPERTIES
        IMPORTED_LOCATION ${SHARED_PROVER_LIBRARY_SO}
        SONAME libpolygonid.so
)
# Add 16 KB alignment for ARM64 / x86_64
target_link_options(${PROJECT_NAME} PRIVATE "-Wl,-z,max-page-size=16384")
# Add the library to this project
target_link_libraries(
        ${PROJECT_NAME}
        polygonid_lib
)

# Add the log library
find_library( log-lib log )
target_link_libraries( ${PROJECT_NAME} ${log-lib} )
