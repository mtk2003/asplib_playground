@ECHO off

cls

set build_dir=build_VS2013_x64
set cur_dir=%cd%

if not defined DevEnvDir (
  call "%VS120COMNTOOLS%..\..\VC\bin\vcvars32.bat"
)

::if not exist package mkdir package

if not exist %build_dir% mkdir %build_dir% 
cd %build_dir%

cmake -G "Visual Studio 12 2013 Win64" -DCMAKE_INSTALL_PREFIX="./%build_dir%" ".."
msbuild /M asplib_playground.sln
cmake --build . --target INSTALL

cd %cur_dir%

pause
