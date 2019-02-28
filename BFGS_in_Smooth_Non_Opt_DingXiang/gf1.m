%function 1 gradient
function z = gf1(x, y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
z = [40 * (x^3 - x * y) - 2 * (1 - x); 20 * (y - x^2)];
end