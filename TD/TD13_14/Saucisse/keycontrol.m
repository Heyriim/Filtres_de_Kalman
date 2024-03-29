% This function should be called when a key is pressed.
function keycontrol()
% Global variables to share with other files.
global u;
global bExit;
global scale, global offsetx, global offsety;
key = get(gcbf,'CurrentCharacter');
% Actions to do depending on the key pressed.
switch (key)
    case 27,
        bExit = 1;
    case 'z',
        u(1) = u(1) + 0.1;
        
        u(2) = u(2)+0.1;
       
    case 's',
        u(1) = u(1) - 0.1;
        
        u(2) = u(2)-0.1;
    case 'q',
        u(1) = u(1) - 0.1;
        
        u(2) = u(2)+0.1;
    case 'd',
        u(1) = u(1) + 0.1;
        
        u(2) = u(2)-0.1;
    case ' ',
        u = [0;0];
    case '+',
        scale = scale*0.9;
    case '-',
        scale = scale/0.9;
    case 'space',
        u = [0;0];
 
end
if (u(1)>1) , u(1) =  1;end
if (u(1)<-1), u(1) = -1;end
if (u(2)>1) , u(2) =  1;end
if (u(2)<-1), u(2) = -1;end
end