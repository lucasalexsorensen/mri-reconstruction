size = 256;
with_tex = generate_simdata(size, 'textures/');

% noise_vector = linspace(0.1,0.9,30);
% lim_vector = linspace(0.9,0.1,30);
% noise_errors = zeros(1,length(noise_vector));
% lim_errors = zeros(1,length(lim_vector));
% combined_errors = zeros(1,length(noise_vector));
% 
% for i=1:length(noise_vector)
%     recon = abs(ifft2(fftshift(fft2(addnoise(with_tex, noise_vector(i))))));
%     err = error_measure(with_tex, recon);
%     noise_errors(i) = err;
% end
% 
% for i=1:length(lim_vector)
%     recon = abs(ifft2(fftshift(fft2(signal_limited(with_tex, lim_vector(i))))));
%     err = error_measure(with_tex, recon);
%     lim_errors(i) = err;
% end
% 
% for i=1:length(noise_vector)
%     recon = abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex, noise_vector(i)), lim_vector(i))))));
%     err = error_measure(with_tex, recon);
%     combined_errors(i) = err;
% end

% subplot(3,3,1)
% imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, noise_vector(1)))))));
% title(sprintf('%g st�jniveau\n%g procent fejl', noise_vector(1), noise_errors(1)*100));
% 
% subplot(3,3,2)
% imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, noise_vector(15)))))));
% title(sprintf('%g st�jniveau\n%g procent fejl', noise_vector(15), noise_errors(15)*100));
% 
% subplot(3,3,3)
% imshow(abs(ifft2(fftshift(fft2(addnoise(with_tex, noise_vector(end)))))));
% title(sprintf('%g st�jniveau\n%g procent fejl', noise_vector(end), noise_errors(end)*100));
% 
% subplot(3,3,4)
% imshow(abs(ifft2(signal_limited(fftshift(fft2(with_tex)), lim_vector(end)))));
% title(sprintf('%g sample\n%g procent fejl', lim_vector(end), lim_errors(end)*100));
% 
% subplot(3,3,5)
% imshow(abs(ifft2(signal_limited(fftshift(fft2(with_tex)), lim_vector(15)))));
% title(sprintf('%g sample\n%g procent fejl', lim_vector(15), lim_errors(15)*100));
% 
% subplot(3,3,6)
% imshow(abs(ifft2(signal_limited(fftshift(fft2(with_tex)), lim_vector(1)))));
% title(sprintf('%g sample\n%g procent fejl', lim_vector(1), lim_errors(1)*100));
% 
% subplot(3,3,7)
% imshow(abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex,noise_vector(1)), lim_vector(1)))))));
% title(sprintf('%g st�j- og samplingniveau\n%g procent fejl', noise_vector(1), combined_errors(1)*100));
%  
% subplot(3,3,8)
% imshow(abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex,noise_vector(15)), lim_vector(15)))))));
% title(sprintf('%g st�j- og samplingniveau\n%g procent fejl', noise_vector(15), combined_errors(15)*100));
% 
% subplot(3,3,9)
% imshow(abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex,noise_vector(end)), lim_vector(end)))))));
% title(sprintf('%g st�j- og samplingniveau\n%g procent fejl', noise_vector(end), combined_errors(end)*100));
% 
% return;

% 
% return;
% 

points = 50;
noiseX = linspace(0.0, 0.99, points);
sampleY = linspace(0.0, 0.99, points);
errorPoints = zeros(points,points);

for n=1:points
    for s=1:points
        errorPoints(s,n) = error_measure(with_tex, abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex, noiseX(n)), sampleY(s)))))));
    end
end

[X,Y] = meshgrid(noiseX,sampleY);
surf(X,Y,errorPoints);
title('Fejlm�l v. varierende st�j- og samplingniveau');
xlabel('St�jniveau (%)')
ylabel('Samplingandel (%)')
return;


% plot(noise_vector, noise_errors, '-',...
%     'LineWidth',2);
% hold on;
% plot(lim_vector, lim_errors, '-',...
%     'LineWidth',2);
% plot(noise_vector, combined_errors, '-g',...
%     'LineWidth',2);
% title('Fejlm�l versus st�j og sampling')
% xlabel('St�j/Samplingniveau (%)')
% ylabel('Fejlm�l (%)')
% legend('St�jvektor','Sampling vektor', 'Kombineret','Location','Southwest')