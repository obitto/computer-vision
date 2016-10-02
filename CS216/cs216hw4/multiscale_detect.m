function [ x,y,score] = multiscale_detect( I,template,ndet,resizeFactor)
%MULTISCALE_DETECT Summary of this function goes here
%   Detailed explanation goes here
[templateh,templatew] = size(template);
level = 0;
X = [];
Y = [];
Score = [];

while 1
    [h,w] = size(I);
    if (h < templateh) && (w < templatew)
        break;
    end
    [xtemp,ytemp,scoretemp] = detect(I,template,ndet);
    xtemp = floor(xtemp ./(resizeFactor ^ level));
    ytemp = floor(ytemp ./(resizeFactor ^ level));
    level = level +1;
    X = [X;xtemp];
    Y = [Y;ytemp];
    Score = [Score;scoretemp];
    I = imresize(I,resizeFactor);
end


[~,ind] = sort(Score(:),'descend');
i=1;
detcount = 0;
x = zeros(ndet,1);
y = zeros(ndet,1);
[h,w,d] = size(template);

while ((detcount < ndet) && (i < length(ind)))
  xpixel = X(ind(i));
  ypixel = Y(ind(i));
  % check if this detection overlaps any detections which we've already added to the list
  overlap = 0;
  if (min(abs(y-ypixel)) <= (2*h)) && (min(abs(x - xpixel)) <= (2*w))
      overlap = 1;
  end
  % if not, then add this detection location and score to the list we return
  if (~overlap)
    detcount = detcount+1;
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) = Score(ind(i));
  end
  i = i + 1;
end
end

