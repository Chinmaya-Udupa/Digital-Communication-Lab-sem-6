function x = AlternatingBits(first,second,length)
x=zeros(1,length);
if rem(length,2)==1
    len=length-1;
else
    len=length;
end
for i=1:len/2
    x((2*i)-1)=first;
    x(2*i)=second;
end
if rem(length,2)==1
    x(end)=first;
end