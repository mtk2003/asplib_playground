  include(ExternalProject)
  
  set(asplib_COMPONENTS Biquad)
  
  ExternalProject_Add(asplib
                      LOG_DOWNLOAD    1
                      LOG_UPDATE      1
                      LOG_CONFIGURE   1
                      LOG_BUILD       1
                      LOG_INSTALL     1
                      
                      CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/depends/output
                                 -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
                                 -DASPLIB_MODULES_TO_BUILD=${asplib_COMPONENTS}
                      
                      PREFIX          ${CMAKE_BINARY_DIR}/depends/build/asplib
                      TMP_DIR         ${CMAKE_BINARY_DIR}/depends/build/asplib/asplib-tmp
                      STAMP_DIR       ${CMAKE_BINARY_DIR}/depends/build/asplib/asplib-stamp
                      
                      BINARY_DIR      ${CMAKE_BINARY_DIR}/depends/build/asplib/asplib-project
                      
                      #INSTALL_DIR     ${CMAKE_BINARY_DIR}/depends/include
                      SOURCE_DIR      ${CMAKE_BINARY_DIR}/depends/src/asplib
        
                      GIT_REPOSITORY  https://github.com/AchimTuran/asplib.git
                      GIT_TAG         add-spectrum-vis-processor)
                      
set(asplib_INCLUDE_DIRS "${CMAKE_BINARY_DIR}/depends/output/include" "${CMAKE_BINARY_DIR}/depends/output/include/asplib")

# Workaround for not yet created include directories. See https://cmake.org/Bug/view.php?id=15052 for more details
file(MAKE_DIRECTORY ${asplib_INCLUDE_DIRS})

add_library(asplib::Core STATIC IMPORTED)
set_target_properties(asplib::Core PROPERTIES
                                     IMPORTED_LOCATION "${CMAKE_BINARY_DIR}/depends/output/lib/${CMAKE_STATIC_LIBRARY_PREFIX}asplib_Core${CMAKE_STATIC_LIBRARY_SUFFIX}"
                                     INTERFACE_INCLUDE_DIRECTORIES "${asplib_INCLUDE_DIRS}")
                      
add_library(asplib::Biquad STATIC IMPORTED)
set_target_properties(asplib::Biquad PROPERTIES
                                     IMPORTED_LOCATION "${CMAKE_BINARY_DIR}/depends/output/lib/${CMAKE_STATIC_LIBRARY_PREFIX}asplib_Biquad${CMAKE_STATIC_LIBRARY_SUFFIX}"
                                     INTERFACE_INCLUDE_DIRECTORIES "${asplib_INCLUDE_DIRS}")
