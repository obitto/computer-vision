% load a training example image
Itrain = im2double(rgb2gray(imread('test1.jpg')));

%have the user click on some training examples.  
% If there is more than 1 example in the training image (e.g. faces), you could set nclicks higher here and average together
figure(1); clf;
imshow(Itrain);
 %get nclicks from the user
num_pos = 1;
num_neg = 0;
%get the rect specified by user

positivePatch = cell(num_pos,1);
negativePatch = cell(num_neg,1);
width = zeros(num_pos+num_neg,1);
height = zeros(num_pos+num_neg,1);

%get 5 positive and 100 negative examples
%{
[resizePosPatch,resizeNegPatch] = generatetemplate();
[resizeHeight,resizeWidth,num_pos] = size(resizePosPatch);
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;
%}


%standard extract examples
for i = 1:num_pos
    rect = getrect;
    width(i) = floor(rect(3));
    height(i) = floor(rect(4));
    positivePatch{i} = Itrain(floor(rect(2))+(0:floor(rect(4))),floor(rect(1))+(0:floor(rect(3))));
end


for i = 1:num_neg
    rect = getrect;
    width(i+num_pos) = floor(rect(3));
    height(i+num_pos) = floor(rect(4));
    negativePatch{i} = Itrain(floor(rect(2))+(0:floor(rect(4))),floor(rect(1))+(0:floor(rect(3))));
end



aspectratio = width ./ height;
templateheight = mean(height);
templatewidth = mean(width);
resizeHeight = floor(templateheight/8) * 8;
resizeWidth = floor(templatewidth/8) * 8;
templateHeight = resizeHeight/8;
templateWidth = resizeWidth/8;

resizePosPatch = zeros(resizeHeight,resizeWidth,num_pos);
for i = 1:num_pos
    resizePosPatch(:,:,i) = imresize(positivePatch{i},[resizeHeight,resizeWidth]);
end

resizeNegPatch = zeros(resizeHeight,resizeWidth,num_neg);
for i = 1:num_neg
    resizeNegPatch(:,:,i) = imresize(negativePatch{i},[resizeHeight,resizeWidth]);
end

%{
% output the positive examples
figure;
hold on;
for i = 1:num_pos
    subplot(2,3,i);imshow(positivePatch{i});
end
hold off;
%}

%visualize negative examples
%{
figure(2); clf;
for i = 1:num_neg
  figure(2); subplot(3,2,i); imshow(negativePatch{i});
end
%}

% compute the average template for the user clicks
positiveTemplate = zeros(templateHeight,templateWidth,9,num_pos);
negativeTemplate = zeros(templateHeight,templateWidth,9,num_neg);
positiveSum = zeros(templateHeight,templateWidth,9);
negativeSum = zeros(templateHeight,templateWidth,9);
for i = 1:num_pos
    positiveTemplate(:,:,:,i) = hog(resizePosPatch(:,:,i));
    positiveSum = positiveSum + positiveTemplate(:,:,:,i);
end
for i = 1:num_neg
    negativeTemplate(:,:,:,i) = hog(resizeNegPatch(:,:,i));
    negativeSum = negativeSum + negativeTemplate(:,:,:,i);
end

template = positiveSum/num_pos;
if num_neg >0
    template = template - negativeSum/num_neg;
end

%
% load a test image
%
Itest= im2double(rgb2gray(imread('test1.jpg')));


% find top 5 detections in Itest
ndet = 5;
%[x,y,score] = detect(Itest,template,ndet);
[x,y,score] = multiscale_detect(Itest,template,ndet,0.7);
%display top ndet detections
figure(3); clf; imshow(Itest);
title('detection using multiscale');
for i = 1:ndet
  % draw a rectangle.  use color to encode confidence of detection
  %  top scoring are green, fading to red
  hold on; 
  h = rectangle('Position',[x(i)-64 y(i)-64 128 128],'EdgeColor',[(i/ndet) ((ndet-i)/ndet)  0],'LineWidth',3,'Curvature',[0.3 0.3]); 
  hold off;
end
