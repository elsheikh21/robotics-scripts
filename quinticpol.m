%% Resetting workspace

clear all; close all; clc

syms dq T

%% Boundaries

%remove - sign
dq1 = 1.9694;
dq2 = 0.5692;

% Jerk Bounds
J1 = 30;
J2 = 70;

% Acc Bounds
A1 = 3
A2 = 7.5

% Velocities Bounds
V1 = 1
V2 = 2

%% Derivations of q(taw)

% q'''(taw) -- Jerk
tj = 0.5
qj = 60 * dq / power(T, 3) * (6 * power(tj, 2) - 6 * tj + 1)

% q''(taw) -- Acc
ta = 0.7887
qa = 60 * dq / power(T, 2) * (2 * power(ta, 3) - 3 * power(ta, 2) + ta)

% q'(taw) -- Vel
tv = 0.5
qv = 30 * dq / T * (power(tv, 4) - 2 * power(tv, 3) + power(tv, 2))

%% Max time computation for coordinated motion

% Time computed for Jerk, acc, veloctiy as per joint 1
Tj1 = (60 * dq1 / J1)^(1/3)
Ta1 = sqrt(5.7735 * dq1 / A1)
Tv1 = 1.875 * dq1 / V1

% Time computed for Jerk, acc, veloctiy as per joint 2
Tj2 = (60 * dq2 / J2)^(1/3)
Ta2 = sqrt(5.7735 * dq2 / A2)
Tv2 = 1.875 * dq2 / V2

% Max time as per joint 1
Tst1 = max(Tj1, Ta1);
Tstar1 = max(Tst1, Tv1)

% Max time as per joint 2
Tst2 = max(Tj2, Ta2);
Tstar2 = max(Tst2, Tv2)

% Minimum time for coordinated motion of the 2 joints
Tstar = max(Tstar1, Tstar2)

%% Compute of jerk, acc, vel for 2 joints for min motion time

t = Tstar / 2

qjs1 = -30 * dq1 / ((Tstar)^(1/3))
qjs2 = -30 * dq2 / ((Tstar)^(1/3))

qas1plus = 5.7735 * dq1 / power(Tstar, 2)
qas1min = -5.7735 * dq1 / power(Tstar, 2)

qas2plus = 5.7735 * dq2 / power(Tstar, 2)
qas2min = -5.7735 * dq2 / power(Tstar, 2)

qvs1 = 1.875 * dq1 / Tstar
qvs2 = 1.875 * dq2 / Tstar
