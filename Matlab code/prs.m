function [xopt, fopt] = prs(x0, f_str,  L, U, MaxEval, seed0, addLocalSearch)
    rng(seed0);
    n = length(x0);     f = str2func(f_str);
    xopt = x0;    fopt = f(x0);   nfeval = 1; 
    options = optimoptions('fminunc', 'Display', 'off', 'Algorithm', 'quasi-newton');
    for m = 1:(MaxEval-1)
        x = L + rand([n,1]) * (U - L);
        fx = f(x);   
        nfeval = nfeval + 1;
        if fx < fopt
            xopt = x;
            fopt = fx;
        end
    end
    if addLocalSearch
        [xopt, fopt] = fminunc(f, xopt, options);
    end
end 