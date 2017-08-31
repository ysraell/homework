%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with DMDA with MSD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc

addpath(pwd)
addpath('matlab_libsvm322')

w = warning ('off','all');

%% Balance
% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [1];

%% Experiment random samples, mix actors
T_rounds = 100;
% T_rounds = 2;

%% SVM parameeters

nn = [0.1:0.01:0.2]';
% nn = [0.1 0.2]';

T_nn = max(size(nn));
for i=1:T_nn
    arg_svm{i} = ['-q -s 1 -n ',num2str(nn(i)),' -t 1 -d 2'];
end
T_d = max(size(arg_svm));
T_bal = max(size(bal));

%% Experiments

D_sets = dir('dataset_*.mat');
T_sets = max(size(D_sets));
Exps = [2 3];
T_Exps = max(size(Exps));
delete(gcp)
parpool('local',4);

for n=1:T_Exps
    load(D_sets(Exps(n)).name)
    load(['rounds_' set_str '.mat'])
    
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=bal

        R = zeros(T_d,T_rounds);
        time = zeros(T_d,T_rounds);
        parfor r=1:T_rounds
            for d=1:T_d
                texto = ['(' set_str ')'...
                         ' d = ',num2str(d),'/',num2str(T_d),'.'...
                         ' Round:' num2str(r),'/',num2str(T_rounds),'.'...
                         ' bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
                disp(texto)
                [R(d,r),~,time(d,r)] = SVM_actions(trajectories,...
                                                        test_samples{r,b},...
                                                        training_samples{r,b},...
                                                        arg_svm{d});
            end
        end
        Smax = 2;
        mR = mean(R,Smax);
        sR = std(R,[],Smax);
        minR = min(R,[],Smax);
        maxR = max(R,[],Smax);
        [~,i] = max(mR(:));
        
%         mT = mean(T,Smax-1);
%         sT = std(T,[],Smax-1);
%         minT = min(T,[],Smax-1);
%         maxT = max(T,[],Smax-1);
%         (:,pi,zi,rri,d,r)
%         dim_opt_proj(j),Dim(k),rr(l),zeta(k)
        Results(n,b) = struct('Method','SVM',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i) sR(i) minR(i) maxR(i)],...
                              'Best_D',arg_svm{i},...
                              'R',R,'time',time);                        
        
    end

end

clear trajectories
save results_rounds_SVM_og.mat




% 
% pause(60)
% disp('poweroff')
% system('poweroff')


% ST=0;
% for n=1:T_sets
%     ST=ST+sum(Results(n).Time(:));
% end

%EOF



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% % All experiments with dataset A.
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% 
% close all
% clear all
% clc
% w = warning ('off','all');
% 
% load dataset_C
% trajectories = trajectories_C;
% atores = atores_C;
% 
% %% For all experiments
% 
% % balance of samples for test: bal*Total_samples for each classe for test
% % and (1-bal)*Total_samples for trainning.
% bal = [0.5];
% 
% %% Experiment random samples, mix actors
% T_rounds = 500;
% 
% 
% % arg_svm{1} = '-q -s 1 -n 0.1 -t 0';
% % arg_svm{2} = '-q -s 1 -n 0.1 -t 2';
% % arg_svm{3} = '-q -s 1 -n 0.1 -t 3';
% % for i=1:4
% %     arg_svm{i+3} = ['-q -s 1 -n 0.1 -t 1 -d ' num2str(i)];
% % end
% % 
% % arg_svm{1+7} = '-q -s 1 -n 0.01 -t 0';
% % arg_svm{2+7} = '-q -s 1 -n 0.01 -t 2';
% % arg_svm{3+7} = '-q -s 1 -n 0.01 -t 3';
% % for i=1:4
% %     arg_svm{i+3+7} = ['-q -s 1 -n 0.01 -t 1 -d ' num2str(i)];
% % end
% 
% nn = [0.1431:0.0001:0.1449]';
% 
% % nn = 0.1431 is the best! but, around 1.4 e 1.45 we give the same result...
% 
% T_nn = max(size(nn));
% for i=1:T_nn
%     arg_svm{i} = ['-q -s 1 -n ',num2str(nn(i)),' -t 1 -d 2'];
% end
% 
% T_d = max(size(arg_svm));
% 
% N = max(size(trajectories));
% T_bal = max(size(bal));
% MC = zeros(N,N,T_d,T_rounds,T_bal);
% R = zeros(T_d,T_rounds,T_bal);
% 
% for b=1:T_bal
%     for r=1:T_rounds
%         [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
%         for d=1:T_d
%             texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
%             disp(texto)
%             [R(d,r,b),MC(:,:,d,r,b)] = SVM_actions(trajectories,test_samples,training_samples,arg_svm{d});
%         end
%     end
% end
% 
% 
%  save search_SVM_data.mat
% % pause(60)
% % disp('poweroff')
% % system('poweroff')
%  %EOF
% 
