clear all
close all
clc

% Path to database
data = '/home/israel/Documents/Datasets_actions/MSRA3D/MSRAction3D/MS3';

% Total classes
N = 20;
Atores = 10;
Rep = 3;



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
            
            %filename = strcat(data,'/moc_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            filename = strcat(data,'/a',num2str(n,'%02i'),'_s',num2str(a,'%02i'),'_e',num2str(r,'%02i'),'_skeleton3D.txt');
            
            if exist(filename,'file')
                fprintf('Generating sample %d for class %d.\n',sample,n)
                
                Temp = load(filename);
                [l,c] = size(Temp);
                Temp = reshape(Temp,20,l/20,4);
                Temp = Temp(:,:,1:3);
                
                temp_traj = zeros(20,tamanho_sinal,3);
                for j=1:20
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(j,:,i),tamanho_sinal-1));
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

trajectories_G = trajectories;
atores_G = atores;
cont_G = Atores*N*Rep-missing_count;

save dataset_G.mat trajectories_G atores_G cont_G


