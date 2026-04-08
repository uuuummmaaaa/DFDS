function [xopt, fopt] = ihr(x0, f_str, L, U, MaxEval, epsilon, seed0, addLocalSearch)
    N = length(x0);   f = str2func(f_str);
    xopt = x0; fopt = f(xopt);  nfeval = 1;
    L = L * ones(N, 1);     U = U * ones(N,1);
    rng(seed0);
    options = optimoptions('fminunc', 'Display', 'off', 'Algorithm', 'quasi-newton');
    while nfeval < MaxEval
        d = randn([N, 1]);  d = d / sum(d.^2) ^ 0.5;    max_step = inf;     min_step = -inf;
        if any(d > 0)
            max_step = min(min((U(d > 0) - xopt(d > 0)) ./ d(d > 0)), max_step);
            min_step = max(max((L(d > 0) - xopt(d > 0)) ./ d(d > 0)), min_step);
        end
        if any(d < 0)
            min_step = max(max((U(d < 0) - xopt(d < 0)) ./ d(d < 0)), min_step);
            max_step = min(min((L(d < 0) - xopt(d < 0)) ./ d(d < 0)), max_step); 
        end
        r = min_step + (max_step - min_step) * rand;  
        Ftest = f(xopt + r * d);  nfeval = nfeval + 1;
        if  Ftest < fopt - epsilon
            xopt = xopt + r * d ;
            fopt = Ftest; 
        end
    end
    if addLocalSearch
        [xopt, fopt] = fminunc(f, xopt, options);
    end
end 