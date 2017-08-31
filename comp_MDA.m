
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with DMDA with MDA.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');
addpath(pwd)

%% Balance authors
% how much for training
bal = 1;

% Dim = [0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
Dim = [0.1:0.05:0.95 0.99 0.999 0.9999];
% Dim = [0.1 0.2];

%% Proporcional dim by eigenvalues or size dim (1 or 0)
rr = [0 1];

%% distance metric
dist_method_type = 'og';

%% How much dim progections
dim_opt_proj = [1 2 3];
% dim_opt_proj = [1 2];

%% Weight of discriminant w max scatter
zeta = [0:6]';
% zeta = [0 4]';

%% Max iterations
T_max = [1 2 3 4];
% T_max = [1 2];

%% Max tolerancia
tolerancia = 0;

%% Totals
T_bal = max(size(bal));
T_d = max(size(Dim));
T_rr = max(size(rr));
T_dm = max(size(dist_method_type));
T_z = max(size(zeta));
T_proj = max(size(dim_opt_proj));
TT_max = max(size(T_max));


%% Experiments

D_sets = dir('dataset_*.mat');
T_sets = max(size(D_sets));
Exps = 1:T_sets;
T_Exps = max(size(Exps));
delete(gcp)
parpool('local',16);

for n=1:T_Exps
    load(D_sets(Exps(n)).name)
    load(['comps_' set_str '.mat'])
    
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=bal
        R = zeros(T_dm,T_proj,TT_max,T_z,T_rr,T_d,T_rounds(b));
        time = zeros(T_dm,T_proj,TT_max,T_z,T_rr,T_d,T_rounds(b));
        parfor r=1:T_rounds(b)
            for d=1:T_d
                for rri=1:T_rr
                    for zi=1:T_z
                        for it_max=1:TT_max
                            for pi=1:T_proj
                                if ((dim_opt_proj(pi)>2)&&(p_dim>1))||(dim_opt_proj(pi)<3)
                                    texto = ['(' set_str ')'...
                                             ' Proj = ',num2str(dim_opt_proj(pi)),'/',num2str(T_proj)...
                                             ' T_max = ',num2str(T_max(it_max)),'/',num2str(TT_max)...
                                             ' zeta = ',num2str(zi),'/',num2str(T_z),'.'... 
                                             ' rr = ',num2str(rr(rri)),'/',num2str(T_rr),'.' ...
                                             ' d = ',num2str(d),'/',num2str(T_d),'.'...
                                             ' Round:' num2str(r),'/',num2str(T_rounds(b)),'.'...
                                             ' bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
                                    disp(texto)                                
                                    [R(:,pi,it_max,zi,rri,d,r),~,~,~,time(:,pi,it_max,zi,rri,d,r)] = MDA_actions(trajectories,...
                                                                           test_samples{r,b},...
                                                                           training_samples{r,b},...
                                                                           dist_method_type,...
                                                                           dim_opt_proj(pi),...
                                                                           Dim(d),rr(rri),zeta(zi),...
                                                                           T_max(it_max),tolerancia);
                                end
                            end
                        end
                    end
                end
            end
        end
        Smax = 7;
        mR = mean(R,Smax);
        sR = std(R,[],Smax);
        minR = min(R,[],Smax);
        maxR = max(R,[],Smax);
        [~,idx] = max(mR(:));
        [i,j,mm,k,l,m] = ind2sub(size(mR),idx);
        
%         mT = mean(T,Smax-1);
%         sT = std(T,[],Smax-1);
%         minT = min(T,[],Smax-1);
%         maxT = max(T,[],Smax-1);
%         (:,pi,zi,rri,d,r)
%         dim_opt_proj(j),Dim(k),rr(l),zeta(k)
        Results(n,b) = struct('Method','MDA',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i,j,mm,k,l,m) sR(i,j,mm,k,l,m) minR(i,j,mm,k,l,m) maxR(i,j,mm,k,l,m)],...
                              'Best_D',dist_method_type(i),...
                              'Best_Proj',dim_opt_proj(j),...
                              'Best_Tmax',T_max(mm),...
                              'Best_Dim',Dim(m),...
                              'Best_rr',rr(l),...
                              'Best_zeta',zeta(k),...
                              'R',R,'Time',time);
        
    end

end

clear trajectories
save search_MDA_data.mat

% pause(60)
% disp('poweroff')
% system('poweroff')


