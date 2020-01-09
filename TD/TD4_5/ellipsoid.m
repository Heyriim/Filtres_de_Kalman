function ellipsoid(xbar, G , eta)
%ELLIPSOID Summary of this function goes here
%   Detailed explanation goes here
s = 0:0.01:2*pi;
w = xbar * ons(size(s)) + sqrtm(-2 * log(1-eta) * G) * [cos(s);sin(s)];
plot(w(1,:),w(2,:));
end

