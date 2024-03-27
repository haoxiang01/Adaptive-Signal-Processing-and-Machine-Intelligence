%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.1. Complex LMS and Widely Linear Modelling Part e unbalanced
%...............................................
clc
clear
close all
addpath('../Utils/');

%% Initilization
fontsize = 20;
lineWidth = 2;
opt = 'o';
opt_size = 60;
N = 1e3;
fs = 1e3; % sampling frequency
f0 = 50;  % system frequency
phi = 0; % phase
n = 1:N;

%% Unbalanced
Vmag = [1 2 4];
Dmag = [0, 0.3, 0.6];
V = Vmag.*ones(1,3);
Delta = Dmag.*ones(1,3);
V_complex = fClarke(V, Delta, f0, fs, phi, N);

%CLMS
mu = 0.002;
M = 1;
[~,h_balance] = fCLMS(V_complex, V_complex, M, mu);
f0_estimated = fs/(2*pi) * atan(imag(h_balance) ./ real(h_balance));
plot(abs(f0_estimated),'-r','LineWidth', lineWidth);
hold on;
grid on;
%ACLMS
[~,h_balance,g_balance] = fACLMS(V_complex, V_complex, M, mu);
f0_estimated = fs/(2*pi) * atan(sqrt(imag(h_balance).^2 - abs(g_balance).^2 ) ./ real(h_balance));
plot(real(f0_estimated),'-b','LineWidth', lineWidth);
set(gca, 'FontSize', 12);
legend('CLMS','ACLMS','FontSize',fontsize,'interpreter','latex');
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('Estimated Frequency $f_o$ (Hz)','FontSize',fontsize,'interpreter','latex');
title('UnBalanced','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);
