% Clearing the command window, variables, and closing all windows
clc; clear; close all;

% Declaring the symbols to be used
syms alpha beta gamma theta
 
% define rotation angles 
% alpha = pi/2;
% beta = -pi/4;
% gamma = pi/4;

% Defining the matrices
RyAlpha = [cos(alpha) 0 sin(alpha); 
    0 1 0;
    -sin(alpha) 0 cos(alpha)];

RxBeta = [1 0 0;
    0 cos(beta) -sin(beta);
    0 sin(beta) cos(beta)];

RyGamma = [cos(gamma) 0 sin(gamma);
        0 1 0;    
        -sin(gamma) 0 cos(gamma)];
    
% multiplication of 3 matrices 
Ryxy = RyAlpha*RxBeta*RyGamma;
% disp('Orientation of body around (Y,X,Y) using (alpha, beta, gamma), respectively.');
% disp(Ryxy);

% disp('Simplified rotation matrix.');
% disp(sym(Ryxy));

% disp('determinant rotation matrix.');
% disp(det(Ryxy));

% disp('Inverse of the matrix');
% disp(inv(Ryxy));

% disp('Transpose of the matrix');
% disp(transpose(Ryxy));

% Skew of matrix [r]
r = [1/sqrt(3) -1/sqrt(3) 1/sqrt(3)];
skewed_r = [0 -r(3) r(2) ; r(3) 0 -r(1) ; -r(2) r(1) 0 ];
% disp('Skew symmetric form matrix');
% disp(skewed_r);

% Identity matrix
I = eye(3);

% Rotation around vector r with angle theta R(theta, r)
% theta = deg2rad(-30);
% theta = - pi/6;

R_theta_r = [power(r(1), 2)*(1-cos(theta))+cos(theta) r(1)*r(2)*(1-cos(theta))-r(3)*sin(theta) r(1)*r(3)*(1-cos(theta))+r(2)*sin(theta);
r(1)*r(2)*(1-cos(theta))+r(3)*sin(theta) (power(r(2), 2))*(1 - cos(theta))+cos(theta) r(2)*r(3)*(1-cos(theta))-r(1)*sin(theta);
r(1)*r(3)*(1-cos(theta)) - r(2)*sin(theta) r(2)*r(3)*(1-cos(theta))+r(1)*sin(theta) power(r(3), 2)*(1-cos(theta))+cos(theta)];

% disp('Rotation around vector r with angle theta R(theta, r)');
% disp(R_theta_r);

o_rot_i = transpose(R_theta_r)*Ryxy;
% disp(o_rot_i);


x = [-0.2*sin(theta) 0.2*cos(theta);
    -sin(theta) cos(theta);
    ]

disp('Null space of the matrix');
disp(null(x));