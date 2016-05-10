# sets the solution name
project(Exectuables_ComputeDeviceInfo)

# set here further source and header files, which should be relative to this file
set(SOURCES main.cpp)

# this will create filters in the visual studio solution
asplib_source_group("${SOURCES}")

# create the executable
add_executable(${PROJECT_NAME} ${SOURCES})

#find_package(asplib REQUIRED Biquad)

# link against asplib Biquad component
target_link_libraries(${PROJECT_NAME} asplib::ComputeDeviceInfo)
# sets the exectuable output file name
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})

# sets the visual studio solution folder (nested projects)
# NOTE: folders are separated with /
set_property(TARGET ${PROJECT_NAME} PROPERTY FOLDER "Exectuables")
