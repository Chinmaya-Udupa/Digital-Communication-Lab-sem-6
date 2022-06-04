function frame=FrameGenerator(input,FrameLength,nth_frame,Tb)

BarkerCode=[+1 +1 +1 +1 +1 -1 -1 +1 +1 -1 +1 -1 +1];
frame=[BarkerCode input((nth_frame-1)*FrameLength+1:FrameLength*nth_frame)];

pt=ones(1,1/Tb);
frame=upsample(frame,1/Tb);
frame=conv(frame,pt);
frame=frame(1:end-(length(pt)-1));% extra bits after convolution 