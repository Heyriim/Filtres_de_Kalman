function y = g(x,u)
% Global variables to share with other files.
global L, global r, global alpha1, global alpha2;
global omega1, global omega2; % To be available for g.
y = [omega1+mvnrnd(0,0.05);
     omega2+mvnrnd(0,0.02);
     x(3)+mvnrnd(0.01,0.05)];
end
