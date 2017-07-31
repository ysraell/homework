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


% arg_svm{1} = '-q -s 1 -n 0.1 -t 0';
% arg_svm{2} = '-q -s 1 -n 0.1 -t 2';
% arg_svm{3} = '-q -s 1 -n 0.1 -t 3';
% for i=1:4
%     arg_svm{i+3} = ['-q -s 1 -n 0.1 -t 1 -d ' num2str(i)];
% end
% 
% arg_svm{1+7} = '-q -s 1 -n 0.01 -t 0';
% arg_svm{2+7} = '-q -s 1 -n 0.01 -t 2';
% arg_svm{3+7} = '-q -s 1 -n 0.01 -t 3';
% for i=1:4
%     arg_svm{i+3+7} = ['-q -s 1 -n 0.01 -t 1 -d ' num2str(i)];
% end

nn = [0.1431:0.0001:0.1449]';

% nn = 0.1431 is the best! but, around 1.4 e 1.45 we give the same result...

T_nn = max(size(nn));
for i=1:T_nn
    arg_svm{i} = ['-q -s 1 -n ',num2str(nn(i)),' -t 1 -d 2'];
end

T_d = max(size(arg_svm));

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
            [R(d,r,b),MC(:,:,d,r,b)] = SVM_actions(trajectories,test_samples,training_samples,arg_svm{d});
        end
    end
end


 save search_SVM_data.mat
% pause(60)
% disp('poweroff')
% system('poweroff')
 %EOF

