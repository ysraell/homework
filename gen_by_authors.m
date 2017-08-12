

function [test_samples_,training_samples_,test_count_,training_count_] = gen_by_authors(trajectories,atores,test_a,training_a)


    N = max(size(trajectories));
    
                test_samples = [];
            training_samples = [];
                test_count = 0;
            training_count = 0;
            
            for Ni=1:N
                temp=[];
                for a=test_a
                    temp = [temp atores{a}{Ni}];
                    test_count = test_count+max(size(atores{a}{Ni}));
                end
                test_samples{Ni} =temp;
                temp=[];
                for a=training_a
                     temp = [temp atores{a}{Ni}];
                    training_count = training_count+max(size(atores{a}{Ni}));
                end
                training_samples{Ni} =temp;
            end
            
            
    test_samples_ = test_samples;
    training_samples_ = training_samples;
    test_count_ = test_count;
    training_count_ = training_count;      
end