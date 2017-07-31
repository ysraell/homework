close all
clear all
clc

load HDM_mot_joint_trajectories_3D_normalizado_interpolado_atores.mat
N=11;
% bal = [2];
% T_bal = max(size(bal));
dist_method_type = [2 3];
dim_opt_proj = [0 3];
Dim = [0.5 0.8];
% Dim = 0.6
% zeta = [1 1 1;
%         100 10 1;
%         10 10 10;
%         100 100 100;
%         1e3 1e3 1e3];
% T_zeta = max(size(zeta));      
zeta = [10 10 10];
T_zeta = 1;

ator_teste = sort(combnk([1 2 3 4 5],2),'ascend');
T_atores = size(ator_teste,1);

T_Dim = max(size(Dim));

T_dist = max(size(dist_method_type));

T_dim_p = max(size(dim_opt_proj));

R_DGTDA = zeros(T_dist,T_zeta,T_dim_p,T_Dim,T_atores);
T_DGTDA = R_DGTDA;
MC_DGTDA = zeros(N,N,T_dist,T_zeta,T_dim_p,T_Dim,T_atores);


% last time: dim 60% SSIM 693.7228s FROB 0.6794s
% T_bal*T_zeta*T_Dim*T_dim_p*(693.7228 +0.6794 )/3600
% T_bal*T_zeta*T_Dim*T_dim_p*(213.6742 +0.3804 )/3600



for b=1:T_atores
    for Ni=1:11
        test_samples{Ni} = [];
        training_samples{Ni} = [];
    end
    for ai=1:5
        if find(atores_num(ator_teste(b))==ai)
            TEMP = [];
            for Ni=1:11
                TEMP = test_samples{Ni};
                TEMP = [TEMP atores{ai}{Ni}];
                test_samples{Ni} =  TEMP;
            end
        else
            TEMP = [];
            for Ni=1:11
                TEMP = training_samples{Ni};
                TEMP = [TEMP atores{ai}{Ni}];
                training_samples{Ni} =  TEMP;
            end
        end
    end
    
    
    if (dim_opt_proj(1)==0)
        for s=1:T_zeta
            for k=1:T_dist
                m=1;
                dimi=1;
                disp('b dimi m s k')
                disp([b dimi m s k])
                tic
                [R_DGTDA(k,s,m,dimi,b),MC_DGTDA(:,:,k,s,m,dimi,b)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
%                 [R_DGTDA(k,s,m,dimi,b),~]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                T_DGTDA(k,s,m,dimi,b) = toc;
            end
        end
        for dimi = 2:T_Dim
            for s=1:T_zeta
                for k=1:T_dist
                    disp('b dimi m s k')
                    disp([b dimi m s k])
                    R_DGTDA(k,s,m,dimi,b) = R_DGTDA(k,s,m,dimi,b);
                    MC_DGTDA(:,:,k,s,m,dimi,b) = MC_DGTDA(:,:,k,s,m,dimi,b);
                    T_DGTDA(k,s,m,dimi,b) = T_DGTDA(k,s,m,dimi,b);
                end
            end
        end
    end
    
    for dimi = 1:T_Dim
        for m=1:T_dim_p
            if (dim_opt_proj(m)~=0)
                for s=1:T_zeta
                    for k=1:T_dist
                        disp('b dimi m s k')
                        disp([b dimi m s k])
                        tic
                        [R_DGTDA(k,s,m,dimi,b),MC_DGTDA(:,:,k,s,m,dimi,b)]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
%                         [R_DGTDA(k,s,m,dimi,b),~]= DGTDA_actions(trajectories,test_samples,training_samples,dist_method_type(k),dim_opt_proj(m),Dim(dimi),zeta(s,:)');
                        T_DGTDA(k,s,m,dimi,b) = toc;
                    end
                end
            end
        end
    end
end


S = zeros(5,1);
for a=1:5
    for Ni=1:11
        S(a) = S(a)+max(size(atores{a}{Ni}));
    end
end


save results_MDA_actions_atores_combinacao_180317_testes.mat

% load handel
% sound(y,Fs)
% contagem de amostras por ator
% pause(60)
% disp('poweroff')
% system('poweroff')



%EOF