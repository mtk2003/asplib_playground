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



#include <string>
using namespace std;

// Matlab include files
#include <mex.h>

#include "CompressorDll.h"

// buffers
single *g_Inbuffers = NULL;
single *g_Outbuffers = NULL;
single **g_Channels = NULL;

// signal processing parameters
unsigned int g_MaxChannels = 0;     // max in-/output channels
unsigned int g_MaxFrameSize = 0;    // max in-/output framelength
single g_SampleFrequency = 0.0f;    // sample frequency


// matlab <--> C/C++ control variables
bool g_InitSuccess = false;

// Biquad helper function prototypes
void destroy_Biquads();


// ---------------------------------------- Biquad helper functions ----------------------------------------

#ifdef __cplusplus
extern "C" {
#endif
  // ---------------------------------------- Biquad functions ----------------------------------------
  DLL_EXPORT RET_ERR create_Compressor(uint32 BiquadAmount)
  {
    mexPrintf("%ssuccessful created compressor handle with\n", ASPLIB_LOGGING_TAG);

    return ERR_NO_ERROR;
  }

  DLL_EXPORT RET_ERR process_Compressor(single *Data, uint32 MaxFrames)
  {
    if (Data == NULL || !MaxFrames)
    {
      string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! Failed to created biquad handle.\n");
      mexErrMsgTxt(errStr.c_str());
      return ERR_INVALID_INPUT;
    }

//    if (!g_BiquadHandle || !g_InitSuccess)
//    {
//      string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! BiquadDll is not correctly initialized.\n");
//      mexErrMsgTxt(errStr.c_str());
//      return ERR_FATAL_ERROR;
//    }

    //// copy Data to internal buffer
    //memcpy(g_Inbuffers, Data, sizeof(single)*g_MaxChannels*g_MaxFrameSize);

    // process samples
  //  CBiquadFactory::calc_BiquadSamples(g_BiquadHandle, Data, Data, MaxFrames);
    //CBiquadFactory::calc_BiquadSamples(g_BiquadHandle, g_Inbuffers, g_Outbuffers, g_MaxFrameSize);
    //memcpy(g_Outbuffers, g_Inbuffers, sizeof(single)*g_MaxChannels*g_MaxFrameSize);

    //// copy from internal output to Data
    //memcpy(g_Outbuffers, Data, sizeof(single)*g_MaxChannels*g_MaxFrameSize);

    return ERR_NO_ERROR;
  }

  DLL_EXPORT RET_ERR init_asplib(single SampleFrequency, uint32 MaxChannels, uint32 MaxFrameSize)
  {
    if (MaxChannels == 0 || MaxFrameSize == 0 || SampleFrequency <= 0.0f)
    {
      string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! MaxFrames == 0 or MaxChannels == 0 or MaxFrameSize == 0 or ProcessingData_fA <= 0.0f\n");
      mexErrMsgTxt(errStr.c_str());
      return ERR_INVALID_INPUT;
    }

    mexPrintf("%sinitialize BiquadDll\n", ASPLIB_LOGGING_TAG);
    g_MaxChannels = MaxChannels;
    g_MaxFrameSize = MaxFrameSize;
    g_SampleFrequency = SampleFrequency;

    // create internal buffers
    g_Inbuffers = new single[g_MaxChannels*g_MaxFrameSize];
    g_Outbuffers = new single[g_MaxChannels*g_MaxFrameSize];
    g_Channels = new single*[g_MaxChannels];
    if (!g_Inbuffers || !g_Outbuffers || !g_Channels)
    {
      string errStr = string(ASPLIB_LOGGING_TAG) + string("Error! Could not create internal buffers. Not enough free memory?\n");
      mexErrMsgTxt(errStr.c_str());
      delete[] g_Inbuffers;
      delete[] g_Outbuffers;
      delete[] g_Channels;
      return ERR_FATAL_ERROR;
    }

    for (unsigned int ii = 0; ii < g_MaxChannels; ii++)
    {
      g_Channels[ii] = &g_Outbuffers[ii*g_MaxFrameSize];
    }

    g_InitSuccess = true;

    return ERR_NO_ERROR;
  }

  DLL_EXPORT void destroy_Compressor()
  {
    mexPrintf("%sdestroying BiquadDll\n", ASPLIB_LOGGING_TAG);

    delete[] g_Channels;
    g_Channels = NULL;

    delete[] g_Inbuffers;
    g_Inbuffers = NULL;

    delete[] g_Outbuffers;
    g_Outbuffers = NULL;

    g_SampleFrequency = 0.0f;
    g_Channels = 0;
    g_MaxChannels = 0;
    g_InitSuccess = false;

    mexPrintf("%sdestroyed BiquadDll\n", ASPLIB_LOGGING_TAG);
  }
#ifdef __cplusplus
}
#endif