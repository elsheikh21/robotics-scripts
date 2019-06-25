%% prepare Working space
close all; clearvars; clc;

% Symbols used
syms q1 q2 q3 q4 q5 a2 a3 a4 d1 d4

%% Angular component of Geometric Jacobian

z01 = [[cos(q1) 0  sin(q1);]
    [sin(q1) 0 -cos(q1);]
    [0 1 0;]];

z12 = [[cos(q2) 0  -sin(q2);]
    [sin(q2) 0 cos(q2);]
    [0 -1 0;]];


z23 = [[cos(q3) 0  sin(q3);]
    [sin(q3) 0 -cos(q3);]
    [0 1 0;]];


z34 = [[cos(q4) 0 sin(q4);]
    [sin(q4) 0 -cos(q4);]
    [0 1 0;]];

z45 = [[cos(q5) -sin(q5) 0;]
    [sin(q5) cos(q5) 0;]
    [0 0 1;]];

z00 = [[0;]
    [0;]
    [1;]];

zero_vector = [[0;]
    [0;]
    [0;]];

col0 = (z00);
col1 = (z01*z00);
col2 = (z01*z12*z00);
col3 = (z01 * z12 * z23 * z00);
% col4 = (z01 * z12 * z23 * z34 * z00);
JA = horzcat(col0, col1, col2, col3);

disp('JA: ')
pretty(JA);
disp(['Angular Jacobian is', num2str(size(JA, 1)), 'x', num2str(size(JA, 2))]);

rankJA = rank(JA);

q = [q1, q2, q3, q4];
% JA = subs(JA, q, {0, pi/2, q3, 0});
% JA_init_config = pretty(JA);

NullSpaceJA = null(JA);
NullSpaceJA;

% RangeJA = colspace(JA);
% RangeJA;

%% Linear Jacobian component

p = [[q3 * cos(q1);]
    [q3 * sin(q1);]
    [d4 + q2;]];

q = [q1, q2, q3, q4, q5];

JL = jacobian(p, q);
JL = simplify(JL);
% JL = subs(JL, q, {0, pi/2, q3, 0});
disp('JL: ')
pretty(JL);
disp(['Linear Jacobian is', num2str(size(JL, 1)), 'x', num2str(size(JL, 2))]);

% rankJL = rank(JL);

% NullSpaceJL = null(JL);
% NullSpaceJL;

% RangeJL = colspace(JL);
% RangeJL;

%% Jacobian Matrix
J = vertcat(JL, JA);
rows = size(J, 1);
cols = size(J, 2);
disp(['Jacobian Dimensions: ', num2str(rows), 'x', num2str(cols)]);
pretty(J);

%% Jacobian Matrix Operations
rankJ = rank(J)

JT = transpose(J);
colsN = rows - rank(JT);
disp(['NullSpace Dimensions: ', num2str(rows), 'x', num2str(colsN)]);
NullSpaceJT = null(JT);

% pseudo_inverse = pinv(J)

%% Angular Velocity related
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
