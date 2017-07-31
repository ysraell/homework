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
T_rounds = 500;

T_d = 1;

N = max(size(trajectories));
T_bal = max(size(bal));
MC = zeros(N,N,T_d,T_rounds,T_bal);
R = zeros(T_d,T_rounds,T_bal);

for b=1:T_bal
    for r=1:T_rounds
        [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
        for d=1:T_d
            texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
            disp(texto)
            Distance = 'cosine';
            NSMethod = 'exhaustive';
            BreakTies = 'smallest';
            DistanceWeight ='equal';
            NumNeighbors = 1;
            [R(d,r,b),MC(:,:,d,r,b)] = KNN_actions(trajectories,test_samples,training_samples,BreakTies,NSMethod{d},Distance{d},DistanceWeight,NumNeighbors);
        end
    end
end

 save search_KNN_data.mat

