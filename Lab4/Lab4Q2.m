N=1000;
seq=randi([0 1],1,N);
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
%% Passband Channel
freq=[0 20 25 75 80 Fs/2];
amp=[0 0 1 1 0 0];
freq=freq*2/Fs;
variance=0:0.01:2;
sd=sqrt(variance);
BERbask=zeros(1,201);
BERbpsk=zeros(1,201);
i=1:N;
channel=fir2(101,freq,amp);
freq=[0 20 25 Fs/2];
freq=freq*2/Fs;
amp=[1 1 0 0];
lpf=fir2(101,freq,amp);
for k=1:201
    
channel_output_bask=conv(channel,mod_bask);
channel_output_bpsk=conv(channel,mod_bpsk);
channel_output_carrier=conv(channel,carrier);
for j=1:10
channel_output_bask=channel_output_bask+randn(1,length(channel_output_bask))*sd(k);
channel_output_bpsk=channel_output_bpsk+randn(1,length(channel_output_bpsk))*sd(k);
channel_output_carrier=channel_output_carrier+randn(1,length(channel_output_carrier))*sd(k);

filter_output_bask=conv(channel,channel_output_bask);
filter_output_bpsk=conv(channel,channel_output_bpsk);
filter_out_carrier=conv(channel_output_carrier,channel);

demod_bask=filter_output_bask.*filter_out_carrier;
demod_bpsk=filter_output_bpsk.*filter_out_carrier;

demod_bask=conv(demod_bask,lpf);
demod_bpsk=conv(demod_bpsk,lpf);

mf_out_bask=conv(pn,demod_bask);
mf_out_bpsk=conv(pn,demod_bpsk);

samples_bask=demod_bask(150+Fs*tb/2+(i-1)*Fs*tb);
samples_bpsk=demod_bpsk(150+Fs*tb/2+(i-1)*Fs*tb);
bits_recv_bask=zeros(1,N);
bits_recv_bpsk=zeros(1,N);
bits_recv_bask(samples_bask<0.25)=0;
bits_recv_bask(samples_bask>=0.25)=1;
bits_recv_bpsk(samples_bpsk<0)=0;
bits_recv_bpsk(samples_bpsk>=0)=1;

BERbask(k)=BERbask(k)+sum(abs(bits_recv_bask-seq)==1);
BERbpsk(k)=BERbpsk(k)+sum(abs(bits_recv_bpsk-seq)==1);
end
BERbask(k)=BERbask(k)/10;
BERbpsk(k)=BERbpsk(k)/10;
end
subplot(2,1,1)
stem(variance,BERbask);
title("BASK"),xlabel("\sigma^2");
subplot(2,1,2)
stem(variance,BERbpsk);
title("BPSK"),xlabel("\sigma^2");
sgtitle("Bit Error Rate")
