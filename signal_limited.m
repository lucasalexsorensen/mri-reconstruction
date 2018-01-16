% Parameters:
%  signal - raw fourier signal
%  frac - fraction in the range 0-1, determines how much signal data is
%   kept (Number)
function lim_signal = signal_limited(signal, frac)
[h, w, d] = size(signal);
if h ~= w
    error('Error: non-square signal given to lim_signal.');
end

if frac < 0 || frac >= 1
    error('Error: frac given to lim_signal is not in the valid range 0-1.')
end

keep_length = frac * h;

bounds = [round(h/2 - keep_length/2), round(h/2 + keep_length/2)];

for i=1:h
    for j=1:w
        if (i < bounds(1) || i > bounds(2)) || (j < bounds(1) || j > bounds(2))
           signal(i,j) = 0;
        end
    end 
end
lim_signal = signal;