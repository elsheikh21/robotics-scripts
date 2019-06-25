%% Prepare workspace
clearvars; close all; clc;

% Boundary Data
p0=20; p1=60; % [deg]
v0=0; v1=0; % [deg/s]
T=2; % total motion time (s)

%% balanced solution does not wander (symmetric around average position)
pm = (p0 + p1)/2;
pd = p1 - p0;
q0 = -pd/2;
q1 = pd/2;

% solution
a1 = 0.25 * (3* q1 + v0 * 2 * T/pi);
a2 = 0.25 * (v0 *2 * T/pi - q1);
b1 = 0.25 * (3 * q0-v1 * 2 * T/pi);
b2 = 0.25 * (q0 + v1 * 2 * T/pi);
% Sampling time
t = [0 : 0.01 : T];
% Define Tau
tau = (pi/2) * t/T;

p = pm + a1*sin(tau) + a2*sin(3*tau) + b1*cos(tau) + b2*cos(3*tau);
pdot = pi/(2*T)*(a1*cos(tau) + 3*a2*cos(3*tau) - b1*sin(tau) - 3*b2*sin(3*tau));
pddot = -(pi/(2*T))^2 * (a1*sin(tau) + 9*a2*sin(3*tau) + b1*cos(tau) + 9*b2*cos(3*tau));

subplot(3, 2, 1)
plot(t, p, 'r');
grid;title('position');
xlabel('time [s]');
ylabel('[deg]');
% pause;

subplot(3, 2, 3)
plot(t, pdot, 'r');
grid;title('velocity');
xlabel('time [s]');
ylabel('[deg / s]');
% pause;

subplot(3, 2, 5)
plot(t, pddot, 'r');
grid;
title('acceleration');
xlabel('time [s]');
ylabel('[deg / s^2]');

%% unbalanced solution leads to wandering
% uncomment to see this result
q0 = p0;
q1 = p1;
pm = 0;

% solution
a1 = 0.25 * (3* q1 + v0 * 2 * T/pi);
a2 = 0.25 * (v0 *2 * T/pi - q1);
b1 = 0.25 * (3 * q0-v1 * 2 * T/pi);
b2 = 0.25 * (q0 + v1 * 2 * T/pi);
% Sampling time
t = [0 : 0.01 : T];
% Define Tau
tau = (pi/2) * t/T;

p = pm + a1*sin(tau) + a2*sin(3*tau) + b1*cos(tau) + b2*cos(3*tau);
pdot = pi/(2*T)*(a1*cos(tau) + 3*a2*cos(3*tau) - b1*sin(tau) - 3*b2*sin(3*tau));
pddot = -(pi/(2*T))^2 * (a1*sin(tau) + 9*a2*sin(3*tau) + b1*cos(tau) + 9*b2*cos(3*tau));

subplot(3, 2, 2)
plot(t, p);
grid;
title('position (Wandering)');
xlabel('time [s]');
ylabel('[deg]');
% pause;

subplot(3, 2, 4)
plot(t, pdot);
grid;
title('velocity');
xlabel('time [s]');
ylabel('[deg / s]');
% pause;

subplot(3, 2, 6)
plot(t, pddot);
grid;
title('acceleration');
xlabel('time [s]');
ylabel('[deg / s^2]');
