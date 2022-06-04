function ContSignal= LineCoder(x,Fs,Ton,Ttotal)

t=linspace(0,Ttotal-(1/Fs),Fs*Ttotal);
h=zeros(1,length(t));
for i=1:length(t)
    if t(i)<Ton
        h(i)=1;
    else
        h(i)=0;
    end
end
ContSignal=conv(x,h);