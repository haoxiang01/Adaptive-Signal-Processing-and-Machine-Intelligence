%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.1. Complex LMS and Widely Linear Modelling Part a
%...............................................

clc
clear
close all
addpath('../Utils/');
fontsize = 20;
lineWidth = 1.5;

%% Initialization
mu = 0.01;
b1 = 1.5 + 1i;
b2 = 2.5 - 0.5i;
epoch = 100;
N = 1000; % numSamples
M = 1; % order of filter

%% CLMS 
errors_CLMS = zeros(1,N);
errors_ACLMS = zeros(1,N);
for i = 1:epoch
    x = sqrt(1/2) * (randn(N+1,1) + 1i * randn(N+1,1));
    y = zeros(N+1,1);
    for n = 2:N+1
        y(n) = x(n) + b1 * x(n-1) + b2 * x(n-1)';
    end
    [error_CLMS,~] = fCLMS(x, y, M, mu);
    [error_ACLMS,~] = fACLMS(x, y, M, mu);
    errors_CLMS = errors_CLMS + abs(error_CLMS).^2;
    errors_ACLMS = errors_ACLMS + abs(error_ACLMS).^2;
end
errors_CLMS_avg = errors_CLMS ./ epoch;
errors_ACLMS_avg = errors_ACLMS ./ epoch;
errors_CLMS = pow2db(errors_CLMS);
errors_ACLMS = pow2db(errors_ACLMS);

%% plotting
figure;

plot(errors_ACLMS_avg,'-b','LineWidth',lineWidth);
hold on
plot(errors_CLMS_avg,'-r','LineWidth',lineWidth);
grid on;
set(gca, 'FontSize', 12);
xlabel('Step $n$','FontSize',fontsize,'interpreter','latex');
ylabel('MPSE ($dB$)','FontSize',fontsize,'interpreter','latex');
legend('ACLMS','CLMS','FontSize',fontsize,'interpreter','latex');
title('Learning Curve','FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);