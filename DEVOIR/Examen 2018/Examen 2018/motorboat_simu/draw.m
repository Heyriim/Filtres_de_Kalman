function draw(x,u)
% Global variables to share with other files.
global L, global l, global alpha, global beta;
v = alpha*u(1);
delta = beta*u(2);
M=[-L/2 -L/2 L/2-0.3  L/2 L/2-0.3 -L/2;
   -l/2  l/2     l/2    0    -l/2 -l/2;
    ones(1,6)]; % Motif de la coque.
J=[-0.2 0;
      0 0;
      1 1]; % Motif du jet.
R=[cos(x(3)),-sin(x(3)),x(1);sin(x(3)),cos(x(3)),x(2);0 0 1];
M=R*M;
J=R*[cos(-delta),-sin(-delta) -L/2;sin(-delta),cos(-delta) 0;0 0 1]*J;
plot(M(1,:),M(2,:),'b');
plot(J(1,:),J(2,:),'k');
end
