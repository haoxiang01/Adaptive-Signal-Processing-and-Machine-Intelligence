%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for Task 4.2.and 4.3
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

%LMS with tanh

M = 4;
mu = 1e-5;
task = 3; %adjust here to switch task2 and task3 

if task == 2
    [y_hat,~,errors] = fLMS_Learning(y, mu, M, 'tanh');% Task2
else
    a = 80; %scaling factor
    [y_hat,~,errors] = fLMS_Learning(y, mu, M, 'tanh', a);% Task3
end

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
legend('Groundtruth signal $y(n)$','Estimated signal $\hat{y}(n)$','FontSize', fontsize-2,'Interpreter','latex');
ylim([-50,50]);
set(gcf, 'Position', [100, 100, 800, 600]);