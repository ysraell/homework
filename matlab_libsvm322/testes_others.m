clear all
close all
clc

p=30;
n=3;
A =[rand(n,p); rand(n,p)+10*abs(rand(n,p)); rand(n,p)-10*abs(rand(n,p))];
C = [ones(1,n) 2*ones(1,n) 3*ones(1,n)]';


% Mdl = svmtrain(C,A,'-s 1 -n 0.1');
% svmpredict(0,rand(1,10),Mdl)

% Mdl = fitcknn(A,C);
% Mdl = fitNaiveBayes(A,C,'Distribution','kernel');
% Mdl = TreeBagger(8,A,C);
% fitcnb 
% Mdl = fitlm(A,C);
% Mdl = fitctree(A,C);
% predict(Mdl,rand(1,10),'HandleMissing','on')
% a = str2num(cell2mat(predict(Mdl,100*rand(1,2)+10)))
%       Model = fitNaiveBayes(Y,C);
%       Model = fitlm(Y,C);

% [Ck,Ak] = kmeanspp(A',3)
% [Ck,Ak] = kmeans(A,3)

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
