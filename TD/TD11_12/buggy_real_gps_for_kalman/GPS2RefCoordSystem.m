function [x,y]=GPS2RefCoordSystem(lat0, long0, latitude, longitude)
 EARTH_RADIUS=6371000.0;
 x = (pi/180.0)*EARTH_RADIUS*(longitude-long0)*cos((pi/180.0)*latitude);
 y = (pi/180.0)*EARTH_RADIUS*(latitude-lat0);
end
