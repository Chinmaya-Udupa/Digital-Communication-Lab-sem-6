function i=impulseTrain(seq,T,Fs)
    i=seq;
    i(seq==0)=-1;
    i=upsample(i,T*Fs);
end