function [ result ] = GaussianDiff( image,sigma1,sigma2)
%GAUSSIANDIFF Summary of this function goes here
%   Detailed explanation goes here
gauss1 = fspecial('gaussian',[3 * sigma1 3 * sigma1],sigma1);
gauss2 = fspecial('gaussian',[3 * sigma2 3 * sigma2],sigma2);

result = conv2(image,gauss1,'same') - conv2(image,gauss2,'same');

end

