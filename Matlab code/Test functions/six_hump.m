function [output1] = six_hump(x)
    x1 = x(1);
    x2 = x(2);
    output1 = 4 * x1 ^ 2 - 2.1 * x1 ^ 4 + x1 ^ 6 / 3 + x1 * x2 - 4 * x2 ^ 2 + 4 * x2 ^ 4;
end