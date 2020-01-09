Virtual buggy :

Download and extract http://www.ensta-bretagne.fr/lebars/Share/BUGGY_SIMULATOR_WORKSPACE.zip 
and launch UxVCtrl_compat.exe (or UxVCtrl_Ubuntu64_static for Ubuntu 16.04.5 64 bit, 
or rebuild from source on https://github.com/ENSTABretagneRobotics/UxVCtrl ).
 This program emulates via a network connection usual sensors and interface boards : a GPS 
using the NMEA protocol (on TCP port 5001), a Razor AHRS (mainly used as a compass, on TCP port 5007), 
a SSC-32 interface board (used to generate PWM signals to control servomotors and motors, on TCP port 5004).
 Use Mission Planner (get it from 
http://www.ensta-bretagne.fr/lebars/Share/mission_planner.zip or http://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-latest.zip 
if it is not installed) or QGroundControl to connect through TCP port 5760 to the virtual buggy to see its real position (cancel the "Get Params" or "Home altitude" dialogs if they appear).


Buggy with embedded Android smartphone :

Connect the smartphone to the same Wi-Fi network as your computer and launch on the smartphone GPSSvcSrv, AHRSSvcSrv, IOIOSvcSrv (see https://github.com/ENSTABretagneRobotics/Android for more information). Each app is making the smartphone emulate via a network connection usual sensors and interface boards : a GPS using the NMEA protocol (on TCP port 4001), a Razor AHRS (mainly used as a compass, on TCP port 4007), a SSC-32 interface board (used to generate PWM signals to control servomotors and motors, on TCP port 4004).


Buggy with embedded PC :

The embedded PC should automatically connect to the ROBOTICS Wi-Fi network (connected to the Ethernet ENSTA Bretagne network)
 as well as generate SARDINE-UBNT Wi-Fi network (you will need to change the IP address of your computer to a static one 
192.168.0.150-200 if you choose to communicate through this independent network). 
The embedded PC should automatically make available via a network connection its sensors and interface boards : a GPS using the
 NMEA protocol (on TCP port 4001), a Razor AHRS (mainly used as a compass, on TCP port 4007), a SSC-32 or Pololu Maestro interface 
board (used to generate PWM signals to control servomotors and motors, on TCP port 4004). If the buggy is equipped with a Pololu Maestro 
instead of SSC-32, you will need to replace each instance of SSC32 to Pololu in main.m, as well as nbchannels to 24 instead of 32.


For all buggys :

Launch MATLAB preferably by right-clicking on `Run as administrator` on MATLAB shortcut 
(this is sometimes required to be able to access serial devices, for Linux and Mac OS you will need to rebuild 
https://github.com/ENSTABretagneRobotics/Hardware-MATLAB ).

You might need to modify the IP address (check on the smartphone or PC) and TCP ports in the files ublox0.txt, RazorAHRS0.txt, SSC320.txt,
 Pololu0.txt. Check that no antivirus, firewall, proxy, gateway login, etc. is causing disturbances.

If the robot is not going straight or is slowly moving while it should be stopped, you might need to trim the MidPW and 
InitPW values for channel 0 (front direction servo), 1 (rear direction servo) and 2 (motors) in SSC320.txt or Pololu0.txt to 
correct the neutral position. Same for MinPW and MaxPW if it is not turning symmetrically, and change CoefPW if the direction is inverted.
