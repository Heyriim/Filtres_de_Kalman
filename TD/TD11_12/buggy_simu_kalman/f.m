function xdot = f(x,u)
% Global variables to share with other files.
global L, global alpha, global beta;
v = alpha*u(1);
delta = beta*u(2);
xdot = [v*cos(delta)*cos(x(3));
        v*cos(delta)*sin(x(3));
        v*sin(delta)/L];
end
