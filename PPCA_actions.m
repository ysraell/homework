%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_MDA,MC_MDA,num_max] = PPCA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim,r,Func,Algorithm)

    N = max(size(trajectories));
    [l,c] = size(trajectories{1}{1});
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PCA subspace optimal usgin MATLAB function
    s=0;
    for Ni=1:N
        s = s+max(size(test_samples{Ni}));
    end    
    
    Y = zeros(s,l*c);
    s=0;
    for Ni=1:N
        for gmi = training_samples{Ni}
            s=s+1;
            Y(s,:) = reshape(trajectories{Ni}{gmi},l*c,1)';
        end
    end
    
    [V,~,L] = ppca(Y,min(l,c)-1);   
    
    [U,num_max] = redux_dim(V,L,Dim,r);
    U=U';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Testing step.    
   
    % Project the entire base in the new optimal subspace
    trajectories_proj = trajectories;
    for Ni=1:N
        for Mi = training_samples{Ni}
            trajectories_proj{Ni}{Mi} = U*reshape(trajectories{Ni}{Mi},l*c,1);
        end
        for Mi = test_samples{Ni}
            trajectories_proj{Ni}{Mi} = U*reshape(trajectories{Ni}{Mi},l*c,1);
        end
    end
    
    %%%%% Classification All testing samples vs All training samples
    
     T_dist = max(size(dist_method_type));
    MC = zeros(N,N,T_dist);
    R = zeros(T_dist,1);
    for d=1:T_dist
        [R(d),MC(:,:,d)] = TEST_step_MDAs(trajectories_proj,test_samples,training_samples,N,dist_method_type(d));
    end
    MC_MDA = MC;
    R_MDA = R;
    
end