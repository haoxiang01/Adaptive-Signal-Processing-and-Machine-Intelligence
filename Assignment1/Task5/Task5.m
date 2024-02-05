%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.5.
%...............................................
clc;
clear variables;
close all;
addpath('../Utils/');
addpath('../data/');
load ('xRRI1.mat');
load ('xRRI2.mat');
load ('xRRI3.mat');
RAW_ECG = readmatrix("Data\First_recording_2024-01-23-163351_EEG.csv");

nfft = 2048;
fsRRI = 4;
T = 1/fsRRI;
xRRI1 = detrend(xRRI1);
xRRI2 = detrend(xRRI2);
xRRI3 = detrend(xRRI3);
f_n = fsRRI*(0:(nfft/2))/nfft;

%% plot RRI data
figure(1);
subplot(3,1,1); plot((0:length(xRRI1)-1)*T, xRRI1,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');title('Trial1');
subplot(3,1,2); plot((0:length(xRRI2)-1)*T, xRRI2,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');title('Trial2');
subplot(3,1,3); plot((0:length(xRRI3)-1)*T, xRRI3,'-b','LineWidth',1.5);
grid on; xlabel('time (s)');title('Trial3');

%% standard periodogram
[P_RRI_1,f_RRI_1] = periodogram(xRRI1,[],nfft,fsRRI);
[P_RRI_2,f_RRI_2] = periodogram(xRRI2,[],nfft,fsRRI);
[P_RRI_3,f_RRI_3] = periodogram(xRRI3,[],nfft,fsRRI);
figure(2);
plot(f_RRI_1, 10*log10(P_RRI_1), 'r', 'LineWidth', 1.5);
hold on;
plot(f_RRI_2, 10*log10(P_RRI_2), 'g', 'LineWidth', 1.5);
plot(f_RRI_3, 10*log10(P_RRI_3), 'b', 'LineWidth', 1.5);
title("Standard Periodogram");
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;
legend("Trial1","Trial2","Trial3", 'Location', 'best');
set(gca, 'FontSize', 10);

%% Bartlett periodogram
tLen = 200;
wLen = tLen*fsRRI;
[P_bartlett_1, f_bartlett_1] = fBartlett(xRRI1',fsRRI,nfft,wLen);
[P_bartlett_2, f_bartlett_2] = fBartlett(xRRI2',fsRRI,nfft,wLen);
[P_bartlett_3, f_bartlett_3] = fBartlett(xRRI3',fsRRI,nfft,wLen);
figure(3);
plot(f_bartlett_1, 10*log10(P_bartlett_1), 'r', 'LineWidth', 1.5);
hold on;
plot(f_bartlett_2, 10*log10(P_bartlett_2), 'g', 'LineWidth', 1.5);
plot(f_bartlett_3, 10*log10(P_bartlett_3), 'b', 'LineWidth', 1.5);
title(['Bartlett Periodogram, Window length=' num2str(tLen) 's'],'FontSize',13,'interpreter','latex');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;
legend("Trial1","Trial2","Trial3", 'Location', 'best');
set(gca, 'FontSize', 10);

%%AR spectrum estimate
order = 50;
bestOrder = order;
coeff1 = aryule(xRRI1, order); % estimate AR coefficients
PSD_RRI_1_AR = fARSpectrum(-coeff1(2:end), coeff1(1), nfft,'dB');
coeff2 = aryule(xRRI2, order);
PSD_RRI_2_AR = fARSpectrum(-coeff2(2:end), coeff2(1), nfft,'dB');
coeff3 = aryule(xRRI3, order);
PSD_RRI_3_AR = fARSpectrum(-coeff3(2:end), coeff3(1), nfft,'dB');

figure(4);
fontsize =13;
% Plot true PSD
plot(f_n,PSD_RRI_1_AR(1:nfft/2+1) , '-r', 'LineWidth', 1.5);
hold on;
% Plot best estimated PSD
plot(f_n,PSD_RRI_2_AR(1:nfft/2+1) , '-b', 'LineWidth', 1.5);
plot(f_n,PSD_RRI_3_AR(1:nfft/2+1), '-g', 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)', 'FontSize', fontsize, 'interpreter', 'latex'); 
ylabel('Power/Frequency (dB/Hz)', 'FontSize', fontsize, 'interpreter', 'latex'); 
legend('Trial1', 'Trial2', 'Trial3', 'FontSize', 10, 'interpreter', 'latex', 'Location', 'best');
title(['AR  Spectrum (Model Order=' num2str(bestOrder) ')'], 'FontSize', fontsize);


