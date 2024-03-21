%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.2 Adaptive Step Sizes Part a
%...............................................

clc
clear
close all
addpath('../Utils/');

M = 1;
numSteps = 2001;
mu = 0.01;
rho = 0.0003;
K = 100;
w_B_Avg = zeros(M, numSteps+1);% Benveniste's method
w_F_Avg = zeros(M, numSteps+1);% Farhang's method
w_M_Avg = zeros(M, numSteps+1);% Matthews's method
w_N_Avg = zeros(M, numSteps+1);% Standard method mu = 0.01
w_N_Avg_Altered = zeros(M, numSteps+1);% Standard method mu = 0.1

for k = 1:K

    % MA(1) process
    x = zeros(numSteps,1);
    eta = sqrt(1/2) * randn(numSteps,1);
    for i = 2:numSteps
        x(i) = 0.9*eta(i-1) + eta(i);   
    end
    
    % Benveniste's method
    [w_B] = fLMS_GASS_MA1(x, eta, 'B', mu, rho, M);  
    w_B_Avg = w_B_Avg + w_B;

    % Farhang's method
    [w_F] = fLMS_GASS_MA1(x, eta, 'F', mu, rho, M);  
    w_F_Avg = w_F_Avg + w_F;

    % Matthews's method
    [w_M] = fLMS_GASS_MA1(x, eta, 'M', mu, rho, M);  
    w_M_Avg = w_M_Avg + w_M;

    % Standard method mu = 0.01
    [w_N] = fLMS_GASS_MA1(x, eta, 'N', mu, rho, M);  
    w_N_Avg = w_N_Avg + w_N;

    % Standard method mu = 0.1
    [w_N_Altered] = fLMS_GASS_MA1(x, eta, 'N', 0.1, rho, M);  
    w_N_Avg_Altered = w_N_Avg_Altered + w_N_Altered;
end

w_B_Avg = w_B_Avg / K;
w_F_Avg = w_F_Avg / K;
w_M_Avg = w_M_Avg / K;
w_N_Avg = w_N_Avg / K;
w_N_Avg_Altered = w_N_Avg_Altered / K;

figure;
fontsize = 14;
lineWidth = 2;
plot(0.9 - w_N_Avg(1,:), '-b', 'LineWidth', lineWidth);
hold on;
plot(0.9 - w_N_Avg_Altered(1,:), '-g', 'LineWidth', lineWidth);
plot(0.9 - w_M_Avg(1,:), '-r', 'LineWidth', lineWidth);
plot(0.9 - w_F_Avg(1,:), '-c', 'LineWidth', lineWidth);
plot(0.9 - w_B_Avg(1,:), '-m', 'LineWidth', lineWidth);

grid on;
xlim([0, 2000]);
legend(['Standard LMS, $\mu=' num2str(mu) '$'], ...
       ['Standard LMS, $\mu=0.1$'], ...
       ['Matthews, $\mu(0)=' num2str(mu) '$'], ...
       ['Ang \& Farhang, $\mu(0)=' num2str(mu) '$'], ...
       ['Benveniste, $\mu(0)=' num2str(mu) '$'], ...
       'FontSize', fontsize, 'interpreter', 'latex', 'Location', 'best');
xlabel('Step $n$', 'FontSize', fontsize, 'interpreter', 'latex');
ylabel('Weight Error $w_o - w(n)$', 'FontSize', fontsize, 'interpreter', 'latex');
title('Comparison of LMS Algorithm within GASS Variants', 'FontSize', fontsize+1, 'interpreter', 'latex');

set(gcf, 'Position', [100, 100, 800, 600]); 