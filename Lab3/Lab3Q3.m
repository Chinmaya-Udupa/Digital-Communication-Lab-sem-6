N=1000;
Fs=100;
Ts=1/Fs;
Tb=0.1;
Fb=1/Tb;
x=BitGenerator(N);
xn=upsample(x,Fs*Tb);
xt=LineCoder(xn,Fs,Tb,Tb);
xt=xt(1:end-((Fs*Tb)-1));
sigma2=0.1;
gamma=1;
ChannelOutput=xt*gamma+randn(1,length(xt))*sigma2;

% stem(linspace(0,(Fs*Tb)-(1/Fs),length(xt)),xt,'r')
% hold on
% stem(linspace(0,(Fs*Tb)-(1/Fs),length(xt)),ChannelOutput,'b')
% hold off

ChannelOutput2=[zeros(1,randi([2,Fs*Tb])), ChannelOutput];

MF=(Tb)*ones(1,Fs*Tb);
MFOutput=conv(MF,ChannelOutput2);
% eyediagram(MFOutput,20);
% plot(MFOutput,'b')
% hold on
% plot(ChanOut,'r')
% hold off

[ChanOutDigi, SamplingTimes]=EarlyLateSampler(MFOutput,ChannelOutput2,100,0.1,0,3,2,0);

% stem(x)
% hold on
% stem(ChanOutDigi)
% hold off

y(ChanOutDigi>=0.5)=1;
y(ChanOutDigi<=0.5)=0;

% subplot(2,1,1)
% stem(x)
% hold on
% stem(y)
% hold off
% subplot(2,1,2)
% stem(x-y(2:end))
