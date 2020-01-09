function xdot = f(x,u)
% Global variables to share with other files.
global L, global r, global alpha1, global alpha2;
global omega1, global omega2; % To be available for g.
% Noise has been added to be more realistic. Warning : this is not
% gaussian, so this is bad for the Kalman filter, but anyway it should
% still work correctly...
omega1 = (alpha1+0.25*rand())*u(1);
omega2 = (alpha2-0.3*rand())*u(2);
v1 = r*omega1;
v2 = r*omega2;
v = (v1+v2)/2.0;
omega = (v2-v1)/L;
xdot = [v*cos(x(3));
        v*sin(x(3));
        omega];
end
