dist = 1;
lambda = 0.1;
alpha = 1;
image = im2double(imread('segtest2.jpg'));
figure;
imshow(image);
[X,Y]= ginput(2);
background = [floor(Y(1)),floor(X(1))];
foreground = [floor(Y(2)),floor(X(2))];

backR = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,1);
backG = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,2);
backB = image(background(1)-dist:background(1)+dist,background(2)-dist:background(2)+dist,3);
backgroundColor = [mean(mean(backR)) mean(mean(backG)) mean(mean(backB))];

foreR = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,1);
foreG = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,2);
foreB = image(foreground(1)-dist:foreground(1)+dist,foreground(2)-dist:foreground(2)+dist,3);
foregroundColor = [mean(mean(foreR)) mean(mean(foreG)) mean(mean(foreB))];


[H,W,D] = size(image);
N = H*W;
imagePixel = reshape(image,[N 3]);
distWithForeground = sqrt(sum((imagePixel - repmat(foregroundColor,[N 1])).^2,2));
distWithBackground = sqrt(sum((imagePixel - repmat(backgroundColor,[N 1])).^2,2));

labelcost = [0 1;1 0]*lambda;
unary = [distWithForeground distWithBackground]';
segclass = zeros(N,1);
pairwise = sparse(N,N);


for x = 1:W-1
  for y = 1:H
    node  = 1 + (y-1) + (x-1)*H;
    right = 1 + (y-1) + x*H;
    distance = norm(imagePixel(node,:) - imagePixel(right,:));
    pairwise(node,right) = alpha * distance;
    pairwise(right,node) = alpha * distance;
  end
end

for x = 1:W
  for y = 1:H-1
    node = 1 + (y-1) + (x-1)*H;
    down = 1 + y + (x-1)*H;
    distance = norm(imagePixel(node,:) - imagePixel(down,:));
    pairwise(node,down) = alpha * distance;
    pairwise(down,node) = alpha * distance;
  end
end

[labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);

figure;
subplot(211);
imagesc(image);
title('Original image');
hold on;
plot(floor(X),floor(Y),'rx','LineWidth',2);
subplot(212);
imagesc(reshape(labels,[H W]));
title('Min-cut');
