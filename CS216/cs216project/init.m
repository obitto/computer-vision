v = VideoReader('shop.mpg');
video = im2double(v.read());
start = 1;
tempsize = 25;
data = video(:,:,:,start:start+tempsize);
a =0.002;
L = 2.5;
K = 5;
T= 0.97;
[m,n,d] = size(data);
oldcenter = zeros(m,n,K,3);
oldcovariance =zeros(m,n,K);
oldweight = zeros(m,n,K);
center = zeros(m,n,K,3);
covariance =zeros(m,n,K);
weight = zeros(m,n,K);
for i = 1:m
    display(i);
    for j = 1:n
        pixeldata = data(i,j ,:,:);
        pixeldata = reshape(pixeldata,[],3);
        [center(i,j,:,:),variance,w,~] = EM(pixeldata,K);
        covariance(i,j,:) = variance(1,1,:);
        weight(i,j,:) = sum(w,1)/(tempsize+1);
    end
end
oldcenter = center;
oldcovariance = covariance;
oldweight = weight;
