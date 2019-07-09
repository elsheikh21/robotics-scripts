%% Clean workspace
clearvars; close all; clc;

%% Compute Linear Jacobian
syms l1 l2 l3 q1 q2 q3

q = [q1, q2, q3];

px = [l1 * cos(q1) + l2 * cos(q1 + q2) + l3 * cos(q1 + q2 + q3)];
py = [l1 * sin(q1) + l2 * sin(q1 + q2) + l3 * sin(q1 + q2 + q3)];

position = [px; py];
disp('Position');
disp(position);

phi = q1 + q2 + q3;

r = [position; phi];
disp('r: ');
disp(r);

J = jacobian(r, q);
[rows, cols] = size(J);
disp(['Jacobian [', num2str(rows), 'x', num2str(cols), ']']);
disp(J);

if rows == cols
    disp('Jacobian determinant');
    pretty(simplify(det(J)));
end
%% Substitute with values

Ja = subs(J, [l1, l2, l3, q1, q2, q3], [0.5, 0.5, 0.5, deg2rad(30), deg2rad(30), deg2rad(120)]);
disp('Jacobian in the config');
disp(Ja);

%% Compute q_dot

Ja_inv = inv(Ja);
p_dot = [[0]; [1]; [0];];

q_dot = mtimes(Ja_inv, p_dot);
disp('Desired joint velocities as per desired cartesian velocity');
disp(q_dot);

%% Compute joint torques

JT = Ja.';
JT_ = JT(:, 1:2);
disp('Jacobian Transpose');
disp(JT_);

Fe = [[-5]; [0];];
T = mtimes(JT_, Fe);
disp('Desired torques as per desired enviromental forces');
disp(T);
