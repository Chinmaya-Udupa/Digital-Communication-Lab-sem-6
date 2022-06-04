function psdplot(x,Fs)
L=length(x);
X=fftshift(fft(x));
psd=(1/Fs/L)*abs(X).^2;
f=-L/2:L/2-1;
f=f*Fs/L;
plot(f,psd)
end