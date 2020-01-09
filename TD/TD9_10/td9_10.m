clear; close all; clc; 



C0 = [4,0] ; C1 =[10,1]; C2=[10,5]; C3=[13,5]; C4 = [15,3];
y0 = 5;    y1 = 10; y2=11; y3 =14; y4 = 17; 
Gbeta = 9; xhat=[1;-1]; Gxhat = diag([4;4]);  % matrice de covariance 
Galpha = diag([0;0]); % alpha [0;0]
A = eye(2,2);
u = [0;0]; 
eta = 0.9;
hold on ; axis([-10 10 -10 10]); axis square;

draw_ellipse(xhat, Gxhat,eta,'g',1);
[xhat,Gxhat,xup,Gup] = kalman(xhat,Gxhat,u,y0,Galpha,Gbeta,A,C0);

draw_ellipse(xhat, Gxhat,eta,'r',1);
[xhat,Gxhat,xup,Gup] = kalman(xhat,Gxhat,u,y1,Galpha,Gbeta,A,C1);

draw_ellipse(xhat, Gxhat,eta,'m',1);
[xhat,Gxhat,xup,Gup] = kalman(xhat,Gxhat,u,y2,Galpha,Gbeta,A,C2);

draw_ellipse(xhat, Gxhat,eta,'b',1);
[xhat,Gxhat,xup,Gup] = kalman(xhat,Gxhat,u,y3,Galpha,Gbeta,A,C3);

draw_ellipse(xhat, Gxhat,eta,'k',1);
[xhat,Gxhat,xup,Gup] = kalman(xhat,Gxhat,u,y4,Galpha,Gbeta,A,C4);

