%%
h=fir2(99,[0 1/40 1/20 1/10 1/5 2/5 1],[1 0.7 0.9 0.3 0.5 0 0]);
x=BitGenerator(100);
x(x==0)=-1;
xn=upsample(x,10);
xt=LineCoder(xn,100, 0.1, 0.1);
mt=conv(xt,h);
eyediagram(mt,20,0.2,4);
title("Eye Diagram of Channel Output")
%fvtool(h)

%% channel inversion

a=[1 0.7 0.9 0.3 0.5 0 0];
ainv=zeros(size(a));
for i=1:length(a)
    if a(i)~=0
        ainv(i)=1/a(i);
    end
end
zf=fir2(99,[0 1/40 1/20 1/10 1/5 2/5 1],ainv);
%fvtool(zf)
ytq5=conv(mt,zf);
eyediagram(ytq5,20,0.2,4);
title("Eye Diagram of Final Signal after Channel Inversion")

%% Tapped Delay filtering (Ive no idea -v0v- )

N=50;
pt=ones(1,10);
r=conv(pt,h);
sampletimes=5:10:length(r);
rsamples=r(sampletimes);
lr=length(rsamples)+2*N ;
G=zeros(lr,1);
G(ceil(lr/2))=1;
R=zeros(lr,2*N+1);

for i = 1:lr
    for k = 1:2*N+1
        if ((i - k) >= 0)  && ((i - k) < length(rsamples))
            R(i,k) = rsamples(i - k + 1);
        end
    end
end

w=pinv(R)*G;
q=upsample(w,10);
ytq6=conv(mt,q);
eyediagram(ytq6,20,0.2,4);
title("Eye Diagram of Final Signal (N=50)")