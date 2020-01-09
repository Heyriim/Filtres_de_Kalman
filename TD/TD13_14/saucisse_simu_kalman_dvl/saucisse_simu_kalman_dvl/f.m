function xdot = f(x,u)
xdot = [x(4)*cos(x(3));
        x(4)*sin(x(3));
        u(2)-u(1);
        u(1)+u(2)-x(4)];
end
