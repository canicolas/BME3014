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

% rosina: 
% ok so I used

% pwelch(lpdata(lpdelay:end))
% and putting just that gives a curve that looks like the right shape, but it has a bunch of waves in it

%and then i did this
% pwelch(lpbdata(lpdelay:end),[],[],[],200)

%and it looks just like the previous one, just shifted up a little
%and i'm not sure which one is prefered



figure 
plot(lptime, welchdata)
xlabel('time [s]')
ylabel('breath [V]')
title('Respiration data')


%% ok so this is the interp stuff. I got it to work but i'm not sure if it is right or what it means
%pop this onto the bottom on your lab 1A because it uses the data from that

rpeak = sort(rpeak);
rpeak = rpeak(1:250); %makes rpeak equal to the length of rrint
rrint = sort(rrint);
[~, ind] = unique(rpeak); %removes 
y = interp1(time(rpeak(ind)),rrint(ind), time, 'pchip');
hold on
plot(time, y, 'm--','linewidth',2);
plot(time(rpeak),rrint,'bo');
