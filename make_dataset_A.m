% clear all
% close all
% clc

% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/HDM05';

% Path to data for each class
path{1} = 'throwBasketball';
path{2} = 'elbowToKnee1RepsLelbowStart';
path{3} = 'grabHighR';
path{4} = 'hopBothLegs1hops';
path{5} = 'jogLeftCircle4StepsRstart';
path{6} = 'kickLFront1Reps';
path{7} = 'lieDownFloor';
path{8} = 'rotateArmsBothBackward1Reps';
path{9} = 'sneak2StepsLStart';
path{10} = 'squat3Reps';
path{11} = 'depositFloorR';

% Total classes
N = max(size(path));

% number_of_frames = 276.5863 +- 184.0253, (min/max 56/901), it is good to
% use 276+184. The rank of the sample, in general, is preserved. Preserving
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=460;

trajectories = [];
atores = [];

cont = 0;
for Ni=1:N
    sample=1;
    for ator=1:5
        atores_temp = [];
        take=1;
        filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take)','.amc.mat');
        while exist(filename,'file')
            cont = cont+1;
            fprintf('A) Generating sample: %d of 249.\n',cont)
            load(filename);
            
            total_joints = max(size(mot.jointTrajectories));
            [total_coord,total_frames] = size(mot.jointTrajectories{1});
            
            temp = zeros(total_joints,tamanho_sinal,total_coord);
            for coord = 1:total_coord
                for joint=1:total_joints
%                     figure;
%                     plot(mot.jointTrajectories{joint}(coord,:))
                    temp(joint,:,coord) = interpolar(mot.jointTrajectories{joint}(coord,:),tamanho_sinal-1);
%                     figure;
%                     plot(temp(joint,:,coord))
%                     pause
                end
                temp(:,:,coord) = normalizar(temp(:,:,coord));
            end
            
            trajectories{Ni}{sample} = temp;           
            
            atores_temp = [atores_temp sample];
            clear mot skel
%             disp(filename)
            take = take+1;
            sample = sample+1;
            filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take),'.amc.mat');
        end
        atores{ator}{Ni} = atores_temp;
    end
end


set_str = 'A';

save -v7.3 dataset_A.mat trajectories atores cont set_str


%EOF

