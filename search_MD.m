%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All datasets with DMDA with MSD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

%% Balance
% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5];

%% Experiment random samples, mix actors
T_rounds = 200;

%% distance metric
dist_method_type = 'og';


%% Totals
T_bal = max(size(bal));
T_dm = max(size(dist_method_type));


%% Experiments

% D_sets = dir('dataset_*.mat');
D_sets = dir('dataset_C.mat');
T_sets = max(size(D_sets));

for n=1:T_sets
    load(D_sets(n).name)
    N = max(size(trajectories));
    [~,~,p_dim] = size(trajectories{1}{1});

    for b=1:T_bal

        R = zeros(T_dm,T_rounds);
        time = zeros(T_dm,T_rounds);
        T = zeros(T_rounds);
        for r=1:T_rounds
            [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
            texto = ['(' set_str ') Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
            disp(texto)
            tic
            [R(:,r),~,time(:,r)] = MD_actions(trajectories,test_samples,training_samples,dist_method_type);
            T(r) = toc;
        end
        Smax = 2;
        mR = mean(R,Smax);
        sR = std(R,[],Smax);
        minR = min(R,[],Smax);
        maxR = max(R,[],Smax);
        [~,idx] = max(mR(:));
        [i] = ind2sub(size(mR),idx);
        
        mT = mean(time,Smax);
        sT = std(time,[],Smax);
        minT = min(time,[],Smax);
        maxT = max(time,[],Smax);
        Results(n,b) = struct('Method','MD',...
                              'Dataset',set_str,...
                              'Best_R',[mR(i) sR(i) minR(i) maxR(i)],...
                              'Best_D',dist_method_type(i),...
                              'R',R,'Time',T,'Time_dist',time);
        
    end

end

clear trajectories
save search_MD_data.mat
% 
% pause(60)
% disp('poweroff')
% system('poweroff')


ST=0;
for n=1:T_sets
    ST=ST+sum(Results(n).Time(:));
end

%EOF




% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% % Just first near neighborhod
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% 
% close all
% clear all
% clc
% w = warning ('off','all');
% 
% 
% 
% %% For all experiments
% 
% % balance of samples for test: bal*Total_samples for each classe for test
% % and (1-bal)*Total_samples for trainning.
% bal = [0.5];
% 
% %% Experiment random samples, mix actors
% T_rounds = 100;
% 
% %% Distance metrics
% dist_method_type = 'o';
% 
% 
% %% totlas
% T_bal = max(size(bal));
% T_d = max(size(dist_method_type));
% 
% 
% %% Experiments
% 
% D_sets = dir('dataset_*.mat');
% T_sets = max(size(D_sets));
% 
% for n=1:T_sets
%     load(D_sets(n).name)
%     N = max(size(trajectories));
% 
%     for b=1:T_bal
%         %MC = zeros(N,N,T_d,T_rounds);
%         R = zeros(T_d,T_rounds);
%         Time = zeros(T_rounds);
%         for r=1:T_rounds
%             [test_samples,training_samples,test_count,training_count] = gen_round_rand_balance(trajectories,bal(b));
%             texto = ['(' set_str ')' 'Round:' num2str(r),'/',num2str(T_rounds),', bal = ' num2str(bal(b)),' (',num2str(b),'/',num2str(T_bal),').' ];
%             disp(texto)
%             tic
%             [R(:,r),~] = MD_actions(trajectories,test_samples,training_samples,dist_method_type);
%             Time(r)=toc;
%         end
%         
%         Rf = [mean(R,2) std(R,[],2) min(R,[],2) max(R,[],2)];
%         [~,idx] = max(Rf(:,1));
%         Tf = [mean(Time) std(Time) min(Time) max(Time)];
%         
%         Results(n,b) = struct('Method','MD','Dataset',set_str,'Best_R',Rf(idx,:),'Best_D',dist_method_type(idx),'R',Rf,'Time',Tf);
%     end
% 
% end
% 
% save Results_MD.mat
% 
% 
% 
% % load handel
% % sound(y,Fs)
% % pause(60)
% % disp('poweroff')
% % system('poweroff')
% 
% 
% 
% %EOF
% 
