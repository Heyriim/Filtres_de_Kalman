function xp = f(x,u)
xp = [x(4)*cos(x(3));
    x(4)*sin(x(3));
    10 * u(2) - 10 * u(1);
    10 * u(1) + 10 * u(2) - x(4) ];
end
