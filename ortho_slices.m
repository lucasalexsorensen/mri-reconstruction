function [o1, o2, o3] = ortho_slices(slices, s1, s2, s3)
[h, w, d] = size(slices);
if s1 > d || s2 > w || s3 > h
   error('Given index is out of bounds'); 
end
o1 = squeeze(slices(:,:,s1));
o2 = squeeze(slices(:,s2,:));
o3 = squeeze(slices(s3,:,:));