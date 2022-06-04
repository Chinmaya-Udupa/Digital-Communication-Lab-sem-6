function plot_constellation(signal, samples_per_symbol_time, samples_per_second, fc)

frequency_offset = 0;
phase_offset = 0;

num_symbols = floor(length(signal)/samples_per_symbol_time);
signal = signal(1:num_symbols * samples_per_symbol_time);
signal = reshape(signal, samples_per_symbol_time, num_symbols)';

constellation = [];
basis_cos = cos(phase_offset + 2 * pi * (fc + frequency_offset) * [0:samples_per_symbol_time - 1]/samples_per_second);
basis_sin = sin(phase_offset + 2 * pi * (fc + frequency_offset) * [0:samples_per_symbol_time - 1]/samples_per_second);
for i = 1:num_symbols
    signal_cos_component = sum(signal(i, :) .* basis_cos) / samples_per_symbol_time;
    signal_sin_component = sum(signal(i, :) .* basis_sin) / samples_per_symbol_time;
    constellation = [constellation; [signal_cos_component, signal_sin_component]];
end

scatter(constellation(:,1), constellation(:,2));
xlabel('cos(2\pif_ct)'),ylabel('sin(2\pif_ct)');
    

