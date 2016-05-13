% this function sets the gain value for a specific biquad filter
%   BiquadIdx = index of the biquad
%   Gain      = gain value for the corresponding biquad filter


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



function asplib_setBiquadGain(BiquadIdx, Gain)
  if not(libisloaded('BiquadDll'))
    disp('[asplib] BiquadDll was not loaded! Please run asplib_load_BiquadDll.m first!');
    return;
  end
  
  % ToDo evaluate err
  err = calllib('BiquadDll', 'set_BiquadGain', uint32(BiquadIdx), single(Gain));
end
