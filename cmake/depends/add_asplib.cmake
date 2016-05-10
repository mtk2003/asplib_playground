include(ExternalProject)

set(ASPLIB_COMPOENTS Biquad SpectrumVisProcessor)
  
ExternalProject_Add(asplib
                    LOG_DOWNLOAD    1
                    LOG_UPDATE      1
                    LOG_CONFIGURE   1
                    LOG_BUILD       1
                    LOG_INSTALL     1
                    
                    
                    CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/../output"
                               "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
                               #"-DASPLIB_MODULES_TO_BUILD='${ASPLIB_COMPOENTS}'"
                               # This is quite an ugly hack, because CMake does not support
                               # separated arguments like Biquad;FFT!
                               # The workaround is to define ASPLIB_MODULES_TO_BUILD
                               # with an module name that isn't supported by asplib and
                               # manually set the required ON/OFF options for 
                               # every required module.
                               #-DASPLIB_MODULES_TO_BUILD="${ASPLIB_COMPOENTS}" # TODO: Ask fetzerch why Biquad;FFT is not possible!
                               -DASPLIB_MODULES_TO_BUILD=custom # TODO: Ask fetzerch why Biquad;FFT is not possible!
                               -DBUILD_BIQUAD=ON
                               -DBUILD_SPECTRUMVISPROCESSOR=ON
                               -DBUILD_COMPUTEDEVICEINFO=ON
                               #-DBUILD_AUDIOINTERFACES=OFF
                               #-DBUILD_FFT=OFF
                               #-DBUILD_IIR=OFF
                               #-DBUILD_LOGGER=OFF
                               #-DBUILD_SIGNALS=OFF
                               #-DBUILD_TIMER=OFF
                    
                    PREFIX          ${CMAKE_BINARY_DIR}/workspace/asplib
                    TMP_DIR         ${CMAKE_BINARY_DIR}/workspace/asplib/tmp
                    STAMP_DIR       ${CMAKE_BINARY_DIR}/workspace/asplib/stamp
                    
                    BINARY_DIR      ${CMAKE_BINARY_DIR}/workspace/asplib/project
                    
                    #INSTALL_DIR     ${CMAKE_BINARY_DIR}/depends/include
                    SOURCE_DIR      ${CMAKE_BINARY_DIR}/src/asplib
      
                    GIT_REPOSITORY  https://github.com/AchimTuran/asplib.git
                    GIT_TAG         add-spectrum-vis-processor)
