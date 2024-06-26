cmake_minimum_required(VERSION 3.4.1)

set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_CXX_STANDARD 11)

# Define a name for this project. It will be accessible with ${PROJECT_NAME}.
project(rapidsnark_module)

# Create a library with the name defined for the project.
# Set it as SHARED library (will generate a .so file)
# Set the source file
add_library(
        ${PROJECT_NAME}
        SHARED
        rapidsnark_module.cpp
)
target_compile_options(${PROJECT_NAME} PRIVATE -Wno-unused-value)

# Import an already existing .so file
# Here, we add a dependency to the shared_library prebuilt
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs)

set(
        SHARED_PROVER_LIBRARY_SO
        ${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${CMAKE_ANDROID_ARCH_ABI}/librapidsnark.so
)
# IMPORTED allows to depends on a library file outside the project.
add_library(
        rapidsnark_prover_lib
        SHARED
        IMPORTED
)
# IMPORTED_LOCATION specifies the location of the library file on disk
set_target_properties(
        rapidsnark_prover_lib
        PROPERTIES
        IMPORTED_LOCATION ${SHARED_PROVER_LIBRARY_SO}
)

#set(
#        SHARED_SDK_LIBRARY_SO
#        ${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${CMAKE_ANDROID_ARCH_ABI}/libpolygonid.so
#)
## IMPORTED allows to depends on a library file outside the project.
#add_library(
#        rapidsnark_sdk_lib
#        SHARED
#        IMPORTED
#)
## IMPORTED_LOCATION specifies the location of the library file on disk
#set_target_properties(
#        rapidsnark_sdk_lib
#        PROPERTIES
#        IMPORTED_LOCATION ${SHARED_SDK_LIBRARY_SO}
#        NO_SONAME 1
#)

# Add libraries to this project
target_link_libraries(
        ${PROJECT_NAME}
        rapidsnark_prover_lib
#        rapidsnark_sdk_lib
)

# Add the log library
find_library(log-lib log)
target_link_libraries(${PROJECT_NAME} ${log-lib})
