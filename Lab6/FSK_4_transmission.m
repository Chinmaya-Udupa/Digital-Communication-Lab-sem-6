clear;
total=0;
number_of_bits_per_symbol = 2;
number_of_runs = 100;
number_of_symbols = 100;
number_of_bits = number_of_bits_per_symbol * number_of_symbols;
symbol_time = 1;
samples_per_symbol_time = 100;
samples_per_second = samples_per_symbol_time / symbol_time;
f1=5;
f2=10;
f3=15;
f4=20;
bit = 1.0 * (rand(1, number_of_bits) < 0.5);
bits = reshape(bit, number_of_bits_per_symbol, []);
channel_input=FSK_4_Generator(bits,symbol_time,samples_per_symbol_time);
received_bits=FSK_Bit_Determiner(channel_input,symbol_time,samples_per_symbol_time);
plot(received_bits-bit);
% 
% pulse_shape = ones(1, samples_per_symbol_time);
% 
% for i=1:number_of_runs
% bit = 1.0 * (rand(1, number_of_bits) < 0.5);
% bits = reshape(bit, number_of_bits_per_symbol, []);
% num_symbols = size(bits, 2);
% fc=zeros(1,num_symbols);
% levels_for_bits = zeros(2, num_symbols);
% for s = 1:num_symbols
%     if (bits(1,s) == 1)&&(bits(2,s) == 1)
%         fc(s) = f1;
%     elseif (bits(1,s) == 1)&&(bits(2,s) == 0)
%         fc(s) = f2;
%     elseif (bits(1,s) == 0)&&(bits(2,s) == 1)
%         fc(s) = f3;
%     else
%         fc(s) = f4;
%     end
% end
% fc=upsample(fc, samples_per_symbol_time);
% fc=conv(fc, pulse_shape);
% signal=cos(2*pi*fc.*(0:length(fc)-1)/samples_per_second);
% 
% c1=cos(2*pi*f1.*(0:length(fc)-1)/samples_per_second);
% c2=cos(2*pi*f2.*(0:length(fc)-1)/samples_per_second);
% c3=cos(2*pi*f3.*(0:length(fc)-1)/samples_per_second);
% c4=cos(2*pi*f4.*(0:length(fc)-1)/samples_per_second);
% 
% channel_input = signal;
% 
% Recieved_f1=channel_input.*c1;
% Recieved_f2=channel_input.*c2;
% Recieved_f3=channel_input.*c3;
% Recieved_f4=channel_input.*c4;
% 
% freq=[0 5 7.5 samples_per_second/2];
% freq=freq*2/samples_per_second;
% amp=[1 1 0 0];
% lpf=fir2(100,freq,amp);
% Recieved_f1=conv(Recieved_f1,lpf);
% Recieved_f2=conv(Recieved_f2,lpf);
% Recieved_f3=conv(Recieved_f3,lpf);
% Recieved_f4=conv(Recieved_f4,lpf);
% 
% sampling=symbol_time*samples_per_second;
% 
% sampled_signal=zeros(1,number_of_symbols);
% b=[1 1 0 0;1 0 1 0];
% 
% recieved_bits=zeros(1,2*number_of_symbols);
% for j=1:number_of_symbols
%     sample_f1=Recieved_f1((j)*sampling+40);
%     sample_f2=Recieved_f2((j)*sampling+40);
%     sample_f3=Recieved_f3((j)*sampling+40);
%     sample_f4=Recieved_f4((j)*sampling+40);
%     [m,p]=max([sample_f1 sample_f2 sample_f3 sample_f4]);
%     recieved_bits(2*j-1)=b(1,p);
%     recieved_bits(2*j)=b(2,p);
% end
% magspectrum = fftshift(abs(fft(channel_input)));
% power_spectrum = magspectrum.^2;
% total=total+power_spectrum;
% end
% x=linspace(-samples_per_second/2,samples_per_second/2,length(total));
% plot(x,total/number_of_runs);
% title('Power Spectrum-4-FSK');
