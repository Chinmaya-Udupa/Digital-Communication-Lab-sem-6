function i=impulseTrain_bask(seq,T,Fs)
    i=seq;
    i=upsample(i,T*Fs);
end