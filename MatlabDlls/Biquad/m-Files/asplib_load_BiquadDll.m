% this script loads the asplib_Matlab.dll library

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

% load asplib_MatlabDll
addpath(fullfile(pwd,'bin')) %add bin folder to path

dll = 'BiquadDll';
dllHeader = 'BiquadDll.h';

if (libisloaded('BiquadDll'))
	disp('[asplib] Reloading BiquadDll');
	calllib('BiquadDll', 'destroy')
	unloadlibrary('BiquadDll');
end

%hfile = fullfile(matlabroot,'extern','include','matrix.h');
%for details of the loadlibrary function see:
%http://www.mathworks.de/de/help/matlab/ref/loadlibrary.html
[dllnotfound, dllwarnings] = loadlibrary(dll, dllHeader, 'alias', 'BiquadDll');
disp('[asplib] Successful loaded BiquadDll');

%ToDo: call init with specific parameters
%calllib('BiquadDll', 'init', parameters)