%EOF



 



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

% 
% [Dim mean(R,2) std(R')' min(R')' max(R')']
% 
% ans =
% 
%     0.9000    0.4781    0.0639    0.3948    0.6163
%     0.9900    0.6423    0.0579    0.5213    0.7381
%     0.9990    0.6722    0.0440    0.5967    0.8019
%     0.9999    0.7252    0.0430    0.6210    0.7941
%     1.0000    0.8276    0.0377    0.7630    0.8995
%     1.0000    0.8570    0.0348    0.7972    0.9344
%     1.0000    0.8722    0.0337    0.8002    0.9274
%     1.0000    0.8700    0.0375    0.7951    0.9274
%     1.0000    0.8688    0.0354    0.7951    0.9230
%     1.0000    0.8688    0.0354    0.7951    0.9230
%     1.0000    0.8688    0.0354    0.7951    0.9230
%     1.0000    0.8688    0.0354    0.7951    0.9230


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
% T_rounds = 30;
% 
% T_max = 500;
% T_tm = max(size(T_max));
% 
% Dim = 1-4.50359962738.*eps*10.^[11 10 9 8 7 6 5 4 3]';
% T_d = max(size(Dim));
% 
% rr = 1;
% dist_method_type = 'n';
% dim_opt_proj = 2;
% tolerancia = 0.89;
% 
% T_dm = max(size(dist_method_type));
% 
% N = max(size(trajectories));
% T_bal = max(size(bal));
% % MC = zeros(N,N,T_tm,T_d,T_rounds,T_bal);
% % R = zeros(T_tm,T_d,T_rounds,T_bal);
% % E = zeros(max(T_max),T_tm,T_d,T_rounds,T_bal);
% % num_max = -ones(max(dim_opt_proj),2,T_tm,T_d,T_rounds,T_bal);
% % time = zeros(T_tm,T_d,T_rounds,T_bal);
% 
% MC = zeros(N,N,T_d,T_rounds,T_bal);
% R = zeros(T_d,T_rounds,T_bal);
% E = zeros(T_max,T_d,T_rounds,T_bal);
% num_max = -ones(max(dim_opt_proj),2,T_d,T_rounds,T_bal);
% time = zeros(T_d,T_rounds,T_bal);
% 
% for b=1:T_bal
%     for r=1:T_rounds
%         [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
%         for d=1:T_d
% %             for tm=1:T_tm
% %                 texto = ['tm = ',num2str(tm),'/',num2str(T_tm),'. d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
% %                 disp(texto)
% %                 tic
% %                 [R(tm,d,r,b),MC(:,:,tm,d,r,b),num_max(1:dim_opt_proj,:,tm,d,r,b),E(1:T_max(tm),tm,d,r,b)] = MDA_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim(d),r,T_max(tm),tolerancia);
% %                 time(tm,d,r,b) = toc;
% %             end
%                 texto = ['d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
%                 disp(texto)
%                 tic
%                 [R(d,r,b),MC(:,:,d,r,b),num_max(1:dim_opt_proj,:,d,r,b),E(:,d,r,b)] = MDA_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim(d),rr,T_max,tolerancia);
%                 time(d,r,b) = toc;
%         end
%     end
% end
% 
% 
% % Rn = reshape(R(1,:,:),3,10);
% % Rf = reshape(R(2,:,:),3,10);
% 
% save search_MDA_data.mat
% pause(60)
% disp('poweroff')
% system('poweroff')
%  
% 
% 
% 
% %% LDA
% %     [Dim mean(R,2) std(R')' min(R')' max(R')']
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
% %% MDA
% %     [Dim mean(R,2) std(R')' min(R')' max(R')']
% % 
% %     0.9999    0.7309    0.0440    0.6082    0.7971
% %     1.0000    0.7888    0.0377    0.6749    0.8544
% %     1.0000    0.8693    0.0347    0.7755    0.9243
% %     1.0000    0.8733    0.0350    0.7797    0.9377
% %     1.0000    0.8819    0.0333    0.7841    0.9326
% %     1.0000    0.8791    0.0318    0.7841    0.9387
% %     1.0000    0.8791    0.0318    0.7841    0.9387
% %     1.0000    0.8791    0.0318    0.7841    0.9387
% %     1.0000    0.8791    0.0318    0.7841    0.9387
% 
% 
% 
% 
% 
% %EOF
% 
