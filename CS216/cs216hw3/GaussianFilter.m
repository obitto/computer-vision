function [ vertResult,horiResult ] = GaussianFilter( target,sigma)
%GAUSSIANFILTER Summary of this function goes here
%   Detailed explanation goes here
gauss = fspecial('gaussian',[3 * sigma 3 * sigma],sigma);
gaussFilter = gauss(ceil(3 * sigma/2),:);

conv = conv2(target,gaussFilter,'same');

vertResult = conv2(conv,[-1 1]','same');
horiResult = conv2(conv,[-1 1],'same');
end


