function [output1] =levy(x)
    n = length(x);
    y = 1 + (x - 1) / 4;
    
    i = 1:(n-1);
    middle_terms = sum((y(i) - 1) .^2  .* (1 + 10 * sin(pi * y(i) + 1) .^ 2));
    output1 = sin(pi * y(1))^2 +  (y(n) - 1) ^ 2 * (1 + sin(2 * pi * y(n))^2) + middle_terms;
    output1 = output1 * pi / n;
end