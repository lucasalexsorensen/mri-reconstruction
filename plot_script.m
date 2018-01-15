size = 256;
no_tex = generate_simdata(size);
with_tex = generate_simdata(size, 'textures/');
sl = phantom('Modified Shepp-Logan',200);

subplot(1,3,1)
imshow(no_tex);
title('No texture')

subplot(1,3,2)
imshow(with_tex);
title('With texture')

subplot(1,3,3)
imshow(sl);
title('Shepp-Logan')