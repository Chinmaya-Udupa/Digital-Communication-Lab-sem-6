xA=BitGenerator(10);
xP(xA==0)=-1;
xP(xA==1)=1;
fc=50;
Carrier=cos(2*pi*50*linspace(0,0.1,100));
xBASK=upsample(xA,10); %Tb=0.1 Fs=100
xBPSK=upsample(xP,10);
pt=ones(1,10);
xBASK=conv(xBASK,pt);
xBASK=xBASK(1:end-9);
plot(cos(2*pi*50*linspace(0,0.1,100)).*xBASK)
figure;
xBPSK=conv(xBPSK,pt);
xBPSK=xBPSK(1:end-9);
plot(cos(2*pi*50*linspace(0,0.1,100)).*xBPSK)
figure;