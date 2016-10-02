function [ resizePosPatch,resizeNegPatch] = generatetemplate( )
%GENERATENEGTEMPLATE Summary of this function goes here
%   Detailed explanation goes here

num_pos = 5; 
num_neg = 100; 

positivePatch = cell(num_pos,1);
negativePatch = cell(num_neg,1);
x = zeros(num_pos,1);
y = zeros(num_pos,1);
width = zeros(num_pos,1);
height = zeros(num_pos,1);


perm = [1 2 3 4 5];
for j = 1:num_pos
    imname = strcat('test',num2str(perm(j)),'.jpg'); 
    Itrain = im2double(rgb2gray(imread(imname)));
    figure(1); clf;
    imshow(Itrain);
    rect = getrect(figure(1));
    width(j) = floor(rect(3));
    height(j) = floor(rect(4));
    positivePatch{j} = Itrain(floor(rect(2))+(0:floor(rect(4))),floor(rect(1))+(0:floor(rect(3))));
end


aspectRatio = width./height;

resizeHeight = mean(height);
resizeWidth = resizeHeight * mean(aspectRatio);
resizeHeight = floor(resizeHeight/8) * 8;
resizeWidth = floor(resizeWidth/8) * 8;
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;

resizePosPatch = zeros(resizeHeight,resizeWidth,num_pos);
for i = 1:num_pos
    resizePosPatch(:,:,i) = imresize(positivePatch{i},[resizeHeight,resizeWidth]);
end

figure;
hold on;
for i = 1:num_pos
    subplot(2,3,i);
    imshow(resizePosPatch(:,:,i));
end
hold off;

resizeNegPatch = zeros(resizeHeight,resizeWidth,num_neg);
for i = 1:num_pos
    imname = strcat('test',num2str(perm(i)),'.jpg'); 
    Itrain = im2double(rgb2gray(imread(imname)));
    imsize = size(Itrain);
    H = imsize(1)-height(i);
    W = imsize(2)-width(i);

    numPics = 20;
    index = 1;
    
    minDist = (resizeHeight^2 + resizeWidth^2);
    while index <= numPics
        randXvals = floor(rand(1)*(W - resizeWidth))+1;
        randYvals = floor(rand(1)*(H - resizeHeight))+1;
        overlap = (((randYvals - height(i)/2 - y(i))^2 + (randXvals - width(i)/2 - x(i))^2) < minDist);
        
        if ~overlap
           patch = Itrain(randYvals:randYvals+resizeHeight-1,...
           randXvals:randXvals+resizeWidth-1);
           resizeNegPatch(:,:,(i-1)*numPics + index) = patch;
           index = index + 1;
        end
    end 
end

end

