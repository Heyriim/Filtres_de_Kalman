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

while (bExit == 0)    
    % State equation noise, assumed as gaussian...
    Galphax = dt*[0.002,0,0;0,0.003,0;0,0,0.0001]; alphaxbar = dt*[0.001;-0.002;0];
    alphax = alphaxbar+sqrtm(Galphax)*randn(3,1); % Or mvnrnd(alphaxbar,Galphax)'
    % Measurement noise, assumed as gaussian...
    Gbetay = [1,0,0;0,1.5,0;0,0,0.0001]; betaybar = [0;0;0];
    betay = betaybar+sqrtm(Gbetay)*randn(3,1); % Or mvnrnd(betaybar,Gbetay)'
    
    % Simulated state evolution.
    x = x+dt*f(x,u)+alphax; 
    % Simulated measurements.
    y = g(x,u)+betay;
    
    % Kalman filter known inputs.
    v = alpha*u(1);
    delta = beta*u(2);  
    theta = y(3);
    uk = [dt*v*cos(delta)*cos(theta);dt*v*cos(delta)*sin(theta)];
    
    % Kalman filter evolution matrix.
    Ak = [1 0;0 1];

    % Kalman filter state noise. 
    Galphak = dt*[0.005,0;0,0.005];
        
    % Kalman filter measurements.
    yk = []; Ck = []; Gbetak = []; % Without GPS.
    %yk = [y(1);y(2)]; Ck = [1 0;0 1]; Gbetak = [2,0;0,2]; % With GPS.
    
    % Computations with the Kalman filter.
    [zk,Gzk,zup,Gzup] = kalman(zk,Gzk,uk,yk,Galphak,Gbetak,Ak,Ck);
        
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); axis square;
    draw(x,u); % Real position of the simulated robot.
    draw_ellipse(zup(1:2),Gzup(1:2,1:2),0.9); % Ellipse showing the estimated position and error.
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

t

close(fig);
