function [xopt, fopt] = dfds(x0, f_str, R,  L,  U, MaxEval, epsilon, seed0, addLocalSearch)
    n = length(x0);   f = str2func(f_str);
    xopt = x0;  fopt = f(xopt);   nfeval = 1;
    rng(seed0);
    options = optimoptions('fminunc', 'Display', 'off', 'Algorithm', 'quasi-newton');
    while nfeval < MaxEval
        d = randn([n,1]);  d = d / sum(d.^2) ^ 0.5;
        r = R;
        while all(xopt + r * d >= L) && all(xopt + r * d <= U) && nfeval < MaxEval
            x1 = xopt + r * d;  f1 = f(x1);   nfeval = nfeval + 1;
            if f1 < fopt - epsilon
                xopt = x1;    fopt = f1; 
                break
            end
            r = r + R;
        end
    end
    if addLocalSearch
        [xopt, fopt] = fminunc(f, xopt, options);
    end
end 