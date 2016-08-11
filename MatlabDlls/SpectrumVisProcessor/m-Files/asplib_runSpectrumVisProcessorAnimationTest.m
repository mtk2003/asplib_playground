% this script is used to create and test Biquads from asplib

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
plotFPS = 120; % FPS
dBFSScaleVal = 2.0/fftFrameSize;
maxSampleBits = 32;
max_dBFSVal = (6.0206*maxSampleBits + 1.761);
max_dBFSVal = 160;
[x, fS, NBits] = wavread('sweep.wav');
%figure(1)
%plot(x)
maxAmplitude = 0.01;
x = x/max(x);
x = maxAmplitude*x;

asplib_createSpectrumVisProcessor(frameSize, fftFrameSize)

len = size(x,1);
blocks = floor(len/fftFrameSize);
frameTime = 1.0/plotFPS;

figure(1)
for ii=floor(blocks*0.2):blocks-2
  progress = (ii/(blocks-2))*100.0;

  subplot(2, 1, 1)
  y = asplib_processSpectrumVisProcessor(x(fftFrameSize*ii +1 : fftFrameSize*(ii+1) +1));
  %y = max_dBFSVal + y;
  %bar(max(y(1:frameSize/2)/max_dBFSVal, 0))
  bar((y(1:frameSize) + max_dBFSVal)/max_dBFSVal)
  xlim([1, frameSize])
  %ylim([0, 1.5])
  grid on
  title(strcat('progress: ', num2str(progress)))

  subplot(2, 1, 2)
  y_ref = abs(fft(x(fftFrameSize*ii +1 : fftFrameSize*(ii+1) +1)))*2/fftFrameSize;
  bar(y_ref)
  xlim([1, fftFrameSize/2])
  ylim([0, maxAmplitude])
  grid on
  
  pause(frameTime)
end

asplib_destroySpectrumVisProcessor()

% unload asplib_MatlabDll
asplib_unload_SpectrumVisProcessorDll()
