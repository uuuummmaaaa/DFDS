%% ===================== PROBLEM SETUP =====================
% Modify [N, MaxEval, R]  for different experimental setup
% =========================================================
N = 12;                   %problem dimension
MaxEval = 500 * 2 ^ N;      % function evaluation budget
R = (N / 32) ^ 0.5;     % Parameter R_\epsilon  small/medium/large

f_str= 'ackley';   % function name
L = -10;  U = 10;  % feasbile domain
xmin = zeros(N, 1);    fmin= 0;              %global minimum;
epsilon = 10 ^ (-4); 
f = str2func(f_str);
addLocalSearch = 0;    %To use the stand-alone algorithm (addLocalSearch = 0);

%% ===================== EXPERIMENT SETUP =====================
% =========================================================
T = 20;
fgap_dfds = zeros(T,1); fgap_prs = zeros(T,1);   fgap_ihr = zeros(T,1);
xdist_dfds = zeros(T,1); xdist_prs = zeros(T,1);   xdist_ihr = zeros(T,1);
for i = 1:T
    seed = N * T + i;      % random seed
    rng(seed);
    x0 = L + rand([N, 1]) * (U - L);  % random initial point
    %%% DFDS
    [x_opt, f_opt] = dfds(x0, f_str, R, L, U, MaxEval, epsilon, seed, addLocalSearch);
    fgap_dfds(i) = f_opt - fmin;  xdist_dfds(i) = norm(x_opt - xmin);
    %%% PRS
    [x_opt, f_opt] = prs(x0, f_str, L, U, MaxEval, seed, addLocalSearch);  %PRS
    fgap_prs(i) = f_opt - fmin;  xdist_prs(i) = norm(x_opt - xmin);
    %%%  IHR
    [x_opt, f_opt] = ihr(x0, f_str,  L, U, MaxEval, epsilon, seed, addLocalSearch); 
    fgap_ihr(i) = f_opt - fmin;  xdist_ihr(i) = norm(x_opt - xmin);
end
disp(['Results on ', f_str, ' function,  N = ', num2str(N)]);
disp(['Min, Avg, Std of ||xbest-x*||,  DFDS: ', num2str(min(xdist_dfds)), '  ', num2str(mean(xdist_dfds)), '  ', num2str(std(xdist_dfds))]);  
disp(['Min, Avg, Std of ||xbest-x*||,  IHR: ', num2str(min(xdist_ihr)), '  ', num2str(mean(xdist_ihr)), '  ', num2str(std(xdist_ihr))]); 
disp(['Min, Avg, Std of ||xbest-x*||,  PRS: ', num2str(min(xdist_prs)), '  ', num2str(mean(xdist_prs)), '  ', num2str(std(xdist_prs))]); 
disp(['Min, Avg, Std of (fbest-f*),  DFDS: ', num2str(min(fgap_dfds)), '  ', num2str(mean(fgap_dfds)), '  ', num2str(std(fgap_dfds))]);  
disp(['Min, Avg, Std of (fbest-f*),  IHR: ', num2str(min(fgap_ihr)), '  ', num2str(mean(fgap_ihr)), '  ', num2str(std(fgap_ihr))]); 
disp(['Min, Avg, Std of (fbest-f*),  PRS: ', num2str(min(fgap_prs)), '  ', num2str(mean(fgap_prs)), '  ', num2str(std(fgap_prs))]); 
