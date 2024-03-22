%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.3. Adaptive Line Enhancer (ALE) Part c
%...............................................

clc
clear
close all
addpath('../Utils/');

%Initialization
w0 = 0.01 * pi;
sigma = 1;
N = 1000;
n = 1:N;
mu = 0.01;
epoch = 100;
delta = 3;
M = 10; % Order
fontsize = 14;
lineWidth = 2;
x = sin(w0 * n);

x_hat_sum_ALE = zeros(N,1);
x_hat_sum_ANC = zeros(N,1);
errors_avg= zeros(N,1);
PSEs_ALE = zeros(epoch, 1);
PSEs_ANC = zeros(epoch, 1);

for j = 1:epoch
    eta = randn(N,1);
    noise = filter([1,0,0.5], 1, eta);
    x_noise = x' + noise;
    [x_hat_ALE,~,errors] = fLMS_ALE(x_noise, mu, M, delta);
    x_hat_sum_ALE = x_hat_sum_ALE + x_hat_ALE;
    PSEs_ALE(j) = mean((x' - x_hat_ALE).^2);
    secondary_noise = 1.27*noise + 0.06;
    [~,x_hat_ANC,~] = fLMS_ANC(secondary_noise, x_noise, mu, M);
    x_hat_sum_ANC = x_hat_sum_ANC + x_hat_ANC;
    PSEs_ANC(j) = mean((x' - x_hat_ANC).^2);
end

x_hat_avg_ALE = x_hat_sum_ALE ./ epoch;
MPSE_ALE = mean(PSEs_ALE);
fprintf('MPSE_ALE = %.4f\n', MPSE_ALE);
x_hat_avg_ANC = x_hat_sum_ANC ./ epoch;
MPSE_ANC = mean(PSEs_ANC);
fprintf('MPSE_ANC = %.4f\n', MPSE_ANC);

hold on;
plot(x,'-b','LineWidth',lineWidth);
plot(x_hat_avg_ANC,'-g','LineWidth',lineWidth);
plot(x_hat_avg_ALE,'-r','LineWidth',lineWidth);
legend('Groudtruth','Estimation (ANC)','Estimation (ALE)','FontSize',fontsize, 'interpreter','latex','Location', 'southeast');
title(['Delay $\Delta$ = ' num2str(delta)], 'FontSize', fontsize, 'Interpreter', 'latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]); 
