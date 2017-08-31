%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the scripts to generate the datasets A, B and C.
% The frist two is relatively quick, but the third need around N hours
% (using a Intel Xeon E3-1241 V3 (like a i7 4790). There are 249 samples.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



S_set = dir('make_dataset_*.m');
T_sets = max(size(S_set));

for n=1:T_sets
    clearvars -except n S_set T_sets
    run(S_set(n).name);
end

