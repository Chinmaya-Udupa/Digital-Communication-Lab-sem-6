%%
fs=100;
x=BitGenerator(1000);
x(x==0)=-1;
Tb=[0.1 0.05 0.2];
Tk=5*Tb(1);
xn=upsample(x,10);
A=1/pi;
alpha=1;
t=-Tk/2+Tk*(1/fs):1/fs:Tk/2;

%%
brt=LineCoder(xn,fs,0.1,0.1);
h1=A*Tb(1)*(sin(pi.*t/Tb(1))./t);
bst=conv(xn,h1);
brr=cos(pi*alpha.*t/Tb(1))./(1-(2*alpha.*t/Tb(1)).^2);
h2=h1.*brr;
bct=conv(h2,xn);

% eyediagram(brt,20,0.2,5)
% eyediagram(bst,20,0.2,5)
% eyediagram(bct,20,0.2,5)

% subplot(1,3,1)
% plot(linspace(0,10,length(brt)),brt)
% xlim([5,6])
% title("rectangular pulse")
% subplot(1,3,2)
% plot(linspace(0,10,length(bst)),bst)
% xlim([5,6])
% title("sinc pulse")
% subplot(1,3,3)
% plot(linspace(0,10,length(bct)),bct)
% xlim([5,6])
% title("raised cosine pulse")
%%
BRT=abs(fftshift(fft(brt)));
BST=abs(fftshift(fft(bst)));
BCT=abs(fftshift(fft(bct)));

% subplot(3,1,1)
% plot(linspace(-length(brt)/2,length(brt)/2,length(brt)),BRT.^2)
% title("b_r(t)")
% subplot(3,1,2)
% plot(linspace(-length(bst)/2,length(bst)/2,length(bst)),BST.^2)
% title("b_s(t)")
% subplot(3,1,3)
% plot(linspace(-length(bct)/2,length(bct)/2,length(bct)),BCT.^2)
% title("b_c(t)")
% sgtitle("PSD of the signals")
 
%%

alpha=0.2;
brr=cos(pi*alpha.*t/Tb(1))./(1-(2*alpha.*t/Tb(1)).^2);
h2=h1.*brr;
bct=conv(h2,xn);
% eyediagram(bct,20,0.2,5)

BCT=abs(fftshift(fft(bct)));
subplot(3,1,1)
plot(linspace(-length(bct)/2,length(bct)/2,length(bct)),BCT.^2)
title("\alpha =0.2")

alpha=0.5;
brr=cos(pi*alpha.*t/Tb(1))./(1-(2*alpha.*t/Tb(1)).^2);
h2=h1.*brr;
bct=conv(h2,xn);
% eyediagram(bct,20,0.2,5)

BCT=abs(fftshift(fft(bct)));
subplot(3,1,2)
plot(linspace(-length(bct)/2,length(bct)/2,length(bct)),BCT.^2)
title("\alpha =0.5")

alpha=1;
brr=cos(pi*alpha.*t/Tb(1))./(1-(2*alpha.*t/Tb(1)).^2);
h2=h1.*brr;
bct=conv(h2,xn);
% eyediagram(bct,20,0.2,5)

BCT=abs(fftshift(fft(bct)));
subplot(3,1,3)
plot(linspace(-length(bct)/2,length(bct)/2,length(bct)),BCT.^2)
title("\alpha =1")
sgtitle("PSD of the Raised Cosines")

%%
ybrt=channel(brt,10,100,50,1);
ybst=channel(bst,10,100,50,1);
ybct=channel(bct,10,100,50,1);

% eyediagram(ybrt,20,0.2)
% eyediagram(ybst,20,0.2)
% eyediagram(ybct,20,0.2)

% figure;
%%
YBRT=abs(fftshift(fft(ybrt)));
YBST=abs(fftshift(fft(ybst)));
YBCT=abs(fftshift(fft(ybct)));

% subplot(3,1,1)
% plot(linspace(-length(ybrt)/2,length(ybrt)/2,length(ybrt)),YBRT.^2)
% title("Yb_r(t)")
% subplot(3,1,2)
% plot(linspace(-length(ybst)/2,length(ybst)/2,length(ybst)),YBST.^2)
% title("Yb_s(t)")
% subplot(3,1,3)
% plot(linspace(-length(ybct)/2,length(ybct)/2,length(ybct)),YBCT.^2)
% title("Yb_c(t)")
% sgtitle("PSD of the channeled signals")

%%
Tk=5*Tb(2);
t1=-Tk/2+Tk*(1/fs):1/fs:Tk/2;
xn1=upsample(x,fs*Tb(2));
Tk=5*Tb(3);
t2=-Tk/2+Tk*(1/(2*fs)):1/fs:Tk/2;
xn2=upsample(x,fs*Tb(3));

h11=A*Tb(2)*(sin(pi.*t1/Tb(2))./t1);
bst1=conv(xn1,h11);
ybst1=channel(bst1,10,100,50,1);
brr1=cos(pi*alpha.*t1/Tb(2))./(1-(2*alpha.*t1/Tb(2)).^2);
h21=h11.*brr1;
bct1=conv(h21,xn1);
ybct1=channel(bct1,10,100,50,1);

h12=A*Tb(3)*(sin(pi.*t2/Tb(3))./t2);
bst2=conv(xn2,h12);
ybst2=channel(bst2,10,100,50,1);
brr2=cos(pi*alpha.*t2/Tb(3))./(1-(2*alpha.*t2/Tb(3)).^2);
h22=h12.*brr2;
bct2=conv(h22,xn2);
ybct2=channel(bct2,10,100,50,1);

% eyediagram(bst1,10,0.1,2)
% eyediagram(bst2,40,0.4,10)
% 
% eyediagram(bct1,10,0.1,2)
% eyediagram(bct2,40,0.4,10)

% eyediagram(ybst1,10,0.1,2)
% eyediagram(ybst2,40,0.4,15)
% 
% eyediagram(ybct1,10,0.1,2)
% eyediagram(ybct2,40,0.4,10)

YBST1=abs(fftshift(fft(ybst1)));
YBCT1=abs(fftshift(fft(ybct1)));
YBST2=abs(fftshift(fft(ybst2)));
YBCT2=abs(fftshift(fft(ybct2)));

% subplot(1,2,1)
% plot(linspace(-length(ybst1)/2,length(ybst1)/2,length(ybst1)),YBST1)
% title("Tb=0.05")
% subplot(1,2,2)
% plot(linspace(-length(ybst2)/2,length(ybst2)/2,length(ybst2)),YBST2)
% title("Tb=0.2")
% sgtitle("Frequency response of final output (sinc pulse)")
% 
% figure;
% 
% subplot(1,2,1)
% plot(linspace(-length(ybct1)/2,length(ybct1)/2,length(ybct1)),YBCT1)
% title("Tb=0.05")
% subplot(1,2,2)
% plot(linspace(-length(ybct2)/2,length(ybct2)/2,length(ybct2)),YBCT2)
% title("Tb=0.2")
% sgtitle("Frequency response of final output (raised cosine pulse)")