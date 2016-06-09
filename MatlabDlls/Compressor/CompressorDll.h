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

DLL_EXPORT RET_ERR create_Biquad(uint32 BiquadAmount);
DLL_EXPORT RET_ERR process_Biquads(single *Data, uint32 MaxFrames);
DLL_EXPORT RET_ERR set_BiquadGain(uint32 BiquadIdx, single Gain);
DLL_EXPORT RET_ERR set_BiquadGains(single Gain);
DLL_EXPORT RET_ERR set_BiquadCoefficients(mxArray *Coefficients, uint32 BiquadIdx, single C0, single D0);
DLL_EXPORT RET_ERR set_BiquadsCoefficients(mxArray *Coefficients, single C0, single D0);

DLL_EXPORT RET_ERR init_asplib(single SampleFrequency, uint32 MaxChannels, uint32 MaxFrameSize);
DLL_EXPORT void destroy();

#ifdef __cplusplus
}
#endif

#endif // __ASPLIB_MATLABDLL_H__
