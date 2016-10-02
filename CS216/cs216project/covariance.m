function [ C ] = covariance(data,mu,weight,k )
%COVARIANCE Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(data);
N = sum(weight,1);
C = 0;
for i = 1:m
    C = C + weight(i,k)*sum((data(i,:)-mu(k,:)) .^2);
end
C = C/N(k);
end

