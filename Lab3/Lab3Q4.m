N=50000;
Nf=50;
Tb=0.1;
BarkerCode=[+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
data=BitGenerator(N);
data(data==0)=-1;

Frames=zeros(N/Nf,(Nf+23)*(1/Tb));
TxSignal=zeros(1,randi([1,50]));

for i=1:N/Nf
    Frames(i,:)=FrameGenerator2(data,Nf,i,Tb);
end
for i=1:N/Nf
    TxSignal=[TxSignal Frames(i,:) zeros(1,randi([1 50]))];
end
% plot(TxSignal)
BER=zeros(1,50);
FrameStartErrorRate=zeros(1,50);
for k=1:50
sigma2=0:0.05:2.45;
gamma=1;
ChannelOutput=TxSignal*gamma+randn(1,length(TxSignal))*sigma2(k);
% plot(ChannelOutput)
MF=0.1*ones(1,10);
MFOut=conv(ChannelOutput,MF);

[ChanOutDigi, SamplingTimes]=EarlyLateSampler(MFOut,ChannelOutput,100,0.1,0,3,2,0);
% plot(ChannelOutput)
% hold on
% stem(SamplingTimes,ChanOutDigi)
% xlim([2000 3000])
% hold off
yn(ChanOutDigi>=0)=1;
yn(ChanOutDigi<0)=-1;

ynxAB=AltBitsXCorr(yn,10);
ynxBC=BarkerXCorr13Bits(yn);
% stem(ynxAB)
% figure;
% stem(ynxBC)

l=length(ynxBC(ynxBC==13));
if l~=N/Nf
    FrameStartErrorRate(k)=l-N/Nf;
end
end
stem(FrameStartErrorRate)
title('FrameStartErrorRate vs \sigma^2')