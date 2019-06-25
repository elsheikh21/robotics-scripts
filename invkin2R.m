%% Resetting workspace

clear all; close all; clc

%% 2R robot
l1 = 0.5;
l2 = 0.5;

p1x = 0.35;
p1y = 0.3;

c2 = (power(p1x, 2) + power(p1y, 2) - power(l1, 2) - power(l2, 2)) / (2 * l1 * l2);
s2 = sqrt(1 - power(c2, 2));
disp('first configuration is ')
q2a = atan2(s2, c2);
q1a = atan2(p1y, p1x) - atan2(l2 * s2, l1 + (l2 * c2));
qa = [q1a; q2a]

disp('second configuration is ')
q2b = atan2(-s2, c2);
q1b = atan2(p1y, p1x) - atan2(-l2 * s2, l1 + (l2 * c2));
qb = [q1b; q2b]

%algebraic when c2 != [-1,1]
det = power(l1, 2) + power(l2, 2) + 2 * l1 * l2;
q1 = atan2((p1y * (l1 + l2 * c2) - p1x * l2 * s2) / det, (p1x * (l1 + l2 * c2) + p1y * l2 * s2) / det)

%% Jacobian

syms l1 l2 q1 q2

J=[-l1*sin(q1)-l2*sin(q1+q2) -l2*sin(q1+q2);
l1*cos(q1)+l2*cos(q1+q2) l2*cos(q1+q2)];

inv_J = inv(J)
