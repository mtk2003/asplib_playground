@ECHO off

cls

set build_dir=build_VS2015_x64
set cur_dir=%cd%

if not defined DevEnvDir (
  call "%VS140COMNTOOLS%..\..\VC\bin\vcvars32.bat"
)

::if not exist package mkdir package

if not exist %build_dir% mkdir %build_dir% 
cd %build_dir%

cmake -G "Visual Studio 14 2015 Win64" -DCMAKE_INSTALL_PREFIX="./%build_dir%" ".."
msbuild /M asplib_playground.sln
cmake --build . --target INSTALL

cd %cur_dir%

pause
