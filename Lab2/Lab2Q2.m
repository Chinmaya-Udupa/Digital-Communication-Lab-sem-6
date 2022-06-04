deltat=[1, zeros(1,99)];
fc=10;
fs=100;
n=50;
g=1;
DelResponse=channel(deltat,fc,fs,n,g);

%fvtool(y)

N=100;
Ton=[0.1 0.05 0.2];

xn=BitGenerator(N);
xn(xn==0)=-1;
xn1=upsample(xn,Ton(1)*N);
xn2=upsample(xn,Ton(2)*N);
xn3=upsample(xn,Ton(3)*N);

xt1=LineCoder(xn1,fs,Ton(1),Ton(1));
xt2=LineCoder(xn2,fs,Ton(2),Ton(2));
xt3=LineCoder(xn3,fs,Ton(3),Ton(3));

%plot(round(linspace(0,N*Ton(1),length(xt1)),2),xt1)
eyediagram(xt1,20,0.2,5)
eyediagram(xt2,10,0.1,2)
eyediagram(xt3,40,0.4,10)

yt1=channel(xt1,fc,fs,n,g);
yt2=channel(xt2,fc,fs,n,g);
yt3=channel(xt3,fc,fs,n,g);

%plot(linspace(0,N*Ton(1),length(yt1)),yt1)
%eyediagram(yt1,20,0.2)
%eyediagram(yt2,10,0.1,2)
%eyediagram(yt3,40,0.4,15)

qt1=firpm(50,[0 fc/(fs/2) (11*fc)/(5*fs) 1],[1 1 0 0]);
yfinal=conv(qt1,yt1);

%eyediagram(yfinal,20,0.2,5)