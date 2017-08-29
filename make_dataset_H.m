%  clear all
%  close all
%  clc

% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/MSRA3D/MSRAction3D/MS2';

% Total classes
N = 20;
Atores = 10;
Rep = 3;



% number_of_frames = 39.7681 +- 10.0809, (min/max 20/76), it is good to
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=50;

trajectories = [];
atores = [];
missing_files = [];
missing_count = 0;
cont=0;
for n=1:N;
    sample=0;
    for a=1:Atores
        atores_temp =[];
        for r=1:Rep
            
            %filename = strcat(data,'/moc_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            filename = strcat(data,'/a',num2str(n,'%02i'),'_s',num2str(a,'%02i'),'_e',num2str(r,'%02i'),'_skeleton.txt');
            
            if exist(filename,'file')
                cont=cont+1;
                fprintf('H) Generating sample %d for class %d.\n',sample,n)
                
                Temp = load(filename);
                [l,c] = size(Temp);
                Temp = reshape(Temp,20,l/20,4);
                Temp = Temp(:,:,1:3);
                Size(cont) = max(size(Temp));
                
                temp_traj = zeros(20,tamanho_sinal,3);
                for j=1:20
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(j,:,i),tamanho_sinal-1));
                    end
                end

                sample=sample+1;
                atores_temp = [atores_temp sample];
                trajectories{n}{sample} = temp_traj;
            else
                missing_count=missing_count+1;
                missing_files{missing_count} = filename;
            end

        end
        atores{a}{n} = atores_temp;
    end
end

set_str = 'H';

save -v7.3 dataset_H.mat trajectories atores cont set_str


