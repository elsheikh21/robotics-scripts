%% Resetting workspace

clear all; close all; clc

%% DH params of the robot

px = 1.5309;
py = 1.5309;
pz = 0.25;

d1 = 0.5;

a1 = 0;
a2 = 1.5;
a3 = 1;

%% Inverse Kinematics

% cos(q1) & sin(q1) computations
c1 = px / (sqrt(power(px, 2) + power(py, 2)));
s1 = py / (sqrt(power(px, 2) + power(py, 2)));
q1plus = atan2(py, px)

% cos(q3) & sin(q3) computations
c3plu = (power(sqrt(power(px, 2) + power(py, 2) - a1), 2) + power(pz - d1, 2) - (power(a2, 2) + power(a3, 2))) / (2 * a2 * a3);
s3plu1 = sqrt(1 - power(c3plu, 2));
s3min1 = -sqrt(1 - power(c3plu, 2));
q3plus = atan2(s3plu1, c3plu)

% Coefficient Matrix A
A = [a2 + a3 * c3plu, a3 * s3plu1; -a3 * s3plu1, a2 + a3 * c3plu];

% cos(q2) & sin(q2) computations
c2 = (a2 + a3 * c3plu) * (c1 * px + s1 * py - a1) + a3 * s3plu1 * (pz - d1);
s2 = (a2 + a3 * c3plu) * (pz - d1) - a3 * s3plu1 * (c1 * px + s1 * py - a1);
q2 = atan2(s2, c2)
