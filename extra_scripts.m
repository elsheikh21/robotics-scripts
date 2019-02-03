%% Preparing workspace

close all; clear all; clc;

%% Demo for solving polynomials, substitution of values

syms q1 q2 L

eq1 = (0.5 == 0.5*cos(q1) + 0.5*cos(q1 + q2));
eq2 = (0.866 == 0.5*sin(q1) + 0.5*sin(q1 + q2));

eqs = [eq1, eq2];
qs = [q1, q2];

[x1, x2] = solve(eqs, qs);

p = [[L*cos(q1) + L*cos(q1 + q2);]
    [L*sin(q1) + L*sin(q1 + q2);]];

p = subs(p, [q1, q2, L], [deg2rad(45), deg2rad(-90),0.5])
% rad2deg(pi/2) 

%% Demos for factoring, differentiation, polynomials solving

syms t;

eqn = power(t, 4) - 2*power(t, 3) + power(t, 2);
 
factor(eqn);

eqn_prime = diff(eqn, t);
 
factor(eqn_prime);
  
eqn_prime = eqn_prime * 30 * (-3*pi/4);
 
solve(eqn_prime == 0);

eqn = subs(eqn, t, 0.5);

eq1 = 30*-135*(power(t, 4) - 2*power(t, 3) + 3*power(t, 2)) == 120;
  
solve(eq1, t);