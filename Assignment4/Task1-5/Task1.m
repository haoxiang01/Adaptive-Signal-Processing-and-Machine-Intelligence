%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for Task 4.1.
%...............................................

clc
clear
close all
addpath('../Utils/');
addpath('../Data/');
fontsize = 20;
lineWidth = 1.5;

load time-series.mat

% remove mean
y = y - mean(y); 

%LMS
M = 4;
mu = 1e-5;

[y_hat,~,errors] = fLMS_Learning(y, mu, M);

MSE = mean(errors .^2 );
Rp = pow2db(var(y_hat) ./ var(errors)); %prediction gain
fprintf('MSE is %.3f \n',MSE);
fprintf('Prediction gain is %.3f \n',Rp);

figure;
plot(y,'-b','LineWidth', lineWidth);
hold on;
plot(y_hat,'-r','LineWidth', lineWidth);
set(gca, 'FontSize', 12);
grid on;
ylabel('Magnitude','FontSize',fontsize,'interpreter','latex');
xlabel('Sample $n$','FontSize',fontsize,'interpreter','latex');
legend('Groundtruth signal $y(n)$','Estimated signal $\hat{y}(n)$','FontSize', fontsize,'Interpreter','latex');
ylim([-50,50]);
set(gcf, 'Position', [100, 100, 800, 600]);
