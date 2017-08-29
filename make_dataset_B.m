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

% number_of_frames = 200, like other authors
tamanho_sinal=200;


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
            fprintf('B) Generating sample: %d of 249.\n',cont)
            load(filename);
            
            total_joints = 15;
            [total_coord,total_frames] = size(mot.jointTrajectories{1});
            
            t=size(mot.jointTrajectories{1},2);
            matriz_Ang=[];
            for i=1:t

                a=1; b=2; c=7;
                matriz_Ang(1,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

                a=2; b=1; c=3;
                matriz_Ang(2,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=7; b=1; c=8;
                matriz_Ang(3,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=3; b=2; c=4;
                matriz_Ang(4,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=8; b=7; c=9;
                matriz_Ang(5,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=4; b=3; c=6;
                matriz_Ang(6,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=9; b=8; c=11;
                matriz_Ang(7,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=14; b=16; c=25;
                matriz_Ang(8,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=16; b=14; c=17;
                matriz_Ang(9,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]); 

                a=18; b=19; c=14;
                matriz_Ang(10,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=25; b=26; c=14;
                matriz_Ang(11,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=19; b=18; c=21;
                matriz_Ang(12,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=26; b=25; c=28;
                matriz_Ang(13,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=21; b=19; c=23;
                matriz_Ang(14,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);

                a=28; b=26; c=30;
                matriz_Ang(15,i)=angulo([mot.jointTrajectories{a}(1,i) mot.jointTrajectories{a}(2,i) mot.jointTrajectories{a}(3,i)],[mot.jointTrajectories{b}(1,i) mot.jointTrajectories{b}(2,i) mot.jointTrajectories{b}(3,i)],[mot.jointTrajectories{c}(1,i) mot.jointTrajectories{c}(2,i) mot.jointTrajectories{c}(3,i)]);


            end % fim i
            
            temp = zeros(total_joints,tamanho_sinal);
            for joint=1:total_joints
                temp(joint,:) = interpolar(matriz_Ang(joint,:),tamanho_sinal-1);
            end
            trajectories{Ni}{sample} = normalizar(temp);
              
            
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

set_str = 'B';

save -v7.3 dataset_B.mat trajectories atores cont set_str

