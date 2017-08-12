% clear all
% close all
% clc

% Path to database
data = '/home/israel/Documents/actions_app/Datasets_actions/BMHAD/BerkeleyMHAD/Mocap/OpticalData';

% Total classes
N = 12;
Atores = 11;
Rep = 5;

% number_of_frames = 3602.91 -+2510.94, (min/max 774/14567), it is good to
% 90.17% of the total frames. (using sum((x<461).*x+(x>460).*460)/sum(x)).
tamanho_sinal=6100;


trajectories = [];
atores = [];
missing_Eiles = [];
missing_count = 0;
for n=1:N;
    sample=0;
    sample_temp = [];
    for a=1:Atores
        atores_temp = [];
        for r=1:Rep
            
            filename = strcat(data,'/moc_s',num2str(n,'%02i'),'_a',num2str(a,'%02i'),'_r',num2str(r,'%02i'),'.txt');
            
            if exist(filename,'file')
                fprintf('E) Generating sample %d for class %d.\n',sample,n)
                Temp = load(filename);
                Temp = Temp(:,1:end-2);
                temp_traj = zeros(43,tamanho_sinal,3);
                for j=1:43
                    for i=1:3
                        temp_traj(j,:,i) = normalizar(interpolar(Temp(:,(j*3-(3-i)))',tamanho_sinal-1));
                    end
                end
                
            matriz_Ang=zeros(15,tamanho_sinal);
            for i=1:tamanho_sinal

                a=1; b=2; c=7;
                matriz_Ang(1,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]); 

                a=2; b=1; c=3;
                matriz_Ang(2,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=7; b=1; c=8;
                matriz_Ang(3,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=3; b=2; c=4;
                matriz_Ang(4,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=8; b=7; c=9;
                matriz_Ang(5,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=4; b=3; c=6;
                matriz_Ang(6,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=9; b=8; c=11;
                matriz_Ang(7,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=14; b=16; c=25;
                matriz_Ang(8,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=16; b=14; c=17;
                matriz_Ang(9,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]); 

                a=18; b=19; c=14;
                matriz_Ang(10,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=25; b=26; c=14;
                matriz_Ang(11,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=19; b=18; c=21;
                matriz_Ang(12,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=26; b=25; c=28;
                matriz_Ang(13,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=21; b=19; c=23;
                matriz_Ang(14,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

                a=28; b=26; c=30;
                matriz_Ang(15,i)=angulo([temp_traj(a,i,1) temp_traj(a,i,2) temp_traj(a,i,3)],[temp_traj(b,i,1) temp_traj(b,i,2) temp_traj(b,i,3)],[temp_traj(c,i,1) temp_traj(c,i,2) temp_traj(c,i,3)]);

            end % fim i

                sample=sample+1;
                sample_temp = [sample_temp sample];
                atores_temp = [atores_temp sample];
                trajectories{n}{sample} = matriz_Ang;
            else
                missing_count=missing_count+1;
                missing_Eiles{missing_count} = filename;
            end

        end
        atores{a}{n} = atores_temp;
    end
end


set_str = 'D';

save dataset_D.mat trajectories atores cont set_str


