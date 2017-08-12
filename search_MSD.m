%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with DMDA with MSD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

%% Balance
% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5 0.7];

%% Experiment random samples, mix actors
T_rounds = 2;

% Dim = [0.9 0.99 1-4.50359962738.*eps*10.^[12 11 10 9 8 7 6 5 4 3]]';
% Dim = [0.1:0.05:0.95 0.99 0.999 0.9999];
Dim = [0.1 0.2];

%% Proporcional dim by eigenvalues or size dim (1 or 0)
rr = [0 1];

%% distance metric
dist_method_type = 'of';

%% How much dim progections
% dim_opt_proj = [1 2 3];
dim_opt_proj = [1 2];

%% Weight of discriminant w max scatter
% zeta = [0:6]';
zeta = [0 4]';

%% Max iterations
% T_max = [1 2 3 4];
T_max = [1 2];

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

for n=1:T_sets
    load(D_sets(n).name)
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=1:T_bal

        R = zeros(T_dm,T_proj,TT_max,T_z,T_rr,T_d,T_rounds,T_bal);
        T = zeros(T_proj,T_z,TT_max,T_rr,T_d,T_rounds,T_bal);
        for r=1:T_rounds
            [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
            for d=1:T_d
                for rri=1:T_rr
                    for zi=1:T_z
                        for it_max=1:TT_max
                            for pi=1:T_proj
                                if ((dim_opt_proj(pi)>2)&&(p_dim>1))||(dim_opt_proj(pi)<3)
                                    texto = ['(' set_str ')' ' T_max = ',num2str(T_max(it_max)),'/',num2str(TT_max) ' Proj = ',num2str(dim_opt_proj(pi)),'/',num2str(T_proj),' zeta = ',num2str(zi),'/',num2str(T_z),'. rr = ',num2str(rr(rri)),'/',num2str(T_rr),'. d = ',num2str(d),'/',num2str(T_d),'. Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
                                    disp(texto)
                                    tic
                                    [R(:,pi,it_max,zi,rri,d,r),~,~,~] = MSD_actions(trajectories,...
                                                                           test_samples,...
                                                                           training_samples,...
                                                                           dist_method_type,...
                                                                           dim_opt_proj(pi),...
                                                                           Dim(d),rr(rri),zeta(zi),...
                                                                           T_max(it_max),tolerancia);
                                    T(pi,it_max,zi,rri,d,r) = toc;
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
        
        mT = mean(T,Smax-1);
        sT = std(T,[],Smax-1);
        minT = min(T,[],Smax-1);
        maxT = max(T,[],Smax-1);
%         (:,pi,zi,rri,d,r)
%         dim_opt_proj(j),Dim(k),rr(l),zeta(k)
        Results(n,b) = struct('Method','MSD',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i,j,mm,k,l,m) sR(i,j,mm,k,l,m) minR(i,j,mm,k,l,m) maxR(i,j,mm,k,l,m)],...
                              'Best_D',dist_method_type(i),...
                              'Best_Proj',dim_opt_proj(j),...
                              'Best_Tmax',T_max(mm),...
                              'Best_Dim',Dim(m),...
                              'Best_rr',rr(l),...
                              'Best_zeta',zeta(k),...
                              'R',R,'Time',T);
        
    end

end

clear trajectories
save search_MSD_data.mat

% pause(60)
% disp('poweroff')
% system('poweroff')


%EOF


