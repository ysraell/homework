%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R,MC,num_max,E] = METHODS_actions(Methods,trajectories,test_samples,training_samples,...
            dist_method_type,dim_opt_proj,Dim,r,T_max,tolerancia,zeta)
                
        num_max = zeros(dim_opt_proj,2);
        E = -ones(T_max,1);
        
        
            % To check
            % DMDA
            % DMSD
            % GAP
            % KM
            % KNN
            % KPP
            % LDA
            % LDA
            % MDA
            % MD
            % MSD
            % PCA
            % PPCA
            % SVM
            % TB
            % TREE

        
        
        switch Methods
            case 'TREE'
                [R,MC] = TREE_actions(trajectories,test_samples,training_samples);
            case 'KM'
                [R,MC] = KM_actions(trajectories,test_samples,training_samples);
            case 'KNN'
                [R,MC] = KNN_actions(trajectories,test_samples,training_samples);
            case 'TB'
                [R,MC] = TB_actions(trajectories,test_samples,training_samples);
            case 'SVM'
                [R,MC] = SVM_actions(trajectories,test_samples,training_samples);
            case 'PCA'
                [R,MC,num_max(end,:)] = PCA_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,Dim,r);
            case 'LDA'
                [R,MC,num_max(end,:)] = LDA_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,Dim,r);
%                 [R,MC] = LDA_actions(trajectories,test_samples,training_samples);
            case 'MDA'
                [R,MC,num_max,E] = MDA_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,dim_opt_proj,Dim,r,T_max,tolerancia);
            case 'MSD'
                [R,MC,num_max,E] = MSD_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,dim_opt_proj,Dim,r,T_max,tolerancia,zeta);
            case 'DMDA'
                [R,MC,num_max] = DMDA_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,dim_opt_proj,Dim,r);
            case 'DMSD'
                [R,MC,num_max] = DMSD_actions(trajectories,test_samples,training_samples,...
                    dist_method_type,dim_opt_proj,Dim,r,zeta);
            otherwise
                disp('Something wrong is not correctly!')
        end

end