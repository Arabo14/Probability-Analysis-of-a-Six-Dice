function p = theoreticalProbabilities()
% Binomial PMF for number of sixes in 6 dice

n = 6;
p6 = 1/6;
q = 5/6;

p = zeros(1,7);
for k = 0:6
    p(k+1) = nchoosek(n,k) * p6^k * q^(n-k);
end
end
