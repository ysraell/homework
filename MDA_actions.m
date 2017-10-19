%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_,num_max,E_,time_] = MDA_actions(trajectories,test_samples,training_samples,dist_method_type,dim_opt_proj,Dim,r,zeta,T_max,tolerancia)

    N = max(size(trajectories));
    
    [l,c,p] = size(trajectories{1}{1});

    Ul =eye(l,l);
    Uc =eye(c,c);
    Up =eye(p,p);
    aUc =eye(c,c);
    aUp =eye(p,p);
    num_max = -ones(dim_opt_proj,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training step.

    t=1;
    Erro_it = -ones(T_max,1);
    erro = Inf;
    trajectories_proj = trajectories;
    
    while (t<=T_max)&&(erro>tolerancia)
        
        if (t>1)
            for Ni=1:N
                for Mi = training_samples{Ni}
                    if p==3
                        trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories_proj{Ni}{Mi}),Ul',Uc',Up'));
                    else
                        trajectories_proj{Ni}{Mi} = double(ttensor(tensor(trajectories_proj{Ni}{Mi}),Ul',Uc'));
                    end
                end
            end
        end

         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1-mode
        [aUl,Ll] = subspace_proj_MDA(training_samples,trajectories_proj,N,l,c*p,1,zeta);


        if (dim_opt_proj>1)
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2-mode
            [aUc,Lc] = subspace_proj_MDA(training_samples,trajectories_proj,N,c,l*p,2,zeta);

            if (dim_opt_proj>2)&&(p>1)
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3-mode
                [aUp,Lp] = subspace_proj_MDA(training_samples,trajectories_proj,N,p,l*c,3,zeta);

            end
        end   
            
                erro = frob(Ul-aUl)/frob(aUl)+frob(Up-aUp)/frob(aUp)+frob(Uc-aUc)/frob(aUc); 
                Erro_it(t) = erro;
                Ul=aUl;
                Uc=aUc;
                Up=aUp;
                t=t+1;
    end
    
    [Ul,num_max(1,:)] =redux_dim(aUl,Ll,Dim,r);
    if dim_opt_proj >1
        [Uc,num_max(2,:)] =redux_dim(aUc,Lc,Dim,r);
    end
    if dim_opt_proj >2
        [Up,num_max(3,:)] =redux_dim(aUp,Lp,Dim,r);  
    end
    E_ = Erro_it;
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Testing step.    
   
    % Project the entire base in the new optimal subspace
    trajectories_proj = trajectories;
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
    MC_ = MC;
    R_ = R;
    
end