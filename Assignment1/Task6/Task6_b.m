%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.6.b
%...............................................
clc;
clear variables;
close all;
addpath('../Utils/');
load('../data/PCAPCR.mat');

% Perform SVD on Xnoise and X
[U_Xnoise, S_Xnoise, V_Xnoise] = svd(Xnoise);
[U_X, S_X, V_X] = svd(X);

r = 3;%low rank
S_Xnoise_r = S_Xnoise;
S_Xnoise_r(r+1:end, r+1:end) = 0; 
Xdenoise= U_Xnoise * S_Xnoise_r * V_Xnoise';
[U_Xdenoise, S_Xdenoise, V_Xdenoise] = svd(Xdenoise);

figure;subplot(2, 1, 1);
subplot(2, 1, 1);
stem(diag(S_X), 'Color','r','Marker','o','LineWidth', 1.5); 
hold on;
stem(diag(S_Xnoise),'filled', 'Color','g','Marker','s','LineWidth', 1.5); 
stem(diag(S_Xdenoise), 'filled', 'Color','b','LineWidth', 1.5); 
title('Singular Values of $X_{denoised}$', 'Interpreter', 'latex');
xlabel('Index', 'Interpreter', 'latex');
ylabel('Singular Value', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);
hold off;
legend('X', 'Xnoise', 'Xdenoise', 'Location', 'best');

%error
error_noise = mean((X-Xnoise).^2);
error_denoise = mean((X-Xdenoise).^2);
subplot(2, 1, 2);
stem(error_noise, 'filled', 'Color','r','LineWidth', 1.5); 
title('Mean Square Error with $X$', 'Interpreter', 'latex');
xlabel('Index', 'Interpreter', 'latex');
ylabel('Singular Value', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);
hold on;
stem(error_denoise, 'filled', 'Color','b','LineWidth', 1.5); 
legend('Xnoise', 'Xdenoise', 'Location', 'best');