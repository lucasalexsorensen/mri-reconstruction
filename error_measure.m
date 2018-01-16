% Parameters
%  ground_truth - original image to test against (Matrix[2d])
%  test_image - image for which an error rate is being calculated (Matrix(2d])
% Output
%  epsilon - Error in the range 0-1 (Number)
function epsilon = error_measure(ground_truth, test_image)
[h1, w1, d1] = size(ground_truth);
[h2, w2, d2] = size(test_image);

if h1 ~= h2 || w1 ~= w2 || d1 ~= d2
   error('Error: Dimension mismatch of input images in error_measure function.');
end

epsilon = norm(ground_truth - test_image, 'fro') / norm(ground_truth, 'fro');