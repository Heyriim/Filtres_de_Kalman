% Global variables to share with other files.
global u;
global bExit;
global scale;

% button = questdlg('Welcome to Ecrazor game. Activate sound?', 'Ecrazor game');
% if (strcmp(button, 'Yes') == 1)
%     sound(audioread('sound.wav'), 22050);%wavplay(wavread('sound.wav'), 22050, 'async');
% end
% 
% button = questdlg('Get the most of targets within the shortest time. Controls are z,s,q,d keys, zoom with +,- and stop with ESC. Ready?', 'Ready?');
% if (strcmp(button, 'Yes') == 0)
%     return;
% end

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Ecrazor game','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 10;

x = [0;0;0;0];
u = [0;0];
dt = 0.01;
t = 0;
zk =[x(1); x(2); x(4)]; %  car vecteur d'etat on a v  = x(4) 
Gzk = diag([0.1;0.1;0.1]); % d'après l'énoncé et la taille de zk
%zthetak = x(3); Gzthetak = diag(0.02); % on admet que c'est connu     
targets = 0;
target = scale*rand(2,1);

while (bExit == 0)
    x = x + f(x,u) * dt;  
    y = g(x,u);
    Ak = [1 0 dt * cos(y(1)); 0 1 dt * sin(y(1)); 0 0 1-dt ]  ;
    uk = [0; 0; dt * 10 *(u(1)+u(2))];
    %Ck = []; yk =[]; Gbetak = []; % car pas de mesure
    Ck = [0 0 1]; yk =[y(2)]; Gbetak = [0.001]; % Q6
    
    %Kalman 
    
    [zk,Gzk,zup,Gzup]=kalman(zk,Gzk,uk,yk,Galphak,Gbetak,Ak,Ck);
    
    % Suivi des points 
    % autonomous control part to go to waypoints .
    thetaw = atan2(target(2) -zk(2), target(1) - zk(1));
    if cos(thetaw - y(1)) >= 0
        uw = -sin(thetaw - y(1));   % p16 diapo avec deltamax = 1 
    else 
        uw = -sign(sin(thetaw - y(1))); 
    end
    uv = 1;
    u(1) = (uv + uw)/2;
    u(2) = (uv - uw)/2;
    
    % tracé
    clf;
    hold on;
    axis([-scale,scale,-scale,scale]); axis square;
   
    draw(x);
    draw_ellipse([zup(1);zup(2)],[Gzup(1,1) Gzup(1,2); Gzup(2,1) Gzup(2,2)],0.9,'r',1);  % car on prends deux coordonnées eta -0.1
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    
    if ((target(1)-2.5 < x(1))&&(x(1) < target(1)+2.5)&&(target(2)-2.5 < x(2))&&(x(2) < target(2)+2.5))
        targets = targets+1;
        target = scale*rand(2,1);
    end
    
    % Wait a little bit.
    pause(dt);
    t = t+dt;
end

targets
t
score = 100*targets/t

str = sprintf('Targets catched : %d, total time = %f s, score = %6.f', targets, t, score);
warndlg(str, 'Results');

close(fig);

