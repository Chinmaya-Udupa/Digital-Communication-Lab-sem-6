clear all;
close all
clc

%% Generating bit sequence
N=10;
seq=[1,0,1,0,1,1,1,0,0,1];
tb=0.1;
Fs=200;
fc=50;

%% Baseband - BASK & BPSK
pn=ones(1,Fs*tb);
imptrain_bask=impulseTrain_bask(seq,tb,Fs);
bask=conv(pn,imptrain_bask);
imptrain_bpsk=impulseTrain(seq,tb,Fs);
bpsk=conv(imptrain_bpsk,pn);
%% modulation
n=0:length(bpsk)-1;
carrier=cos(2*pi*fc/Fs*n);
mod_bask=bask.*carrier;
mod_bpsk=bpsk.*carrier;

subplot(2,1,1)
psdplot(bask,Fs);
title("PSD of unmodulated BASK Signal");
subplot(2,1,2)
psdplot(mod_bask,Fs);
title("PSD of Modulated BASK Signal");
figure;

subplot(2,1,1)
psdplot(bpsk,Fs);
title("PSD of unmodulated BPSK Signal");
subplot(2,1,2)
psdplot(mod_bpsk,Fs);
title("PSD of Modulated BPSK Signal");


%% Passband Channel
freq=[0 35 40 60 65 Fs/2];
amp=[0 0 1 1 0 0];
freq=freq*2/Fs;
channel=fir2(101,freq,amp);
fvtool(channel)
% L=length(channel);
% H=fftshift(fft(channel));
% f=-L/2:L/2-1;
% f=f*Fs/L;
% plot(f,abs(H));
% title("Passband Channel : Magnitude"),xlabel("Frequency (Hz)"),ylabel("Magnitude");
channel_output_bask=conv(channel,mod_bask);
channel_output_bpsk=conv(channel,mod_bpsk);

subplot(2,1,1)
plot(channel_output_bask);
title("Channel Output of BASK Signal");
subplot(2,1,2)
plot(channel_output_bpsk);
title("Channel Output of BPSK Signal");
figure;
channel_out_carrier=conv(channel,carrier);

%% Receive Filter
filter_output_bask=conv(channel,channel_output_bask);
filter_output_bpsk=conv(channel,channel_output_bpsk);
subplot(2,1,1)
plot(filter_output_bask);
title("Filter Output of BASK Signal");
subplot(2,1,2)
plot(filter_output_bpsk);
title("Filter Output of BPSK Signal");
figure;

%% Coherent demodulation
filter_out_carrier=conv(channel_out_carrier,channel);
demod_bask=filter_output_bask.*filter_out_carrier;
demod_bpsk=filter_output_bpsk.*filter_out_carrier;
freq=[0 20 25 Fs/2];
freq=freq*2/Fs;
amp=[1 1 0 0];
lpf=fir2(101,freq,amp);
demod_bask=conv(demod_bask,lpf);
demod_bpsk=conv(demod_bpsk,lpf);
subplot(2,1,1)
plot(demod_bask)
title("Demodulated Output of BASK Signal");
subplot(2,1,2)
plot(demod_bpsk);
title("Demodulated Output of BPSK Signal");
figure;

%% Match Fitler
mf_out_bask=conv(pn,demod_bask);
mf_out_bpsk=conv(pn,demod_bpsk);
subplot(2,1,1)
plot(mf_out_bask);
title("Matched Filter Output: BASK Signal"),xlabel("Index"),ylabel("Amplitude");
subplot(2,1,2)
plot(mf_out_bpsk);
title("Matched Filter Output: BPSK Signal"),xlabel("Index"),ylabel("Amplitude");
figure;
%% Sampling and Decision
i=1:10;
samples_bask=demod_bask(150+Fs*tb/2+(i-1)*Fs*tb);
samples_bpsk=demod_bpsk(150+Fs*tb/2+(i-1)*Fs*tb);

subplot(2,1,1)
plot(demod_bask)
hold on
stem(150+Fs*tb/2+(i-1)*Fs*tb,samples_bask);
hold off
legend("Continuos Output","Sampled Output")
title("BASK")
subplot(2,1,2)
plot(demod_bpsk);
hold on
stem(150+Fs*tb/2+(i-1)*Fs*tb,samples_bpsk);
hold off
legend("Continuos Output","Sampled Output")
title("BPSK")


%%
bits_recv_bask(samples_bask<0.25)=0;
bits_recv_bask(samples_bask>=0.25)=1;
bits_recv_bpsk(samples_bpsk<0)=0;
bits_recv_bpsk(samples_bpsk>=0)=1;
disp("Original Bits");
seq
disp("Bits From BASK:");
bits_recv_bask
disp("Bits From BPSK:");
bits_recv_bpsk
