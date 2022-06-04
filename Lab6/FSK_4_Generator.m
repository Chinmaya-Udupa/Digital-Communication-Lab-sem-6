function channel_input=FSK_4_Generator(bits,symbol_time,samples_per_symbol_time)
number_of_bits_per_symbol = 2;
samples_per_second = samples_per_symbol_time / symbol_time;
f1=5;
f2=10;
f3=15;
f4=20;
pulse_shape = ones(1, samples_per_symbol_time);
bits = reshape(bits, number_of_bits_per_symbol, []);
num_symbols = size(bits, 2);
fc=zeros(1,num_symbols);
for s = 1:num_symbols
    if (bits(1,s) == 1)&&(bits(2,s) == 1)
        fc(s) = f1;
    elseif (bits(1,s) == 1)&&(bits(2,s) == 0)
        fc(s) = f2;
    elseif (bits(1,s) == 0)&&(bits(2,s) == 1)
        fc(s) = f3;
    else
        fc(s) = f4;
    end
end
fc=upsample(fc, samples_per_symbol_time);
fc=conv(fc, pulse_shape);
channel_input=cos(2*pi*fc.*(0:length(fc)-1)/samples_per_second);
end