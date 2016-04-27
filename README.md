## Introduction
This repository contains testing code for [asplib](http://github.com/AchimTuran/asplib), which is a digital signal processing library. 
It shows how to use asplib or can help to develop new algorithms for asplib. Furthermore this repository explains how to use modern CMake 
with imported- and exported-targetrs,  automatically download, build and use asplib for this or your project.

Currently it used for the Kodi binary add-ons [visualization.pictureit](https://github.com/linuxwhatelse/visualization.pictureit) and [adsp.biquad.filters](https://github.com/kodi-adsp/adsp.biquad.filters).

## How to Build and Use asplib_playground
1. Clone the repository with `git clone http://github.com/AchimTuran/asplib_playground`
2. Open the cloned repository path and run one of the included `build_solution_<VS-Version>.cmd` or build_solution_<VS-Version>_x64.cmd (64 Bit build)
3. Open the Visual Studio solution `asplib_playground.sln` inside `build_<VS-Version>` or `build_<VS-Version>_x64.cmd` (depends on the script from step 2)


## Matlab 2013a with Visual Studio 2013
1. Download the zip file [from](http://www.mathworks.com/matlabcentral/fileexchange/45878-setting-microsoft-visual-c++-2013-as-default-mex-compiler) and extract it some where
2. Follow the steps in instructions.txt
3. Start MATLAB and run `mex -setup`, which will setup the compiler for MATLAB

## Useful links
* CMake Guides
  * [Useful CMake variables](https://cmake.org/Wiki/CMake_Useful_Variables)
  * [Modern CMake with target_link_libraries](https://schneide.wordpress.com/2016/04/08/modern-cmake-with-target_link_libraries/) by mariuselvert
  * [The Ultimate Guide to Modern CMake](https://rix0r.nl/blog/2015/08/13/cmake-guide/) by rix0rrr
  * [CMake - Introduction and best practices](http://www.slideshare.net/DanielPfeifer1/cmake-48475415) by Daniel Pfeifer


-------------
#### License
[GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007](https://github.com/kodi-adsp/adsp.freesurround/blob/master/LICENSE.md)
