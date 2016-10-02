image = im2double(rgb2gray(imread('zebra1.jpg')));
figure,imagesc(image);
colormap(gray);
sigma = 1;
mu = 0;
Gaussianfilter = fspecial('gaussian',[3 3],sigma);
smooth = conv2(image,Gaussianfilter,'same');
figure,imagesc(smooth);
colormap(gray);

filterH = [-1 1];
horizonGradientImage = conv2(smooth,filterH,'same');
figure,imagesc(horizonGradientImage);
colormap(gray);

filterV = [-1 1]';
verticalGradientImage = conv2(smooth,filterV,'same');
figure,imagesc(verticalGradientImage);
colormap(gray);

[Magnitude,direction] = imgradient(smooth);
figure,imagesc(Magnitude);
colormap(gray);
figure,imagesc(direction);
colormap(gray);