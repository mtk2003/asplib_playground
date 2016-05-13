% this function sets the biquad coefficients for all earlier created biquad filters
%   Coefficients = one dimensional array, which contains the biquad coefficients [a0, a1, a2, b1, b2]
%   C0           = common gain value for one biquad filter, default is 1.0
%   D0           = gain value for mixing the input signal into the output signal, default is 0.0


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



function asplib_setBiquadsCoefficients(Coefficients, C0, D0)
    if not(libisloaded('BiquadDll'))
      disp('[asplib] BiquadDll is not loaded! Please run asplib_load_BiquadDll.m first!');
      return;
    end
   
    % ToDo evaluate err
    err = calllib('BiquadDll', 'set_BiquadsCoefficients', single(Coefficients), single(C0), single(D0));
end
