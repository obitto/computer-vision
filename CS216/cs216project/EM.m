function [ center,C,weight,like ] = EM( data,K )
%EM Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(data);
smin = 0.001;
weight = rand([m,K]);
theta = zeros(K,n);
C = zeros(n,n,K);
normal = sum(weight,2);
newW = zeros(m,K);
newtheta = zeros(K,n);
newcenter = zeros(K,n);
iteration = zeros(100,1);
likelihood = zeros(100,1);
newcovariance = zeros(n,n,K);
iterations = 20;
for i = 1:K
    weight(:,i) = weight(:,i) ./ normal;
end
[~,center] = kmeans(data,K,10,0);
x = covariance(data,center,weight,1);
if x < smin
    x = smin;
end
C(:,:,1) = x*eye(n);
C = repmat(C(:,:,1),1,1,K);
Q = zeros(m,K);

%calculate log likelihood
for iter = 1:iterations
%calculate new W
    %display(iter);
    for k = 1:K
        %display(C(:,:,k));
        Q(:,k) = mvnpdf(data,center(k,:),C(:,:,k));
    end
    
    alpha = sum(weight,1)/m;
    like = Q * alpha';
    iteration(iter) = iter;
    likelihood(iter) = sum(log(like)); 
    for i = 1:m
        Q(i,:)=Q(i,:) .* alpha;
    end
    P = sum(Q,2);
    for k = 1:K
        newW(:,k) = Q(:,k) ./ P;
    end

%calculate new center
    N = sum(newW,1);
    for k = 1:K
        newcenter(k,:) =  newW(:,k)' * data ./ N(k);
        x = covariance(data,newcenter,newW,k);
        %x = variance(data,newcenter,newW,k);
        if x < smin
            x = smin;
        end
        newcovariance(:,:,k) = x*eye(n);
    end
    center = newcenter;
    weight = newW;
    C = newcovariance;
end
like = likelihood(iter);
%{
for k = 1:K
    gparams(k) = struct('mean',center(k,:),'covariance',C(:,:,k));
end
%}
%{
figure,
plot(iteration(1:iterations),likelihood(1:iterations));
title('likelihood convergence');
xlabel('iterations');
ylabel('likelihood');
%}
end

