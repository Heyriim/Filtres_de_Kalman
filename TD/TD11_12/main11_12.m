% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
global L, global alpha, global beta;

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Buggy simu','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 5; offsetx = 0; offsety = 0;

L = 0.5; %Distance (en m) entre essieux avant et arriere.
alpha = 2.0; %Coefficient (en m/s) a regler en regardant la vitesse du buggy pour une entree u(1) donnee.
beta = 0.7; %Coefficient (en rad) a regler selon l'angle max des roues de la direction avant.

x = [0;0;0];
zk = [x(1);x(2)]; % Estimated state vector (initial position).
Gzk = [0.1,0;0,0.1]; % Corresponding covariance matrix (error of the initial position).
u = [0;0];
dt = 0.05;
t = 0;

targets = 0;
target = scale*rand(2,1);

while (bExit == 0)    
    % State equation noise, assumed as gaussian...
    Galphaxk = dt*[0.002,0,0;0,0.003,0;0,0,0.001]; alphaxkbar = dt*[0.001;-0.002;0];
    alphaxk = alphaxkbar+sqrtm(Galphaxk)*randn(3,1);
    % Measurement noise, assumed as gaussian...
    Gbetak = [1.5,0;0,2]; betakbar = [-0.5;0.2];
    betak = betakbar+sqrtm(Gbetak)*randn(2,1);
    % Linearized estimated state noise. 
    Galphazk = dt*[0.002,0;0,0.003];
    
    % Simulated state evolution.
    x = x+dt*f(x,u)+alphaxk; 
        
    % Known inputs.
    v = alpha*u(1);
    delta = beta*u(2);  
    theta = x(3);
    uk = [dt*v*cos(delta)*cos(theta);dt*v*cos(delta)*sin(theta)];
        
    % Measurements.
    yk = []; Ck = []; Gbetak = []; % without GPS
    %yk = g(x,u)+betak; Ck = [1 0;0 1]; % with GPS 
    
    % Linearized evolution matrix.
    Ak = [1 0;0 1];
    
    % Computations with the Kalman filter.
    [zk,Gzk,zup,Gzup] = kalman(zk,Gzk,uk,yk,Galphazk,Gbetak,Ak,Ck);
    thetaw = atan2(target(2) -zk(2), target(1) - zk(1));% 0 q1 e t2
    % Regulation 
    %thetaw = 0; % wanted;
    if cos(thetaw - x(3)) >= 0
        u(2) =  sin(thetaw - x(3));   % p16 diapo avec deltamax = 1 
    else 
        u(2) = sign(sin(thetaw - x(3))); 
    end
    % Plot  
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); axis square;
    
    % Waitpoints generation
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    if ((target(1)-1.5 < x(1))&&(x(1) < target(1)+2.5)&&(target(2)-1.5 < x(2))&&(x(2) < target(2)+1.5)) %regenerer un carre  chaque fois que l'ancien est atteint
        targets = targets+1;
        target = scale*rand(2,1);
    end
    
    draw(x,u); % Real position of the simulated robot.
    draw_ellipse(zup(1:2),Gzup(1:2,1:2),0.9); % Ellipse showing the estimated position and error.
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

t

close(fig);