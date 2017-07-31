clear all
close all
clc

A =[rand(10); rand(10)+10*abs(rand(10)); rand(10)-10*abs(rand(10))];
C = [ones(1,10) 2*ones(1,10) 3*ones(1,10)]';
Mdl = svmtrain(C,A,'-s 1 -n 0.1');
svmpredict(0,rand(1,10),Mdl)