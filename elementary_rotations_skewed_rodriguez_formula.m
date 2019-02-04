%% Preparing the workspace

clc; clear; close all;

% Declaring the symbols to be used
syms alpha beta gamma theta
 
%% Elementary Rotation Matrices
% Defining the matrices
RzAlpha = [{cos(alpha) -sin(alpha) 0;} 
    {sin(alpha) cos(alpha) 0;}
    {0 0 1;}];

RxBeta = [1 0 0;
    0 cos(beta) -sin(beta);
    0 sin(beta) cos(beta)];

RyGamma = [cos(gamma) 0 sin(gamma);
        0 1 0;    
        -sin(gamma) 0 cos(gamma)];
    
% multiplication of 3 matrices 
Rzxy = RzAlpha*RxBeta*RyGamma;
disp("Body orientation around (Z,X',Y'') using (alpha, beta, gamma)");
pretty(Rzxy);

disp('Simplified rotation matrix.');
pretty(simplify(Rzxy));

% define rotation angles' values
angles = [alpha, beta, gamma];

alpha_val = deg2rad(30);
beta_val = deg2rad(-30);
gamma_val = deg2rad(60);

angles_val = [alpha_val, beta_val, gamma_val];

Rzxy = subs(Rzxy, angles, angles_val);
pretty(Rzxy);

%% Compute Angular Velocity from Rot Mat
% omega = ((z)*(alpha)') + ((x')*(beta)') + ((y'')*(gamma)')
% Rotation around z first, followed by rotation around new x-axis (x')
% followed by a rotation around new y-axis (y'')
x_vector = [[1;]
            [0;]
            [0;]];

omega_z_comp = [{0;}
                {0;}
                {1;}];

omega_y_comp = RzAlpha*RxBeta;
omega_y_comp = omega_y_comp(1:3, 2);

omega_x_comp = RzAlpha(1:3, 1);

omega = horzcat(omega_z_comp, omega_x_comp, omega_y_comp)

%% Rotation Matrix Operations

% disp('determinant rotation matrix.');
% disp(det(Rzxy));

% disp('Inverse of the matrix');
% disp(inv(Rzxy));

% disp('Transpose of the matrix');
% disp(transpose(Ryxy));

% Skew of matrix [r]
r = [1/sqrt(3) -1/sqrt(3) 1/sqrt(3)];
skewed_r = [0 -r(3) r(2) ; r(3) 0 -r(1) ; -r(2) r(1) 0 ];
% disp('Skew symmetric form matrix');
% disp(skewed_r);

x = [-0.2*sin(theta) 0.2*cos(theta);
    -sin(theta) cos(theta);
    ];

% disp('Null space of the matrix');
% disp(null(x));

%% Rotation around vector r with angle theta R(theta, r)

% theta = deg2rad(-30);
% theta = - pi/6;

R_theta_r = [power(r(1), 2)*(1-cos(theta))+cos(theta) r(1)*r(2)*(1-cos(theta))-r(3)*sin(theta) r(1)*r(3)*(1-cos(theta))+r(2)*sin(theta);
r(1)*r(2)*(1-cos(theta))+r(3)*sin(theta) (power(r(2), 2))*(1 - cos(theta))+cos(theta) r(2)*r(3)*(1-cos(theta))-r(1)*sin(theta);
r(1)*r(3)*(1-cos(theta)) - r(2)*sin(theta) r(2)*r(3)*(1-cos(theta))+r(1)*sin(theta) power(r(3), 2)*(1-cos(theta))+cos(theta)];

% disp('Rotation around vector r with angle theta R(theta, r)');
% disp(R_theta_r);

o_rot_i = transpose(R_theta_r)*Rzxy;
% disp(o_rot_i);