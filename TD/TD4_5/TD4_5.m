%% Q1 
n = 1000
x0 = randn(n,2)'    % signal normal aléatoire de 1000 colonnes et 2 lignes
x_bar = [1;2];
Gx =[3 1; 1 3];
x = x_bar * ones(1,n) + sqrtm(Gx) * x0;
% solution temporaire x = mvnrnd(x_bar,Gx,1000)'; ' veut dire transposé

%% Q2
figure (1);
clf;
hold on;
axis([-5 5 -5 5]); axis square;
plot(x(1,:),x(2,:),'.');
draw_ellipse(x_bar, Gx, 0.9,'black');
draw_ellipse(x_bar, Gx, 0.99,'green');
draw_ellipse(x_bar, Gx, 0.999,'red');

%% Q3
G = cov(x0')
x0bar = mean(x0') 

%% part 2

a1 =[1 0; 0 3];
a2 =[cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)];
g1 = eye(2,2);
g2 = 3*eye(2,2);
g3 = a1 * g2 * a1' + g1;
g4 = a2 * g3 * a2';
g5 = g4 + g3;
g6 = a2 * g5 * a2';

figure (2);
clf;
hold on;

axis([-15 17 -15 17]); axis square;

% eta 90% : si on génère un vecteur aléatoire gaussien 90 pt se
% trouveraient dans l'ellispe

draw_ellipse(x_bar, a1, 0.9,'black');
draw_ellipse(x_bar, a2, 0.9,'green');
draw_ellipse(x_bar, g1, 0.9,'red');
draw_ellipse(x_bar, g2, 0.9,'yellow');
draw_ellipse(x_bar, g3, 0.9,'blue');
draw_ellipse(x_bar, g4, 0.9,'cyan');
draw_ellipse(x_bar, g5, 0.9,'m');
draw_ellipse(x_bar, g6, 0.9);
legend('a1','a2','g1','g2','g3','g4','g5','g6')
title('Tracé d ellipses part 2 td')

x = mvnrnd(x_bar,g1,1000)';
plot(x(1,:),x(2,:),'m.');

