# Check and modify the content of this Makefile to match your configuration if needed to build this library.
# Put the built library (hardwarex.so/.dylib) in this folder (.so for Linux, .dylib for Mac).
#
# For Linux, run in a terminal something similar to : 
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/Hardware-MATLAB-master
# to enable MATLAB to find the library, and launch MATLAB from the same terminal.
# In some cases (MATLAB before 2013?) you might have to launch MATLAB using something similar to this : 
# LD_PRELOAD=/usr/lib64/libstdc++.so.6 matlab
# or 
# LD_PRELOAD=/usr/lib64/libstdc++.so.6:/lib64/libgcc_s.so.1 matlab
# to force it to run using the system default version of the C++ Standard Library (otherwise MATLAB might use its 
# own version, which is likely to be different from the one used when you built the shared library)...
#
# For Mac, run in a terminal something similar to : 
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:~/Hardware-MATLAB-master
# to enable MATLAB to find the library, and launch MATLAB from the same terminal.
# In some cases (MATLAB before 2013?) you might have to launch MATLAB using something similar to this : 
# DYLD_INSERT_LIBRARIES=/usr/lib/libstdc++.6.dylib /Applications/MATLAB_R2012a.app/bin/matlab
# or 
# DYLD_INSERT_LIBRARIES=/usr/lib/libstdc++.6.dylib:/usr/lib/libgcc_s.1.dylib /Applications/MATLAB_R2012a.app/bin/matlab
# to force it to run using the system default version of the C++ Standard Library (otherwise MATLAB might use its 
# own version, which is likely to be different from the one used when you built the shared library)...
#
# Check test_XXX.m files for usage information.

# Change here depending on your OS (.so for Linux, .dylib for Mac).
LIB = hardwarex.so
#LIB = hardwarex.dylib

CC = gcc
CXX = g++

CFLAGS += -fPIC
CFLAGS += -g
#CFLAGS += -O3
CFLAGS += -Wall -Wno-unknown-pragmas
#CFLAGS += -Wextra -Winline

CFLAGS += -DDISABLE_AIS_SUPPORT

CFLAGS += -I. -I..
CFLAGS += -IMAVLinkSDK
CFLAGS += -IsbgECom/src -IsbgECom/common 
CFLAGS += -I/usr/local/include/sbgECom/src -I/usr/local/include/sbgECom/common 

# Depending on your OS (old Linux or Mac)...
#CFLAGS += -DUSE_OLD_CHRONO

CXXFLAGS += $(CFLAGS) -fpermissive

LDFLAGS += -LsbgECom/lib

# sbgECom needs to be built with -fPIC...
#LDFLAGS += -lsbgECom
LDFLAGS += -lrt -lm
LDFLAGS += -lpthread -lrt -lm

default: $(LIB)

############################# OSUtils #############################

OSComputerRS232Port.o: OSComputerRS232Port.c OSComputerRS232Port.h OSTime.o
	$(CC) $(CFLAGS) -c $<

OSCore.o: OSCore.c OSCore.h
	$(CC) $(CFLAGS) -c $<

OSCriticalSection.o: OSCriticalSection.c OSCriticalSection.h OSThread.o
	$(CC) $(CFLAGS) -c $<

OSMisc.o: OSMisc.c OSMisc.h OSTime.o
	$(CC) $(CFLAGS) -c $<

OSNet.o: OSNet.c OSNet.h OSTime.o
	$(CC) $(CFLAGS) -c $<

OSThread.o: OSThread.c OSThread.h OSTime.o
	$(CC) $(CFLAGS) -c $<

OSTime.o: OSTime.c OSTime.h OSCore.o
	$(CC) $(CFLAGS) -c $<

############################# PROGS #############################

hardwarex.o: hardwarex.cpp hardwarex.h OSNet.h OSComputerRS232Port.h OSMisc.h OSTime.h OSThread.o OSCriticalSection.h OSCore.h Hokuyo.h IM483I.h MAVLinkDevice.h MAVLinkProtocol.h MDM.h MT.h NMEADevice.h NMEAProtocol.h P33x.h Pololu.h RazorAHRS.h RPLIDAR.h RS232Port.h SBG.h SSC32.h ublox.h UBXProtocol.h
	$(CXX) $(CXXFLAGS) -c $<

$(LIB): hardwarex.o OSNet.o OSComputerRS232Port.o OSMisc.o OSTime.o OSThread.o OSCriticalSection.o OSCore.o
	$(CXX) $(CXXFLAGS) -shared -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(LIB) *.o *.obj core *.gch
