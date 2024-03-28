%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.1. Complex LMS and Widely Linear Modelling Part b Low wind
%...............................................

clc
clear
close all
addpath('../Utils/');
addpath('../Wind-dataset/');

%% Initializaiton
fontsize = 30;
lineWidth = 2;
% data_type = 'Low Wind'; % Change here for low-wind, medium-wind, and high-wind
% data_type = 'Medium Wind';
data_type = 'High Wind';

M = 30;% order of filter

if strcmp(data_type, 'Low Wind')
    load low-wind.mat;
    mu = 0.1;
elseif strcmp(data_type, 'Medium Wind')
    load medium-wind.mat;
    mu = 1e-2;
elseif strcmp(data_type, 'High Wind')
    load high-wind.mat;
    mu = 1e-3;
end

% plot data
figure;
scatter(v_east, v_north, 10,'blue','filled');
set(gca, 'FontSize', 18);
axis equal;axis square;grid on;
xlabel('Real','FontSize',fontsize,'interpreter','latex');
ylabel('Imag','FontSize',fontsize,'interpreter','latex');
% title(data_type,'FontSize',fontsize,'interpreter','latex');
set(gcf, 'Position', [100, 100, 800, 600]);

% circularity coefficient 
complex = v_east + 1i * v_north;
pseudocovariance = mean(complex .^ 2 );
covariance = mean(abs(complex) .^ 2);
circular = abs(pseudocovariance)/covariance;

% CLMS & ACLMS
errors_CLMS = zeros(M, 1);
errors_ACLMS = zeros(M, 1);
for i = 1:M
    [error_CLMS,~] = fCLMS(complex, complex,i,mu);
    errors_CLMS(i) = pow2db(mean(abs(error_CLMS) .^ 2 ,2));
    [error_ACLMS,~] = fACLMS(complex, complex,i,mu);
    errors_ACLMS(i) = pow2db(mean(abs(error_ACLMS) .^ 2,2));
end

%plot
figure;
plot(errors_CLMS,'-b','LineWidth',lineWidth);
hold on
grid on
plot(errors_ACLMS,'-r','LineWidth',lineWidth);
set(gca, 'FontSize', 20);
% title(data_type,'FontSize',fontsize,'interpreter','latex');
ylabel('MPSE (dB)','FontSize',fontsize,'interpreter','latex');
xlabel('Filter order $M$','FontSize',fontsize,'interpreter','latex');
legend('CLMS','ACLMS','FontSize',25,'interpreter','latex','Location', 'northwest');
set(gcf, 'Position', [100, 100, 800, 600]);