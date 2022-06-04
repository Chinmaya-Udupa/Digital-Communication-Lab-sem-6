function recieved_bits=FSK_Bit_Determiner(channel_output,symbol_time,samples_per_symbol_time)
samples_per_second = samples_per_symbol_time / symbol_time;

f1=5;
f2=10;
f3=15;
f4=20;


c1=cos(2*pi*f1.*(0:length(channel_output)-1)/samples_per_second);
c2=cos(2*pi*f2.*(0:length(channel_output)-1)/samples_per_second);
c3=cos(2*pi*f3.*(0:length(channel_output)-1)/samples_per_second);
c4=cos(2*pi*f4.*(0:length(channel_output)-1)/samples_per_second);



Recieved_f1=channel_output.*c1;
Recieved_f2=channel_output.*c2;
Recieved_f3=channel_output.*c3;
Recieved_f4=channel_output.*c4;

freq=[0 5 7.5 samples_per_second/2];
freq=freq*2/samples_per_second;
amp=[1 1 0 0];
lpf=fir2(100,freq,amp);
Recieved_f1=conv(Recieved_f1,lpf);
Recieved_f2=conv(Recieved_f2,lpf);
Recieved_f3=conv(Recieved_f3,lpf);
Recieved_f4=conv(Recieved_f4,lpf);

sampling=symbol_time*samples_per_second;
number_of_symbols=round(length(channel_output)/sampling-1);
sampled_signal=zeros(1,number_of_symbols);
b=[1 1 0 0;1 0 1 0];

recieved_bits=zeros(1,2*number_of_symbols);
for j=1:number_of_symbols
    sample_f1=Recieved_f1((j)*sampling+40);
    sample_f2=Recieved_f2((j)*sampling+40);
    sample_f3=Recieved_f3((j)*sampling+40);
    sample_f4=Recieved_f4((j)*sampling+40);
    [m,p]=max([sample_f1 sample_f2 sample_f3 sample_f4]);
    recieved_bits(2*j-1)=b(1,p);
    recieved_bits(2*j)=b(2,p);
end
end