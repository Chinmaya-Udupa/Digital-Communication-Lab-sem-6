function y=channel(x,fc,fs,n,g)
%n is the order of filter and g is gain at baseband
h=firpm(n,[0, fc/(fs/2), (11*fc)/(5*fs), 1], [g, g, 0, 0]);
y=conv(h,x);