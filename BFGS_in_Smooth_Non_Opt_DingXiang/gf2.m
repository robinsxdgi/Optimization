%function 2 gradient
function z = gf2(x, y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if y <= x^2
    z = [20 * x - 2 * (1 - x); -10];
else
    z = [-20 * x - 2 * (1 - x); 10];
end