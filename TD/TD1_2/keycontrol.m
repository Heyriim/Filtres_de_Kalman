
% This function should be called when a key is pressed.
function keycontrol()
% Global variables to share with other files.

global u;
global bExit;
global scale;

key = get(gcbf,'CurrentCharacter');
% Actions to do depending on the key pressed.
switch (key)
    case 27,
        bExit = 1;
    case 'z', %avancer
        if (u(1) < 9)
            u(1) = u(1) + 0.5;
        end
    case 's', %reculer
        if (u(1) > -9)
            u(1) = u(1) - 0.5;
        end
    case 'q',
        if (u(2) < 0.5)
            u(2) = u(2) + 0.1;
        end
    case 'd',
        if (u(2) > -0.5)
            u(2) = u(2) - 0.1;
        end
    case ' ',
         u = [0, 0];
    case '+',
        scale = scale*0.9;
    case '-',
        scale = scale/0.9;
end