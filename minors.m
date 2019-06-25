%% Cleaning workspace
clear all; close all; clc;

%% Preparing workspace
syms q11 q12 q13 q21 q22 q23 q31 q32 q33 L

%% Computing J from pos & its linear algebra

pos = [[q2*cos(q1)+L*cos(q1+q3)]; [q2*sin(q1)+L*sin(q1+q3)];];
 
J = jacobian(pos, [q1, q2, q3]);
 
Dim_J = size(J);

Rank_J = rank(J);

JT = J.';

Dim_JT = size(JT);

Rank_JT = rank(JT);

Range_J = colspace(J);

Null_JT = null(JT);

Range_JT = colspace(JT);

Null_J = null(J);

%% Minors of matrix

M = [[q11 q12 q13]; [q21 q22 q23]; [q31 q32 q33];]

[rows, cols] = size(M);

for i = 1:rows
    for j = 1:cols
        disp(['Minor ', num2str(i), num2str(j), '= '])
        pretty(det(M([1:i-1 i+1:cols],[1:j-1 j+1:cols])))
    end
end