%...............................................
% + Author: Haoxiang Huang, MSc CSP, IC. 
% + Date: 04-Feb-2024.
% + This is the implementation for 
% + 1.5. RRI Data Processing
%...............................................

clc;
clear variables;
close all;
addpath('../Utils/');
addpath('../data/');
RAW_ECG = readmatrix("Data\First_recording_2024-01-23-163351_EEG.csv");
timestamp = RAW_ECG(:,1);
data = RAW_ECG(:,2);

figure
plot(data)
trial1 = data(24003:95363);
trial2 = data(135363:215363);
trial3 = data(245363:315363);
[xRRI1,fsRRI1] = ECG_to_RRI(trial1,500,'ampthresh', 0.5*10e-5,'anomalyparam',10);
save('xRRI1.mat', 'xRRI1');
[xRRI2,fsRRI2] = ECG_to_RRI(trial2,500,'ampthresh', 0.5*10e-5,'anomalyparam',10);
save('xRRI2.mat', 'xRRI2');
[xRRI3,fsRRI3] = ECG_to_RRI(trial3,500,'ampthresh', 0.5*10e-5,'anomalyparam',10);
save('xRRI3.mat', 'xRRI3');