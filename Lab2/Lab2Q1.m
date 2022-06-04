x=[1, zeros(1,99)];
fc=250;
fs=1000;
n=50;
g=sqrt(2);
y=channel(x,fc,fs,n,g);
fvtool(y)