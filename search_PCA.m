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
T_rounds = 1;


% The user method is better! with 500 rounds
% u : 0.9300; m : 0.9281
Func = 'mu'; 

T_d = max(size(Func));

Algorithm = 'svd'; % only for pca from MATLAB
rr = 1;
Dim = [0.9 0.95 0.99]';
T_dm = max(size(Dim));
dist_method_type = 'n';


N = max(size(trajectories));
T_bal = max(size(bal));
MC = zeros(N,N,T_dm,T_d,T_rounds,T_bal);
R = zeros(T_dm,T_d,T_rounds,T_bal);

time = zeros(T_dm,T_d,T_rounds,T_bal);
for b=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
        for d=1:T_d
            for dm=1:T_dm
                texto = ['dm = ',num2str(dm),'/',num2str(T_dm),', d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
                disp(texto)
                tic
                [R(dm,d,r,b),MC(:,:,dm,d,r,b)] = PCA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim(dm),rr,Func(d),Algorithm);
                time(dm,d,r,b) = toc;
            end
        end
    end
end


% Rn = reshape(R(1,:,:),3,10);
% Rf = reshape(R(2,:,:),3,10);

 save search_PCA_data.mat
% pause(60)
% disp('poweroff')
% system('poweroff')
 %EOF

