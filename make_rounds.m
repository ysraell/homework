%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the scripts to generate the datasets A, B and C.
% The frist two is relatively quick, but the third need around N hours
% (using a Intel Xeon E3-1241 V3 (like a i7 4790). There are 249 samples.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Balances
bal = [0.5 0.7];

% How much rounds
T_rounds = 200;


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
    for b=1:T_bal
        for r=1:T_rounds
            [test_samples{r,b},training_samples{r,b},test_count{r,b},training_count{r,b}] = gen_round_rand_balance(trajectories,bal(b));
        end
    end
    filename = ['rounds_' set_str '.mat'];
    save(filename,'test_samples','training_samples','test_count','training_count');
    disp(set_str)
end