% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;

% Controls are z,s,q,d keys, zoom with +,-, move camera with i,j,k,l and stop with ESC.

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','SAUC''ISSE simu','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 5; offsetx = 0; offsety = 0;

x = [0;0;0;0];
zk=[x(1);x(2);x(4)]; % Estimated state vector (initial position).
Gzk=[0.1,0,0;0,0.1,0;0,0,0.1]; % Corresponding covariance matrix (error of the initial position).
u = [0;0];
dt = 0.05;
t = 0;

while (bExit == 0)    
    % Simulated state evolution.
    x = x+dt*f(x,u);
    % Simulated measurements.
    y = g(x,u);
    
    % Kalman filter known inputs.
    theta = y(3);
    uk=[0;0;dt*(u(1)+u(2))];
    
    % Kalman filter evolution matrix.
    Ak=[1 0 dt*cos(theta);0 1 dt*sin(theta);0 0 1-dt];
    
    % Kalman filter state noise. 
    Galphak=dt*[0.002,0,0;0,0.003,0;0,0,0.001];
        
    % Kalman filter measurements.
    yk=y(4); Ck=[0 0 1]; Gbetak=0.01; % A DVL is able to measure v.
    
    % Computations with the Kalman filter.
    [zk,Gzk,zkup,Gzkup]=kalman(zk,Gzk,uk,yk,Galphak,Gbetak,Ak,Ck); % With DVL.
    %[zk,Gzk,zkup,Gzkup]=kalman(zk,Gzk,uk,[],Galphak,[],Ak,[]); % Without DVL.
    
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]); axis square;
    draw(x,u); % Real position of the simulated robot.
    draw_ellipse([zkup(1);zkup(2)],[Gzkup(1,1) Gzkup(1,2);Gzkup(2,1) Gzkup(2,2)],0.9); % Ellipse showing the estimated position and error.

    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

t

close(fig);
