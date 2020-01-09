function xdot = f(x,u)
%  variables to share with other files.
  dt = 0.01;
 alphatheta = mvnrnd(0,0.01 * dt);
 alphav     = mvnrnd(0,0.01 * dt);
 alphadelta = mvnrnd(0,0.01 * dt);
 xdot = [x(4)*cos(x(5))*cos(x(3));
        x(4)*cos(x(5))*sin(x(3));
        x(4)*sin(x(5))/3 + alphatheta;
        u(1) + alphav;
        u(2) + alphadelta
        ];
end

