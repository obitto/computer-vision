%part1
impluse = zeros(100,1);
impluse(50) = 1;
DFT = fft(impluse);
figure;
plot(DFT);
title('magnitude of the spectrum of the impluse function');

%part2
box = zeros(100,1);
box(45:54) = ones(10,1);
DFT = fftshift(fft(box));
figure;
plot(DFT);
title('magnitude of the spectrum of the box function');

%part3
sigma = 1;
mu = 0;
X = [-50:1:50];
Gau = normpdf(X,mu,sigma);
DFT = fftshift(fft(Gau));
figure;
plot(DFT);
title('magnitude of the spectrum of the 1st Gaussian function');
%part3
sigma = 2;
Gau = normpdf(X,mu,sigma);
DFT = fftshift(fft(Gau));
figure;
plot(DFT);
title('magnitude of the spectrum of the 2nd Gaussian function');

%2d image
image1 = im2double(rgb2gray(imread('zebra1.jpg')));
image2 = im2double(rgb2gray(imread('simpsons.jpg')));
[m,n,d] = size(image2);
image1 = imresize(image1,[m n]);

image1fft = fft2(image1);
image1magnitude = abs(image1fft);
image1phase = angle(image1fft);

image2fft = fft2(image2);
image2magnitude = abs(image2fft);
image2phase = angle(image2fft);

inver1fft = image1magnitude .* exp(image2phase .* 1i);
inver1 = ifft2(inver1fft);
inver2fft = image2magnitude .* exp(image1phase .* 1i);
inver2 = ifft2(inver2fft);

figure
imshow(abs(inver1));
figure
imshow(abs(inver2));



