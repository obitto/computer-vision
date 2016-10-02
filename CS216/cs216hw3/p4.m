image = im2double(rgb2gray(imread('zebra1.jpg')));
[m,n] = size(image);
sigma = [1,2,4];
result = zeros(m,n,8);
for k = 1: 3
    [result(:,:,2*k-1),result(:,:,2*k)] = GaussianFilter(image,sigma(k));
end
result(:,:,7) = GaussianDiff(image,2,1);
result(:,:,8) = GaussianDiff(image,4,2);

imagedata = reshape(result,[m*n 8]);
[index,C] = kmeans(imagedata,20);
imagePixel = reshape(index,[m n]);
figure,imagesc(imagePixel);
colormap jet;
colorbar;