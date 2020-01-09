dt = 0.01;
t =0;
x = [0;0;0;10;0.5];
u = [0;0];
while (t<30)
     alphatheta = mvnrnd(0,0.01 * dt );
     alphav     = mvnrnd(0,0.01 * dt);
     alphadelta = mvnrnd(0,0.01 * dt);
     x = x + dt * f(x,u)+ [0;0;alphatheta;alphav;alphadelta];
     clf;
     hold on; axis([-50 50 -50 50]); axis square 
     draw_car(x);
     
     pause(dt);
     t = t+dt;
     
end