a1 =[1 0; 0 3];
a2 =[cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)];
g1 = eye(2,2);
g2 = 3*eye(2,2);
g3 = a1 * g2 * a1' + g1;
g4 = a2 * g3 * a2';
g5 = g4 + g3;
g6 = a2 * g5 * a2';

figure (1);
clf;
hold on;

axis([-5 5 -5 5]); axis square;

draw_ellipse(x_bar, a1, 0.9,'black');
%draw_ellipse(x_bar, Gx, 0.99,'green');
%draw_ellipse(x_bar, Gx, 0.999,'red');