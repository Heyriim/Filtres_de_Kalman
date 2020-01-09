y=[5;10;11;14;17]; C=[4 0;10 1;10 5; 13 5;15 3]
xhat=[1;-1]; Gx=4*eye(2,2);
Galpha=zeros(2,2); Gbeta=9; A=eye(2,2); u=zeros(2,1);
for k=1:5,
    hold on; axis([-5,5,-5,5]); axis square;
    draw_ellipse(xhat,Gx,0.9,'r',1);
    [xhat,Gx,xhatup,Gxup]=kalman(xhat,Gx,u,y(k),Galpha,Gbeta,A,C(k,:))
    draw_ellipse(xhatup,Gxup,0.9,'b',4);
end;
