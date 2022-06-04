% subplot(2,1,1)
% plot(linspace(-length(xt)/2,length(xt)/2,length(xt)),fftshift(abs(fft(xt))))
% title ("before channel")
% subplot(2,1,2)
% plot(linspace(-length(y1t)/2,length(y1t)/2,length(y1t)),fftshift(abs(fft(y1t))))
% title("after channel")
% sgtitle("Frequency Response of signal")
%reciever
% Qf=abs(fft(qt));%qt is obtained from FilterDesigner
% plot(linspace(-length(qt)/2,length(qt)/2,length(qt)),fftshift(Qf))
% figure;
yt=conv(qt,y1t);
plot(linspace(0,length(yt)/100,length(yt)),yt)
title("signal after going through reciever filter")
figure;
yn=zeros(1,1000);
ytemp=yt(55:10:10050);
for i=1:length(ytemp)
    if ytemp(i)>0
        yn(i)=1;
    else
        yn(i)=0;
    end
end
plot(linspace(0,length(yn)/100,length(yn)),yn)
title("final signal")
