function crosscor= BarkerXCorr13Bits(InputSignal)

BarkerCode=[+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
crosscor=zeros(1,length(InputSignal)-12);

for i=1:length(InputSignal)-12
    a=xcorr(BarkerCode,InputSignal(i:i+12));
    crosscor(i)=a(13);
end