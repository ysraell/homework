

function [test_samples_,training_samples_,test_count_,training_count_] = gen_round_rand_balance(trajectories,bal)


    N = max(size(trajectories));
    
                test_samples = [];
            training_samples = [];
                test_count = 0;
            training_count = 0;
            
            for Ni=1:N
                M = max(size(trajectories{Ni}));
                M2 = round(M*bal);
                temp = randperm(M);
                test_samples{Ni} = temp(1:M2);
                test_count = test_count+max(size(temp(1:M2)));
                training_samples{Ni} = temp(M2+1:end);
                training_count = training_count+max(size(temp(M2+1:end)));
            end
            
    test_samples_ = test_samples;
    training_samples_ = training_samples;
    test_count_ = test_count;
    training_count_ = training_count;      
end