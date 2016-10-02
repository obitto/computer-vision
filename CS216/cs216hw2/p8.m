simpsons = im2double(rgb2gray(imread('simpsons.jpg')));
zebra = im2double(rgb2gray(imread('zebra1.jpg')));
%figure;
%imshow(simpsons);
%[x,y] = ginput(2);
patch = simpsons(490:540,360:400);
figure,imshow(patch);
C = xcorr2(simpsons,patch);
figure,imagesc(C);
colormap(jet);
colorbar;

%threshold = 1000;
threshold = max(C(:))-100;
Left = (C(2:end-1,2:end-1) > C(1:end-2,2:end-1));
Right = (C(2:end-1,2:end-1) > C(3:end,2:end-1));
UpperLeft = C(2:end-1,2:end-1) > C(1:end-2,1:end-2);
UpperMiddle = C(2:end-1,2:end-1) > C(2:end-1,1:end-2);
UpperRight = C(2:end-1,2:end-1) > C(3:end,1:end-2);
BottomLeft = C(2:end-1,2:end-1) > C(1:end-2,3:end);
BottomMiddle = C(2:end-1,2:end-1) > C(2:end-1,3:end);
BottomRight = C(2:end-1,2:end-1) > C(3:end,3:end);
T = C(2:end-1,2:end-1) > threshold;
maxima = T & Right & Left & UpperLeft & UpperMiddle & UpperRight & BottomLeft & BottomRight & BottomMiddle;
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