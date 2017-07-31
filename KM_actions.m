%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_] = KM_actions(trajectories,test_samples,training_samples,K,distance,emptyaction,start)

    N = max(size(trajectories));
    [l,c] = size(trajectories{1}{1});

    s=0;
    for Ni=1:N
        s = s+max(size(training_samples{Ni}));
    end    
    
    Y = zeros(l*c,s);
    C = zeros(s,1);
    s=0;
    for Ni=1:N
        for gmi = training_samples{Ni}
            s=s+1;
            Y(:,s) = reshape(trajectories{Ni}{gmi},l*c,1);
            C(s) = Ni;
        end
    end
    [Ck,Ak] = kmeans(Y',K,'distance',distance,'emptyaction',emptyaction,'start',start);
    MC = zeros(N,N);
    for Ni=1:N
        M_test = max(size(test_samples{Ni}));
        for i=1:M_test
            Mi = test_samples{Ni}(i);
            A=reshape(trajectories{Ni}{Mi},l*c,1)';
            [~,idxk] = min(sum((Ak-repmat(A,K,1)).^2,2));
            index_img = mode(C(Ck==idxk));
            MC(Ni,index_img) = MC(Ni,index_img)+1;
        end
        MC(Ni,:) = MC(Ni,:)./M_test;
    end
    
    MC_ = MC;
    R_ = sum(diag(MC))/N;
    
end