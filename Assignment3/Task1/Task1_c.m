%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 25-Mar-2024.
% + This is the implementation for 
% + 3.1. Complex LMS and Widely Linear Modelling Part c
%...............................................
clc
clear
close all
addpath('../Utils/');

%% Initilization
fontsize = 35;
lineWidth = 1.2;
opt = 'o';
opt_size = 60;
delta = [0 0];
N = 1e3;
fs = 1e4; % sampling frequency
f0 = 50;  % system frequency
phi = 0; % phase
n = 1:N;

%% Balanced signal
Vmag = 1;
Dmag = 0;
V = Vmag*ones(1,3);
Delta = Dmag*ones(1,3);
v = fClarke(V, Delta, f0, fs, phi, N);

figure;
scatter(real(v), imag(v), opt_size, 'b' , opt, 'LineWidth', lineWidth);
axis equal;axis square;grid on;
set(gca, 'FontSize', 18);
xlabel('Real','FontSize',fontsize,'interpreter','latex');ylabel('Imag','FontSize',fontsize,'interpreter','latex');
% title({'Balanced'; ['$V_a=V_b=V_c=' num2str(Vmag) '$,$\Delta_b=\Delta_c=' num2str(Dmag) '$, $\phi=' num2str(phi) '$']},'FontSize',fontsize,'interpreter','latex');
xlim([-2,2]);
ylim([-2,2]);
set(gcf, 'Position', [100, 100, 900, 700]);


%% Unbalanced: magnitude
Dmag = 0;
V0 = ones(1,3);
v = zeros(4, N);
Delta = Dmag*ones(1,3);
coeff = [1, 1, 1; 1, 1, 2; 1, 2, 1; 2,1,1];

for i=1:size(coeff,1)
    V = V0.*coeff(i,:);
    v(i,:) = fClarke(V, Delta, f0, fs, phi, N);
end

figure
hold on
colors = ['b','r','g','m','c'];
for i = 1:size(coeff,1)
    scatter(real(v(i,:)),imag(v(i,:)), opt_size , colors(i) , opt,  'LineWidth', lineWidth)
end
axis equal;axis square;grid on;
set(gca, 'FontSize', 18);
xlim([-3 3])
ylim([-3 3])
xlabel('Real','FontSize',fontsize,'interpreter','latex');ylabel('Imag','FontSize',fontsize,'interpreter','latex');
% title(['Unbalanced system: Voltage'],'FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]);
% generate legend
strList = {}; 
for i = 1:size(coeff,1)
    str = ['$V_a=$' num2str(coeff(i,1)) ', $V_b=$' num2str(coeff(i,2)) ', $V_c=$' num2str(coeff(i,3))];
    strList{end+1} = str; 
end
legend(strList,'FontSize',18,'interpreter','latex','Location','southeast');

%% Unbalanced: Phase
coeff = [0, 0, 0; 0, 1, 1/3; 0, 0, 1/3; 0, 1/3, 0];
V = ones(1,3);
delta0 = ones(1,3);
v = zeros(4, N);

for i=1:size(coeff,1)
    Delta = delta0.*coeff(i,:)*pi;
    v(i,:) = fClarke(V, Delta, f0, fs, phi, N);
end

figure
hold on
colors = ['b','r','g','m','c'];
for i = 1:size(coeff,1)
    scatter(real(v(i,:)),imag(v(i,:)), opt_size , colors(i) , opt,  'LineWidth', lineWidth)
end
axis equal;axis square;grid on;
set(gca, 'FontSize', 18);
xlim([-2 2])
ylim([-2 2])
xlabel('Real','FontSize',fontsize-5,'interpreter','latex');ylabel('Imag','FontSize',fontsize,'interpreter','latex');
% title(['Unbalanced system: Phase'],'FontSize',fontsize,'interpreter','latex')
set(gcf, 'Position', [100, 100, 800, 600]);
% generate legend
strList = {}; 
for i = 1:size(coeff,1)
    str = ['$\Delta_b=$' num2str(rats(coeff(i,2),3)) '$\pi$, $\Delta_c=$' num2str(rats(coeff(i,3),3)) '$\pi$'];
    strList{end+1} = str; 
end
legend(strList,'FontSize',18,'interpreter','latex','Location','southeast');





