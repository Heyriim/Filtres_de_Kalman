function [latitude,longitude]=RefCoordSystem2GPS(lat0, long0, x, y)
 EARTH_RADIUS=6371000.0;
 latitude = (y/EARTH_RADIUS)*(180.0/pi)+lat0;
 if ((abs(latitude-90.0) < 0.000000001)|(abs(latitude+90.0) < 0.000000001))
  longitude = 0;
 else
  longitude = (x/EARTH_RADIUS)*(180.0/pi)/cos((M_PI/180.0)*latitude)+long0;
 end
end
