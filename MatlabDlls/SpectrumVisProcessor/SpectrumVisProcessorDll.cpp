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



#include "asplib/SpectrumVisProcessor/asplib_SpectrumVisProcessor.hpp"
#include "asplib/SpectrumVisProcessor/asplib_SpectrumVisProcessorConfigurator.hpp"

// Matlab include files
#include <mex.h>

#include "SpectrumVisProcessorDll.h"

#include <iostream>
#include <string>

using namespace std;
using namespace asplib;


// ---------- global variables ---------
float *g_InternalBuffer  = nullptr;

// --------- global SpectrumVisProcessor variables --------- 
uint32_t                          g_FrameSize = 0;
bool                              g_IsCreated = false;
CSpectrumVisProcessor             g_SpectrumVisProcessor;
CSpectrumVisProcessorConfigurator g_Configurator;


#ifdef __cplusplus
extern "C" {
#endif

// ---------------------------------------- Spectrum Visualization Processor ----------------------------------------
DLL_EXPORT RET_ERR CreateSpectrumVisProcessor(uint32 FrameSize, uint32 fftFrameSize)
{
  ASPLIB_ERR err = g_SpectrumVisProcessor.Create(g_Configurator, FrameSize, fftFrameSize);
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! Failed to create SpectrumVisProcessor.\n");
    mexErrMsgTxt(errStr.c_str());
    return ERR_INVALID_INPUT;
  }

  err = g_SpectrumVisProcessor.GetPostProcessFrameSize(g_FrameSize);
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! Failed to get SpectrumVisProcessor frame size.\n");
    mexErrMsgTxt(errStr.c_str());
    return ERR_INVALID_INPUT;
  }

  g_IsCreated       = true;
  g_InternalBuffer  = new float[FrameSize];

  return ERR_NO_ERROR;
}

DLL_EXPORT RET_ERR DestroySpectrumVisProcessor()
{
  delete[] g_InternalBuffer;
  g_InternalBuffer = nullptr;
  
  g_FrameSize = 0;

  ASPLIB_ERR err = g_SpectrumVisProcessor.Destroy();
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! Failed to destroy SpectrumVisProcessor.\n");
    mexErrMsgTxt(errStr.c_str());
  }

  return ERR_NO_ERROR;
}


DLL_EXPORT RET_ERR ProcessSpectrumVisProcessor(single *In)
{
  if (!g_IsCreated)
  {
    string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! SpectrumVisProcessor is not created.\n");
    mexErrMsgTxt(errStr.c_str());
    return ERR_NOT_INIT;
  }

  ASPLIB_ERR err = g_SpectrumVisProcessor.Process(In, g_InternalBuffer);
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    return ERR_FATAL_ERROR;
  }
  std::copy_n(g_InternalBuffer, g_FrameSize, (float*)In);

  return ERR_NO_ERROR;
}

#ifdef __cplusplus
}
#endif
