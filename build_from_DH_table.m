%% prepare Working space
close all; clearvars; clc;

% Symbols used
syms L L1 L2 L3 q1 q2 q3 q4 q5 q6 D theta alpha a d a3 d1 d3 d4 d5

%% DH Table

% row = [LINK TWIST (ALPHA) || A || LINK OFFSET (D) || JOINT ANGLE (THETA)]
row1_dh_tbl = [pi/2 0 q1 pi/2;];
row2_dh_tbl = [pi/2 0 q2 pi/2;];
row3_dh_tbl = [0 L 0 q3;];
% row4_dh_tbl = [pi/2 -a3 0 q4;];

% Number of Joints
N = 3;
DHTABLE = [row1_dh_tbl; row2_dh_tbl; row3_dh_tbl;];
% N = 4;
% DHTABLE = [row1_dh_tbl; row2_dh_tbl; row3_dh_tbl; row4_dh_tbl;];

disp('DH Table:');
disp('Alpha, a, D, Q');
pretty(DHTABLE);

%% General DH Transformation matrix

row1 = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta); ];
row2 = [sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta); ];
row3 = [0 sin(alpha) cos(alpha) d;];
row4 = [0 0 0 1;];

TDH = [row1; row2; row3; row4;];
% disp('DH Transformation Matrix:');
% pretty(TDH);

%% Build Transformation matrix for each link

% First, we create an empty cell array

A = cell(1, N);

% For every row in 'DHTABLE' we substitute the right value inside
% the general DH matrix
for i = 1:N
    alpha = DHTABLE(i, 1);
    a = DHTABLE(i, 2);
    d = DHTABLE(i, 3);
    theta = DHTABLE(i, 4);
    A{i} = subs(TDH);
end

for i = 1:N
    % print each matrix of the transformation matrices
    disp(['Transformation Matrix no. ', num2str(i)]);
    A{i}
    pause
end

T = eye(4);

for i = 1:N
    T = T * A{i};
    T = simplify(T);
end

transformation_matrix = T
pause

% output position
pos = simplify(T(1:3, 4))
pause

% output normal component
rotation_matrix = simplify(T(1:3, 1:3))
pause

%% Compute Analytical Jacobian
q = [q1, q2, q3];
r = [[pos];];

J = jacobian(r, q)
pause

rankJ = rank(J)
pause
rangeJ = colspace(J)
pause

nullJ = null(J)
pause

JTranspose = J.'
rankJT = rank(JTranspose)
pause

rangeJT = colspace(JTranspose)
pause

nullJT = null(JTranspose)
pause
%% Compute Linear Jacobian Component
q = [q1, q2, q3, q4];

% Output position based on a given configuration
% pos_Q0 = subs(pos, q, {0, pi/2, q3, 0});
% pretty(pos_Q0);

% Compute Linear component of Geometrical Jacobian
JL = jacobian(pos, q);
JL = simplify(JL);
disp('JL: ')
% JL = subs(JL, q, {0, pi/2, q3, 0});
pretty(JL);
disp(['Linear Jacobian is', num2str(size(JL, 1)), 'x', num2str(size(JL, 2))]);
pause

% NullSpaceJL = null(JL);
% dimNullSpaceJL = size(NullSpaceJL, 2);
% 
% if dimNullSpaceJL > 0
%     NullSpaceJL = NullSpaceJL / norm(NullSpaceJL);
% else
%     NullSpaceJL;
% end
% 
% % Compute Angular component of Geometrical Jacobian
% for i = 1:N
%     trans_mat = A{i};
%     z_comp_rot_mat = trans_mat(1:3, 3);
% end
