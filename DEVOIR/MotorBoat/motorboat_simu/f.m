function xdot = f(x,u)
% Global variables to share with other files.
global L, global l, global alpha, global alphafx, global beta;
delta = beta*u(2); % direction avec prise en compte de l'erreur d'estimation
theta = x(3); % pas d'erreur
vx = x(4);
xdot = [vx*cos(delta)*cos(theta);
        vx*cos(delta)*sin(theta);
        vx*sin(delta)/(L/2);
        alpha*u(1)-alphafx*vx];
end
