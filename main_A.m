%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% All experiments with dataset A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





close all
clear all
clc
w = warning ('off','all');

load dataset_A
trajectories = trajectories_A;
atores = atores_A;

%% For all experiments

% n =  norm-2, f = forb norm and s = SSIM index.
dist_method_type = 'nfs';

% balance of samples for test: bal*Total_samples for each classe for test
% and (1-bal)*Total_samples for trainning.
bal = [0.5 0.7];

% optimal parameters:
dim_opt_proj = 3; % using all dimensions possible (max 3)
r = 1; % choose the principal components until 'Dim' representativite.
Dim = 1-eps*10.^6;  % almost 1, but not 1!

% Only for MSD basead methods:
% The zeta parameter: [V,L] = eig(zeta.*Sb - Sw)
% -1 -> zeta = max(eig(Sb/Sw)) 
% -2 -> zeta = max(eig(Sb))
% -3 -> zeta = max(eig(Sw))
% a > 0 -> zeta = a;
zeta = [-3 -3 -3];

%% Iterative methods, optimal parameters

T_max = 3; % max iterations in training step
tolerancia = 0; % 0 for no tolerance specified

%% Experiment random samples, mix actors

T_rounds = 2;

%% Choose the methods

Methods{1} = 'MDA';
Methods{2} = 'MSD';
Methods{3} = 'DMDA';
Methods{4} = 'DMSD';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To make the training and step process and generate the recognition data
% performance for the experiments:
%
% Experiment with random samples.
%-------------------------------------------------------------------------
run experiment_rand.m
%-------------------------------------------------------------------------
%
% Experiment with authors saparation.
%-------------------------------------------------------------------------
% run experiment_authors.m
%-------------------------------------------------------------------------
%
% Experiment comparable (this is part of the previus experiment).
%-------------------------------------------------------------------------
% run experiment_comp.m
%-------------------------------------------------------------------------
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save results_A.mat


