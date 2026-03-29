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

% 画1#炉空燃比
a=data(12,:);
%e=data(12,:);
b=data(72,2:end);%72
c=data(86,2:end);
d=data(95,:);
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

data(73,:) = data(13,:)./data(12,:);
data(74,:) = data(32,:)./data(31,:);
data(75,:) = data(51,:)./data(50,:);
a = data(73,:)
b = data(74,:)
c = data(75,:)
d = data(60,:)
subplot(4,1,1)
plot(a,'r');
hold on
subplot(4,1,2)
plot(b,'r');
hold on
subplot(4,1,3)
plot(c,'r');
hold on
subplot(4,1,4)
plot(d,'r');
hold on

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

% 画co含量与空燃比
a=data(60,:);
%e=data(13,:);
b=data(86,:);
c=data(87,:);
d=data(88,:);
subplot(2,1,1)
plot(a,'r');
hold on
%plot(e,'k')
subplot(2,1,2)
plot(b,'r')
hold on
plot(c,'g')
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
plot(d,'b')

% 画3#煤气流量
a=data(112,:);
%e=data(38,:);
b=data(74,:);
c=data(39,:);
d=data(40,:);
subplot(2,1,1);
plot(a,'r');
hold on
plot(b,'b')
% hold on
% plot(e,'k')
subplot(2,1,2);
plot(c);
hold on
plot(d,'r')
ylim([20,50]);
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
c=data(63,:);
d=data(64,:);
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
plot(data(15,:),'r')
plot(data(68,:),'r')
plot(data(106,:),'r')
plot(data(107,:),'r')
plot(data(108,:),'r')
plot(data(109,:),'r')

a=data(68,:);
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

% 画3#空燃比/富氧
a=data(50,:);
%e=data(38,:);
b=data(74,:);
subplot(6,1,1);
plot(a,'r');
hold on
plot(b,'b');
grid on;
c=data(60,:);
%e=data(26,:);
d=data(97,:);
f=data(71,:);
g=data(68,:);
h=data(51,:);
subplot(6,1,2)
plot(c,'r');
grid on;
subplot(6,1,3)
plot(d,'b');
% axis([0,100000,0,1]);
grid on;
subplot(6,1,4)
plot(f,'b')
subplot(6,1,5)
plot(g,'b')
subplot(6,1,6)
plot(h,'b')

% 画2#空燃比/富氧
a=data(60,:);
%e=data(26,:);
d=data(96,:);
f=data(31,:);
subplot(3,1,1)
plot(a,'r');
grid on;
subplot(3,1,2)
plot(d,'b');
axis([0,100000,0,1]);
grid on;
subplot(3,1,3)
plot(f,'b')




