function [cnt, emp, rolls] = simulateDice(N)
% Simulates rolling 6 dice N times

rolls = randi([1 6], N, 6);
numSixes = sum(rolls == 6, 2);

cnt = zeros(1,7);
for k = 0:6
    cnt(k+1) = sum(numSixes == k);
end

emp = cnt / N;
end
