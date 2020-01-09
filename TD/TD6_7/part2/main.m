dt = 0.01;
t =0;
x = [0;0;0;10;0.5];
u = [0;0];
zk = [x(1);x(2);x(4)]; % valeurs à estimer du système initialisé à 1
Gzk = diag([0.1;0.1;0.1]);
while (t<30)
     %%  bruit -> simulateur 
     alphatheta = mvnrnd(0,0.01 * dt );
     alphav     = mvnrnd(0,0.01 * dt);
     alphadelta = mvnrnd(0,0.01 * dt);
     
     % x(3) = theta et x(5) = delta 
     x  = x + dt * f(x,u)+ [0;0;alphatheta;alphav;alphadelta];
     
     %% observateur
     Ak = [1 0 dt*cos(x(5))*cos(x(3)); 0 1 dt*cos(x(5))*sin(x(3));0 0 1];
     Uk = [0;0;dt*u(1)];
     
     % supposition de bruit sur l'etat
     Galphak = diag([0;0;0.01*dt]); %  matrice de covariance asociée à alphav 
     yk = x(4);                     % capteur de vitesse 
     gbeta = 0.01;                  
     ck = [0 0 1]; 
     
     %[x1,G1,zkup,Gzkup]=kalman(zk,Gzk,Uk,[],Galphak,[],Ak,[]);
     % [] dit qu'ont est en mode prédicteur pas besoin de fusionner = on
     % est pas capable de faire des mesures sur y gbeta et C
     
     [zk,Gzk,zkup,Gzkup]=kalman(zk,Gzk,Uk,yk,Galphak,gbeta,Ak,ck);
     clf;
     hold on; axis([-100 100 -100 100]); axis square 
     draw_car(x);
     draw_ellipse([zkup(1);zkup(2)], diag([Gzkup(1,1);Gzkup(2,2)]),0.99,'b',1);
     pause(dt);
     t = t+dt;
     
end