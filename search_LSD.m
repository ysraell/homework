
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with LDA.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');
addpath(pwd)

%% Balance
% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = 1;

%% Experiment random samples, mix actors
T_rounds = 100;

% Dim = [0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
Dim = [0.1:0.05:0.95 0.99 0.999 0.9999];
% Dim = [0.1];

%% Proporcional dim by eigenvalues or size dim (1 or 0)
rr = [0 1];

%% distance metric
dist_method_type = 'og';

%% Weight of discriminant w max scatter
zeta = [0:6]';
% zeta = [0]';


%% Totals
T_bal = max(size(bal));
T_d = max(size(Dim));
T_rr = max(size(rr));
T_dm = max(size(dist_method_type));
T_z = max(size(zeta));


%% Experiments

D_sets = dir('dataset_*.mat');
T_sets = max(size(D_sets));
Exps = [2 3 11];
T_Exps = max(size(Exps));
delete(gcp)
parpool('local',16);

for n=1:T_Exps
    load(D_sets(Exps(n)).name)
    load(['rounds_' set_str '.mat'])
    
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=bal
        R = zeros(T_dm,T_z,T_rr,T_d,T_rounds);
        time = zeros(T_dm,T_z,T_rr,T_d,T_rounds);
        parfor r=1:T_rounds
            for d=1:T_d
                for rri=1:T_rr
                    for zi=1:T_z
                        texto = ['(' set_str ') zeta = ',num2str(zi),'/',num2str(T_z),'. rr = ',num2str(rr(rri)),'/',num2str(T_rr),'. d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
                        disp(texto)
                        [R(:,zi,rri,d,r),~,~,time(:,zi,rri,d,r)] = LDA_actions(trajectories,...
                                                           test_samples{r,b},...
                                                           training_samples{r,b},...
                                                           dist_method_type,...
                                                           Dim(d),rr(rri),'u','svd',1,zeta(zi));
                    end
                end
            end
        end
        Smax = 5;
        mR = mean(R,Smax);
        sR = std(R,[],Smax);
        minR = min(R,[],Smax);
        maxR = max(R,[],Smax);
        [~,idx] = max(mR(:));
        [i,j,k,l] = ind2sub(size(mR),idx);
%         
%         mT = mean(T,Smax-1);
%         sT = std(T,[],Smax-1);
%         minT = min(T,[],Smax-1);
%         maxT = max(T,[],Smax-1);
%         (:,pi,zi,rri,d,r)
%         dim_opt_proj(j),Dim(k),rr(l),zeta(k)
        Results(n,b) = struct('Method','LSD',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i,j,k,l) sR(i,j,k,l) minR(i,j,k,l) maxR(i,j,k,l)],...
                              'Best_D',dist_method_type(i),...
                              'Best_Dim',Dim(l),...
                              'Best_rr',rr(k),...
                              'Best_zeta',zeta(j),...
                              'R',R,'Time',time);
        
        
    end

end

clear trajectories
save search_LSD_data.mat
% 
% pause(60)
% disp('poweroff')
% system('poweroff')


% ST=0;
% for n=1:3
%     ST=ST+sum(Results(n).Time(:));
% end



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
% T_rounds = 50;
% 
% Dim = 1-eps*10.^[15 14 13 12 11 10 9 8 7]';
% T_d = max(size(Dim));
% 
% % >> [Dim mean(R,2) std(R')' min(R')' max(R')']
% % 
% %     0.9778    0.9012    0.0325    0.8408    0.9712
% %     0.9978    0.9132    0.0265    0.8555    0.9740
% %     0.9998    0.9132    0.0265    0.8555    0.9740
% %     1.0000    0.9132    0.0265    0.8555    0.9740
% %     1.0000    0.9132    0.0265    0.8555    0.9740
% %     1.0000    0.9132    0.0265    0.8555    0.9740
% %     1.0000    0.9132    0.0265    0.8555    0.9740
% %     1.0000    0.9132    0.0265    0.8555    0.9740
% 
% 
% Algorithm = 'svd'; % only for pca from MATLAB
% rr = 1;
% Func = 'u'; 
% dist_method_type = 'n';
% T_dm = max(size(dist_method_type));
% 
% N = max(size(trajectories));
% T_bal = max(size(bal));
% MC = zeros(N,N,T_d,T_rounds,T_bal);
% R = zeros(T_d,T_rounds,T_bal);
% num_max = zeros(T_d,2,T_rounds,T_bal);
% 
% msd = 0;
% zeta = 0;
% 
% time = zeros(T_d,T_rounds,T_bal);
% for b=1:T_bal
%     for r=1:T_rounds
%         [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
%         for d=1:T_d
% 
%             texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
%             disp(texto)
%             tic
%             [R(d,r,b),MC(:,:,d,r,b),num_max(d,:,r,b)] = LDA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim(d),rr,Func,Algorithm,msd,zeta);
%             time(d,r,b) = toc;
%         end
%     end
% end
% 
% 
% % Rn = reshape(R(1,:,:),3,10);
% % Rf = reshape(R(2,:,:),3,10);
% 
% save search_LDA_data.mat
% % pause(60)
% % disp('poweroff')
% % system('poweroff')
%  %EOF
% 
