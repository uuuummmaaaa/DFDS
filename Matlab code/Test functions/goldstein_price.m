function [output1] = goldstein_price(x)
    x1 = x(1);
    x2 = x(2);
    y11 = (x1+ x2 + 1) ^ 2;
    y12 = 19 - 14 * x1 + 3 * x1 ^ 2 - 14 * x2 + 3 * x2 ^ 2 + 6 * x1 * x2;
    y21 = (2 * x1 - 3 * x2) ^ 2;
    y22 = 18 - 32 * x1 +12 * x1^2 + 48 * x2 - 36 * x1 * x2 + 27 * x2 ^ 2;
    output1 = (1 + y11 * y12) * (30 + y21 * y22);
end