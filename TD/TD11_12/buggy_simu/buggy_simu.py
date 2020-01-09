#!/usr/bin/env python
from __future__ import print_function
from matplotlib.pyplot import *
from numpy import *
from numpy.random import *

from math import * # For real cos instead of array cos from numpy...

print('\n\nControls are up,down,left,right,space keys, zoom with +,-, move camera with 4,5,6,8 and stop with ESC.\n\n')

bExit = 0
scale, offsetx, offsety = 5, 0, 0

L = 0.5 #Distance (en m) entre essieux avant et arriere.
alpha = 2.0 #Coefficient (en m/s) a regler en regardant la vitesse du buggy pour une entree u(1) donnee.
beta = 0.7 #Coefficient (en rad) a regler selon l'angle max des roues de la direction avant.

x = array([0,0,0]).reshape(3,1)
u = array([0,0]).reshape(2,1)
dt = 0.05
t = 0

# This function should be called when a key is pressed.
def on_key(event):
    # Global variables to share with other functions.
    global u, bExit, scale, offsetx, offsety
    # Actions to do depending on the key pressed.
    #print('You pressed', event.key, event.xdata, event.ydata)
    if event.key == 'escape':
        bExit = 1
    if event.key == 'up':
        u0 = u[0]+0.1
        if (u0 > 1):
            u0 = 0*u[0]+1
        u1 = u[1]
        u = array([u0,u1]).reshape(2,1)
    if event.key == 'down':
        u0 = u[0]-0.1
        if (u0 < -1):
            u0 = 0*u[0]-1
        u1 = u[1]
        u = array([u0,u1]).reshape(2,1)
    if event.key == 'left':
        u0 = u[0]
        u1 = u[1]+0.1
        if (u1 > 1):
            u1 = 0*u[1]+1
        u = array([u0,u1]).reshape(2,1)
    if event.key == 'right':
        u0 = u[0]
        u1 = u[1]-0.1
        if (u1 < -1):
            u1 = 0*u[1]-1
        u = array([u0,u1]).reshape(2,1)
    if event.key == ' ':
        u = array([0,0]).reshape(2,1)
    if event.key == '+':
        scale = scale*0.9
    if event.key == '-':
        scale = scale/0.9
    if event.key == '8':
        offsety = offsety+1
    if event.key == '5':
        offsety = offsety-1
    if event.key == '6':
        offsetx = offsetx+1
    if event.key == '4':
        offsetx = offsetx-1

def f(x,u):
    # Global variables to share with other functions.
    global L, alpha, beta
    v = alpha*u[0]
    delta = beta*u[1]
    xdot = array([v*cos(delta)*cos(x[2]),
                  v*cos(delta)*sin(x[2]),
                  v*sin(delta)/L]).reshape(3,1)
    return xdot

def draw_buggy(x,u):
    # Global variables to share with other functions.
    global L, alpha, beta
    v = alpha*u[0]
    delta = beta*u[1]
    M = array([[-0.1, L+0.1,L+0.2, L+0.2,L+0.1,-0.1,-0.1,-0.1,   0,   0,-0.1, 0.1,   0,  0,-0.1,0.1,  0,  0,  L,  L,   L], # Chassis et roues arrieres.
               [-0.2,  -0.2, -0.1,   0.1,  0.2, 0.2,-0.2,-0.2,-0.2,-0.3,-0.3,-0.3,-0.3,0.3, 0.3,0.3,0.3,0.2,0.2,0.3,-0.3],
               ones(21)])
    Rav=array([[-0.1,0.1],[0,0],ones(2)]) # Motif d'une roue avant.
    R=array([[cos(x[2]),-sin(x[2]),x[0]],[sin(x[2]),cos(x[2]),x[1]],[0,0,1]])
    M=R@M
    Ravd=R@array([[cos(delta),-sin(delta),L],[sin(delta),cos(delta), 0.3],[0,0,1]])@Rav
    Ravg=R@array([[cos(delta),-sin(delta),L],[sin(delta),cos(delta),-0.3],[0,0,1]])@Rav
    plot(M[0].flatten(),M[1].flatten(),'b')
    plot(Ravd[0].flatten(),Ravd[1].flatten(),'k')
    plot(Ravg[0].flatten(),Ravg[1].flatten(),'k')

ion() # Turn the interactive mode on.

# Create a figure that will use the function on_key() when a key is
# pressed.
fig = figure('Buggy simu')
cid = fig.canvas.mpl_connect('key_press_event',on_key)

while (bExit == 0):
    # Simulated state evolution.
    x = x+f(x,u)*dt 

    clf()
    axis('square')
    axis([-scale+offsetx,scale+offsetx,-scale+offsety,scale+offsety])
    draw_buggy(x,u)
    # Wait a little bit.
    pause(0.001) # <dt because there are also computations delays...
    t = t+dt
