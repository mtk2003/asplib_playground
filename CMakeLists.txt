cmake_minimum_required(VERSION 3.0)



project(asplib_playground VERSION 1.0)
# TODO solve 'Enable C++ exceptions' to 'NO' and I got warning: warning C4530: C++ exception handler used, 
#             but unwind semantics are not enabled. Specify /EHsc'
# Solution: http://stackoverflow.com/questions/552695/how-can-i-switch-off-exception-handling-in-msvc

# make sure CMAKE_PREFIX_PATH is set
file(TO_CMAKE_PATH "${CMAKE_PREFIX_PATH}" CMAKE_PREFIX_PATH)
#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}/depends/out")
message(STATUS "CMAKE_BINARY_DIR=${CMAKE_BINARY_DIR}")
#set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/depends/output/)
#set(CMAKE_PREFIX_PATH D:/DevProjects/myLibs/asplib_playground/build_VS2013_x64/depends/output/lib/cmake/asplib-1.0)
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/depends/output/)
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/depends/output/lib)

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/depends/build)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake/depends"
                        -DCMAKE_INSTALL_PREFIX=
                        ${OUTPUT_QUIET}
                        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/depends/build")
                    
execute_process(COMMAND ${CMAKE_COMMAND} --build .
                        ${OUTPUT_QUIET}
                        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/depends/build")

find_package(asplib 1.0 REQUIRED)

include(cmake/asplib_helpers.cmake)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
message(STATUS "CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}")

foreach(path ${CMAKE_PREFIX_PATH})
  message(STATUS "CMAKE_PREFIX_PATH=${path}")
endforeach()


set(asplib_PLAYGROUND_DESCRIPTION "asplib (Achim's Signal Processing LIBrary), is a small and lightweight C++ library for digital signal processing.")

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

if(CMAKE_SYSTEM_NAME MATCHES Windows)
  add_definitions(-DTARGET_WINDOWS)

  # Enable the orginization of projects with folders
  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endif()

add_subdirectory(Exectuables)
add_subdirectory(MatlabDlls)
        
# Print project configuration
message(STATUS "${CMAKE_PROJECT_NAME} - Configuration:")
message(STATUS "CMAKE_BUILD_TYPE:     ${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
