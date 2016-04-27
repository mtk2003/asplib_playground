#include <iostream>

#include <asplib/Biquad/apslib_BiquadFactory.h>

using namespace std;
using namespace asplib;


int main()
{
  cout << "Hello World!" << endl;

  // create 1 biquad filter structure
  ASPLIB_BIQUAD_HANDLE *biquad = CBiquadFactory::get_Biquads(1, 44100.0f, ASPLIB_OPT_NATIVE);
  if (!biquad)
  {
    cout << "Failed to create biquad handle" << endl;
    return -1;
  }

  // set coefficients
  ASPLIB_BIQUAD_COEFFICIENTS coe;
  coe.a0 = 1.0f;
  coe.a1 = 1.0f;
  coe.a2 = 1.0f;

  coe.b1 = 1.0f;
  coe.b2 = 1.0f;

  ASPLIB_ERR err = CBiquadFactory::set_BiquadCoefficients(biquad, &coe);
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    cout << "Error! CBiquadFactory::set_BiquadCoefficients(...) returned error code: " << err << endl;
    return err;
  }

  // define buffers for input and output signals
  const int frameSize = 256;
  float in[frameSize];
  float out[frameSize];

  for (int ii = 0; ii < frameSize; ii++)
  {
    in[ii] = 1.0f;
    out[ii] = 1.0f;
  }

  // calculate output signal
  err = CBiquadFactory::calc_BiquadSamples(biquad, in, out, frameSize);
  if (err != ASPLIB_ERR_NO_ERROR)
  {
    cout << "Error! CBiquadFactory::calc_BiquadSamples(...) returned error code: " << err << endl;
    return err;
  }
  
  return 0;
}