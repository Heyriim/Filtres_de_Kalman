function draw(x,u)
M_wheel = [-0.25  0.25 0.25 -0.25 -0.25;
           -0.05 -0.05 0.05  0.05 -0.05;
            ones(1,5)];
M_wheel_rear = [1,0,-0.5;0,1,0;0 0 1]*M_wheel;
M_wheel_front = [cos(u(1)),-sin(u(1)),0.5;sin(u(1)),cos(u(1)),0;0 0 1]*M_wheel;
M_wheel_rear = [cos(x(3)),-sin(x(3)),x(1);sin(x(3)),cos(x(3)),x(2);0 0 1]*M_wheel_rear;
M_wheel_front = [cos(x(3)),-sin(x(3)),x(1);sin(x(3)),cos(x(3)),x(2);0 0 1]*M_wheel_front;
plot(M_wheel_rear(1,:),M_wheel_rear(2,:),'b');
plot(M_wheel_front(1,:),M_wheel_front(2,:),'g');
end
