function [Samples, SamplingTimes]=EarlyLateSampler(MFx,x,Fs,Tb,InitialClockEdge,Delta,StepSize,Threshold)

Samples = [];
SamplingTimes = [];
SamplingOffset = floor(Fs*Tb/2);
ClockEdge = InitialClockEdge;

EarlyDel = SamplingOffset-Delta;
if EarlyDel < 0
    EarlyDel = 0;
elseif EarlyDel > (Fs*Tb)-1
    EarlyDel = (Fs*Tb)-1;
end

LateDel = SamplingOffset+Delta;
if LateDel < 0
    LateDel = 0;
elseif LateDel > (Fs*Tb)-1
    LateDel = (Fs*Tb)-1;
end

while (ClockEdge+(Fs*Tb)-1<length(x))
    SamplingTime = ClockEdge + SamplingOffset;
    EarlySampleTime = ClockEdge + EarlyDel;
    LateSampleTime = ClockEdge + LateDel;
    
    SamplingTimes = [SamplingTimes SamplingTime];
    Samples = [Samples x(SamplingTime)];
    
    EarlySample = abs(MFx(EarlySampleTime) - Threshold);
    LateSample = abs(MFx(LateSampleTime) - Threshold);
    
    ClockEdge = ClockEdge + (Fs*Tb);
    if EarlySample < LateSample
        ClockEdge = ClockEdge - StepSize*(LateSample - EarlySample);
    elseif EarlySample > LateSample
        ClockEdge = ClockEdge + StepSize*(LateSample - EarlySample);
    end
    ClockEdge = round(ClockEdge);
end
