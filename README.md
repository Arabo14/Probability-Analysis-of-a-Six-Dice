# 6-Dice Probability Simulation (MATLAB)

This project simulates rolling **6 fair dice** a large number of times and compares **empirical probabilities** to **theoretical probability results**. It focuses on the random variable **X = number of sixes in one roll of 6 dice**, computing the empirical PMF/CDF from simulation and comparing it to the theoretical Binomial distribution. The script also evaluates several additional probability events (both theoretically and empirically) and visualizes results using bar charts, pie charts, and PMF/CDF plots.

## What This Program Does
For `N` trials (default: `1,000,000`), the script:
- Rolls 6 dice per trial using `randi([1 6], N, 6)`
- Computes **X = count of sixes** in each 6-dice roll
- Builds a frequency table for `X = 0..6`
- Computes:
  - Empirical probabilities `P̂(X = k)`
  - Theoretical probabilities `P(X = k)` using the **Binomial distribution** with `n = 6`, `p = 1/6`
  - Empirical PMF and CDF

## Extra Events Analyzed
The script also calculates and compares theoretical vs empirical probabilities for:
- `P(at least 1 six)`
- `P(at least 3 sixes)`
- `P(all dice are different)`
- `P(at least one pair)` (complement of “all different”)
- `P(at least 3 even numbers)` (even = {2,4,6})
- `P(exactly one 1 and exactly one 6)`

## Plots Generated
- Bar plot: theoretical vs empirical for extra events
- Pie chart: theoretical “share” of extra events
- Bar plot: empirical vs theoretical PMF of `X`
- PMF and CDF plots (empirical)
- Bar plot: PMF from **3 independent runs** to show variation

## Files
- `runDiceSimulation.m` – Main script (includes local helper functions)

## How to Run
1. Open MATLAB and set the working directory to the folder containing the script.
2. Run:
```matlab
runDiceSimulation
