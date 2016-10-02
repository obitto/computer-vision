simpsons = im2double(rgb2gray(imread('simpsons.jpg')));
patch = simpsons(490:540,360:400);

template = rot90(patch,2);
IT = conv2(simpsons,template,'same');
Tsquared = sum(sum(template.^2));
Isquared = conv2(simpsons.^2,ones(size(template)),'same');
C = Isquared - 2*IT + Tsquared;


threshold = max(C(:))-100;
Left = (C(2:end-1,2:end-1) > C(1:end-2,2:end-1));
Right = (C(2:end-1,2:end-1) > C(3:end,2:end-1));
% UpperLeft = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,1:end-2);
% UpperMiddle = corrResult(2:end-1,2:end-1) > corrResult(2:end-1,1:end-2);
% UpperRight = corrResult(2:end-1,2:end-1) > corrResult(3:end,1:end-2);
% BottomLeft = corrResult(2:end-1,2:end-1) > corrResult(1:end-2,3:end);
% BottomMiddle = corrResult(2:end-1,2:end-1) > corrResult(2:end-1,3:end);
% BottomRight = corrResult(2:end-1,2:end-1) > corrResult(3:end,3:end);
T = C(2:end-1,2:end-1) > threshold;
maxima = Right & Left ;
figure;
imshow(simpsons);
hold on;
%rectangle('Position',[100 100 500 500],'LineWidth',10,'EdgeColor','g');
[patchH,patchW] = size(patch);
[y,x] = size(maxima);
for i = 1:x
    for j = 1:y
        if maxima(j,i) == 1
            rectangle('Position',[i - patchW/2 , j-patchH/2,patchW,patchH],'LineWidth',2,'EdgeColor','g');
            display(i);
        end
    end
end