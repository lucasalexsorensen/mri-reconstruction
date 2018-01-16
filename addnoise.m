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

% støjmønster
r = randn(h,w);
r = r / norm(r, 'fro');
e = tau * r * norm(im, 'fro');

% return
im_noise = im + e;