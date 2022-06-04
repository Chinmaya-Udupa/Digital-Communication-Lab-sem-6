clc;
clear all;
close all;

number_of_runs=1;
variance=0:0.1:5;
total_qpsk_ser=zeros(1,length(variance));
total_qpsk_ber=zeros(1,length(variance));
total_qam_ser=zeros(1,length(variance));
total_qam_ber=zeros(1,length(variance));
total_psk_ser=zeros(1,length(variance));
total_psk_ber=zeros(1,length(variance));
total_fsk_ser=zeros(1,length(variance));
total_fsk_ber=zeros(1,length(variance));
for z=1:number_of_runs
number_of_bits=6000;
bits = 1.0 * (rand(1, number_of_bits) < 0.5);
symbol_time=1;
fc=20;
samples_per_symbol_time=100;
samples_per_second = samples_per_symbol_time / symbol_time;

for i=1:length(variance)
qpsk_signal=QPSK_Generator(bits,symbol_time,samples_per_symbol_time,fc);
noise=max(qpsk_signal)*randn(1,length(qpsk_signal))*variance(i);
channel_output_qpsk=qpsk_signal+noise;
recieve_bits_qpsk=QPSK_Bit_Determiner(channel_output_qpsk,symbol_time,samples_per_symbol_time,fc);
[qpsk_ser(i),qpsk_ber(i)]=Symbol_and_Bit_Error_Rate(bits,recieve_bits_qpsk,2);
total_qpsk_ser(i)=qpsk_ser(i)+total_qpsk_ser(i);
total_qpsk_ber(i)=qpsk_ber(i)+total_qpsk_ber(i);

qam16_signal=QAM_16_Generator(bits,symbol_time,samples_per_symbol_time,fc);
noise=max(qam16_signal)*randn(1,length(qam16_signal))*variance(i);
channel_output_qam16=qam16_signal+noise;
recieve_bits_qam16=QAM_16_Bit_Determiner(channel_output_qam16,symbol_time,samples_per_symbol_time,fc);
[qam_ser(i),qam_ber(i)]=Symbol_and_Bit_Error_Rate(bits,recieve_bits_qam16,4);
total_qam_ser(i)=qam_ser(i)+total_qam_ser(i);
total_qam_ber(i)=qam_ber(i)+total_qam_ber(i);

psk_signal=PSK_8_Generator(bits,symbol_time,samples_per_symbol_time,fc);
noise=max(psk_signal)*randn(1,length(psk_signal))*variance(i);
channel_output_psk=psk_signal+noise;
recieve_bits_psk=PSK_Bit_Determiner(channel_output_psk,symbol_time,samples_per_symbol_time,fc);
[psk_ser(i),psk_ber(i)]=Symbol_and_Bit_Error_Rate(bits,recieve_bits_psk,3);
total_psk_ser(i)=psk_ser(i)+total_psk_ser(i);
total_psk_ber(i)=psk_ber(i)+total_psk_ber(i);

fsk_signal=FSK_4_Generator(bits,symbol_time,samples_per_symbol_time);
noise=max(fsk_signal)*randn(1,length(fsk_signal))*variance(i);
channel_output_fsk=fsk_signal+noise;
recieve_bits_fsk=FSK_Bit_Determiner(channel_output_fsk,symbol_time,samples_per_symbol_time);
[fsk_ser(i),fsk_ber(i)]=Symbol_and_Bit_Error_Rate(bits,recieve_bits_fsk,2);
total_fsk_ser(i)=fsk_ser(i)+total_fsk_ser(i);
total_fsk_ber(i)=fsk_ber(i)+total_fsk_ber(i);
end
 
end
avg_qpsk_ser=total_qpsk_ser/number_of_runs;
avg_qpsk_ber=total_qpsk_ber/number_of_runs;
avg_qam_ser=total_qam_ser/number_of_runs;
avg_qam_ber=total_qam_ber/number_of_runs;
avg_psk_ser=total_psk_ser/number_of_runs;
avg_psk_ber=total_psk_ber/number_of_runs;
avg_fsk_ser=total_fsk_ser/number_of_runs;
avg_fsk_ber=total_fsk_ber/number_of_runs;

subplot(2,1,1)
plot(variance,avg_qpsk_ser,'g')
hold on
plot(variance,avg_qam_ser,'b')
plot(variance,avg_psk_ser,'r')
plot(variance,avg_fsk_ser,'k')
hold off
title('Symbol Error Rate')
legend('16-QAM','8-PSK','QPSK','4-FSK')
subplot(2,1,2)
plot(variance,avg_qpsk_ber,'g')
hold on
plot(variance,avg_qam_ber,'b')
plot(variance,avg_psk_ber,'r')
plot(variance,avg_fsk_ber,'k')
hold off
title('Bit Error Rate')
legend('16-QAM','8-PSK','QPSK','4-FSK')
