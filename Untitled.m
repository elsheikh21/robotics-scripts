close all; clear all; clc;
V1 = 40*pi/180;
T = 3;
Tc = 0.001;
t = [0:Tc:T];
% solution for desired q2 and s
dets=0.5*cos(V1*t)+(1.5/sqrt(3))*sin(V1*t);
qd2=0.5./dets;
sd=sin(V1*t)./dets;
% solution for desired velocity of q2 and s
dotqd2=V1*(0.25*sd+(1.5/sqrt(3))^2*sd-(1.5/sqrt(3)))./dets;
dotsd=V1*((0.5*sin(V1*t)-(1.5/sqrt(3))*cos(V1*t)).*sd+cos(V1*t))./dets;
