function channel_input=PSK_8_Generator(bits,symbol_time,samples_per_symbol_time,fc)


number_of_bits_per_symbol = 3;

samples_per_second = samples_per_symbol_time / symbol_time;

level_0 = 1;
level_1 = 1/(2^0.5);
level_2 = 0;
level_3 = -1/(2^0.5);
level_4 = -1;
pulse_shape = ones(1, samples_per_symbol_time);
bits = reshape(bits, number_of_bits_per_symbol, []);

num_symbols = size(bits, 2);
levels_for_bits = zeros(2, num_symbols);
for s = 1:num_symbols
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
    if bits(1, s)==0 && bits(2, s) == 0 && bits(3, s)== 0
        levels_for_bits(1, s) = level_4;
        levels_for_bits(2, s) = level_2;
    elseif bits(1, s)==0 && bits(2, s) == 0 && bits(3, s) == 1
        levels_for_bits(1, s) = level_3;
        levels_for_bits(2, s) = level_1;
    elseif bits(1, s)==0 && bits(2, s) == 1 && bits(3, s) == 0
        levels_for_bits(1, s) = level_1;
        levels_for_bits(2, s) = level_1;
    elseif bits(1, s)==0 && bits(2, s) == 1 && bits(3, s) == 1
        levels_for_bits(1, s) = level_2;
        levels_for_bits(2, s) = level_0;
    elseif bits(1, s)==1 && bits(2, s) == 0 && bits(3, s) == 0
        levels_for_bits(1, s) = level_3;
        levels_for_bits(2, s) = level_3;
    elseif bits(1, s)==1 && bits(2, s) == 0 && bits(3, s) == 1
        levels_for_bits(1, s) = level_2;
        levels_for_bits(2, s) = level_4;
    elseif bits(1, s)==1 && bits(2, s) == 1 && bits(3, s) == 0
        levels_for_bits(1, s) = level_0;
        levels_for_bits(2, s) = level_2;
    else 
        levels_for_bits(1, s) = level_1;
        levels_for_bits(2, s) = level_3;
    end
end

impulse_train_cos = upsample(levels_for_bits(1, :), samples_per_symbol_time);
impulse_train_sin = upsample(levels_for_bits(2, :), samples_per_symbol_time);

line_code_cos = conv(impulse_train_cos, pulse_shape);
line_code_sin = conv(impulse_train_sin, pulse_shape);
cos_carrier = cos(2 * pi * fc * (0:length(line_code_cos)-1)/samples_per_second);
sin_carrier = sin(2 * pi * fc * (0:length(line_code_sin)-1)/samples_per_second);

channel_input = line_code_cos .* cos_carrier - line_code_sin .* sin_carrier;


end