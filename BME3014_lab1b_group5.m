clear all
close all
%% GROUP INFORMATION
%--> In these comments input group number and member names
% Group number:
% Group members: Claire Nicolas, Rosina Comatas, Rositsa Mihaleva

fname = importdata('Lab1_Claire_Resting.txt');
fs = 200;
time = fname.data(:,1);
breath = fname.data(:,4);


figure 
plot(time, breath)
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data')


lowpass =designfilt('lowpassfir','PassbandFrequency',250, 'StopbandFrequency', 325,'StopbandAttenuation',65,'SampleRate',1000);
