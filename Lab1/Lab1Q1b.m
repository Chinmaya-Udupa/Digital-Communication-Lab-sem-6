xn=BitGenerator(1000);
pt=LineCoder(100,0.1,0.1);%xxxxxx LineCoder has been changed
%xn(xn==0)=-1;
xnnew=upsample(xn,10);
xt=conv(xnnew,pt);
Xf=abs(fftshift(fft(xt)));
plot(linspace(-length(Xf)/2,length(Xf)/2,length(Xf)),(Xf.^2))
hold on
t=-5000:0.01:5000;
plot(t,500000*abs(sinc(0.001.*t).^2),"LineWidth",3)
title("Power Spectrum of Baseband signal")
legend("Obtained","Theoretical")