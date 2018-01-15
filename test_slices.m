clear all;
clc;
head = load('./cn/head.mat');
signal_head = head.headRe + head.headIm;
recon_head = abs(recon_volume(signal_head, [1:16]));

recon_head = recon_head(:,:,[9 1 10 2 11 3 12 4 13 5 14 6 15 7 16 8]);

%for i=1:size(recon_head,3)
%    subplot(4,4,i)
%    imagesc(recon_head(:,:,i))
%    title(i)
%end
%return;

s1 = 14;
s2 = 100;
s3 = 100;
[o1,o2,o3] = ortho_slices(recon_head,14,100,100);
subplot(3,1,1)
p1 = imagesc(o1);
title(sprintf('xy-lag %d', s1));

subplot(3,1,2)
p2 = imagesc(o2);
title(sprintf('xz-lag %d', s2));

subplot(3,1,3)
p3 = imagesc(o3);
title(sprintf('yz-lag %d', s3));

return;
 i = 1;
 j = 1;
 while 1
     [o1, o2, o3] = ortho_slices(recon_head, j, i, i);
     set(p1,'CData',o1);
     set(p2,'CData',o2);
     set(p3,'CData',o3);
     drawnow;
     
     if i == size(recon_head, 1)
         i = 1;
     else
        i = i + 1;
     end
     
     if j == size(recon_head, 3)
         j = 1;
     else
        j = j + 1;
     end
     
     pause(0.01)
 end