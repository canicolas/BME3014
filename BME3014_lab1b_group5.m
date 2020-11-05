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

%% finding the respirtory rate
minValue = min(lpdata); %helps to remove smaller peaks caused by noise
lpbreath(lpdata < 4) = minValue; %set a threshold of 4

[peaks] = findpeaks(lpdata(lpdelay:end)); %finds all max points
peak_count = length(peaks); % finds the number of peaks/ number of breaths
time_s = (length(lpdata(lpdelay:end))/Fs); %gets the length of time in seconds
time_m = (time_s/60); %gets the length of time in minutes
rpm1 = (peak_count/time_m); %outputs the rpm


%welchdata = pwelch(lpdata(lpdelay:end));

figure
pwelch(lpbdata(lpdelay:end),[],[],[],200)
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data pwelch')

%%EDA
rpeak = sort(rpeak);
rpeak = rpeak(1:length(amp)); %makes rpeak equal to the length of rrint
[~, ind] = unique(rpeak); %removes 
EDA = interp1(time(rpeak(ind)),amp(ind), time, 'pchip');
figure 
plot(time, EDA, 'm--')
hold on
plot(time(rpeak), amp, 'bo') 
xlabel("Time [sec]")
ylabel ("Amplitude")
title(" EDR")

%%RSA
rpeak = sort(rpeak);
rpeak = rpeak(1:length(rrint)); %makes rpeak equal to the length of rrint
 [~, ind] = unique(rpeak); %removes 
RSA = interp1(time(rpeak(ind)),rrint(ind), time, 'pchip');
figure
plot(time, RSA, 'm--','linewidth',2);
hold on
plot(time(rpeak),rrint,'bo');
 xlabel("Time [sec]")
 ylabel ("Amplitude")
title(" RSA")


RSAresp = mean(RSA(5:150));

EDAresp = mean(EDA);
