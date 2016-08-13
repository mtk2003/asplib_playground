% this script tests the SpectrumVisProcessor module from asplib

%/*
% * Copyright (C) 2014 Achim Turan, Achim.Turan@o2online.de
% * https://github.com/AchimTuran/asplib
% *
% * This file is part of asplib (Achim's Signal Processing LIBrary)
% *
% * asplib (Achim's Signal Processing LIBrary) is free software:
% * you can redistribute it and/or modify it under the terms of the
% * GNU General Public License as published by the Free Software Foundation,
% * either version 3 of the License, or (at your option) any later version.
% *
% * asplib (Achim's Signal Processing LIBrary) is distributed
% * in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% * without even the implied warranty of MERCHANTABILITY or FITNESS
% * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% *
% * You should have received a copy of the GNU General Public License
% * along with asplib (Achim's Signal Processing LIBrary).
% * If not, see <http://www.gnu.org/licenses/>.
% *
% */

% reset workspace
clc
clear all;

% load asplib_SpectrumVisProcessorDll
asplib_load_SpectrumVisProcessorDll()

frameSize = 128;
fftFrameSize = 2048;
nFrames = 1;
dBFSScaleVal = 2.0/fftFrameSize;
maxSampleBits = 32;
max_dBFSVal = (6.0206*maxSampleBits + 1.761)*0.3;
fA = 44100;
f0FFTBin = 100;
f0Shift = 1.0;
f0 = 44100/fftFrameSize*f0FFTBin*f0Shift;
t = 0:1/fA:nFrames*fftFrameSize/fA;
A = 1.0;
x = A*sin(2*pi*f0*t);
figure(1)
plot(t, x)
figure(2)
X = max_dBFSVal + 20.0*log10(abs(fft(x(1:fftFrameSize)*dBFSScaleVal)));
bar(max(X(1:fftFrameSize/2)/max_dBFSVal, 0));
xlim([1, fftFrameSize/2])


asplib_createSpectrumVisProcessor(frameSize, fftFrameSize)

y = asplib_processSpectrumVisProcessor(x);

asplib_destroySpectrumVisProcessor()

% unload asplib_MatlabDll
asplib_unload_SpectrumVisProcessorDll()

figure(3)
%y = max_dBFSVal + y;
plot(y(1:frameSize/2))
xlim([1, frameSize/2])
