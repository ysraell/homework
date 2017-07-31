%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mex -I/usr/include/eigen3 test_eigen.cpp

clear all
close all
clc

N = 30;
M = 200;
P = 3;
R = 100;

dist_method_type = 'so';
T_d = max(size(dist_method_type));
time = zeros(T_d,R);
dist = zeros(T_d,R);
for r = 1:R
%     A = abs(randn(N,M,P));
    A = ones(N,M,P);
    B = A+0.05*r.*randn(N,M,P); 
    for d=1:T_d
        tstart = tic; 
        dist(d,r) = DIST_method(A,B,dist_method_type(d));
        time(d,r) = toc(tstart);
    end
end

