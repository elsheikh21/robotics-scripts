%% Preparing the workspace

clearvars; close all; clc;

%% Orientation trajectory tracking

% Ra = [[1 0 0]; [0 0 -1]; [0 1 0];];
% 
% trans_Ra = Ra.';
% 
% Rb = [[0 -1 0]; [1 0 0]; [0 0 1];];
% 
% R = mtimes(trans_Ra, Rb);
% 
% disp("Rotation matrix: ")
% disp(R)

%% Axis/Angle representation
% To fetch theta and neutral axis 'r'

% syms rx ry rz theta
% 
% x_11 = power(rx, 2) * (1 - cos(theta)) + cos(theta);
% x_12 = rx * ry * (1 - cos(theta)) - (rz * sin(theta));
% x_13 = rx * rz * (1 - cos(theta))+ (ry * sin(theta));
% row_1 = [x_11 x_12 x_13;];
% 
% x_21 = rx * ry * (1 - cos(theta)) + (rz * sin(theta));
% x_22 = power(ry, 2) * (1 - cos(theta)) + (cos(theta));
% x_23 = ry * rz * (1 - cos(theta)) - (rx * sin(theta));
% row_2 = [x_21 x_22 x_23;];
% 
% x_31 = rx * rz * (1 - cos(theta)) - (ry * sin(theta));
% x_32 = ry * rz * (1 - cos(theta)) + (rx * sin(theta));
% x_33 = power(rz, 2) * (1 - cos(theta)) - (cos(theta));
% row_3 = [x_31 x_32 x_33;];
% 
% R_theta_r = [row_1; row_2; row_3;]
% 
% disp("R(theta, r) : ")
% disp(R_theta_r)

%% Solve for theta & neutral axis r

% We start with solving for theta
% They are splitted for readability
% y1 = power((R(1, 2) - R(2, 1)), 2);
% y2 = power((R(1, 3) - R(3, 1)), 2);
% y3 = power((R(3, 2) - R(2, 3)), 2);
% y_prime = y1 + y2 + y3;
% 
% y = power(y_prime, 1/2);
% x = R(1, 1) + R(2, 2) + R(3, 3) - 1;
% 
% theta = atan2(y, x)
% 
% r = power(2 * sin(theta), -1) * [[R(3, 2) - R(2, 3)]; [R(1, 3) - R(3, 1)]; [R(2, 1) - R(1, 2)];]

%% solving 3 equations in 3 unknowns

syms q1 q2 q3

d1 = 0.5;
a2 = 1.5;
a3 = 1.0;

row1 = cos(q1) * ((a2 * cos(q2)) + (a3 * cos(q2 + q3)));
row2 = sin(q1) * ((a2 * cos(q2)) + (a3 * cos(q2 + q3)));
row3 = d1 + (a2 * sin(q2)) + (a3 * sin(q2 + q3));

eq1 = row1 == 0;
eq2 = row2 == 1.0607;
eq3 = row3 == 2.5607;

eqn = [eq1, eq2, eq3];
qs = [q1, q2, q3];

[sol_q1, sol_q2, sol_q3] = vpasolve(eqn, qs);

q_1 = round(sol_q1 * power(10, 4)) / power(10, 4)
q_2 = round(sol_q2 * power(10, 4)) / power(10, 4)
q_3 = round(sol_q3 * power(10, 4)) / power(10, 4)

pause


eq4 = row1 == 1.5309;
eq5 = row2 == 1.5309;
eq6 = row3 == 0.25;

eqn1 = [eq4, eq5, eq6];
[sol_q11, sol_q21, sol_q31] = solve(eqn, qs);

q_11 = round(sol_q11 * power(10, 4)) / power(10, 4)
q_21 = round(sol_q21 * power(10, 4)) / power(10, 4)
q_31 = round(sol_q31 * power(10, 4)) / power(10, 4)

pause

p = [row1; row2; row3];

Jacobian_matrix = jacobian(p, qs)