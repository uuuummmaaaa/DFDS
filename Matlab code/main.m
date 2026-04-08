%% ===================== PROBLEM SETUP =====================
% Five independent configurations are provided below
% Select one by uncommenting it and commenting the others
% Modify N in each configuration for different dimensional setup
% =========================================================

%% Configuration: Ackley  Function
N = 2;                  %dimension
f_str = 'ackley';  % function name
L = -10; U = 10;  % feasbile domain
fmin= 0;              %global minimum;
LowEvalBudget = 125 * 2 ^ N;      % function evaluation budget, level = Low
 R_small = (N / 32) ^ 0.5;   R_medium = (N / 8) ^ 0.5;    R_large = (N / 2) ^ 0.5;      % Parameter R_\epsilon  small/medium/large

%  %%  Configuration:  Levy Function
% N = 2;     
% f_str= 'levy';    
% L = -10; U = 10;  
% fmin= 0;            
% LowEvalBudget = 125 * 2 ^ N;    
%  R_small = (N / 32) ^ 0.5;   R_medium = (N / 8) ^ 0.5;    R_large = (N / 2) ^ 0.5;   

%  %% Configuration:  Goldstein price Function
%  N = 2;                  
% f_str= 'goldstein_price'; 
% L = -2; U = 2;
% fmin =3; 
% LowEvalBudget = 125;
%  R_small = 0.1;   R_medium = 0.2;    R_large = 0.4;

%  %%  Configuration:  Six-Hump Function
%  N = 2;                   
% f_str= 'six_hump';  
% L = -5; U = 5;
% fmin = -1.0316; 
% LowEvalBudget = 125;
%  R_small = 0.25;   R_medium = 0.5;    R_large = 1;

%  %%  Configuration: Alpine Function
%  N = 2;
%  f_str = 'alpine';
%  L = 0; U = 10;
%  fmin = -2.8081 ^ N;
%  LowEvalBudget = 625 * 2 ^ N;      % function evaluation budget, level = Low
%  R_small = (N / 32) ^ 0.5;   R_medium = (N / 8) ^ 0.5;    R_large = (N / 2) ^ 0.5;
% %%%

%% ===================== ALGORITHMIC SETUP =====================
% =========================================================
epsilon = 10^(-4); 
f = str2func(f_str);
addLocalSearch = 1;    %To add the local refinement to the solution (addLocalSearch = 1); 


%% ===================== EXPERIMENT SETUP =====================
% =========================================================
T = 20;
for l = 0:2
    MaxEval = LowEvalBudget * 2 ^ l;
    nSuccess_dfds_small = 0;  nSuccess_dfds_medium = 0;  nSuccess_dfds_large = 0;  nSuccess_prs = 0;   nSuccess_ihr = 0;
    for i = 1:T
        seed = N * T + i;      % random seed
        rng(seed);
        x0 = L + rand([N, 1]) * (U - L);  % random initial point
        %%% DFDS R_small
        [~, f_opt] = dfds(x0, f_str, R_small, L, U, MaxEval, epsilon, seed, addLocalSearch);
        nSuccess_dfds_small = nSuccess_dfds_small + (f_opt <= fmin + epsilon);
        %%% DFDS R_medium
        [~, f_opt] = dfds(x0, f_str, R_medium, L, U, MaxEval, epsilon, seed, addLocalSearch);
        nSuccess_dfds_medium= nSuccess_dfds_medium+ (f_opt <= fmin + epsilon);
        %%% DFDS R_large
        [~, f_opt] = dfds(x0, f_str, R_large, L, U, MaxEval, epsilon, seed, addLocalSearch);
        nSuccess_dfds_large = nSuccess_dfds_large + (f_opt <= fmin + epsilon);
        %%% PRS
        [~, f_opt] = prs(x0, f_str, L, U, MaxEval, seed, addLocalSearch);  %PRS
        nSuccess_prs = nSuccess_prs + (f_opt <= fmin + epsilon);
        %%%  IHR
        [~, f_opt] = ihr(x0, f_str,  L, U, MaxEval, epsilon, seed, addLocalSearch); 
        nSuccess_ihr = nSuccess_ihr + (f_opt <= fmin + epsilon);
    end
    if  l == 0
        disp(['Results on ', f_str, ' function,  N = ', num2str(N),',  n_feval = ', num2str(MaxEval),' (Low)']);
    elseif l == 1
        disp(['Results on ', f_str, ' function,  N = ', num2str(N),',  n_feval = ', num2str(MaxEval),' (Medium)']);
    else
        disp(['Results on ', f_str, ' function,  N = ', num2str(N),',  n_feval = ', num2str(MaxEval),' (High)']);
    end
    disp(['Success Rate of DFDS (small R_epsilon): ', num2str(nSuccess_dfds_small / T * 100), '%']);  
    disp(['Success Rate of DFDS (medium R_epsilon): ', num2str(nSuccess_dfds_medium / T * 100), '%']);  
    disp(['Success Rate of DFDS (large R_epsilon): ', num2str(nSuccess_dfds_large / T * 100), '%']);  
    disp(['Success Rate of IHR: ', num2str(nSuccess_ihr / T * 100), '%']);  
    disp(['Success Rate of PRS: ', num2str(nSuccess_prs / T * 100), '%']);  
end
