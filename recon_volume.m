function out_slices = recon_volume(slices, recon_vector)
[h,w,d] = size(slices);

if h ~= w
   error('Error: non-square signal given to recon_volume'); 
end

if not(d > 1)
   error('Error: Invalid 3rd dimension for given slices.');
end

recon_slices = [];
for i=1:length(recon_vector)
   if ~isscalar(slices(1,1,recon_vector(i)))
      error(sprintf('Error: Index %d given in recon_volume parameter is out of bounds.', recon_vector(i)));
   end
   
   recon_slices = cat(3, ifft2(slices(:,:,i)), recon_slices);
end

out_slices = recon_slices;

