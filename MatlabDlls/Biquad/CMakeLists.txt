# sets the solution name
project(BiquadDll)

find_package(Matlab 8.1 REQUIRED)

# set here further source and header files, which should be relative to this file
set(SOURCES BiquadDll.cpp)

set(HEADERS BiquadDll.h
            typedefs.h)

# this will create filters in the visual studio solution
asplib_source_group("${SOURCES}")
asplib_source_group("${HEADERS}")

set(MATLAB_WKS $ENV{APPDATA})
string(REPLACE "\\" "/" MATLAB_WKS ${MATLAB_WKS})
set(MATLAB_WKS "${MATLAB_WKS}/../../documents/MATLAB")
message(STATUS "MATLAB_WKS:${MATLAB_WKS}")

# create the executable
add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS})

target_compile_definitions(${PROJECT_NAME} PRIVATE ASPLIB_DLL_FUNCTION_EXPORT=1)

# add include directories
target_include_directories(${PROJECT_NAME} PRIVATE
                                           $<BUILD_INTERFACE:${MATLAB_INCLUDE_DIR}>)

# link against asplib Biquad component
target_link_libraries(${PROJECT_NAME} asplib::Biquad ${MATLAB_MEX_LIBRARY})
# sets the exectuable output file name
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})

# sets the visual studio solution folder (nested projects)
# NOTE: folders are separated with /
set_property(TARGET ${PROJECT_NAME} PROPERTY FOLDER "MatlabDlls")

# install all into MATLAB's user workspace
if(EXISTS ${MATLAB_WKS})
  install(TARGETS ${PROJECT_NAME} DESTINATION ${MATLAB_WKS}/asplib_playground/bin)
  install(FILES ${HEADERS} DESTINATION ${MATLAB_WKS}/asplib_playground/bin)
  install(DIRECTORY m-Files/ DESTINATION ${MATLAB_WKS}/asplib_playground FILES_MATCHING PATTERN "*.m")
else()
  message(WARNING "Skipped installation of MatlabDll ${PROJECT_NAME} because ${MATLAB_WKS} doesn't exist.")
endif()

add_dependencies(${PROJECT_NAME} asplib)
