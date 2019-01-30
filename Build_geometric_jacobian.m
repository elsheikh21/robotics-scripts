clearvars; close all; clc;

syms q1 q2 q3 q4 a2 a3 a4 d1

z1 = [[cos(q1) 0 sin(q1);]
    [sin(q1) 0 -cos(q1);]
    [0 1 0;]];

z2 = [[cos(q2) 0 sin(q2);]
    [sin(q2) 0 -cos(q2);]
    [0 1 0;]];

z3 = [[-1 0 0;]
    [0 0 1;]
    [0 1 0;]];

z4 = [[cos(q4) -sin(q4) 0;]
    [sin(q4) cos(q4) 0;]
    [0 0 1;]];

z0 = [[0;]
    [0;]
    [1;]];

zero_vector = [[0;]
    [0;]
    [0;]];

col0 = (z0);
col1 = (z1*z0);
% col2 = (z1*z2*z0);
col3 = (z1*z2*z3*z0);
JA = horzcat(col0, col1, zero_vector, col3);

% disp('JA: ')
% pretty(JA);
rankJA = rank(JA);

q = [q1, q2, q3, q4];
JA = subs(JA, q, {0, pi/2, q3, 0});
% JA_init_config = pretty(JA);

NullSpaceJA = null(JA);
NullSpaceJA;

% RangeJA = colspace(JA);
% RangeJA;

p = [{-cos(q1)*(a4*cos(q2 + q4) - q3*sin(q2));}
     {-sin(q1)*(a4*cos(q2 + q4) - q3*sin(q2));}
     {d1 - a4*sin(q2 + q4) - q3*cos(q2);}];

% q = [q1, q2, q3, q4];

JL = jacobian(p, q);
JL = simplify(JL);
JL = subs(JL, q, {0, pi/2, q3, 0});
% disp('JL: ')
% pretty(JL);

% rankJL = rank(JL);

% NullSpaceJL = null(JL);
% NullSpaceJL;

% RangeJL = colspace(JL);
% RangeJL;


% disp('Geometric Jacobian is: ');
J = vertcat(JL, JA);
rows = size(J, 1);
cols = size(J, 2);
disp(['Jacobian Dimensions: ', num2str(rows), 'x', num2str(cols)]);

JT = transpose(J);
colsN = rows - rank(JT);
disp(['NullSpace Dimensions: ', num2str(rows), 'x', num2str(colsN)]);
NullSpaceJT = null(JT)

% pretty(J);
% rankJ= rank(J)

% pseudo_inverse = pinv(J)

v = [[1;]
    [0;]
    [1;]
    [0;]
    [0;]
    [-2;]];

% JV = horzcat(J, v);

% rankJV = rank(JV);
% rankJ = rank(J);

% if(rankJ >= rankJV)
%     disp('So V can be realized by joint velocities');
% else
%     disp('So V can NOT be realized by joint velocities');
% end

% eq = det(JL*transpose(JL)) == 0;
% X = solve(eq, q);
