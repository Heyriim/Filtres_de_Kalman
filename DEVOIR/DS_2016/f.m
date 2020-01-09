function xp = f(x,u)
xp = [u(2)*cos(u(1))*cos(x(3));
    u(2)*cos(u(1))*sin(x(3));
    u(2)*sin(u(1))/1.0];
end
