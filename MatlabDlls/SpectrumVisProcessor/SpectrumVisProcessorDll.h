/*
 * Copyright (C) 2014 Achim Turan, Achim.Turan@o2online.de
 * https://github.com/AchimTuran/asplib
 *
 * This file is part of asplib (Achim's Signal Processing LIBrary)
 *
 * asplib (Achim's Signal Processing LIBrary) is free software:
 * you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation,
 * either version 3 of the License, or (at your option) any later version.
 *
 * asplib (Achim's Signal Processing LIBrary) is distributed
 * in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with asplib (Achim's Signal Processing LIBrary).
 * If not, see <http://www.gnu.org/licenses/>.
 *
 */



/*
 * Description about how to use BiquadDll with Matlab:
 *
 * Use loadlibrary('BiquadDll', 'BiquadDll.h')
 * and calllib('BiquadDll', '<function>') to call Dll functions
 */

#ifndef __ASPLIB_MATLABDLL_H__
#define __ASPLIB_MATLABDLL_H__

#include "typedefs.h"

#define ASPLIB_LOGGING_TAG "[asplib] "

#include <mex.h>

#ifdef TARGET_WINDOWS
    #ifdef ASPLIB_DLL_FUNCTION_EXPORT
        #define DLL_EXPORT __declspec(dllexport)
    #else
        #define DLL_EXPORT __declspec(dllimport)
    #endif
#else
	#define DLL_EXPORT
#endif

#ifdef __cplusplus
extern "C" {
#endif

DLL_EXPORT RET_ERR CreateSpectrumVisProcessor(uint32 FrameSize, uint32 fftFrameSize);
DLL_EXPORT RET_ERR DestroySpectrumVisProcessor();
DLL_EXPORT RET_ERR ProcessSpectrumVisProcessor(single *In);

#ifdef __cplusplus
}
#endif

#endif // __ASPLIB_MATLABDLL_H__
