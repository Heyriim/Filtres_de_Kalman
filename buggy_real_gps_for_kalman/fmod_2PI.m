function res=fmod_2PI(theta)
 res=mod(mod(theta, 2*pi)+3*pi, 2*pi)-pi;
end
