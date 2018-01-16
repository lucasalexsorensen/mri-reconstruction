% Parameters:
%  slices - entire stack of image slices (Matrix[3d])
%  s1 - index of which xy-slice to return
%  s2 - index of which xz-slice to return
%  s3 - index of which yz-slice to return
% Output:
%  [o1, o2, o3] - individual two-dimensional matrices representing the
%   slices corresponding to the indices provided via s1-s3
function [o1, o2, o3] = ortho_slices(slices, s1, s2, s3)
[h, w, d] = size(slices);

% dimensionscheck
if s1 > d || s2 > w || s3 > h
   error('Given index is out of bounds'); 
end
% squeeze benyttes til at fjerne singleton dimensioner
%  f.eks. 256x1x16 bliver til 256x16
o1 = squeeze(slices(:,:,s1));
o2 = squeeze(slices(:,s2,:));
o3 = squeeze(slices(s3,:,:));