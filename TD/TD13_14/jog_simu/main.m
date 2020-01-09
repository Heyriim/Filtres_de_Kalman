% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
global L, global r, global alpha1, global alpha2;

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Ecrazor game','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 5; offsetx = 0; offsety = 0;

L = 0.4; %Distance (en m) entre roues.
r = 0.1; %Rayon des roues (en m).
alpha1 = 10; %Coefficient (en rad/s) a regler en regardant la vitesse de la roue droite pour une entree u(1) donnee.
alpha2 = 10; %Coefficient (en rad/s) a regler en regardant la vitesse de la roue droite pour une entree u(2) donnee.

x = [0;0;0];
u = [0;0];
dt = 0.05;
t = 0;
targets = 0;
target = scale*rand(2,1);

%Q2 estimation zk 
zk =[x(1);x(2)]; 
Gzk = diag([0.1;0.1]); % d'après l'énoncé et la taille de zk
zthetak = x(3); Gzthetak = diag(0.02); % on admet que c'est connu 

while (bExit == 0)    
    % Simulated state evolution.
    x = x + dt * f(x,u);
    y = g(x,u);
    Ak = eye(2,2);
    vk = r * (alpha1 * u(1) + alpha2 * u(2))/2;
    thetak = y(3) ;
    uk = [dt * vk * cos(thetak); dt * vk * sin(thetak)];
    %Q3) nous permet de déterminer :
    Ck = []; yk =[]; Gbetak = []; % car pas de mesure
    Galphak = diag ([0.001;0.001]);
    [zk,Gzk,zup,Gzup]=kalman(zk,Gzk,uk,yk,Galphak,Gbetak,Ak,Ck);
    
    %amélioration kalman 2
    uthetak = dt *r*(alpha2*u(2)-alpha1*u(1))/L;
    Athetak = 1;
    Galphathetak = dt *0.001; Gbetathetak = dt * 0.001;
    Cthetak = 1;
    ythetak = y(3); 
    [zthetak,Gzthetak,zthetaup,Gzthetaup]=kalman(zthetak,Gzthetak,uthetak,ythetak,Galphathetak,Gbetathetak,Athetak,Cthetak);
    
    % autonomous control part to go to waypoints .
    thetaw = atan2(target(2) -zk(2), target(1) - zk(1));
    if cos(thetaw - thetak) >= 0
        uw = -sin(thetaw - thetak);   % p16 diapo avec deltamax = 1 
    else 
        uw = -sign(sin(thetaw - thetak)); 
    end
    uv = 1;
    u(1) = (uv + uw)/2;
    u(2) = (uv - uw)/2;
   
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); axis square;
    draw(x,u); % Real position of the simulated robot.
    draw_ellipse([zup(1);zup(2)],[Gzup(1,1) Gzup(1,2); Gzup(2,1) Gzup(2,2)],0.9,'r',1); % 0.9 == eta
   
    % Waitpoints generation
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    if ((target(1)-1.5 < x(1))&&(x(1) < target(1)+2.5)&&(target(2)-1.5 < x(2))&&(x(2) < target(2)+1.5)) %regenerer un carre  chaque fois que l'ancien est atteint
        targets = targets+1;
        target = scale*rand(2,1);
    end
    
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
    end
t

close(fig);
