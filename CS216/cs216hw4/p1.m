%% test problem 1
imname = 'test0.jpg';
image = im2double(rgb2gray(imread(imname)));
figure,imagesc(image);

ohist = hog(image);

for k=1:9
     figure
     imshow(ohist(:,:,k));
end
