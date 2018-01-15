sl = phantom('Modified Shepp-Logan',200);

sl_noise = addnoise(sl, 0.2);

subplot(2,2,1)
imagesc(sl)
title('Without noise');

subplot(2,2,2)
imagesc(sl_noise)
title('With noise');

subplot(2,2,3)
imagesc(abs(fftshift(fft2(sl_noise))));

subplot(2,2,4)
imagesc(abs(fftshift(fft2(sl))));