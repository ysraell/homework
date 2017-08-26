%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_,time_] = MD_actions(trajectories,test_samples,training_samples,dist_method_type)

    N = max(size(trajectories));
    
    %%%%% Classification All testing samples vs All training samples
    
    T_dist = max(size(dist_method_type));
    MC = zeros(N,N,T_dist);
    R = zeros(T_dist,1);
    time = zeros(T_dist,1);
    for d=1:T_dist
        tic;
        [R(d),MC(:,:,d)] = TEST_step_MDAs(trajectories,test_samples,training_samples,N,dist_method_type(d));
        time(d) = toc;
    end
    time_=time;
    MC_ = MC;
    R_ = R;
      
end