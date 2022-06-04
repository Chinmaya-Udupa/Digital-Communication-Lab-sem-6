function received_bits=QPSK_Bit_Determiner(channel_output,symbol_time,samples_per_symbol_time,fc)
samples_per_second = samples_per_symbol_time / symbol_time;

cos_carrier = cos(2 * pi * fc * (0:length(channel_output)-1)/samples_per_second);
sin_carrier = sin(2 * pi * fc * (0:length(channel_output)-1)/samples_per_second);

Recieved_cos=channel_output.*cos_carrier;
Recieved_sin=-channel_output.*sin_carrier;
freq=[0 fc fc+20 samples_per_second/2];
freq=freq*2/samples_per_second;
amp=[1 1 0 0];
lpf=fir2(100,freq,amp);
Recieved_cos=conv(Recieved_cos,lpf);
Recieved_sin=conv(Recieved_sin,lpf);
sampling=symbol_time*samples_per_second;
number_of_symbols=round(length(channel_output)/sampling-1);
sampled_signal_cos=zeros(1,round(number_of_symbols));
sampled_signal_sin=zeros(1,round(number_of_symbols));
for j=1:number_of_symbols
sampled_signal_cos(j)=Recieved_cos((j)*sampling+40);
sampled_signal_sin(j)=Recieved_sin((j)*sampling+40);
end
%recieved_bits=zeros(1,(2*round(number_of_symbols)));

for j=1:number_of_symbols
    if sampled_signal_cos(j)>0
    received_bits(2*j-1)=1;
    else
    received_bits(2*j-1)=0;
    end
    
    if sampled_signal_sin(j)>0
    received_bits(2*j)=1;
    else
    received_bits(2*j)=0;
    end
end


end