clear all
close all
clc

% Path to database
data = '/home/israel/Documents/Datasets_actions/BMHAD/BerkeleyMHAD/Accelerometer';

% Total classes
N = 12;
Atores = 11;
Rep = 5;

% number_of_frames = 276.5863 +- 184.0253, (min/max 56/901), it is good to
% use 276+184. The rank of the sample, in general, is preserved. Preserving
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=100;

trajectories = [];
atores = [];
missing_files = [];
missing_count = 0;
for n=1:N;
    sample=0;
    sample_temp = [];
    for a=1:Atores
        for r=1:Rep
            
            for s=1:6
                filename{s} = strcat(data,'/Shimmer',num2str(s,'%02i'),'/acc_h',num2str(s,'%02i'),'_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            end
            
            if exist(filename{1},'file')
                fprintf('C) Generating sample %d for class %d.\n',sample,n)
                TempA = [];
                c = Inf;
                for s=1:6
                    TempA{s} = reshape(load(filename{s}),1,[],4);
                    c = min(size(TempA{s},2),c);
                end
                
                Temp = [TempA{1}(1,1:c,1:3); ...
                        TempA{2}(1,1:c,1:3); ...
                        TempA{3}(1,1:c,1:3); ...
                        TempA{4}(1,1:c,1:3); ...
                        TempA{5}(1,1:c,1:3); ...
                        TempA{6}(1,1:c,1:3)];
                
                temp_traj = zeros(6,tamanho_sinal,3);
                for j=1:6
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1));
                    end
                end
                
                temp_traj = tenmat(temp_traj,1);
                sample=sample+1;
                sample_temp = [sample_temp sample];
                trajectories{n}{sample} = temp_traj;
            else
                missing_count=missing_count+1;
                missing_files{missing_count} = filename;
            end

        end
        atores{a}{n} = sample_temp;
    end
end

trajectories_L = trajectories;
atores_L = atores;
cont_L = Atores*N*Rep-missing_count;

save dataset_L.mat trajectories_L atores_L cont_L


