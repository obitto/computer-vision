function [ C] = variance(data,mu,weight,k )
%VARIANCE Summary of this function goes here
%   Detailed explanation goes here
C = 0;
[n,d] = size(data);
N = sum(weight,1);
%display(size(data));
for i = 1:n
    C = C + weight(i,k)* (data(i,:) * data(i,:)');
end
C = C/N(k);
C = C - (mu(k,:)*mu(k,:)');
%display(C);
end

