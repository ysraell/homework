clear all
close all
clc


run make_datasets.m
run make_rounds.m
run make_comps.m

pause(60)
disp('poweroff')
system('poweroff')