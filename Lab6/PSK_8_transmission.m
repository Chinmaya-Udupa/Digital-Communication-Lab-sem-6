clear;
total=0;
number_of_runs=100;
fc = 20;
number_of_bits_per_symbol = 3;
number_of_symbols=100;
number_of_bits = number_of_bits_per_symbol * number_of_symbols;
symbol_time = 1;
samples_per_symbol_time = 100;
samples_per_second = samples_per_symbol_time / symbol_time;
bit = 1.0 * (rand(1, number_of_bits) < 0.5);
bits = reshape(bit, number_of_bits_per_symbol, []);
channel_input=QAM_16_Generator(bits,symbol_time,samples_per_symbol_time,fc);
received_bits=QAM_16_Bit_Determiner(channel_input,symbol_time,samples_per_symbol_time,fc);
plot(received_bits-bit);


% level_0 = 1;
% level_1 = 1/(2^0.5);
% level_2 = 0;
% level_3 = -1/(2^0.5);
% level_4 = -1;
% pulse_shape = ones(1, samples_per_symbol_time);
% for i=1:number_of_runs
% bit = 1.0 * (rand(1, number_of_bits) < 0.5);
% bits = reshape(bit, number_of_bits_per_symbol, []);
% % bits_cos = bits(1:2, :);
% % bits_sin = bits(3:4, :);
% 
% num_symbols = size(bits, 2);
% levels_for_bits = zeros(2, num_symbols);
% for s = 1:num_symbols
%     if bits(1, s)==0 && bits(2, s) == 0 && bits(3, s)== 0
%         levels_for_bits(1, s) = level_2;
%         levels_for_bits(2, s) = level_0;
%     elseif bits(1, s)==0 && bits(2, s) == 0 && bits(3, s) == 1
%         levels_for_bits(1, s) = level_1;
%         levels_for_bits(2, s) = level_1;
%     elseif bits(1, s)==0 && bits(2, s) == 1 && bits(3, s) == 0
%         levels_for_bits(1, s) = level_0;
%         levels_for_bits(2, s) = level_2;
%     elseif bits(1, s)==0 && bits(2, s) == 1 && bits(3, s) == 1
%         levels_for_bits(1, s) = level_1;
%         levels_for_bits(2, s) = level_3;
%     elseif bits(1, s)==1 && bits(2, s) == 0 && bits(3, s) == 0
%         levels_for_bits(1, s) = level_2;
%         levels_for_bits(2, s) = level_4;
%     elseif bits(1, s)==1 && bits(2, s) == 0 && bits(3, s) == 1
%         levels_for_bits(1, s) = level_3;
%         levels_for_bits(2, s) = level_3;
%     elseif bits(1, s)==1 && bits(2, s) == 1 && bits(3, s) == 0
%         levels_for_bits(1, s) = level_4;
%         levels_for_bits(2, s) = level_2;
%     else 
%         levels_for_bits(1, s) = level_3;
%         levels_for_bits(2, s) = level_1;
%     end
% end
% 
% impulse_train_cos = upsample(levels_for_bits(1, :), samples_per_symbol_time);
% impulse_train_sin = upsample(levels_for_bits(2, :), samples_per_symbol_time);
% 
% line_code_cos = conv(impulse_train_cos, pulse_shape);
% line_code_sin = conv(impulse_train_sin, pulse_shape);
% cos_carrier = cos(2 * pi * fc * (0:length(line_code_cos)-1)/samples_per_second);
% sin_carrier = sin(2 * pi * fc * (0:length(line_code_sin)-1)/samples_per_second);
% 
% channel_input = line_code_cos .* cos_carrier - line_code_sin .* sin_carrier;
% 
% Recieved_cos=channel_input.*cos_carrier;
% Recieved_sin=-channel_input.*sin_carrier;
% freq=[0 fc 1.5*fc samples_per_second/2];
% freq=freq*2/samples_per_second;
% amp=[1 1 0 0];
% lpf=fir2(100,freq,amp);
% Recieved_cos=conv(Recieved_cos,lpf);
% Recieved_sin=conv(Recieved_sin,lpf);
% sampling=symbol_time*samples_per_second;
% 
% sampled_signal_cos=zeros(1,number_of_symbols);
% sampled_signal_sin=zeros(1,number_of_symbols);
% for j=1:number_of_symbols
% sampled_signal_cos(j)=Recieved_cos((j)*sampling+40);
% sampled_signal_sin(j)=Recieved_sin((j)*sampling+40);
% end
% recieved_bits=zeros(1,3*number_of_symbols);
% 
% for j=1:number_of_symbols
%     angle=atan(sampled_signal_sin(j)/sampled_signal_cos(j));
%     if sampled_signal_cos(j)<0
%         angle=angle+pi;
%     end
%     if (angle<=pi/8) && (angle>-pi/8)    
%         recieved_bits(3*j-2)=0;
%         recieved_bits(3*j-1)=1;
%         recieved_bits(3*j)=0;
%     elseif (angle<=3*pi/8) && (angle>pi/8)
%         recieved_bits(3*j-2)=0;
%         recieved_bits(3*j-1)=0;
%         recieved_bits(3*j)=1;
%     elseif (angle<=5*pi/8) && (angle>3*pi/8)
%         recieved_bits(3*j-2)=0;
%         recieved_bits(3*j-1)=0;
%         recieved_bits(3*j)=0;
%     elseif (angle<=7*pi/8) && (angle>5*pi/8)
%         recieved_bits(3*j-2)=1;
%         recieved_bits(3*j-1)=1;
%         recieved_bits(3*j)=1;
%     elseif (angle<=9*pi/8) && (angle>7*pi/8)
%         recieved_bits(3*j-2)=1;
%         recieved_bits(3*j-1)=1;
%         recieved_bits(3*j)=0;
%     elseif (angle<=11*pi/8) && (angle>9*pi/8)
%         recieved_bits(3*j-2)=1;
%         recieved_bits(3*j-1)=0;
%         recieved_bits(3*j)=1;
%     elseif (angle<=-pi/8) && (angle>-3*pi/8)
%         recieved_bits(3*j-2)=0;
%         recieved_bits(3*j-1)=1;
%         recieved_bits(3*j)=1;
%     else
%         recieved_bits(3*j-2)=1;
%         recieved_bits(3*j-1)=0;
%         recieved_bits(3*j)=0;
%     end
% end
% 
% 
% 
% magspectrum = fftshift(abs(fft(channel_input)));
% power_spectrum = magspectrum.^2;
% total=total+power_spectrum;
% end
% 
% x=linspace(-(samples_per_second)/2,(samples_per_second)/2,length(total));
% plot(x,total/number_of_runs);
% title('Power Spectrum-8-PSK');
% figure;
% plot_constellation(channel_input, samples_per_symbol_time, samples_per_second, fc);
% title('Signal Constellation-8-PSK');