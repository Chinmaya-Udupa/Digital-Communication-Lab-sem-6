function CrossCorr=AltBitsXCorr(InputSignal,Length)

AltBits=AlternatingBits(1,-1,Length);
CrossCorr=zeros(1,length(InputSignal)-(Length-1));

for i=1:length(InputSignal)-(Length-1)
    a=xcorr(AltBits,InputSignal(i:i+Length-1));
    CrossCorr(i)=a(Length);
end