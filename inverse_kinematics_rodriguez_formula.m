% Computes the neutral axis 'r' and theta of the R(r, theta)

%% Clean the workspace
clear all; close all; clc;

%% Compute inverse kinematics for R(r, theta)

row1 = [0 -sqrt(2)/2 -sqrt(2)/2];
row2 = [0 sqrt(2)/2 -sqrt(2)/2];
row3 = [1 0 0];

R = [row1; row2; row3;];

RT = R.';

R_ = R - RT;

sin_comp = sqrt(power((R_(1, 2) - R_(2, 1)) , 2) + power((R_(1, 3) - R_(3, 1)) , 2) + power((R_(2, 3) - R_(3, 2)) , 2));
cos_comp = R_(1, 1) + R_(2, 2) + R_(3, 3) - 1;
r_comp = [[R_(3, 2) - R_(2, 3)]; [R_(1, 3) - R_(3, 1)]; [R_(2, 1) - R_(1, 2)];];

theta1 = atan2(sin_comp, cos_comp);
r1 = 1/2*sin(theta1) * r_comp;

disp(['1st theta val is: ', num2str(theta1)])
if sin(theta1) ~= 0
    disp('Corresponding neutral axis is: ')
    pretty(simplify(vpa(r1)));
end

pause;

theta2 = atan2(-sin_comp, cos_comp);
r2 = 1/2*sin(theta2) * r_comp;

disp(['2nd theta val is: ', num2str(theta2)])
if sin(theta2) ~= 0
    disp('Corresponding neutral axis is: ')
    pretty(simplify(vpa(r1)));
end
