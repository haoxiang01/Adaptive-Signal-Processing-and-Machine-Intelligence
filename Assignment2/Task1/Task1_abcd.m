%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.1. The Least Mean Square (LMS) Algorithm Part abcd
%...............................................

clc
clear
close all
addpath('../Utils/');

%% Initialization
a = [0.1 0.8];
sigma = 0.25;
N = 1000;
mu = [0.05 0.01];
epoch = 100;
order = length(a);
linewidth = 0.1; 
FontSize = 16;
%% AR model
model = arima('AR',a,'Constant',0,'Variance',sigma);
x = simulate(model, N,'Numpaths',100);

%% MSE
errors_1 = zeros(epoch,N-2);
weights_1 = zeros(order,1);
for i = 1:epoch
   x_AR = x(:,i);
   [errors_1(i,:),weights] = fLMS(x_AR, order, mu(1), 0);
   weights_1 = weights_1 + mean(weights(:,400:end),2);
end
set(gca, 'FontSize', 16);
error_average_1 = mean(pow2db(errors_1.^2),1);
subplot(2,2,1);
plot(pow2db(errors_1(1,:).^2),'-b','LineWidth',linewidth);
xlabel('Time','FontSize',FontSize,'interpreter','latex');ylabel('Squared Error (dB)','FontSize',FontSize,'interpreter','latex');
title('Single Realisation ($\mu$ = 0.05)','FontSize',FontSize,'interpreter','latex');
subplot(2,2,3);
plot(error_average_1,'-b','LineWidth',linewidth);
xlabel('Time','FontSize',FontSize,'interpreter','latex');ylabel('MSE (dB)','FontSize',FontSize,'interpreter','latex');
title('100 Realisations ($\mu$ = 0.05)','FontSize',FontSize,'interpreter','latex');

errors_2 = zeros(epoch,N-2);
weights_2 = zeros(order,1);
for i = 1:epoch
   x_AR = x(:,i);
   [errors_2(i,:),weights] = fLMS(x_AR, order, mu(2), 0);
   weights_2 = weights_2 + mean(weights(:,400:end),2);
end
error_average_2 = mean(pow2db(errors_2.^2),1);
subplot(2,2,2);
plot(pow2db(errors_2(1,:).^2),'-r','LineWidth',linewidth);
xlabel('Time','FontSize',FontSize,'interpreter','latex');ylabel('Squared Error (dB)','FontSize',FontSize,'interpreter','latex');
title('Single Realisation ($\mu$ = 0.01)','FontSize',FontSize,'interpreter','latex');
subplot(2,2,4);
plot(error_average_2,'-r','LineWidth', linewidth);
xlabel('Time','FontSize',FontSize,'interpreter','latex');ylabel('MSE (dB)','FontSize',FontSize,'interpreter','latex');
title('100 Realisations ($\mu$ = 0.01)','FontSize',FontSize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]); 

%% Misadjustment
EMSE_1 = mean(mean(errors_1(:,400:end).^2,1)) - sigma;
M_1 = EMSE_1 / sigma;
EMSE_2 = mean(mean(errors_2(:,400:end).^2,1)) - sigma;
M_2 = EMSE_2 / sigma;

R = [0.9259 0.4630;0.4630 0.9259];
m_lms_1 = mu(1) /2 *trace(R);
m_lms_2 = mu(2) /2 *trace(R);

fprintf('The estimated misadjustment for mu=%.2f is %.4f \n',mu(1), M_1);
fprintf('The estimated misadjustment for mu=%.2f is %.4f \n',mu(2), M_2);
fprintf('The theoretical misadjustment for mu=%.2f is %.4f \n',mu(1), m_lms_1);
fprintf('The theoretical misadjustment for mu=%.2f is %.4f \n',mu(2), m_lms_2);

%% Estimated weights
a_estimated_1 = weights_1/100;
a_estimated_2 = weights_2/100;
fprintf('The estimated AR coefficients for mu=%.2f is a1 = %.3f and a2 = %.3f \n', mu(1), a_estimated_1(1), a_estimated_1(2));
fprintf('The estimated AR coefficients for mu=%.2f is a1 = %.3f and a2 = %.3f \n', mu(2), a_estimated_2(1), a_estimated_2(2));
