clearvars; close all; clc;

% Incremental encoder placed on motor
change = power(10, -5);
link_length = 0.55;

outer_gear = 1;
inner_gear = 1;
outer_gear1 = 0.35;
inner_gear1 = 0.08;

reduction_ratio1 = outer_gear / inner_gear;
reduction_ratio2 = outer_gear1 / inner_gear1;

resolution_from_linear = change / link_length

reduction_ratios = reduction_ratio1 * reduction_ratio2;

resolution_motor = reduction_ratios * resolution_from_linear;

number_pulses_per_turn = (2 * pi) / (4 * resolution_motor);
number_pulses_per_turn = round(number_pulses_per_turn, 4)

bits_number = ceil(log2(number_pulses_per_turn))

% Calculate torque on motor side
J_l = 0.3025;
J_m = J_l / power(reduction_ratios, 2)
