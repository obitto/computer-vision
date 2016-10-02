function [yblock,xblock] = convert(i,m)
%CONVERT Summary of this function goes here
%   Detailed explanation goes here
yblock = mod(i,m);
xblock = ceil(i/m);
if yblock == 0
    yblock = m;
end
end

