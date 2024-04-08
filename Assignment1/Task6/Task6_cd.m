%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.6.c
%...............................................

clc;
clear variables;
close all;
addpath('../Utils/');
addpath('../data/');
load('../data/PCAPCR.mat');

% OLS solution
B_OLS = (Xnoise'*Xnoise) \ Xnoise'*Y;
Y_OLS = Xnoise * B_OLS;

rank = 3; 

[U, S, V] = svd(Xnoise);
U = U(:, 1:rank);
S = S(1:rank, 1:rank);
V = V(:, 1:rank);

B_PCR = V / S * U' * Y;
Y_PCR = Xnoise * B_PCR;

% Calculate errors for the training set
e_OLS = sum(sum((Y - Y_OLS).^2)) / numel(Y);
e_PCR = sum(sum((Y - Y_PCR).^2)) / numel(Y);

% Apply the models to the test set
Y_OLS_T = Xtest * B_OLS;
Y_PCR_T = Xtest * B_PCR;

% Calculate errors for the test set
e_OLS_T = sum(sum((Ytest - Y_OLS_T).^2)) / numel(Ytest);
e_PCR_T = sum(sum((Ytest - Y_PCR_T).^2)) / numel(Ytest);

% Display the results
fprintf('Training Error OLS: %.4f\n', e_OLS);
fprintf('Training Error PCR: %.4f\n', e_PCR);
fprintf('Test Error OLS: %.4f\n', e_OLS_T);
fprintf('Test Error PCR: %.4f\n', e_PCR_T);

%% d
%% Performance on extra testing set
loops = 1000;
e_OLS_extra = 0;
e_PCR_extra = 0;
for i = 1:loops
    [Y_OLS, Y] = regval(B_OLS);
    e_OLS_extra = e_OLS_extra + mean(mean((Y-Y_OLS).^2));

    [Y_PCR, Y] = regval(B_PCR);
    e_PCR_extra = e_OLS_extra + mean(mean((Y-Y_PCR).^2));
end
e_OLS_extra  = e_OLS_extra  / loops;
e_PCR_extra = e_PCR_extra / loops;
fprintf('%d Times Extra Test Error OLS: %.4f\n', loops, e_OLS_extra);
fprintf('%d Times Extra Test Error PCR: %.4f\n', loops, e_PCR_extra);

