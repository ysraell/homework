clear all
close all
clc

% Path to database
data = 'data_BMHAD';

% Total classes
N = 12;
Atores = 11;
Rep = 5;

% number_of_frames = 276.5863 +- 184.0253, (min/max 56/901), it is good to
% use 276+184. The rank of the sample, in general, is preserved. Preserving
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=460;

trajectories = [];
atores = [];
missing_files = [];
missing_count = 0;
for n=1:N;
    sample=0;
    sample_temp = [];
    for a=1:Atores
        for r=1:Rep
            
            filename = strcat(data,'/moc_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            
            if exist(filename,'file')
                fprintf('C) Generating sample %d for class %d.\n',sample,n)
                Temp = load(filename);
                Temp = Temp(:,1:end-2);
                temp_traj = zeros(43,tamanho_sinal,3);
                for j=1:43
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1));
                    end
                end

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

trajectories_D = trajectories;
atores_D = atores;
cont_D = Atores*N*Rep-missing_count;

save dataset_D.mat trajectories_D atores_D cont_D


