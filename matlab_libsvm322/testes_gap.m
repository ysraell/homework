clear all
close all
clc

p=30; %variables
n=3; % n*3 = observations
A =[rand(n,p); rand(n,p)+10*abs(rand(n,p)); rand(n,p)-10*abs(rand(n,p))];
C = [ones(1,n) 2*ones(1,n) 3*ones(1,n)]';

options.B = 5;
options.Dist = 'norm';
options.MaxK = size(A',2);
options.MinK = 3;
options.Tries = 8;

[Ck,Ak] =  gap(A',options);

X=A';
varargin = options;

Ck=Ck';
Ak=Ak';
N=100;
T = randn(N,p);

idx=zeros(N,1);
for i=1:N
    akp = size(Ak,1);
    [~,idxk] = min(sum((Ak-repmat(T(i,:),akp,1)).^2,2));
    idx(i) = round(harmmean(C(Ck==idxk)));
end

%eof