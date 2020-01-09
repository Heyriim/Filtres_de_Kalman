function y = g(x,u)
% Position measured using a GPS when at the surface, heading measured using a compass, speed measured with a DVL.
y = [x(1);
     x(2);
     x(3);
     x(4)+mvnrnd(0,0.01)];
end
