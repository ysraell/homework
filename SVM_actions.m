%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Program to actions recognition by DCMDA (Li and Schonfeld, 2014).
% Created by Israel Oliveira, 01/17.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [R_,MC_,time_] = SVM_actions(trajectories,test_samples,training_samples,arg_svm)

    N = max(size(trajectories));
    [l,c] = size(trajectories{1}{1});

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
    
    MODEL = svmtrain(C,Y,arg_svm);
    tic
    MC = zeros(N,N);
    for Ni=1:N
        M_test = max(size(test_samples{Ni}));
        for i=1:M_test
            Mi = test_samples{Ni}(i);
            A=reshape(trajectories{Ni}{Mi},l*c,1)';
            index_img = round(svmpredict(0,A,MODEL));
            if (index_img==0)
                index_img = 1;
            end
%             index_img = predict(Model,A);
            MC(Ni,index_img) = MC(Ni,index_img)+1;
        end
        MC(Ni,:) = MC(Ni,:)./M_test;
    end
    
    time_=toc;
    MC_ = MC;
    R_ = sum(diag(MC))/N;
    
end