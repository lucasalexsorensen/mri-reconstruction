size = 256;
no_tex = generate_simdata(size);
no_lim = fftshift(fft2(no_tex));
lim = signal_limited(no_lim, 0.1);

subplot(2,2,1)
imshow((no_lim))
title('Not Limited');

subplot(2,2,2)
imshow(lim)
title('Limited');

subplot(2,2,3)
imshow(abs(ifft2(no_lim)));

subplot(2,2,4)
imshow(abs(ifft2(lim)));