%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.6.a
%...............................................
clc;
clear variables;
close all;
addpath('../Utils/');
load('../data/PCAPCR.mat');

[U_X, S_X, V_X] = svd(X);
[U_Xnoise, S_Xnoise, V_Xnoise] = svd(Xnoise); 

% Plotting the singular values of X and Xnoise
figure;
subplot(2, 1, 1);
stem(diag(S_X), 'filled', 'Color','r','LineWidth', 1.5); 
title('Singular Values of $X$ and $X_{noise}$', 'Interpreter', 'latex');
xlabel('Index', 'Interpreter', 'latex');
ylabel('Singular Value', 'Interpreter', 'latex');
set(gca, 'FontSize', 12);
hold on;
stem(diag(S_Xnoise), 'filled', 'Color','b','LineWidth', 1.5); 
legend('X', 'Xnoise', 'Location', 'best');
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 800, 600]);

% Calculate the square error between each singular value of X and Xnoise
square_errors = (diag(S_X) - diag(S_Xnoise)).^2;

% Plotting the square errors between singular values of X and Xnoise
subplot(2, 1, 2);
stem(square_errors, 'filled', 'Color','b','LineWidth', 1.5); 
title('Square Error Between Singular Values of $X$ and $X_{noise}$', 'Interpreter', 'latex');
xlabel('Index', 'Interpreter', 'latex');
ylabel('Square Error', 'Interpreter', 'latex');
set(gca, 'FontSize', 18);
set(gcf, 'Position', [100, 100, 800, 700]);
