%%
h=fir2(100,[0 1/40 1/20 1/10 1/5 2/5 0.45 1],[1 0.7 0.9 0.3 0.5 0 0 0]);
%fvtool(h)

%%
x=BitGenerator(100);
x(x==0)=-1;
xn=upsample(x,10);
xt=LineCoder(xn,100, 0.1, 0.1);
%plot(xt)

%%
mt=conv(xt,h);
%eyediagram(mt,20,0.2,17);

H=fft(h);
G=1./H;
g=ifft(G);

yt1=conv(g,mt);
plot(yt1);
eyediagram(yt1,20,0.2);
figure;


h2=ifft(G.*H);
yt2=conv(h2,xt);

plot(yt2);