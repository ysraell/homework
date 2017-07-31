%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run the scripts to generate the datasets A, B and C.
% The frist two is relatively quick, but the third need around N hours
% (using a Intel Xeon E3-1241 V3 (like a i7 4790). There are 249 samples.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



disp('Creating dataset A...')
run make_dataset_A.m
disp('Creating done.')

disp('Creating dataset B...')
run make_dataset_B.m
disp('Creating done.')

disp('Creating dataset C...')
run make_dataset_C.m
disp('Creating done.')
