% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
global L, global alpha, global beta;

% Controls are z,s,q,d keys, zoom with +,-, move camera with i,j,k,l and stop with ESC.

% Create a figure that will use the function keycontrol () when a key is
% pressed.
fig = figure ('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Buggy simu','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis ('off');

bExit = 0;
scale = 5; offsetx = 0; offsety = 0;

L = 0.5; % Distance (en m) entre essieux avant et arriere.
alpha = 2.0; % Coefficient (en m/s) a regler en regardant la vitesse du buggy pour une entree u (1) donnee.
beta = 0.7; % Coefficient (en rad) a regler selon l'angle max des roues de la direction avant.

x = [1;0.02;0];
u = [0;0];
dt = 0.05;
t = 0;

while (bExit ==0)
% simulated state evolution 
x = x + dt * f (x,u) + mvnrnd ([0;0.0001;-0.0002], diag ([0.0001;0.0001;0.0001]))';
Ak = eye (2,2);
xhat = [x (1);x (2)]; Gxhat = diag ([0.1;0.1]);
uk = [dt * alpha * u (1) * cos (beta*u (2)) * cos (x (3)); alpha * u (1) * cos (beta*u (2)) * cos (x (3))];
Galphak = diag ([0.001;0.001]);
Ck = []; yk = []; Gbetak = []; 
[xhat,Gxhat,xup,Gup]=kalman (xhat,Gxhat,uk,yk,Galphak,Gbetak,Ak,Ck) ;
clf;
hold on;
axis ([- scale + offsetx, scale + offsetx,-scale + offsety,scale + offsety ]); axis square; 
draw (x,u);
draw_ellipse ([xup (1);xup (2)], diag ([Gup (1,1); Gup (2,2)]),0.99,'r',1);
% wait a little bit.
pause(0.02); % t = t + dt;

end

t

close (fig);