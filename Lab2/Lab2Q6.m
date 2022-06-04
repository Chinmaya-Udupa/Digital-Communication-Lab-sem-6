N=10;
h=fir2(2*N,[0 1/40 1/20 1/10 1/5 2/5 0.45 1],[1 0.7 0.9 0.3 0.5 0 0 0]);
H=fft(h);
Tb=0.1;
Fs=100;
t=0:1/Fs:2*N*Tb;
g=zeros(1,length(t));
for i=1:length(t)
   g(i)=(0.1)*rand;
end
g(1)=0;
g(t==N*Tb)=1;
g(t==(N-1)*Tb)=0;
g((length(t)-1)/2+11)=0;
g(end)=0;
gn=downsample(g,10);
%stem(linspace(-N*Tb,N*Tb,(length(g)/10)+1),gn)
G=fft(gn);
Q=G./H;
q=ifft(Q);
q=upsample(q,10);

%%
x=BitGenerator(100);
x(x==0)=-1;
xn=upsample(x,10);
xt=LineCoder(xn,100, 0.1, 0.1);
plot(xt);
% figure;

% yt1=conv(xt,gn);
% plot(yt1);
% figure;

yt2=conv(conv(xt,h),q);
eyediagram(yt2,20,0.2);