function [value] = compute_impedance( omega )
r = 725;
c = 8 * 10^-5;
l = 2;
value = abs(1/(sqrt(1/r^2 + (omega*c - 1/(omega*l)^2) ) ) ) - 75;

end

