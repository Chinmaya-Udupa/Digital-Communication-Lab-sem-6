D=10*randi([1 100]);
pulse=[zeros(1,D) ones(1,100)];
pt=0.01*ones(1,100);
output=conv(pt,pulse);
stem(0:0.01:(length(output)-0.01)/100,output,'r')
hold on
stem(0:0.01:(length(pulse)-0.01)/100,pulse,'b')
k=randi([1 length(output)-50]);
for i=1:25
    if (output(k)==0)
        k=k+100;
    else
        if (output(k)<output(k+6))
            k=k+10;
        elseif (output(k)>output(k+6))
            k=k-6;
        elseif (output(k)==output(k+6))
            k=k+3;
            break
        end
    end
end
plot((k-1)/100,output(k),'sk','MarkerSize',5,'LineWidth',5)