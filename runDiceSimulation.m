% runDiceSimulation.m
% EE300 project - rolling 6 dice many times
% Empirical vs theoretical probability analysis

close all;
clear; clc;

% Reproducible RNG seed
seed = 24681357;
rng(seed);
fprintf("rng seed = %d\n", seed);

N = 1000000;
fprintf("\nrunning 6-dice experiment with N = %d trials...\n", N);

% Main simulation
[counts, empProb, allRolls] = simulateDice(N);

% Theoretical probabilities
theoProb = theoreticalProbabilities();

% PMF and CDF
[pmfVals, cdfVals] = pmf_cdf(empProb);

% Print comparison table
fprintf('\nX = number of sixes in 6 dice\n');
fprintf('X   Count         EmpProb       TheoProb\n');
for k = 0:6
    fprintf('%d   %8d     %.6f     %.6f\n', ...
        k, counts(k+1), empProb(k+1), theoProb(k+1));
end

% ===== Extra events (theoretical) =====
totalOut = 6^6;

p_win = 1 - (5/6)^6;

p_big = 0;
for k = 3:6
    p_big = p_big + nchoosek(6,k) * (1/6)^k * (5/6)^(6-k);
end

p_all_diff = factorial(6) / totalOut;
p_at_least_pair = 1 - p_all_diff;

p_even = 1/2;
p_atleast3even = 0;
for k = 3:6
    p_atleast3even = p_atleast3even + ...
        nchoosek(6,k) * (p_even^k) * ((1-p_even)^(6-k));
end

good_1_and_6 = nchoosek(6,1) * nchoosek(5,1) * 4^4;
p_exactly1_1_and1_6 = good_1_and_6 / totalOut;

% ===== Extra events (empirical) =====
win_emp = 0; big_emp = 0; all_diff_emp = 0;
atleast3even_emp = 0; one1_one6_emp = 0;

for i = 1:N
    roll = allRolls(i,:);

    if sum(roll == 6) >= 1, win_emp = win_emp + 1; end
    if sum(roll == 6) >= 3, big_emp = big_emp + 1; end
    if length(unique(roll)) == 6, all_diff_emp = all_diff_emp + 1; end
    if sum(mod(roll,2)==0) >= 3, atleast3even_emp = atleast3even_emp + 1; end
    if sum(roll==1)==1 && sum(roll==6)==1
        one1_one6_emp = one1_one6_emp + 1;
    end
end

p_win_emp = win_emp / N;
p_big_emp = big_emp / N;
p_all_diff_emp = all_diff_emp / N;
p_at_least_pair_emp = 1 - p_all_diff_emp;
p_atleast3even_emp = atleast3even_emp / N;
p_one1_one6_emp = one1_one6_emp / N;

% ===== Plotting =====
theoExtra = [p_win, p_big, p_all_diff, p_at_least_pair, ...
             p_atleast3even, p_exactly1_1_and1_6];
empExtra  = [p_win_emp, p_big_emp, p_all_diff_emp, ...
             p_at_least_pair_emp, p_atleast3even_emp, p_one1_one6_emp];

figure;
bar(1:6, [theoExtra; empExtra]');
set(gca, 'XTick', 1:6, ...
    'XTickLabel', {'>=1 six','>=3 six','all diff','pair','>=3 even','1&6'});
xtickangle(20);
ylabel('Probability');
title('Extra Events: Theoretical vs Empirical');
legend('Theoretical','Empirical');
grid on;

figure;
bar(0:6, [empProb; theoProb]');
xlabel('X = number of sixes');
ylabel('Probability');
title('Empirical vs Theoretical PMF');
legend('Empirical','Theoretical');
grid on;

figure;
subplot(2,1,1);
bar(0:6, pmfVals);
title('PMF (Empirical)');
xlabel('k'); ylabel('PMF');

subplot(2,1,2);
stairs(0:6, cdfVals, 'LineWidth', 2);
title('CDF (Empirical)');
xlabel('k'); ylabel('CDF');
grid on;

fprintf("\ndone.\n");
