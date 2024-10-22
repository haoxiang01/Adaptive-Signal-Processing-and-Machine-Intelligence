%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.2 Adaptive Step Sizes Part c
%..............................................
clc
clear
close all
addpath('../Utils/');

fontsize = 23;
lineWidth = 2;
M = 1;
num = 2001;
rho = 0.005;
K = 100;
mu = 0.01; % adjust here
w_GNGD_Avg = zeros(M, num+1);
w_B_Avg = zeros(M, num+1);
e_GNGD_Avg = zeros(M, num);
e_B_Avg = zeros(M, num);

for k = 1:K
    % MA(1) process
    x = zeros(num,1);
    eta = sqrt(1/2) * randn(num,1);
    for i = 2:num
        x(i) = 0.9*eta(i-1) + eta(i);   
    end

    [w_GNGD,e_GNGD] = fLMS_GNGD_MA1(x, eta, mu, rho, M);
    w_GNGD_Avg = w_GNGD_Avg + w_GNGD;
    e_GNGD_Avg = e_GNGD_Avg + 10*log10(e_GNGD.^2);
    
    [w_B,e_B] = fLMS_GASS_MA1(x, eta, 'B', mu, rho, M);
    w_B_Avg = w_B_Avg +  w_B;   
    e_B_Avg = e_B_Avg + 10*log10(e_B.^2);
end

w_B_Avg = w_B_Avg ./K;
w_GNGD_Avg = w_GNGD_Avg ./K;

e_B_Avg = e_B_Avg ./K;
e_GNGD_Avg = e_GNGD_Avg ./K;


% Plotting
figure; 
plot(w_GNGD_Avg(1,:), '-b', 'LineWidth', lineWidth);
hold on;
plot(w_B_Avg(1,:), '-r', 'LineWidth', lineWidth);
set(gca, 'FontSize', 18);
grid on; 
xlim([0, 2000]); 

% Legend
legend(['GNGD $\mu$ = ' num2str(mu)], ['Benveniste $\mu$(0) = ' num2str(mu)], ...
       'FontSize', fontsize, 'interpreter', 'latex', 'Location', 'southeast');

xlabel('Step $n$', 'FontSize', fontsize, 'interpreter', 'latex');
ylabel('Estimated Weight $w(n)$', 'FontSize', fontsize, 'interpreter', 'latex');
title(['Weight Estimation ($\mu$ = ' num2str(mu) ', $\rho$ = ' num2str(rho) ')'],'FontSize',fontsize, 'interpreter', 'latex');
set(gcf, 'Position', [100, 100, 800, 600]); 
xlim([0,200])
% ylim([-0.2,1.0])

