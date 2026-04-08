function [res] = alpine(x)
    n = length(x);
    res = - 1;
    for i = 1:n
        res = res * x(i) ^ 0.5 * sin(x(i));
    end
end