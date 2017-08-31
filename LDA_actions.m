%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [R_,MC_] = LDA_actions(trajectories,test_samples,training_samples)
function [R_,MC_,num_max,time_] = LDA_actions(trajectories,test_samples,training_samples,dist_method_type,Dim,r,Func,Algorithm,msd,zeta)

    N = max(size(trajectories));
    [l,c] = size(trajectories{1}{1});
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % LDA subspace optimal usgin MATLAB function

    switch Func
        case 'm'
            s=0;
            for Ni=1:N
                s = s+max(size(test_samples{Ni}));
            end    

            Y = zeros(s,l*c);
            C = zeros(s,1);
            s=0;
            for Ni=1:N
                for gmi = training_samples{Ni}
                    s=s+1;
                    Y(s,:) = reshape(trajectories{Ni}{gmi},l*c,1)';
                    C(s) = Ni;
                end
            end

            Model = fitcdiscr(Y,C,'SaveMemory','on','DiscrimType','linear');
            num_max = 0;

            MC = zeros(N,N);
            for Ni=1:N
                M_test = max(size(test_samples{Ni}));
                for i=1:M_test
                    Mi = test_samples{Ni}(i);
                    A=reshape(trajectories{Ni}{Mi},l*c,1)';
                    index_img = predict(Model,A);
                    MC(Ni,index_img) = MC(Ni,index_img)+1;
                end
                MC(Ni,:) = MC(Ni,:)./M_test;
            end

            MC_ = MC;
            R_ = sum(diag(MC))/N;

        case 'u'
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % LDA subspace optimal use our own function
            [V,L] = subspace_proj_LDA(training_samples,trajectories,msd,zeta);
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

end