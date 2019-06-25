% 1st question
% tbar=0;

% outputs the desired Cartesian acc at t=0.8 s
dpd = [3; 3;];
% ddp1=0;
% ddp2=3.6*tbar;
% ddpd=[ddp1;ddp2]

clear all; close all; clc;

% current state
q1=-0.3831;
q2=2.1834;

syms dq1 dq2
% dq1=-pi;
% dq2=pi;
dq=[dq1; dq2];

% direct kinematics
l1 = 0.5;
l2 = 0.5;
p=[l1*cos(q1)+l2*cos(q1+q2);
l1*sin(q1)+l2*sin(q1+q2)];

% Jacobian matrix
J=[-l1*sin(q1)-l2*sin(q1+q2) -l2*sin(q1+q2);
l1*cos(q1)+l2*cos(q1+q2) l2*cos(q1+q2)];

% J'
% dJ=[-l1*cos(q1)*dq1-l2*cos(q1+q2)*(dq1+dq2) -l2*cos(q1+q2)*(dq1+dq2);
% -l1*sin(q1)*dq1-l2*sin(q1+q2)*(dq1+dq2) -l2*sin(q1+q2)*(dq1+dq2)];

% outputs the requested joint velocity command
dqd = inv(J)*(dpd - J*dq)

% outputs the requested joint acceleration command
ddqd=inv(J)*(ddpd - dJ*dq) 

pd0 = [0; -0.6];

% second joint computations
c2 = (pd0(1)^2 + pd0(2)^2 - l1^2 - l2^2) / (2 * l1 * l2);
s2 = sqrt(1 - c2^2); %other solution: -sqrt(1-c2^2)

% first joint computations
det = l1^2 + l2^2 + 2 * l1 * l2 * c2;
s1 = (pd0(2) * (l1 + l2 * c2) - pd0(1) * l2 * s2) / det;
c1 = (pd0(1) * (l1 + l2 * c2) + pd0(2) * l2 * s2) / det;

% output
q01 = atan2(s1, c1);
q02 = atan2(s2, c2);
q0 = [q01; q02]
