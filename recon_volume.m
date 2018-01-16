% Parameters:
%  slices - raw fourier signal (Matrix[3d])
%  recon_Vector - indices of which layers to reconstruct (Vector)
% Output:
%  out_slices - reconstructed image data (Matrix[3d])
function out_slices = recon_volume(slices, recon_vector)
[h,w,d] = size(slices);

% tjek kvadratisk størrelse
if h ~= w
   error('Error: non-square signal given to recon_volume'); 
end

% output slices
recon_slices = [];
for i=1:length(recon_vector)
    % slå fejl hvis det efterspurgte slide ikke findes ved index i
   if ~isscalar(slices(1,1,recon_vector(i)))
      error(sprintf('Error: Index %d given in recon_volume parameter is out of bounds.', recon_vector(i)));
   end
   
   % stabel slides sammen langs 3. dimension
   recon_slices = cat(3, ifft2(slices(:,:,i)), recon_slices);
end

out_slices = recon_slices;

