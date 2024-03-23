%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 21-Mar-2024.
% + This is the implementation for 
% + 2.1. The Least Mean Square (LMS) Algorithm Part ef
%...............................................
clc
clear
close all
addpath('../Utils/');

clc
clear
close all
%% Initialization
a = [0.1 0.8];
sigma = 0.25;
N = 1000;
mu = 0.01;  % adjust here
epoch = 100;
order = length(a);
gamma = 0.01; % adjust here

%% AR model
model = arima('AR',a,'Constant',0,'Variance',sigma);
x = simulate(model,N,'Numpaths',100);

%% MSE
errors_1 = zeros(epoch,N-2);
weights_1 = zeros(order,1);
for i = 1:epoch
   x_AR = x(:,i);
   [errors_1(i,:),weights] = fLMS(x_AR, order, mu, gamma);
   weights_1 = weights_1 + mean(weights(:,400:end),2);
end
error_average_1 = mean(pow2db(errors_1.^2),1);
subplot(2,1,1);
plot(pow2db(errors_1(1,:).^2),'-b');
xlabel('Time','FontSize',18);ylabel('Squared Error (dB)','FontSize',18);
title('1 Realisation (\mu = 0.05)','FontSize',18);
subplot(2,1,2);
plot(error_average_1,'-b');
xlabel('Time','FontSize',18);ylabel('MSE (dB)','FontSize',18);
title('100 Realisation (\mu = 0.05)','FontSize',18);



%% Misadjustment
EMSE_1 = mean(mean(errors_1(:,400:end).^2,1)) - sigma;
M_1 = EMSE_1 / sigma;

R = [0.9259 0.4630;0.4630 0.9259];
m_lms_1 = mu(1) /2 *trace(R);
fprintf('The misadjustment for mu=%.2f and gamma=%.2f is %.4f \n',mu(1), gamma, m_lms_1);

%% Estimated weights
a_estimated_1 = weights_1/100;
fprintf('The estimated AR coefficients for mu=%.2f and gamma=%.2f is a1 = %.3f and a2 = %.3f \n', mu(1), gamma, a_estimated_1(1), a_estimated_1(2));