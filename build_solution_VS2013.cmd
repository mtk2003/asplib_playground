@ECHO off

cls

set build_dir=build_VS2013
set cur_dir=%cd%

if not defined DevEnvDir (
  call "%VS120COMNTOOLS%..\..\VC\bin\vcvars32.bat"
)

::if not exist package mkdir package

if not exist %build_dir% mkdir %build_dir% 
cd %build_dir%

cmake -G "Visual Studio 12 2013" -DCMAKE_INSTALL_PREFIX="./bin" ".."
msbuild /M asplib_playground.sln
cmake --build . --target INSTALL

cd %cur_dir%

pause
