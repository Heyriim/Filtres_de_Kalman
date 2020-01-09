% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
global L, global l, global alpha, global alphafx, global beta;

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
alpha = 2.0; % Coefficient a regler en regardant la vitesse du sous-marin pour une entree u(1) donnee.
alphafx = 1.0; % Coefficient a regler pour les frottements.
beta = 0.7; % Coeffecient (en rad) a regler selon l'angle max du gouvernail.

x = [0;0;0;0];
u = [0;0];
dt = 0.02;
t = 0;

delta = beta*u(2);

% -------------Q7----------------
%Randomly initialize first waypoint
targets = 0;
target = scale*rand(2,1);

%-------------Q3----------------
Zk = [x(1); x(2); x(4)];    % on connait l'etat initial du robot 
                            % Ici on l'initialise à 0,0,0 ainsi il sera au
                            % milieu du graphique avec une vitesse nulle 
Gzk = diag([0.1,0.1,0.1]);  % Matrice de Covariance de variance 0.1
                            % variance de 0.1

while (bExit == 0)
    % Simulated state evolution.
    x = x + f(x,u)*dt;
    y = g(x,u);
    % -----------Q2-------------
    Ak = [1 , 0 , dt*cos(delta)*cos(x(3));
          0 , 1 , dt*cos(delta)*sin(x(3));
          0 , 0, 1-alphafx*dt];
    Uk = [0; 0; dt*alpha*u(1)];
    
    % ---------- Q4 -------------
    % Le GPS ne fonctionne pas <=> (x,y) non connues
    % Le loch à hélice  ne fonctionne pas <=> v non connue
        
%     yk = [];       
%     Ck =[];         
%     Gbetak = [];     %pas de bruit de mesure
%     Galphak = diag([0.0001 , 0.0001 ,0.0001]); %matrice de covariance du bruit d'etat
%     
    % ---------- Q6 -------------
    Gbetak = 0.00001;
    yk=y(4); Ck=[0 0 1]; 
    Galphak = dt * diag([0.0001 , 0.0001 ,0.0001]); %matrice de covariance du bruit d'etat
    
    % Application du filtre de Kalman
    [Zk,Gzk,Zup,Gzup] = kalman(Zk,Gzk,Uk,yk,Galphak,Gbetak,Ak,Ck);
       
    % ---------- Q7 -------------
    theta_w = atan2(target(2)-Zup(2),target(1)-Zup(1));    % td 11-12 target xw yw (1,2) zkup(x ,y )
    if (cos(x(3)-theta_w) > 0.5)
        u(2) = -sin(x(3)-theta_w); % définition de la direction 
    else
        u(2)= -sign(sin((x(3)-theta_w)));
    end
    % affichage du robot sous marin Neptune
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); axis square;
    draw(x,u); % Real position of the simulated robot.
    
    % ------------- Q5 -----------
    % dessiner les ellipses de confiance à 95%
    eta = 0.95;   % 95%
    draw_ellipse([Zup(1); Zup(2)],[Gzup(1,1), Gzup(1,2); Gzup(2,1), Gzup(2,2)],eta,'r',2)
    % ici on trace une ellispse à deux dimensions donc on ne prend pas en
    % compte la 3ième dimension.
    
    % -------------Q7----------------
    %Draw current waypoint and change it when we are close.
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    if ((target(1)-2.5 < Zk(1))&&(Zk(1) < target(1)+2.5)&&(target(2)-2.5 < Zk(2))&&(Zk(2) < target(2)+0.5))
        target = scale*rand(2,1);
    end
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

t

close(fig);
