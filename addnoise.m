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