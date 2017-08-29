%  clear all
%  close all
%  clc

%i=0; for a in `cat list |grep bend`; do let "i+=1";  echo "trajectories{}{$i} = $a;"; done
file = '/home/israel/Documents/actions_app/Datasets_actions/ASTS/classification_masks.mat';
load(file)

trajectories{1}{1} = aligned_masks.daria_bend;
trajectories{1}{2} = aligned_masks.denis_bend;
trajectories{1}{3} = aligned_masks.eli_bend;
trajectories{1}{4} = aligned_masks.ido_bend;
trajectories{1}{5} = aligned_masks.ira_bend;
trajectories{1}{6} = aligned_masks.lena_bend;
trajectories{1}{7} = aligned_masks.lyova_bend;
trajectories{1}{8} = aligned_masks.moshe_bend;
trajectories{1}{9} = aligned_masks.shahar_bend;

trajectories{2}{1} = aligned_masks.daria_jack;
trajectories{2}{2} = aligned_masks.denis_jack;
trajectories{2}{3} = aligned_masks.eli_jack;
trajectories{2}{4} = aligned_masks.ido_jack;
trajectories{2}{5} = aligned_masks.ira_jack;
trajectories{2}{6} = aligned_masks.lena_jack;
trajectories{2}{7} = aligned_masks.lyova_jack;
trajectories{2}{8} = aligned_masks.moshe_jack;
trajectories{2}{9} = aligned_masks.shahar_jack;

trajectories{3}{1} = aligned_masks.daria_jump;
trajectories{3}{2} = aligned_masks.denis_jump;
trajectories{3}{3} = aligned_masks.eli_jump;
trajectories{3}{4} = aligned_masks.ido_jump;
trajectories{3}{5} = aligned_masks.ira_jump;
trajectories{3}{6} = aligned_masks.lena_jump;
trajectories{3}{7} = aligned_masks.lyova_jump;
trajectories{3}{8} = aligned_masks.moshe_jump;
trajectories{3}{9} = aligned_masks.shahar_jump;

trajectories{4}{1} = aligned_masks.daria_pjump;
trajectories{4}{2} = aligned_masks.denis_pjump;
trajectories{4}{3} = aligned_masks.eli_pjump;
trajectories{4}{4} = aligned_masks.ido_pjump;
trajectories{4}{5} = aligned_masks.ira_pjump;
trajectories{4}{6} = aligned_masks.lena_pjump;
trajectories{4}{7} = aligned_masks.lyova_pjump;
trajectories{4}{8} = aligned_masks.moshe_pjump;
trajectories{4}{9} = aligned_masks.shahar_pjump;

trajectories{5}{1} = aligned_masks.daria_run;
trajectories{5}{2} = aligned_masks.denis_run;
trajectories{5}{3} = aligned_masks.eli_run;
trajectories{5}{4} = aligned_masks.ido_run;
trajectories{5}{5} = aligned_masks.ira_run;
trajectories{5}{6} = aligned_masks.lena_run1;
trajectories{5}{7} = aligned_masks.lyova_run;
trajectories{5}{8} = aligned_masks.moshe_run;
trajectories{5}{9} = aligned_masks.shahar_run;
%trajectories{5}{10} = aligned_masks.lena_run2;

trajectories{6}{1} = aligned_masks.daria_side;
trajectories{6}{2} = aligned_masks.denis_side;
trajectories{6}{3} = aligned_masks.eli_side;
trajectories{6}{4} = aligned_masks.ido_side;
trajectories{6}{5} = aligned_masks.ira_side;
trajectories{6}{6} = aligned_masks.lena_side;
trajectories{6}{7} = aligned_masks.lyova_side;
trajectories{6}{8} = aligned_masks.moshe_side;
trajectories{6}{9} = aligned_masks.shahar_side;

trajectories{7}{1} = aligned_masks.daria_skip;
trajectories{7}{2} = aligned_masks.denis_skip;
trajectories{7}{3} = aligned_masks.eli_skip;
trajectories{7}{4} = aligned_masks.ido_skip;
trajectories{7}{5} = aligned_masks.ira_skip;
trajectories{7}{6} = aligned_masks.lena_skip1;
trajectories{7}{7} = aligned_masks.lyova_skip;
trajectories{7}{8} = aligned_masks.moshe_skip;
trajectories{7}{9} = aligned_masks.shahar_skip;
%trajectories{7}{10} = aligned_masks.lena_skip2;

trajectories{8}{1} = aligned_masks.daria_walk;
trajectories{8}{2} = aligned_masks.denis_walk;
trajectories{8}{3} = aligned_masks.eli_walk;
trajectories{8}{4} = aligned_masks.ido_walk;
trajectories{8}{5} = aligned_masks.ira_walk;
trajectories{8}{6} = aligned_masks.lena_walk1;
trajectories{8}{7} = aligned_masks.lyova_walk;
trajectories{8}{8} = aligned_masks.moshe_walk;
trajectories{8}{9} = aligned_masks.shahar_walk;
%trajectories{8}{10} = aligned_masks.lena_walk2;

trajectories{9}{1} = aligned_masks.daria_wave1;
trajectories{9}{2} = aligned_masks.denis_wave1;
trajectories{9}{3} = aligned_masks.eli_wave1;
trajectories{9}{4} = aligned_masks.ido_wave1;
trajectories{9}{5} = aligned_masks.ira_wave1;
trajectories{9}{6} = aligned_masks.lena_wave1;
trajectories{9}{7} = aligned_masks.lyova_wave1;
trajectories{9}{8} = aligned_masks.moshe_wave1;
trajectories{9}{9} = aligned_masks.shahar_wave1;

trajectories{10}{1} = aligned_masks.daria_wave2;
trajectories{10}{2} = aligned_masks.denis_wave2;
trajectories{10}{3} = aligned_masks.eli_wave2;
trajectories{10}{4} = aligned_masks.ido_wave2;
trajectories{10}{5} = aligned_masks.ira_wave2;
trajectories{10}{6} = aligned_masks.lena_wave2;
trajectories{10}{7} = aligned_masks.lyova_wave2;
trajectories{10}{8} = aligned_masks.moshe_wave2;
trajectories{10}{9} = aligned_masks.shahar_wave2;


% S =zeros(3,90);
% s=0;
% for n=1:10
%     for a=1:9
%         atores{a}{n} = a;
%         s=s+1;
%         [S(1,s),S(2,s),S(3,s)] = size(trajectories{n}{a});
%     end
% end
% [mean(S,2) std(S,[],2) min(S,[],2) max(S,[],2)]
% 
%   114.2667    5.6126  103.0000  129.0000
%    77.1778   10.1257   59.0000  103.0000
%    61.4667   21.9331   28.0000  146.0000

nx=120;
ny=90;
nz=85; %% desired output dimensions

% [X,Y,Z] = meshgrid(1:nx,1:ny,1:nz);

for n=1:10
    for a=1:9
        atores{a}{n} = a;
        trajectories{n}{a} = resize(sum(double(trajectories{n}{a}),3),[nx ny],'linear');
%         close all
%         figure;
%         subplot(1,2,1)       
%         imagesc(sum(double(trajectories{n}{a}),3))
%         subplot(1,2,2)                   
%         imagesc(sum(Temp,3))
%         pause
        
    end
end


cont = 90;
set_str = 'K';

save -v7.3 dataset_K.mat trajectories atores cont set_str 


