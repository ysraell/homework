%  clear all
%  close all
%  clc

% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Accelerometer';

% Total classes
N = 11;
Atores = 12;
Rep = 5;

% number_of_frames = 231 +- 163.2, (min/max 26/941), it is good to
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=400;


trajectories = [];
atores = [];
missing_files = [];
missing_count = 0;
cont=0;
for n=1:N;
    sample=0;
    for a=1:Atores
        atores_temp = [];
        for r=1:Rep
            
            for s=1:6
                filename{s} = strcat(data,'/Shimmer',num2str(s,'%02i'),'/acc_h',num2str(s,'%02i'),'_s',num2str(a,'%02i'),'_a',num2str(n,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            end
            
            if exist(filename{1},'file')
                fprintf('I) Generating sample %d for class %d.\n',sample,n)
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
                cont=cont+1;
                Size(cont) = max(size(Temp));
                    
                temp_traj = zeros(6,tamanho_sinal,3);
                for j=1:6
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1));
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


set_str = 'I';

save -v7.3 dataset_I.mat trajectories atores cont set_str 


