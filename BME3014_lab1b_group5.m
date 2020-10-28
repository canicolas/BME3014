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

filter = pwelch(breath);
DelayVal = grpdelay(filter);
delay = DelayVal(1) ;

%lowpass =designfilt('lowpassfir','CutoffFrequency',0.9,'SampleRate',fs);
lowpass = designfilt('lowpassfir', 'FilterOrder', 10,'CutoffFrequency', 0.5, 'SampleRate', 200);

lpdata= filter(lowpass, breath);
lpDelayVal = grpdelay(lowpass);
delay = lpDelayVal(1) ;

figure 
plot(time(delay:end), lpdata)
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data')
