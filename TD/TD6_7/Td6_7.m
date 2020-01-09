%% part 1
A0=[0.5 0;0 1]; u0=[8;16]; c0=[1 1]; y0=7;
A1=[1 -1;1 1]; u1=[-6;-18]; c1=[1 1]; y1=30;
A2=[1 -1;1 1]; u2=[32;-8]; c2=[1 1]; y2=-6;
Galpha=[1 0;0 1]; Gbeta=1;
xhat=[0;0];Gxhat=[100 0;0 100];

hold on;axis([-50 50 -50 50]);axis square;

%k=0
draw_ellipse(xhat,Gxhat,0.9,'red');
[xhat,Gxhat,xhatup,Gxhatup]=kalman(xhat,Gxhat,u0,y0,Galpha,Gbeta,A0,c0);
draw_ellipse(xhatup,Gxhatup,0.9,'red');
%k=1

draw_ellipse(xhat,Gxhat,0.9,'black');
[xhat,Gxhat,xhatup1,Gxhatup1]=kalman(xhat,Gxhat,u1,y1,Galpha,Gbeta,A1,c1);
draw_ellipse(xhatup1,Gxhatup1,0.9,'black');

%k = 2
draw_ellipse(xhat,Gxhat,0.9,'green');
[xhat,Gxhat,xhatup2,Gxhatup2]=kalman(xhat,Gxhat,u2,y2,Galpha,Gbeta,A2,c2);
draw_ellipse(xhatup2,Gxhatup2,0.9,'green');

%k = 3

draw_ellipse(xhat,Gxhat,0.9,'m');




