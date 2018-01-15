size = 256;
with_tex = generate_simdata(size, 'textures/');

noise_vector = linspace(0.1,0.9,30);
lim_vector = linspace(0.1,0.9,30);
noise_errors = zeros(1,length(noise_vector));
lim_errors = zeros(1,length(lim_vector));
combined_errors = zeros(1,length(noise_vector));

for i=1:length(noise_vector)
    recon = abs(ifft2(fftshift(fft2(addnoise(with_tex, noise_vector(i))))));
    err = error_measure(with_tex, recon);
    noise_errors(i) = err;
end

for i=1:length(lim_vector)
    recon = abs(ifft2(fftshift(fft2(signal_limited(with_tex, lim_vector(i))))));
    err = error_measure(with_tex, recon);
    lim_errors(i) = err;
end

for i=1:length(noise_vector)
    recon = abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex, noise_vector(i)), lim_vector(i))))));
    err = error_measure(with_tex, recon);
    combined_errors(i) = err;
end

plot(noise_vector, noise_errors, '-',...
    'LineWidth',2);
hold on;
plot(lim_vector, lim_errors, '-',...
    'LineWidth',2);
plot(noise_vector, combined_errors, '-g',...
    'LineWidth',2);
legend('Noise Vector','Limit Vector', 'Combined')