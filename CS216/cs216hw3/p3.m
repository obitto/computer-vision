image = im2double(rgb2gray(imread('zebra_small.jpg')));
figure;
imshow(image);
%[x,y] = ginput(2);

neck = image(41:81,65:105);
%figure;
%imshow(neck);

leaves = image(1:41,151:191);
%figure;
%imshow(leaves);

grass = image(180:220,24:64);
figure;
imshow(grass);

sigma = [1,2,4];
[m,n] = size(neck);
response = zeros(m,n,8);
patches = zeros(m,n,8);
patches(:,:,1) = neck;
patches(:,:,2) = leaves;
patches(:,:,3) = grass;

for i = 1:3
    for k = 1:3
        [response(:,:,2*k-1),response(:,:,2*k)] = GaussianFilter(patches(:,:,i),sigma(k));
        figure,imagesc(response(:,:,k));
        colormap gray;
    end
    response(:,:,7) = GaussianDiff(patches(:,:,i),2,1);
    response(:,:,8) = GaussianDiff(patches(:,:,i),4,2);
    meanresponse = zeros(8,1);
    for j = 1:8
        meanresponse(j) = mean(mean(abs(response(:,:,j))));
    end
    
    figure;
    bar(meanresponse);
    set(gca,'XTickLabel',{'vert,sigma = 1', 'hori,sigma = 1',...
            'vert,sigma = 2', 'hori,sigma = 2', 'vert,sigma = 4',...
            'vert,sigma = 4', 'G2 - G1', 'G4-G2'});
    ylabel('response');
    if i == 1
        as = axis();
    end
    if i >1
        axis(as);
    end
end