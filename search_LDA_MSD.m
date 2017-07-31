%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All experiments with dataset A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

load dataset_C
trajectories = trajectories_C;
atores = atores_C;

%% For all experiments

% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5];

%% Experiment random samples, mix actors
T_rounds = 50;



Dim = 1-eps*10.^[14 13 12 11 10 9 8 7]';
T_d = max(size(Dim));

%     0.9778    0.9083    0.0206    0.8458    0.9499
%     0.9978    0.9201    0.0220    0.8493    0.9560
%     0.9998    0.9201    0.0220    0.8493    0.9560
%     1.0000    0.9201    0.0220    0.8493    0.9560
%     1.0000    0.9201    0.0220    0.8493    0.9560
%     1.0000    0.9201    0.0220    0.8493    0.9560
%     1.0000    0.9201    0.0220    0.8493    0.9560
%     1.0000    0.9201    0.0220    0.8493    0.9560

Algorithm = 'svd'; % only for pca from MATLAB
rr = 1;
Func = 'u'; 
dist_method_type = 'n';
T_dm = max(size(dist_method_type));

N = max(size(trajectories));
T_bal = max(size(bal));
MC = zeros(N,N,T_d,T_rounds,T_bal);
R = zeros(T_d,T_rounds,T_bal);
num_max = zeros(T_d,2,T_rounds,T_bal);

msd = 1;
zeta = -3;

time = zeros(T_d,T_rounds,T_bal);
for b=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
        for d=1:T_d

            texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
            disp(texto)
            tic
            [R(d,r,b),MC(:,:,d,r,b),num_max(d,:,r,b)] = LDA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim(d),rr,Func,Algorithm,msd,zeta);
            time(d,r,b) = toc;
        end
    end
end


% Rn = reshape(R(1,:,:),3,10);
% Rf = reshape(R(2,:,:),3,10);

save search_LDA_MSD_data.mat
pause(60)
disp('poweroff')
system('poweroff')
 %EOF

