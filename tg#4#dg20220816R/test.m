a=data(45,2:end);       %a炉温
c=data(31,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(33,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 10 100])
hold on
plot(d)