clear all
close all
clc

% Path to database
data = 'data';

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
N=2;


% number_of_frames = 276.5863 +- 184.0253, (min/max 56/901), it is good to
% use 276+184. The rank of the sample, in general, is preserved. Preserving
% 90.41% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=460;


trajectories = [];
atores = [];

% all combinations possibles between joints, all exists angles.
x = 1:31;
k = 3;
X = combnk(x,k);
NX = max(size(X));
Y = zeros(NX,k,2);
NC= 2*NX;

for ni=1:NX
    Y(ni,:,1) = X(ni,:);
    Y(ni,:,2) = X(ni,[2 1 3]);
end

cont = 0;
for Ni=1:N
    sample=1;
    for ator=1:5
        atores_temp = [];
        take=1;
        filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take)','.amc.mat');
        while exist(filename,'file')
            tic;
            cont = cont+1;
            fprintf('c) Generating sample: %d of 249.\n',cont);
            load(filename);
            
            total_joints = NC;
            [total_coord,total_frames] = size(mot.jointTrajectories{1});
            
            t=size(mot.jointTrajectories{1},2);
            matriz_Ang=zeros(NC,t);
            for i=1:t
                w=0;
                for ni=1:NX
                    for ci=1:2
                        w=w+1;
                        p = Y(ni,:,ci);
                        matriz_Ang(w,i)=angulo([mot.jointTrajectories{p(1)}(1,i)...
                                                mot.jointTrajectories{p(1)}(2,i)...
                                                mot.jointTrajectories{p(1)}(3,i)],[...
                                                mot.jointTrajectories{p(2)}(1,i)...
                                                mot.jointTrajectories{p(2)}(2,i)...
                                                mot.jointTrajectories{p(2)}(3,i)],[...
                                                mot.jointTrajectories{p(3)}(1,i)...
                                                mot.jointTrajectories{p(3)}(2,i)...
                                                mot.jointTrajectories{p(3)}(3,i)]); 
                    end
                end
            end
            
            temp = zeros(total_joints,tamanho_sinal);
            for joint=1:total_joints
                temp(joint,:) = interpolar(matriz_Ang(joint,:),tamanho_sinal-1);
            end
            trajectories{Ni}{sample} = normalizar(temp);
              
            
            atores_temp = [atores_temp sample];
            clear mot skel
            take = take+1;
            sample = sample+1;
            filename = strcat(data,'/',path{Ni},'/HDM_',num2str(ator),'_',num2str(take),'.amc.mat');
            time(cont)=toc;
            break
        end
        atores{ator}{Ni} = atores_temp;
    end
end

trajectories_C = trajectories;
atores_C = atores;
cont_C = cont;

save dataset_C.mat trajectories_C atores_C time cont_C

