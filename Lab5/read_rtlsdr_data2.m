% ------------------------------------------------------------------------------------------
% Simple Matlab script, that reads an RTL-SDR IQ signal from a file,
% that has been captured by the "rtl_sdr" command from librtlsdr
% 
% shows the IQ signal with absolute value and angle, as well as a spectrogram
%
% by DC9ST, 2016
% ------------------------------------------------------------------------------------------

clear;
clc;
close all;

% filename 
filename1 = 'HELLO_dataset.bin';
% filename1 = 'evaluation.bin';

% read data from file
fileID1 = fopen(filename1);
a = fread(fileID1);
fclose(fileID1); 

% extract I/Q data
num_samples1 = length(a)/2; % determine number of samples
a1 = a(1:num_samples1*2);
inphase1 = a1(1:2:end) -128;
quadrature1 = a1(2:2:end) -128;
% 
% % plot signal in time domain results
% num_plot_samples = length(inphase1);
% 
% subplot(2,1,1); plot(1:num_plot_samples, inphase1(1:num_plot_samples), 1:num_plot_samples, quadrature1(1:num_plot_samples));
% title('RX: I and Q');
% 
% subplot(2,1,2); plot(1:num_plot_samples, abs(inphase1+1i*quadrature1));
% title('abs');

% subplot(3,1,3); plot(1:num_plot_samples, unwrap(angle(inphase1+1i*quadrature1)));
% title('unwrapped phase');
% 
% 
% %% calculate and show spectrogram
% figure;
% complex_signal = detrend(inphase1+1i*quadrature1);
% [S,F,T,P] = spectrogram(complex_signal, 512, 0, 512, num_plot_samples );
% spectrum = fftshift(fliplr(10*log10(abs(P))'));
% surf(F,T, spectrum, 'edgecolor', 'none');
% axis tight;
% view(0,90);
% 
% figure;
%%
signal=abs(inphase1+1i*quadrature1);
filter=firpm(99,[0,0.1,0.2,1],[1,1,0,0]);
FilterOutput=conv(filter,signal);
% plot(FilterOutput)
% mean(FilterOutput(1649110:1690590))= 88.1581   10 ones and zeros
% min(FilterOutput(1649110:1690590))=6.2083
% max(FilterOutput(1649110:1690590))=184.7207
% mean(FilterOutput(1649110:1651190))=151.7068   ones
% mean(FilterOutput(1651290:1653220))= 20.1889   zeros
%%
FilterOutput=FilterOutput-20.1889;
FilterOutput=FilterOutput/131.5179;
pt=ones(1,2048)/2048;
MFOutput=conv(FilterOutput,pt);
% plot(MFOutput)
%%
[FilOutSamples, FilOutSamplingTimes]= EarlyLateSampler(MFOutput,FilterOutput,20480,0.1,128,256,100,0.5);
% plot(FilterOutput)
% hold on
% stem(FilOutSamplingTimes,FilOutSamples)
% hold off
%%
yn(FilOutSamples>=0.5)=1;
yn(FilOutSamples<=0.5)=-1;
% stem(BinaryFilOutSamp)
ynxAB=AltBitsXCorr(yn,20);
% stem(ynxAB)
% figure;
ynxBC=BarkerXCorr13Bits(yn);
% stem(ynxBC)
%%
j=1;
% y=zeros(14,40);
for i=1:length(ynxBC)
     if ynxBC(i)==13
         if i<length(yn)-52
            y(j,:)=yn(i+13:i+52);
         else
             y(j,:)=[yn(i+13:end) zeros(1,3)];
         end
         j=j+1;
     end
end
%%
a_=zeros(5,14);
for i=1:14
    y0(y(i,:)==-1)=0;
    y0(y(i,:)==1)=1;
    for j=0:4
        a_8=y0(1+(8*j):8*j+8);
        an=(num2str(a_8));
        an(isspace(an))='';
        a_(j+1,i)=bin2dec((an));
    end
    fprintf('%d th frame - %s %s %s %s %s \n',i,char(a_(1,i)),char(a_(2,i)),char(a_(3,i)),char(a_(4,i)),char(a_(5,i)));
end