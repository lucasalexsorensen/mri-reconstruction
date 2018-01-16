% Parameters:
%  signal - raw fourier signal
%  frac - fraction in the range 0-1, determines how much signal data is
%   kept (Number)
function lim_signal = signal_limited(signal, frac)
[h, w, d] = size(signal);
% check kvadratisk input billede
if h ~= w
    error('Error: non-square signal given to lim_signal.');
end

% check input br�k
if frac < 0 || frac >= 1
    error('Error: frac given to lim_signal is not in the valid range 0-1.')
end

% l�ngden, der skal beholdes
keep_length = frac * h;

% gr�nserne fra centrum og ud
bounds = [round(h/2 - keep_length/2), round(h/2 + keep_length/2)];

% s�t alle pixels til 0, der falder udenfor gr�nserne
for i=1:h
    for j=1:w
        if (i < bounds(1) || i > bounds(2)) || (j < bounds(1) || j > bounds(2))
           signal(i,j) = 0;
        end
    end 
end

lim_signal = signal;