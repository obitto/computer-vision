function [ label,center ] = kmeans(data,K,maxiteration,error)
%KMEANS Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(data);
Max = max(data);
Min = min(data);
center = rand([K,1])*(Max-Min)+repmat(Min,K,1);
label = zeros(1,m);
dist = zeros(K,m);
iter = 0;
iterations = zeros(maxiteration,1);
ssm = zeros(maxiteration);
for i = 1:maxiteration
    for j = 1:m
        for k = 1:K
            v = data(j,:)-center(k,:);
            dist(k,j)= v *v';
        end
    end
    [mindist,label] = min(dist);
    iter = iter + 1;
    ssm(iter) = sum(mindist);
    iterations(iter) = iter;
    for  k = 1:K
        if length(find(label==k))>0
            center(k,:) = mean(data(find(label==k),:));
        end
    end
end
label = label';
if error == 1
    figure,plot(iterations,ssm);
end
end

