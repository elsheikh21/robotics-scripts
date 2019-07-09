%%% SPLINE %%%
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CUBICA 1                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


syms a b c d e f t T q2 q1 v2 v3 t1 t2 

q = a*((t-t1)/(t2-t1))^3+b*((t-t1)/(t2-t1))^2+c*((t-t1)/(t2-t1))+d
dq = diff(q,t)
ddq = diff(dq,t)

eq = [subs(q, t, t1) == q1,
      subs(q, t, t2) == q2,
      subs(dq, t, t1) == 0,
      subs(dq, t, t2) == v2]
 
X = solve(eq, [a b c d])

% q0 = 45
% q0 = pi/4
% qf = 90
% qf = -pi/2
% T = 1

simplify(X.a)
simplify(X.b)
simplify(X.c)
simplify(X.d)


% eval(X.a)
% eval(X.b)
% eval(X.c)
% eval(X.d)
% eval(X.e)
% eval(X.f)

cubic = X.a*((t-t1)/(t2-t1))^3+X.b*((t-t1)/(t2-t1))^2+X.c*((t-t1)/(t2-t1))+X.d
dcubic = 3*X.a*t^2 + 2*X.b*t + X.c

cubic1 = eval(cubic)
% Y2 = solve(dddquintic == 0, t)
% 
% t = T/2
% eval(dquintic)
% t = (T*(3^(1/2) + 3))/6


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CUBICA 2                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms a b c d e f t T q2 q1 q3 q4 v2 v3 t1 t2 t3 t4

q = a*((t-t2)/(t3-t2))^3+b*((t-t2)/(t3-t2))^2+c*((t-t2)/(t3-t2))+d
dq = diff(q,t)
ddq = diff(dq,t)

eq = [subs(q, t, t2) == q2,
      subs(q, t, t3) == q3,
      subs(dq, t, t2) == v2,
      subs(dq, t, t3) == v3]
 
X = solve(eq, [a b c d])

% q0 = 45
% q0 = pi/4
% qf = 90
% qf = -pi/2
% T = 1

simplify(X.a)
simplify(X.b)
simplify(X.c)
simplify(X.d)


% eval(X.a)
% eval(X.b)
% eval(X.c)
% eval(X.d)
% eval(X.e)
% eval(X.f)

cubic = X.a*((t-t2)/(t3-t2))^3+X.b*((t-t2)/(t3-t2))^2+X.c*((t-t2)/(t3-t2))+X.d
% dcubic = 3*X.a*t^2 + 2*X.b*t + X.c

cubic2 = eval(cubic)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               CUBICA 3                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms a b c d e f t T q2 q1 q3 q4 v2 v3 t1 t2 t3 t4

q = a*((t-t3)/(t4-t3))^3+b*((t-t3)/(t4-t3))^2+c*((t-t3)/(t4-t3))+d
dq = diff(q,t)
ddq = diff(dq,t)

eq = [subs(q, t, t3) == q3,
      subs(q, t, t4) == q4,
      subs(dq, t, t3) == v3,
      subs(dq, t, t4) == 0]
 
X = solve(eq, [a b c d])

% q0 = 45
% q0 = pi/4
% qf = 90
% qf = -pi/2
% T = 1

simplify(X.a)
simplify(X.b)
simplify(X.c)
simplify(X.d)


% eval(X.a)
% eval(X.b)
% eval(X.c)
% eval(X.d)
% eval(X.e)
% eval(X.f)

cubic = X.a*((t-t3)/(t4-t3))^3+X.b*((t-t3)/(t4-t3))^2+X.c*((t-t3)/(t4-t3))+X.d;
% dcubic = 3*X.a*^2 + 2*X.b*t + X.c;

cubic3 = eval(cubic)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcolo velocita v2 v3 pre-impostate %

dcubic1 = diff(cubic1,t);
ddcubic1 = diff(dcubic1,t)
dcubic2 = diff(cubic2,t);
ddcubic2 = diff(dcubic2,t);
dcubic3 = diff(cubic3,t);
ddcubic3 = diff(dcubic3,t);

ddcubic3


eq= [subs(ddcubic1, t, t2) == subs(ddcubic2, t, t2),
        subs(ddcubic2, t, t3) == subs(ddcubic3, t, t3)];


X = solve(eq, [v2,v3])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% SOSTITUZIONE DEI VALORI %%%%%%%%%%%%%%%%%%%%%%%%%%%

t1 = 1;
t2= 2;
t3 =2.5;
t4=4;
q1=45;
q2=90;
q3=-45;
q4=45;

%%%  VELOCITA' %%%

v2 = eval(X.v2)
v3 = eval(X.v3)

cubic1 = eval(cubic1)
cubic2 = eval(cubic2)
cubic3 = eval(cubic3)






