function draw(x,u)
% Global variables to share with other files.
global L, global alpha, global beta;
v = alpha*u(1);
delta = beta*u(2);
M=[-0.1  L+0.1 L+0.2  L+0.2 L+0.1 -0.1 -0.1 -0.1    0    0 -0.1  0.1    0   0 -0.1 0.1   0   0   L   L    L; %Chassis et roues arrieres.
   -0.2   -0.2  -0.1    0.1   0.2  0.2 -0.2 -0.2 -0.2 -0.3 -0.3 -0.3 -0.3 0.3  0.3 0.3 0.3 0.2 0.2 0.3 -0.3;
    ones(1,21)];
Rav=[-0.1 0.1;0 0;1 1]; %Motif d'une roue avant.
R=[cos(x(3)),-sin(x(3)),x(1);sin(x(3)),cos(x(3)),x(2);0 0 1];
M=R*M;
Ravd=R*[cos(delta),-sin(delta) L;sin(delta),cos(delta)  0.3;0 0 1]*Rav;
Ravg=R*[cos(delta),-sin(delta) L;sin(delta),cos(delta) -0.3;0 0 1]*Rav;
plot(M(1,:),M(2,:),'b');
plot(Ravd(1,:),Ravd(2,:),'k');
plot(Ravg(1,:),Ravg(2,:),'k');
end
