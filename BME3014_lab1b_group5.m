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


lowpass = designfilt('lowpassfir','PassbandFrequency',0.45, 'StopbandFrequency', 1.55,'PassbandRipple',1,'StopbandAttenuation',60,'SampleRate',200);
lpdata= filter(lowpass, breath);
lpDelayVal = grpdelay(lowpass);
lpdelay = round(lpDelayVal(1));
lptime = time(lpdelay:end);

figure 
plot(lptime, lpdata(lpdelay:end))
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data')


welchdata = pwelch(lpdata(lpdelay:end));


figure 
plot(lptime, welchdata)
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data')