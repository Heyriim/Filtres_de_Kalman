figure; 

x = [1;-1;0.5];
u = [0.5;0.4];
t = 0;
dt = 0.1;   % gere la gestion de la vitesse de la voiture 

while (t < 300)
    x = x + f(x,u);
    clf;
    hold on;
    axis([-5,5,-5,5]); axis square;
    draw(x,u);
    pause(dt);
    t = t + dt;
end
