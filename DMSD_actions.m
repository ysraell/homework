%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DGTDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_DMSD,MC_DMSD,num_max,time_] = DMSD_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim,r,zeta)

    N = max(size(trajectories));
    [l,c,p] = size(trajectories{1}{1});
    
    Uc =eye(c,c);
    Up =eye(p,p);

    num_max = zeros(p,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.
    
    if (dim_opt_proj>0)
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode
        [Ul,num_max(1,:)] = subspace_proj_DMSD(training_samples,trajectories,N,l,c*p,1,Dim,r,zeta);

        if (dim_opt_proj>1)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode
            [Uc,num_max(2,:)] = subspace_proj_DMSD(training_samples,trajectories,N,c,l*p,2,Dim,r,zeta);

            if (dim_opt_proj>2)&&(p>2)
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-mode
                [Up,num_max(3,:)] = subspace_proj_DMSD(training_samples,trajectories,N,p,l*c,3,Dim,r,zeta);

            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Testing step.    

        trajectories_proj = trajectories;

        % Project the entire base in the new optimal subspace
        for Ni=1:N
            for Mi = training_samples{Ni}
                if p>1
                    trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc',Up'));
                else
                    trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc'));
                end
            end
            for Mi = test_samples{Ni}
                if p>1
                    trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc',Up'));
                else
                    trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories{Ni}{Mi}),Ul',Uc'));
                end
            end
        end
    else
        trajectories_proj = trajectories;
    end
    
    %%%%% Classification All testing samples vs All training samples
   
     T_dist = max(size(dist_method_type));
    MC = zeros(N,N,T_dist);
    R = zeros(T_dist,1);
    time = zeros(T_dist,1);
    for d=1:T_dist
        tic
        [R(d),MC(:,:,d)] = TEST_step_MDAs(trajectories_proj,test_samples,training_samples,N,dist_method_type(d));
        time(d) = toc;
    end
    time_=time;
    MC_DMSD = MC;
    R_DMSD = R;
    
  
    
end