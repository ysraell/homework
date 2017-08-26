function [test_,training_,T_rounds_] = gen_comb_authors(n_training,atores)

   
    NA = max(size(atores));
    training = combnk([1:NA],n_training);
    T_rounds = size(training,1);
    n_test = NA-n_training;
    test = zeros(T_rounds,n_test);
    for r=1:T_rounds
        temp = zeros(1,n_test);
        s=0;
        for a=1:NA
            if find(training(r,:)==a)
            else
                s=s+1;
                temp(1,s) = a;
            end
        end
        test(r,:) = temp;
    end
    
    test_ = training;
    training_= test;
    T_rounds_=T_rounds;
end

%EOF