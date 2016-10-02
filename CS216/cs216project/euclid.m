function [ dist ] = euclid( data,center,covariance )
%EUCLID Summary of this function goes here
%   Detailed explanation goes here
data = reshape(data,3,1);
center = reshape(center,3,1);
%display(data);
%display(center);
%display(data-center);
%display(inv(covariance));
%dist= ((data - center)'/(covariance))*(data - center);
dist= (data - center)'*(data - center);
%display(dist);
end

