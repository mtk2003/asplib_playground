cmake_minimum_required(VERSION 3.0)

project(depends VERSION 1.0)
message(STATUS "Downloading/Building asplib Playground project...")


# TODO solve 'Enable C++ exceptions' to 'NO' and I got warning: warning C4530: C++ exception handler used, 
#             but unwind semantics are not enabled. Specify /EHsc'
# Solution: http://stackoverflow.com/questions/552695/how-can-i-switch-off-exception-handling-in-msvc

# make sure CMAKE_PREFIX_PATH is set
#file(TO_CMAKE_PATH "${CMAKE_PREFIX_PATH}" CMAKE_PREFIX_PATH)
#list(APPEND CMAKE_PREFIX_PATH "${CMAKE_INSTALL_PREFIX}/depends/out")
#message(STATUS "CMAKE_BINARY_DIR=${CMAKE_BINARY_DIR}")
#list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/depends/output/)
#list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR}/depends/output/lib)

if (NOT ASPLIB_DEPENDS_SRC_PREFIX)
  set(ASPLIB_DEPENDS_SRC_PREFIX ${CMAKE_BINARY_DIR}/src)
  set(ASPLIB_DEPENDS_DOWNLOAD TRUE)
else()
  set(ASPLIB_DEPENDS_DOWNLOAD FALSE)
endif()

include(add_asplib.cmake)

#set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
#message(STATUS "CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
#message(STATUS "CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}")

#foreach(path ${CMAKE_PREFIX_PATH})
  #message(STATUS "path=${path}")
#endforeach()

      
# Print project configuration
#message(STATUS "${CMAKE_PROJECT_NAME} - Configuration:")
#message(STATUS "CMAKE_BUILD_TYPE:     ${CMAKE_BUILD_TYPE}")
#message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
