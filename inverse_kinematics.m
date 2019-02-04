%% Preparing workspace
clear all; close all; clc;

%% Inverse kinematics 

% Rotation matrix
R = [0.433 -0.5 -0.75; 0.25 0.866 -0.433; 0.866 0 0.5]

% Determinant of matrix
detR = det(R)

% Elements of the rotation matrix
r11 = R(1,1);
r12 = R(1,2);
r13 = R(1,3);

r21 = R(2,1);
r22 = R(2,2);
r23 = R(2,3);

r31 = R(3,1);
r32 = R(3,2);
r33 = R(3,3);

% Computation of angles
theta_plus = atan2(-r31, sqrt(power(r32, 2) + power(r33, 2)))
theta_min = atan2(-r31, -sqrt(power(r32, 2) + power(r33, 2)))

psi_plus = atan2(r32/cos(theta_plus), r33/cos(theta_plus))
psi_min = atan2(r32/cos(theta_min), r33/cos(theta_min))

phi_plus = atan2(r21/cos(theta_plus), r11/cos(theta_plus))
phi_min = atan2(r21/cos(theta_min), r11/sin(theta_min))