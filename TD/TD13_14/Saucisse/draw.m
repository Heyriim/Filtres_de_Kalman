function draw(x,u)
% Global variables to share with other files.
global L, global r, global alpha1, global alpha2;
% Should depend on L and r here instead of constants...
M = [0.1 -0.1  0    0   -0.2 -0.2   0 0   -0.1 0.1 0   0   0.3  0.3  0;
    -0.2 -0.2 -0.2 -0.1 -0.1  0.1 0.1 0.2  0.2 0.2 0.2 0.1 0.1 -0.1 -0.1;
     ones(1,15)];
M = [cos(x(3)),-sin(x(3)),x(1);sin(x(3)),cos(x(3)),x(2);0 0 1]*M;
plot(M(1,:),M(2,:),'b');
end
