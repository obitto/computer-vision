image = im2double(imread('zebra1.jpg'));
%image = im2double(imread('simpsons.jpg'));
[m,n,d] = size(image);
imagePixel = reshape(image,[m*n 3]);

k = 10;
[idx,C] = kmeans(imagePixel,k);
newimage = zeros(m*n,3);
for i =1:m*n
    newimage(i,:)= C(idx(i),:);
end
pixelLabels = reshape(newimage,[m n d]);
figure,imshow(pixelLabels,[]),title('k-means image with k = 10');
imagetitle = strcat('zebra_k=',num2str(k),'.jpg');
imwrite(pixelLabels,imagetitle,'JPEG');

scaleimage = reshape(image,[m*n 3]);
scaleimage(:,1) = scaleimage(:,1) .* 1000;
[idx,C] = kmeans(scaleimage,k);
scalenewimage = zeros(m*n,3);
for i =1:m*n
    scalenewimage(i,:)= C(idx(i),:);
end
scalenewimage(:,1) = scalenewimage(:,1) ./ 1000;
scalepixelLabels = reshape(scalenewimage,[m n d]);
figure,imshow(scalepixelLabels,[]),title('k-means scaled image with k = 10');
imagetitle = strcat('scaled_zebra_k=',num2str(k),'.jpg');
imwrite(scalepixelLabels,imagetitle,'JPEG');