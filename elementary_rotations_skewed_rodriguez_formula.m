% Minimal representation of frames (symbolic & numerically), Angular velocity based on R, Rodriguez formula

%% Preparing the workspace

close all; clearvars; clc;

% Declaring the symbols to be used
syms alpha beta gamma theta

%% Elementary Rotation Matrices

% Defining the matrices
RyGamma = [[cos(gamma) 0 -sin(gamma);]; [0 1 0;]; [sin(gamma) 0 cos(gamma);]];

RxBeta = [[1 0 0;]; [0 cos(beta) -sin(beta);]; [0 sin(beta) cos(beta);]];

RzAlpha = [[cos(alpha) -sin(alpha) 0;]; [sin(alpha) cos(alpha) 0;]; [0 0 1;]];

% multiplication of 3 matrices
Rxyz = RzAlpha * RxBeta * RyGamma;
disp("Body orientation around (X,Y',Z'') using (alpha, beta, gamma)");
% pretty(Rxyz);

% disp('Simplified rotation matrix.');
pretty(simplify(Rxyz));

%% Substitute into minimal representation with values

disp("Substituting [pi/6, -pi/6, pi/3] in [R]");
pause

% define rotation angles' values
angles = [alpha, beta, gamma];

alpha_val = pi/6;
beta_val = -pi/6;
gamma_val = pi/3;

angles_val = [alpha_val, beta_val, gamma_val];

Rxyz = subs(Rxyz, angles, angles_val);
pretty(Rxyz);

%% Inverse of minimal representation Rotation matrix

R_ = Rxyz;

sin_comp = sqrt(power(R_(2, 1), 2) + power(R_(2, 3), 2));
cos_comp = R_(2, 2);

Beta1 = atan2(sin_comp, cos_comp);
alpha1 = atan2(R_(3, 2)/sin(Beta1), -R_(1, 2)/sin(Beta1));
gamma1 = atan2(R_(2, 3)/sin(Beta1), R_(2, 1)/sin(Beta1));

disp('1st Beta val is: ');
disp(Beta1);

disp('Corresponding alpha: ')
pretty(simplify(vpa(alpha1)));

disp('Corresponding gamma: ')
pretty(simplify(vpa(gamma1)));

Beta2 = atan2(-sin_comp, cos_comp);
alpha2 = atan2(R_(3, 2)/sin(Beta2), -R_(1, 2)/sin(Beta2));
gamma2 = atan2(R_(2, 3)/sin(Beta2), R_(2, 1)/sin(Beta2));

disp('2nd Beta val is: ');
disp(Beta1);

disp('Corresponding alpha: ')
pretty(simplify(vpa(alpha1)));

disp('Corresponding gamma: ')
pretty(simplify(vpa(gamma1)));

%% Compute Angular Velocity from Rot Mat

% omega = ((z)*(alpha)') + ((x')*(beta)') + ((y'')*(gamma)')
% Rotation around z first, followed by rotation around new x-axis (x')
% followed by a rotation around new y-axis (y'')
x_vector = [[1;] [0;] [0;]];

omega_z_comp = [[0;] [0;] [1;]];

omega_y_comp = RzAlpha * RxBeta;
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
skewed_r = [0 -r(3) r(2); r(3) 0 -r(1); -r(2) r(1) 0];
% disp('Skew symmetric form matrix');
% disp(skewed_r);

x = [-0.2 * sin(theta) 0.2 * cos(theta);
    -sin(theta) cos(theta);
    ];

% disp('Null space of the matrix');
% disp(null(x));

%% Rodriguez Formula R(theta, r) -- rot around vector r with theta

% theta = deg2rad(-30);
% theta = - pi/6;

R_theta_r = [power(r(1), 2) * (1 - cos(theta)) + cos(theta) r(1) * r(2) * (1 - cos(theta)) - r(3) * sin(theta) r(1) * r(3) * (1 - cos(theta)) + r(2) * sin(theta);
        r(1) * r(2) * (1 - cos(theta)) + r(3) * sin(theta) (power(r(2), 2)) * (1 - cos(theta)) + cos(theta) r(2) * r(3) * (1 - cos(theta)) - r(1) * sin(theta);
        r(1) * r(3) * (1 - cos(theta)) - r(2) * sin(theta) r(2) * r(3) * (1 - cos(theta)) + r(1) * sin(theta) power(r(3), 2) * (1 - cos(theta)) + cos(theta)];

% disp('Rotation around vector r with angle theta R(theta, r)');
% disp(R_theta_r);

o_rot_i = transpose(R_theta_r) * Rxyz;
% disp(o_rot_i);
