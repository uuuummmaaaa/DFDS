function [res] = ackley(x1)
    a = 20;
    b = 0.2;
    c = 2 * pi;
    N = length(x1);
    res = - a * exp(- b * (sum(x1.^2) / N) ^ 0.5)  - exp(sum(cos(c * x1)) / N) + exp(1) + a ;
end