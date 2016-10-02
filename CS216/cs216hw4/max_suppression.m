function [x,y,score] = max_suppression(R,w,ndet)
%MAX_COMPRESSION Summary of this function goes here
%   Detailed explanation goes here
% sort response from high to low
[val,ind] = sort(R(:),'descend');

% work down the list of responses, removing overlapping detections as we go
i = 1;
detcount = 0;
while ((detcount < ndet) & (i < length(ind)))
  % convert ind(i) back to (i,j) values to get coordinates of the block
  [yblock,xblock] = convert(ind(i),m);

  assert(val(i)==R(yblock,xblock)); %make sure we did the indexing correctly

  % now convert yblock,xblock to pixel coordinates 
  ypixel = yblock * 8;
  xpixel = xblock * 8;

  % check if this detection overlaps any detections which we've already added to the list
  overlap = 0;
  if (min(abs(y-ypixel)) <= h) || (min(abs(x - xpixel)) <= w)
      overlap = 1;
  end
  % if not, then add this detection location and score to the list we return
  if (~overlap)
    x(detcount) = xpixel;
    y(detcount) = ypixel;
    score(detcount) = R(yblock,xblock);
    detcount = detcount+1;
  end
  i = i + 1;
end

end

