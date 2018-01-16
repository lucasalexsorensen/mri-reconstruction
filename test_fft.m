size = 256;
no_tex = generate_simdata(size);
with_tex = generate_simdata(size, 'textures/');
sl = phantom('Modified Shepp-Logan');

% 1. række
%subplot(5,3,1)
%imshow(no_tex)
%title('No Textures');
%
%subplot(5,3,2)
%imshow(with_tex)
%title('With Textures');
%
%subplot(5,3,3)
%imshow(sl)
%title('Shepp Logan');
%
% 2. række
%subplot(5,3,4)
%imagesc(abs(log(fftshift(fft2(no_tex)))));
%
%subplot(5,3,5)
%imagesc(abs(log(fftshift(fft2(with_tex)))));
%
%subplot(5,3,6)
%imagesc(abs(log(fftshift(fft2(sl)))));

% 3. række
% subplot(2,3,1)
% imagesc(abs(log(fftshift(fft2(addnoise(no_tex, 0.1))))))
% title('No Textures + 10% noise');
% 
% subplot(2,3,2)
% imagesc(abs(log(fftshift(fft2(addnoise(with_tex, 0.1))))));
% title('Textures + 10% noise');
% 
% subplot(2,3,3)
% imagesc(abs(log(fftshift(fft2(addnoise(sl, 0.1))))));
% title('Shepp Logan + 10% noise');

% 4. række
%subplot(5,3,10)
%imshow(abs(ifft2(fftshift(fft2(no_tex)))));

%subplot(5,3,11)
%imshow(abs(ifft2(fftshift(fft2(with_tex)))));

%ubplot(5,3,12)
%imshow(abs(ifft2(fftshift(fft2(sl)))));

% 5. række
subplot(2,3,1)
imshow(abs(ifft2(fftshift(fft2(addnoise(no_tex, 0.1))))));
title('No Textures + 10% noise');
%
subplot(2,3,2)
imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, 0.1))))));
title('Textures + 10% noise');
%
subplot(2,3,3)
imshow(abs(ifft2(fftshift(fft2(addnoise(sl, 0.1))))));
title('Shepp Logan + 10% noise');

% 5. række
subplot(2,3,4)
imshow(abs(ifft2(fftshift(fft2(addnoise(no_tex, 100))))));
title('No Textures + 100% noise');
%
subplot(2,3,5)
imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, 100))))));
title('Textures + 100% noise');
%
subplot(2,3,6)
imshow(abs(ifft2(fftshift(fft2(addnoise(sl, 100))))));
title('Shepp Logan + 100% noise');