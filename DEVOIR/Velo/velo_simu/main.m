% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;

button = questdlg('Get the most of targets within the shortest time. Controls are z,s,q,d keys, zoom with +,- and stop with ESC. Ready?', 'Ready?');
if (strcmp(button, 'Yes') == 0)
    return;
end

% Create a figure that will use the function keycontrol() when a key is
% pressed.
fig = figure('Position',[200 200 400 400],'KeyPressFcn','keycontrol','Name','Ecrazor game','NumberTitle','off');
% Force the figure to have input focus (required to capture keys).
set(fig,'WindowStyle','Modal');
axis('off');

bExit = 0;
scale = 10; offsetx = 0; offsety = 0;

x = [0;0;0];
u = [0;1];
dt = 0.05;
t = 0;
    
target = scale*(1-2*rand(2,1)); % Randomly initialize first waypoint.

while (bExit == 0)
    % Simulated state evolution.
    x = x+dt*f(x,u);
    
    clf;
    hold on;
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety]);
    draw(x,u);
    
    % Draw current waypoint and change it when we are close.
    plot(target(1),target(2),'--rs','LineWidth',5,'MarkerSize',5);    
    if ((target(1)-2.5 < x(1))&(x(1) < target(1)+2.5)&(target(2)-2.5 < x(2))&(x(2) < target(2)+2.5))
        target = scale*(1-2*rand(2,1));
    end
    
    % Wait a little bit.
    pause(0.02); % <dt because there are also computations delays...
    t = t+dt;
end

close(fig);
