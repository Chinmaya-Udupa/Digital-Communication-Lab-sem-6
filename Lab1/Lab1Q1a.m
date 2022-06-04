xn=BitGenerator(10);
stem(xn)
title("10 Random Bits")
figure;
pt=LineCoder(100,0.1,0.1);%xxxxxx LineCoder has been changed
xn(xn==0)=-1;
xn=upsample(xn,10);
xt=conv(xn,pt);
plot(linspace(0,length(xt)/100,length(xt)),xt)
title("Bits after passing through line coder")