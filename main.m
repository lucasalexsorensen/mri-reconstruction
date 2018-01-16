% clear all;
% clc;
% generelle variabler
size = 256;
no_tex = generate_simdata(size);
with_tex = generate_simdata(size, './cn/textureFiles/');
sl = phantom('Modified Shepp-Logan');

% load test data (NB: disse kan ændre sig)
head = load('./cn/head.mat');
A = load('./cn/A.mat');
B = load('./cn/B.mat');

% I slutningen af scriptet er den lokale funktion to_sig defineret,
%  som laver fftshift og fft2 af inputtet

%%%% 3x3 billed/signal plots %%%%
% først vil vi generere et 3x3 subplot med forskellige billeder/signaler
% første plot vindue
figure(1);
% 1. række
subplot(3,3,1);
imshow(no_tex);
title('No Textures');

subplot(3,3,2);
imshow(with_tex);
title('With Textures');

subplot(3,3,3);
imshow(sl);
title('Shepp Logan');

% 2. række
subplot(3,3,4);
imagesc(abs(log(to_sig(no_tex))));
title('No Textures (signal)');

subplot(3,3,5);
imagesc(abs(log(to_sig(with_tex))));
title('With Textures (signal)');

subplot(3,3,6);
imagesc(abs(log(to_sig(sl))));
title('Shepp Logan (signal)');

% 3. række
subplot(3,3,7);
imagesc(abs(log(to_sig(addnoise(no_tex, 0.1)))));
title('No Textures (10% noise)');

subplot(3,3,8);
imagesc(abs(log(to_sig(addnoise(with_tex, 0.1)))));
title('With Textures (10% noise)');

subplot(3,3,9);
imagesc(abs(log(to_sig(addnoise(sl, 0.1)))));
title('Shepp Logan (10% noise)');

%%%% 2x2 rekonstruktion af samplet/nonsamplet signal %%%%
% andet plot vindue
figure(2);
% 1. række
subplot(2,2,1);
imshow(to_sig(no_tex));
title('Fully Sampled')

subplot(2,2,2);
imshow(signal_limited(to_sig(no_tex), 0.1));
title('10% Sampled')

% 2. række
subplot(2,2,3);
imshow(abs(ifft2(to_sig(no_tex))));
title('Fully Sampled reconstructed');

subplot(2,2,4);
imshow(abs(ifft2(signal_limited(to_sig(no_tex), 0.1))));
title('10% Sampled reconstructed');

%%%% 3d overfladeplot af støj/samplingniveauer og fejlmål %%%%
% 3. vindue
figure(3);
points = 10; % antal test niveauer
noiseX = linspace(0.0, 0.99, points); % støjaksen
sampleY = linspace(0.0, 0.99, points); % samplingaksen
errorPoints = zeros(points,points); % tom fejlmåls matrix (Z)

% iterér over alle punkter på begge akser (points x points operationer)
for n=1:points
    for s=1:points
        % tilføj fejlmål til matrix for nuværende n- og s-index
        errorPoints(s,n) = error_measure(with_tex, abs(ifft2(fftshift(fft2(signal_limited(addnoise(with_tex, noiseX(n)), sampleY(s)))))));
    end
end

[X,Y] = meshgrid(noiseX,sampleY); % opstil 2d-grundflade
surf(X,Y,errorPoints); % plot 3d-flade
view([-115.9 12.4]); % indstil kameravinkel
title('Fejlmål v. varierende støj- og samplingniveau');
xlabel('Støjniveau (%)')
ylabel('Samplingandel (%)')

%%%% 3x3 plot af billede ved udvalgte støj- og samplingniveauer %%%%
% 4. vindue
figure(4);

% udvalgte niveauer
noise_vals = [0.1, 0.5, 0.9];
sample_vals = [0.1, 0.5, 0.9];

og_sig = to_sig(with_tex); % uforstyrret signal
% 1. række (støj)
subplot(3,3,1);
s = to_sig(addnoise(with_tex, noise_vals(1)));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g støjniveau\n%g procent fejl', noise_vals(1), error_measure(with_tex, i)*100));

subplot(3,3,2);
s = to_sig(addnoise(with_tex, noise_vals(2)));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g støjniveau\n%g procent fejl', noise_vals(2), error_measure(with_tex, i)*100));

subplot(3,3,3);
s = to_sig(addnoise(with_tex, noise_vals(3)));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g støjniveau\n%g procent fejl', noise_vals(3), error_measure(with_tex, i)*100));

% 2. række (sample)
subplot(3,3,4);
s = signal_limited(to_sig(with_tex), sample_vals(1));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g procent fejl', sample_vals(1), error_measure(with_tex, i)*100));

subplot(3,3,5);
s = signal_limited(to_sig(with_tex), sample_vals(2));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g procent fejl', sample_vals(2), error_measure(with_tex, i)*100));

subplot(3,3,6);
s = signal_limited(to_sig(with_tex), sample_vals(3));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g procent fejl', sample_vals(3), error_measure(with_tex, i)*100));

% 3. række (støj + sample)
subplot(3,3,7);
s = signal_limited(to_sig(addnoise(with_tex, noise_vals(1))), sample_vals(3));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g støjniveau\n%g procent fejl', sample_vals(3), noise_vals(1), error_measure(with_tex, i)*100));

subplot(3,3,8);
s = signal_limited(to_sig(addnoise(with_tex, noise_vals(2))), sample_vals(2));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g støjniveau\n%g procent fejl', sample_vals(2), noise_vals(2), error_measure(with_tex, i)*100));

subplot(3,3,9);
s = signal_limited(to_sig(addnoise(with_tex, noise_vals(3))), sample_vals(1));
i = abs(ifft2(s));
imshow(i);
title(sprintf('%g sampleniveau\n%g støjniveau\n%g procent fejl', sample_vals(1), noise_vals(3), error_measure(with_tex, i)*100));

%%%% 1x3 plot af billede ved udvalgte støj- og samplingniveauer %%%%
% 5. vindue
figure(5);

head_signal = head.headRe + j * head.headIm; % sammensæt kompleks signal
% benyt recon_volume til at gendanne det 3-dimensionelle signal
recon_head = abs(recon_volume(head_signal, [1:16]));

% ombyt slides således at lagene er i korrekt sekvens
recon_head = recon_head(:,:,[9 1 10 2 11 3 12 4 13 5 14 6 15 7 16 8]);

% udvalgte slices
s1 = 14;
s2 = 100;
s3 = 100;

% ortho_slices returnerer de udvalgte slices
[o1,o2,o3] = ortho_slices(recon_head,14,100,100);
subplot(1,3,1);
imagesc(o1);
title(sprintf('xy-lag %d', s1));

subplot(1,3,2);
imagesc(o2);
title(sprintf('xz-lag %d', s2));

subplot(1,3,3);
imagesc(o3);
title(sprintf('yz-lag %d', s3));

%%%% Rekonstruktion af udvalgt A & B slice %%%%
% 6. vindue
figure(6);

% rekonstruér og vis slide nr. 125 fra A
A = A.A;
A_slice = abs(ifft2(A(:,:,125)));
subplot(1,2,1);
imagesc(A_slice);
title('A.mat');

% rekonstruér og vis slide nr. 35 fra B
B = B.B;
B_slice = abs(ifft2(B(:,:,35)));
subplot(1,2,2);
imagesc(B_slice);
title('B.mat');

% konvertér fra billeddata til fouriersignal
function sig = to_sig(image)
    sig = fftshift(fft2(image));
end