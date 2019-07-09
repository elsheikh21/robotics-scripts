%% prepare Working space
close all; clearvars; clc;

% Symbols used
syms t t1 t2 t3 t4 a1 a2 a3 b1 b2 b3 c1 c2 c3

%% Cubic Splines problem formulation

% Define pos bounds
q1 = deg2rad(45);
q2 = deg2rad(90);
q3 = deg2rad(-45);
q4 = deg2rad(45);

% Define vel bounds
dq1 = 0;
dq4 = 0;

% Define time intervals
t1 = 1;
t2 = 2;
t3 = 2.5;
t4 = 4;

% Define Tau
tauA = t - t1/ t2 - t1;
tauB = t - t2/ t3 - t2;
tauC = t - t3/ t4 - t3;

% Define Splines
qA_tauA = q1 + a1 * tauA + a2 * power(tauA, 2) + a3 * power(tauA, 3)
qB_tauB = q2 + b1 * tauB + b2 * power(tauB, 2) + b3 * power(tauB, 3)
qC_tauC = q3 + c1 * tauC + c2 * power(tauC, 2) + c3 * power(tauC, 3)