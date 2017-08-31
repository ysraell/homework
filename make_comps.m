%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the scripts to generate the datasets A, B and C.
% The frist two is relatively quick, but the third need around N hours
% (using a Intel Xeon E3-1241 V3 (like a i7 4790). There are 249 samples.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Balances
bal = [0.5 0.7];

S_set = dir('dataset_*.mat');
T_sets = max(size(S_set));



for n=1:T_sets
    clearvars -except n S_set T_sets bal T_rounds
    load(S_set(n).name);

    test_samples=[];
    training_samples=[];
    test_count=[];
    training_count=[];
    
    
    T_bal = max(size(bal));
    T_rounds = zeros(T_bal,1);
    T_atores = max(size(atores));
    for b=1:T_bal
        [test_a,training_a,T_rounds(b)] = gen_comb_authors(round(bal(b)*T_atores+eps),atores);
        for r=1:T_rounds(b)
            [test_samples{r,b},training_samples{r,b},test_count{r,b},training_count{r,b}] = gen_by_authors(trajectories,atores,test_a(r,:),training_a(r,:));
        end
    end
    filename = ['comps_' set_str '.mat'];
    save(filename,'test_samples','training_samples','test_count','training_count','T_rounds');
    disp(set_str)
end


