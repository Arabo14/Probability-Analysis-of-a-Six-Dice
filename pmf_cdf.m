function [pmfVals, cdfVals] = pmf_cdf(probArray)
% Computes PMF and CDF

pmfVals = probArray;
cdfVals = cumsum(probArray);
end
