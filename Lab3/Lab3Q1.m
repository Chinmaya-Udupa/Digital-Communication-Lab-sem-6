N=50000;
Nf=50;
Tb=0.1;% dont change it to anything else
BarkerCode=[+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
data=BitGenerator(N);
data(data==0)=-1;
Frames=zeros(N/Nf,(Nf+13)*(1/Tb));% columns are continuos frames(barker included), ith row has ith frame
D=(1/Tb)*randi([10 100]);% 1/Tb is upsampling factor
TxSignal=zeros(1,D);

for i=1:N/Nf
    Frames(i,:)=FrameGenerator(data,Nf,i,Tb);
end

% stitching frames
for i=1:N/Nf
    TxSignal=[TxSignal Frames(i,:) upsample(zeros(1,randi([10 100])),1/Tb)];
    % predefining size of DataInFrames leads to certain errors, as it
    % depends on a random interval b/w 2 frames
end
% plot(TxSignal)
% sampling the continous time frames
TxSignalSampled=zeros(1,floor(length(TxSignal)/10));
j=1;
for i=1/(Tb):1/Tb:length(TxSignal)
    TxSignalSampled(j)=TxSignal(i);
    j=j+1;
end
% stem(DataInFramesSampled)
FrameStartErrorRate=zeros(1,20);
for k=1:50
sigma2=0:0.05:2.45;
gamma=1;
ChannelOutput=TxSignal*gamma+randn(1,length(TxSignal))*sigma2(k);
% plot(ChannelOutput)
% figure;
% plot(ChannelOutput)
% title('Zoomed in')
% xlim([10000 12000])

MF=Tb*ones(1,1/Tb);% Matched Filter
MFOutput=conv(MF,ChannelOutput);
MFOutput=MFOutput(1:end-(length(MF)-1));
MFOutputSampled=zeros(1,floor(length(MFOutput)/10));

j=1;
for i=1/Tb:1/Tb:length(MFOutput)
    MFOutputSampled(j)=MFOutput(i);
    j=j+1;
end

% plot(MFOutput);
% hold on;
% stem(1/Tb:1/Tb:length(MFOutput),MFOutputSampled);
% xlim([10000 12000])
% title('Matched Filter Output')
% legend('Continuous','Sampled')
% hold off;

% Decision making
MFOutputSampledDx=zeros(1,length(MFOutputSampled));
MFOutputSampledDx(MFOutputSampled>=0)=1;
MFOutputSampledDx(MFOutputSampled<0)=-1;

MFOxBarker=BarkerXCorr13Bits(MFOutputSampledDx);
% stem(MFOxBarker)
% title('Cross Correlation of Signal with Barker')
l=length(MFOxBarker(MFOxBarker==13));
% 
% j=1;
% if l==N/Nf
%     RxOutputFrame=zeros(N/Nf,Nf);
%     for i=1:length(MFOxBarker)
%         if MFOxBarker(i)==13
%             RxOutputFrame(j,:)=MFOutputSampledDx(i+13:i+(Nf+12));
%             j=j+1;
%         end
%     end
%     RxOutput=[];
%     for i=1:N/Nf
%         RxOutput=[RxOutput RxOutputFrame(i,:)];
%     end
% else
% %     RxOutputFrame=zeros(l,Nf);
% %     for i=1:length(MFOxBarker)
% %         if MFOxBarker(i)==13
% %             RxOutputFrame(j,:)=MFOutputSampledDx(i+13:i+(Nf+12));
% %             j=j+1;
% %         end
% %     end
%     FrameStartErrorRate(k)=l-N/Nf;
% end
if l~=N/Nf
    FrameStartErrorRate(k)=abs(l-N/Nf);
end
end
stem(sigma2,FrameStartErrorRate)
