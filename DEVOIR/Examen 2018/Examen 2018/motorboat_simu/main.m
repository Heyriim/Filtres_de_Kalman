%%
% //////////// PARTIE 2 //////////////

% Q1 - Le vecteur d'entrée du robot est u=[u1;u2], avec u1 qui représente sa
% propulsion par l'hydrojet, et u2 son orientation pour changer de
% direction. 
% Le vecteur d'état est composé de la position du robot (x & y) et de son
% cap theta (x=[x,y,teta,v]). 
% Ainsi l'équation d'évolution, qui se trouve dans le fichier
% f.m, est la suivante : 
%                        xdot = [x(4)*cos(delta)*cos(x(3));
%                                x(4)*cos(delta)*sin(x(3));
%                                x(4)*sin(delta)/(L/2);
%                                alpha*u(1)-alphafx*x(4)];


% Q2 - Pour linéariser l'équation d'évolution du robot pour qu'elle
% devienne compatible avec Kalman, j'utilise un vecteur intermédiaire noté
% Z : 
%
% Déjà on pose ; Zk = [x ; y ; v], alors Zkdot = [vcos(delta)cos(theta);
%                                                 vcos(delta)sin(theta);
%                                                 u1 - v];
%
% On a alors zkdot = [ 0  0   cos(delta)cos(theta); * Zk + | 0  |
%                      0  0   cos(delta)sin(theta);        | 0  |
%                      0  0           -1           ];      | u1 |
%
% Et on sait que Zk+1 = Zk + dt*[Ak*Zk + Uk]
% Avec Zk = [1 0 0; 0 1 0; 0 0 1]*Zk
%   
% Ainsi on a : 
%                    |1 0 dt*cos(delta)cos(theta)|      |   0   |
%             Zk+1 = |0 1 dt*cos(delta)sin(theta)|*Zk + |   0   |
%                    |0 0          1-dt          |      | dt*u1 |
%
%                                  Ak                       Uk
%
%
%%
% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
global L, global l, global alpha, global alphafx, global alphafy, global beta;

% Controls are z,s,q,d keys, zoom with +,-, move camera with i,j,k,l and stop with ESC.

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Motorboat simu','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 5; offsetx = 0; offsety = 0;

L = 1.22; % Length of the hull (in m).
l = 0.35; % Width of the hull (in m).
alpha = 2.0; % Coefficient a regler en regardant la vitesse du bateau pour une entree u(1) donnee.
alphafx = 1.0; % Coefficient a regler pour les frottements.
alphafy = 1.0; % Coefficient a regler pour les frottements.
beta = 0.7; % Coeffecient (en rad) a regler selon l'angle max du jet.

x = [0;0;0;0];
u = [0;0];
dt = 0.05;
t = 0;

delta = beta*u(2);

% //////// Q3 \\\\\\\\
zk = [x(1);x(2);x(4)]; % Etat initial du robot...
Gzk = diag([0.1;0.1;0]); %...de variance 0.1

% Randomly initialize first waypoint
targets = 0;
target = scale*rand(2,1);

while (bExit == 0)
    % Simulated state evolution.
    
    % //////// Q4 & Q5 \\\\\\\\
    x = x+f(x,u)*dt;
    alphaxk = [0;0;0;0]; Galphaxk = diag([0.001;0.001;0;0.001]);
    alphak = mvnrnd(alphaxk, Galphaxk)';
    Galphazk = diag([0.001;0.001;0]);
    
    uk = [0;0;dt*u(1)];
    Ak = [1 0 dt*cos(delta)*cos(x(3));
          0 1 dt*cos(delta)*sin(x(3));
          0 0 1-dt];
      
    % Toujours Q4 & 5, mais sans les mesures GPS  
%     Gbetak = [];
%     yk = [];
%     Ck = [];  
      
    % //////// Q6 \\\\\\\\ Avec les mesures GPS
    Gbetak = diag([2;2;2]);
    yk = [x(1);x(2);x(4)];
    Ck = diag([1;1;1]);
  
    [zk,Gzk,zkup,Gzkup]=kalman(zk,Gzk,uk,yk,Galphazk,Gbetak,Ak,Ck);
    
    % //////// Q7 \\\\\\\\ Attention, une fois lancé, donner une impulsion au robot (un appuie long touche Z) et il continue tout seul  
    % Autonomous control part to go to waypoints.
    theta_w = atan2(target(2)-zkup(2),target(1)-zkup(1));    
    if (cos(x(3)-theta_w) > 0.5)
        u(2) = -sin(x(3)-theta_w);
    else
        u(2)= -sign(sin((x(3)-theta_w)));
    end
    
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); 
    axis square;
    draw(x,u);
    
    % //////// Q5 \\\\\\\\
    draw_ellipse([zkup(1);zkup(2)],diag([Gzkup(1,1);Gzkup(2,2)]),0.99);
    % Les ellipse de confiance définissent une zone dans laquelle notre
    % robot a toutes les probabilités de se retrouver à l'instant t+1.
   
    % Draw current waypoint and change it when we are close.
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    if ((target(1)-2.5 < zk(1))&&(zk(1) < target(1)+2.5)&&(target(2)-2.5 < zk(2))&&(zk(2) < target(2)+0.5))
        target = scale*rand(2,1);
    end
    
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

close(fig);
