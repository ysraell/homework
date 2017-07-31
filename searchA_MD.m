%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All experiments with dataset A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

load dataset_A
trajectories = trajectories_A;
atores = atores_A;

%% For all experiments

% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5];

%% Experiment random samples, mix actors
T_rounds = 1;

N = max(size(trajectories));
T_bal = max(size(bal));
% MC = zeros(N,N,T_tm,T_d,T_rounds,T_bal);
% R = zeros(T_tm,T_d,T_rounds,T_bal);
% E = zeros(max(T_max),T_tm,T_d,T_rounds,T_bal);
% num_max = -ones(max(dim_opt_proj),2,T_tm,T_d,T_rounds,T_bal);
% time = zeros(T_tm,T_d,T_rounds,T_bal);
dist_method_type = 'nfs';
T_d = max(size(dist_method_type));

MC = zeros(N,N,T_d,T_rounds,T_bal);
R = zeros(T_d,T_rounds,T_bal);
time = zeros(T_rounds,T_bal);


for b=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
        texto = ['Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
        disp(texto)
        tic
        [R(:,r,b),MC(:,:,:,r,b)] = MD_actions(trajectories,test_samples,training_samples,dist_method_type);
        time(r,b) = toc;       
    end
end


% Rn = reshape(R(1,:,:),3,10);
% Rf = reshape(R(2,:,:),3,10);

save searchA_MD_data.mat
% pause(60)
% disp('poweroff')
% system('poweroff')
 



%% LDA
%     [Dim mean(R,2) std(R')' min(R')' max(R')']
% 
%     0.9778    0.9012    0.0325    0.8408    0.9712
%     0.9978    0.9132    0.0265    0.8555    0.9740
%     0.9998    0.9132    0.0265    0.8555    0.9740
%     1.0000    0.9132    0.0265    0.8555    0.9740
%     1.0000    0.9132    0.0265    0.8555    0.9740
%     1.0000    0.9132    0.0265    0.8555    0.9740
%     1.0000    0.9132    0.0265    0.8555    0.9740
%     1.0000    0.9132    0.0265    0.8555    0.9740

%% MDA
%     [Dim mean(R,2) std(R')' min(R')' max(R')']
% 
%     0.9999    0.7309    0.0440    0.6082    0.7971
%     1.0000    0.7888    0.0377    0.6749    0.8544
%     1.0000    0.8693    0.0347    0.7755    0.9243
%     1.0000    0.8733    0.0350    0.7797    0.9377
%     1.0000    0.8819    0.0333    0.7841    0.9326
%     1.0000    0.8791    0.0318    0.7841    0.9387
%     1.0000    0.8791    0.0318    0.7841    0.9387
%     1.0000    0.8791    0.0318    0.7841    0.9387
%     1.0000    0.8791    0.0318    0.7841    0.9387





%EOF

