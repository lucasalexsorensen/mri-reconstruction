size = 256;
no_tex = generate_simdata(size);
with_tex = generate_simdata(size, 'textures/');
sl = phantom('Modified Shepp-Logan');

% 1. række
subplot(5,3,1)
imshow(no_tex)
title('No Textures');

subplot(5,3,2)
imshow(with_tex)
title('With Textures');

subplot(5,3,3)
imshow(sl)
title('Shepp Logan');

% 2. række
subplot(5,3,4)
imagesc(abs(log(fftshift(fft2(no_tex)))));

subplot(5,3,5)
imagesc(abs(log(fftshift(fft2(with_tex)))));

subplot(5,3,6)
imagesc(abs(log(fftshift(fft2(sl)))));

% 3. række
subplot(5,3,7)
imagesc(abs(log(fftshift(fft2(addnoise(no_tex, 0.1))))));

subplot(5,3,8)
imagesc(abs(log(fftshift(fft2(addnoise(with_tex, 0.1))))));

subplot(5,3,9)
imagesc(abs(log(fftshift(fft2(addnoise(sl, 0.1))))));

% 4. række
subplot(5,3,10)
imshow(abs(ifft2(fftshift(fft2(no_tex)))));

subplot(5,3,11)
imshow(abs(ifft2(fftshift(fft2(with_tex)))));

subplot(5,3,12)
imshow(abs(ifft2(fftshift(fft2(sl)))));

% 5. række
subplot(5,3,13)
imshow(abs(ifft2(fftshift(fft2(addnoise(no_tex, 100))))));

subplot(5,3,14)
imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, 100))))));

subplot(5,3,15)
imshow(abs(ifft2(fftshift(fft2(addnoise(sl, 100))))));