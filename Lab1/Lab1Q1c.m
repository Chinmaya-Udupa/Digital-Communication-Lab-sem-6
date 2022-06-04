ht=firpm(100,[0 0.4 0.5 1],[1 1 0 0]);
Hf=abs(fft(ht));
plot(linspace(-length(ht)/2,length(ht)/2,length(ht)),fftshift(Hf))
title("Frequency Response of Baseband Channel")
figure;
y1t=conv(ht,xt);
plot(linspace(0,length(y1t)/100,length(y1t)),y1t)
title("signal after going through the channel")