% 画1#炉煤气流量
a=data(12,:);
%e=data(12,:);
b=data(72,2:end);%72
c=data(1,2:end);
d=data(2,:);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b,'b')
hold on
%plot(e,'k')
subplot(2,1,2)
plot(d,'r')
hold on
plot(c,'b')

% 画1#炉空气流量
a=data(13,:);
%e=data(13,:);
b=data(75,:);
c=data(3,:);
d=data(4,:);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b,'b');
hold on
%plot(e,'k')
subplot(2,1,2)
plot(c,'r')
hold on
plot(d,'b')


% 画2#炉煤气流量
a=data(31,:);
%e=data(25,:);
b=data(73,:);
c=data(20,:);
d=data(21,:);
subplot(2,1,1);
plot(a,'r');
hold on
plot(b,'b')
hold on
%plot(e,'k')
subplot(2,1,2);
plot(c,'r');
hold on
plot(d);


% 画2#空气PID
a=data(32,:);
%e=data(26,:);
b=data(76,:);
c=data(22,:);
d=data(23,:);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b,'b');
% hold on
% plot(e,'k')
subplot(2,1,2)
plot(c,'r')
hold on
plot(d,'r')

% 画3#煤气流量
a=data(50,:);
%e=data(38,:);
b=data(74,:);
c=data(39,:);
d=data(40,:);
f=data(61,:);
subplot(3,1,1);
plot(a,'r');
hold on
plot(b,'b')
% hold on
% plot(e,'k')
subplot(3,1,2);
plot(c);
hold on
plot(d,'r')
% ylim([24,30]);
subplot(3,1,3);
plot(f);




% 画3#空气PID
a=data(51,:);
%e=data(26,:);
b=data(77,:);
c=data(41,:);
d=data(42,:);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b,'b');
% hold on
% plot(e,'k')
subplot(2,1,2)
plot(c,'r')
hold on
plot(d,'b')

%画助燃风机压力
a=data(62,:);
b=data(85,:);
c=data(69,:);
d=data(70,:);
subplot(2,1,1);
plot(a,'r');
hold on
plot(b)
hold on 
subplot(2,1,2);
plot(c,'r');
hold on
plot(d,'b')

%画煤气总管压力
a=data(66,:);
b=data(43,:);
c=data(40,:);
d=data(41,:);
subplot(2,1,1);
plot(a,'r');
hold on
plot(b)
subplot(2,1,2);
plot(c);
hold on
plot(d,'r')




