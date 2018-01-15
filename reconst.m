clc;
B = load('./cn/B.mat');
B = B.B;
[h,w,d] = size(B);

range = [1:70];
ra = abs(recon_volume(B, range));

p1 = imagesc(squeeze(ra(:,:,1)));
i = 1;
 while 1
    set(p1,'CData',ra(:,:,i));
    title(i);
    drawnow;

    if i == size(ra, 3)
      i = 1;
    else
       i = i + 1;
    end
    
    pause(0.01)
end