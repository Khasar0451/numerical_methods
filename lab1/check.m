function [isCorrect] = check(x,y,a,r,x2,y2,r2)
dist = (r+r2 < sqrt((x2-x)^2 + (y2-y)^2));
isCorrect = x-r>0 & x+r<a & y-r>0 & y+r<a & dist;
end