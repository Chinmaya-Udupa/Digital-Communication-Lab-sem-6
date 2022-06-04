function channel_input=QAM_16_Generator(bits,symbol_time,samples_per_symbol_time,fc)
number_of_bits_per_symbol = 4;
samples_per_second = samples_per_symbol_time / symbol_time;

level_10 = 3;
level_00 = 1;
level_01 = -1;
level_11 = -3;
pulse_shape = ones(1, samples_per_symbol_time);


bits = reshape(bits, number_of_bits_per_symbol, []);
bits_cos = bits(1:2, :);
bits_sin = bits(3:4, :);

num_symbols = size(bits, 2);
levels_for_bits = zeros(2, num_symbols);
for s = 1:num_symbols
    if bits_cos(1, s) == 1 && bits_cos(2, s) == 0
        levels_for_bits(1, s) = level_10;
    elseif bits_cos(1, s) == 0 && bits_cos(2, s) == 0
        levels_for_bits(1, s) = level_00;
    elseif bits_cos(1, s) == 0 && bits_cos(2, s) == 1
        levels_for_bits(1, s) = level_01;
    else
        levels_for_bits(1, s) = level_11;
    end
    
    if bits_sin(1, s) == 1 && bits_sin(2, s) == 0
        levels_for_bits(2, s) = level_10;
    elseif bits_sin(1, s) == 0 && bits_sin(2, s) == 0
        levels_for_bits(2, s) = level_00;
    elseif bits_sin(1, s) == 0 && bits_sin(2, s) == 1
        levels_for_bits(2, s) = level_01;
    else
        levels_for_bits(2, s) = level_11;
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