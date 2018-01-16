% Parameters:
%  im - Input image to which noise will be applied (Matrix[2d])
%  tau - Level of noise, provided in the ranges [0-1] and [1-100] (Number)
% Output:
%  im_noise - Output image with added noise
function im_noise = addnoise(im, tau)
[h,w,d] = size(im);

% check/normalisering af tau input
if isscalar(tau)
    if tau > 0 && tau < 1
        
    elseif tau >= 1 && tau <= 100
        tau = tau/100;
    end
else
   error('Error: Invalid tau given to addnoise function.') 
end

% st�jm�nster
r = randn(h,w);
r = r / norm(r, 'fro');

% her ganges tau p� for at styre niveauet af st�j
e = tau * r * norm(im, 'fro');

% l�g st�jm�nsteret til det oprindelige billede
im_noise = im + e;