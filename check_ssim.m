clear all
close all
clc

Dim = 2;
A = 100.*rand(Dim);
B = rand(Dim);

x = 0.1.*[eps:0.01:1]';
T_x = max(size(x));
y = zeros(T_x,4);
for xi=1:T_x
%     y(xi,1) =  -ssim(A,A+x(xi).*B);
%     y(xi,2) =  1/(-y(xi,1));
%     y(xi,3) =  exp(y(xi,1));
%     y(xi,4) =  exp(y(xi,2));
    y(xi,1) =  -ssim(A,A+x(xi).*B);
    y(xi,2) =  -1/(1+y(xi,1));
    y(xi,3) = DIST_method(A,A+x(xi).*B,5);
end

fig=0;

fig=1+fig;
figure(fig)
title('SSIM(A,A+x*rand)')
plot(x,y)
% legend('-SSIM','1/SSIM','exp(-SSIM)','exp(1/SSIM)')
legend('-SSIM','-1/(1-SSIM)')
xlabel('x')
ylabel('y')
grid