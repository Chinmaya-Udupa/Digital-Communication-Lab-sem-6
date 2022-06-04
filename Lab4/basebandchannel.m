function y = basebandchannel(Fs,fp,fs,g,x)
    freq=[0 2*fp/Fs 2*fs/Fs 1];
    amp=[g g 0 0];
    h=firpm(97,freq,amp);   % order = 100
    y=conv(h,x);
end