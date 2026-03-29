
% 画篦冷机
dl_lvbo_time = 14;
for b =2:3900
    if b>=50    
        data(107,b+1)=sum(data(7,b-33:b+1))/35;%11风机电流 35
    else
        data(107,b+1)=data(7,b+1);
    end
end
figure(1)
a=data(87,2:end);
%e=data(12,:);
b=data(101,2:end);%72
c=data(2,2:end);
d=data(3,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b,'b')
ylim([240,270])
subplot(2,1,2)
% plot(d,'r')
hold on
plot(c,'b')

%分解炉
figure(3)
a=data(80,2:end);
%e=data(12,:);
b=data(66,2:end);%72
c=data(12,2:end);
d=data(74,2:end);
e=data(79,2:end);
f=data(77,2:end);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b,'b')
hold on
ylim([840,870])
%plot(e,'k')
subplot(3,1,2)
plot(d,'r')
hold on
plot(c,'b')
ylim([9,12])
subplot(3,1,3)
plot(e,'r')
hold on
plot(f,'b')
ylim([24,28])

%斗提电流
figure(3)
a=data(89,2:end);
%e=data(12,:);
b=data(102,2:end);%72
c=data(97,2:end);
d=data(97,2:end);
e=data(29,2:end);
f=data(77,2:end);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b,'b')
hold on
ylim([110,150])
%plot(e,'k')
subplot(3,1,2)
plot(d,'r')
hold on
plot(c,'b')
ylim([239,242])
subplot(3,1,3)
plot(e,'r')
hold on
plot(f,'b')
ylim([230,250])

%窑电流
figure(3)
a=data(55,2:end);
%e=data(12,:);
b=data(56,2:end);%72
subplot(2,1,1)
plot(a,'r');
% ylim([110,150])
subplot(2,1,2)
plot(b,'r')
% ylim([239,242])
