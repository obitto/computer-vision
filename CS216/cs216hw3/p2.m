image = im2double(rgb2gray(imread('zebra1.jpg')));
image = imresize(image,[600,800]);

sigma = [1,2,4];
[m,n] = size(image);
vertimage = zeros(m,n,3);
horiimage = zeros(m,n,3);
for k = 1:3
    [vertimage(:,:,k),horiimage(:,:,k)] = GaussianFilter(image,sigma(k));
    figure,imagesc(vertimage(:,:,k));
    colormap gray;
    %imagetitle = strcat('vertical_sigma=',num2str(sigma(k)),'.jpg');
    %imwrite(vertimage,imagetitle,'JPEG');
    figure,imagesc(horiimage(:,:,k));
    colormap gray;
    %imagetitle = strcat('horizontal_sigma=',num2str(sigma(k)),'.jpg');
    %imwrite(horiimage,imagetitle,'JPEG');
end

gauss1 = fspecial('gaussian',[3 * 1 3 * 1],1);
gauss2 = fspecial('gaussian',[3 * 2 3 * 2],2);
gauss4 = fspecial('gaussian',[3 * 4 3 * 4],4);

result1 = conv2(image,gauss2,'same') - conv2(image,gauss1,'same');
figure;
imagesc(result1);
colormap(gray);
%imwrite(result1,'FirstGaussDiff.jpg','JPEG');

result2 = conv2(image,gauss4,'same') - conv2(image,gauss2,'same');
figure;
imagesc(result2);
colormap(gray);
%imwrite(result2,'SecondGaussDiff.jpg','JPEG');