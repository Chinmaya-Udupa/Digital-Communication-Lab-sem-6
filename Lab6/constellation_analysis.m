clc;
clear all;
close all;

number_of_bits=6000;
bits = 1.0 * (rand(1, number_of_bits) < 0.5);
symbol_time=1;
fc=20;
samples_per_symbol_time=100;
samples_per_second = samples_per_symbol_time / symbol_time;

variance=1;
qpsk_signal=QPSK_Generator(bits,symbol_time,samples_per_symbol_time,fc);
% variance=(2*max(qpsk_signal))^2;
noise=randn(1,length(qpsk_signal))*sqrt(variance);
channel_output_qpsk=qpsk_signal+noise;

qam16_signal=QAM_16_Generator(bits,symbol_time,samples_per_symbol_time,fc);
% variance=(2*max(qam16_signal))^2;
noise=randn(1,length(qam16_signal))*sqrt(variance);
channel_output_qam16=qam16_signal+noise;


psk_signal=PSK_8_Generator(bits,symbol_time,samples_per_symbol_time,fc);
% variance=(2*max(psk_signal))^2;
noise=randn(1,length(psk_signal))*sqrt(variance);
channel_output_psk=psk_signal+noise;


subplot(1,3,1)
plot_constellation(channel_output_qpsk, samples_per_symbol_time, samples_per_second, fc);
title('Signal Constellation-QPSK');
subplot(1,3,2)
plot_constellation(channel_output_qam16, samples_per_symbol_time, samples_per_second, fc);
title('Signal Constellation-16QAM');
subplot(1,3,3)
plot_constellation(channel_output_psk, samples_per_symbol_time, samples_per_second, fc);
title('Signal Constellation-8PSK');
sgtitle('For Variance=1')