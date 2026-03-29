% 煤气压力
a=data(52,:);
plot(a,'r');
hold on
plot(a)
% 炉压
figure
a=filter2(data(50,:));
plot(a,'r');
hold on
plot(a)
%画出风机频率和空气总管压力设定值
a=data(53,:);                   %a表示风机频率
b=data(162,:);                   %b表示空气总管压力设定值
c=data(51,:);                    %a表示空气总管压力实际值
subplot(2,1,1)
plot(b,'r');
hold on 
plot(c,'b');
subplot(2,1,2);
plot(a);

%空燃比
a=filter2(data(181,:));       %a表示流量设定值，b表示流量测量值
b=data(182,:);
c=data(183,:);
plot(a,'r');
hold on
plot(b,'b')
hold on
plot(c,'g')
grid on
ylim([0.3,1.5]);
%三段温度
a=data(177,:);       %a表示流量设定值，b表示流量测量值
b=data(150,:);
c=data(178,:);       %a表示流量设定值，b表示流量测量值
d=data(151,:);
e=data(152,:);       %a表示流量设定值，b表示流量测量值
f=data(45,:);     %a表示流量设定值，b表示流量测量值
ylim([800,1300]);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b)
axis([0 4000 900 1200])
subplot(3,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)
axis([0 4000 1100 1300])
subplot(3,1,3)
plot(e,'r')
hold on
plot(f)
axis([0 4000 1200 1300])
% 画一加煤气流量
a=data(131,:);       %a表示流量设定值，b表示流量测量值
% b=data(141,:);       %b=data(91,:);
b=data(6,:);       %b=data(91,:);
c=data(3,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(4,2:end);
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 10 100])
hold on
plot(d)
% 画一加空气流量
a=data(135,:);
b=data(145,:);
e=data(5,:);
c=data(1,2:end);
d=data(2,2:end); 
subplot(3,1,1)
plot(a,'r');
hold on
plot(b);
subplot(3,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)
subplot(3,1,3)
plot(b,'r')
%axis([0 1000 0 100])
hold on
plot(e)

% 画一加空气流量
a=data(5,:);
b=data(5,:);
c=data(1,2:end);
d=data(2,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)
%一段温度
a=data(177,:);       %a表示流量设定值，b表示流量测量值
% b=data(21,:);
b=data(150,:);
c=data(18,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(19,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)


%一加空烟pid
subplot(2,1,1)
a=data(154,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(167,:);%+data(15,:))./2;
% c=data(185,:);
% d=data(186,:);
% e=data(187,:);
plot(a,'r');
grid on
ylim([80,160]);
hold on
plot(b);
% hold on
% plot(c,'m');
% hold on
% plot(d,'y');
% hold on
% plot(e,'k');
subplot(2,1,2);
plot(data(11,:),'r');           %空烟阀门开度设定值
grid on
hold on
plot(data(12,:),'b');           %空烟阀门开度设定值

% 一加煤烟PID
subplot(2,1,1)                  %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(158,:);
b=data(171,:);%+data(16,:))./2;
c=filter2(data(171,:));
plot(a,'r');
grid on
ylim([80,160]);
hold on
plot(b);
hold on
plot(c,'g');
subplot(2,1,2);
plot(data(13,:),'r');            %表示煤烟阀门开度设定值
grid on
hold on
plot(data(14,:),'b'); 
% 画二加煤气流量
figure
a=data(132,:);       %a表示流量设定值，b表示流量测量值
 b=data(21,:);
%b=data(142,:);
c=data(18,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(19,2:end);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b)
subplot(3,1,2)
e=data(101,:);
b=data(21,:);
plot(e,'r')
%axis([0 1000 0 100])
hold on
plot(b)
subplot(3,1,3)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)


%二段温度
a=data(178,:);       %a表示流量设定值，b表示流量测量值
% b=data(21,:);
b=data(151,:);
c=data(18,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(19,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)


% 画二加空气PID
a=data(136,:);
b=data(20,:);
% b=data(146,:);
c=data(16,2:end);
d=data(17,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

%二加空烟pid
figure
subplot(3,1,1)
a=data(168,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(155,:);%+data(31,:))./2;
% c=filter2(a);
plot(a,'r');
grid on
ylim([70,160]);
hold on
plot(b);
% hold on
% plot(c,'g');
subplot(2,1,2);
plot(data(26,:),'r');           %空烟阀门开度设定值
grid on
hold on
plot(data(27,:),'b'); 
% 二加煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(159,:);
b=data(172,:);%+data(32,:))./2;
plot(a,'r');
grid on
ylim([80,160]);
hold on
plot(b);
subplot(2,1,2);
plot(data(28,:),'r');            %表示煤烟阀门开度设定值
grid on
hold on
plot(data(29,:),'b'); 
% san加煤气流量
figure
a=data(133,:);       %a表示流量设定值，b表示流量测量值
b=data(143,:);
c=data(33,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(34,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% 画san加空气PID
a=data(137,:);
b=data(35,:);
c=data(31,2:end);
d=data(32,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

%三加空烟pid
subplot(2,1,1)
a=data(156,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(169,:);%+data(31,:))./2;
plot(a,'r');
grid on
hold on
plot(b);
subplot(2,1,2);
plot(data(41,:),'r');  
grid on

% 三加煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(160,:);
b=data(173,:);%+data(32,:))./2;
plot(a,'r');
grid on
hold on
plot(b);
subplot(2,1,2);
plot(data(43,:),'r');            %表示煤烟阀门开度设定值
grid on

% 画均热煤气流量
a=data(134,:);       %a表示流量设定值，b表示流量测量值
b=data(51,:);
c=data(48,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(49,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%均热温度
a=data(152,:);       %a表示流量设定值，b表示流量测量值
% b=data(21,:);
b=data(45,:);
c=data(34,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(33,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

%% 画均热空气PID
a=data(138,:);
b=data(50,:);
c=data(46,2:end);
d=data(47,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%% 画均热空烟pid
subplot(2,1,1)
a=data(157,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(170,:);%+data(47,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(56,:),'r');           %空烟阀门开度设定值


% 画均热煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(161,:);
b=data(174,:);%+data(48,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(58,:),'r');            %表示煤烟阀门开度设定值



%二加空烟pid
subplot(2,1,1)
a=data(125,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(22,:);%+data(31,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(26,:),'r');           %空烟阀门开度设定值

% 二加煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(159,:);
b=data(23,:);%+data(32,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(28,:),'r');            %表示煤烟阀门开度设定值

%三加空烟pid
subplot(2,1,1)
a=data(156,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(37,:);%+data(31,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(41,:),'r');  

% 三加煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(130,:);
b=data(38,:);%+data(32,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(43,:),'r');            %表示煤烟阀门开度设定值

%画均热空烟pid
subplot(2,1,1)
a=data(127,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(71,:);%+data(47,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(56,:),'r');           %空烟阀门开度设定值


% 画均热煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(131,:);
b=data(72,:);%+data(48,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(58,:),'r');            %表示煤烟阀门开度设定值



%画煤气总管压力
a=data(72,:);                   %a表示煤气总管调节阀给定值
b=data(176,:);                   %b表示煤气总管压力设定值
c=data(67,:);                    %a表示煤气总管压力实际值
 d=data(102,:);   
subplot(2,1,1)
plot(b,'r');
hold on 
plot(d,'g');
plot(c,'b');
subplot(2,1,2);
plot(a);


%一加温度和阀门、流量
% % % c=data(10,:);%炉温
% % % cs=data(120,:);
% % % e=data(91,:);%煤气流量滤波实际值
% % % es=data(81,:);%煤气流量设定值
% % % subplot(2,1,1);
% % % plot(c,'b');
% % % hold on
% % % plot(cs,'r');
% % % subplot(2,1,2);
% % % plot(e,'b')
% % % hold on
% % % plot(es,'r')

c=data(10,:);%炉温
cs=data(120,:);
d=data(4,:);%煤气阀门实际值
ds=data(3,:);%煤气阀门设定值
e=data(91,:);%煤气流量滤波实际值
es=data(81,:);%煤气流量设定值
f=data(95,:); %空气流量滤波值
fs=data(85,:);%空气流量设定值
subplot(4,1,1);
plot(c,'b');
hold on
plot(cs,'r');
subplot(4,1,2);
plot(d,'b')
hold on
plot(ds,'r')
subplot(4,1,3);
plot(e,'g')
hold on
plot(es,'r')
subplot(4,1,4);
plot(f,'g')
hold on
plot(fs,'r')

%二加温度和阀门、流量
% % % c=data(25,:);%炉温
% % % cs=data(121,:);
% % % e=data(92,:);%煤气流量滤波实际值
% % % es=data(82,:);%煤气流量设定值
% % % subplot(2,1,1);
% % % plot(c,'b');
% % % hold on
% % % plot(cs,'r');
% % % subplot(2,1,2);
% % % plot(e,'b')
% % % hold on
% % % plot(es,'r')

c=data(25,:);%炉温
cs=data(121,:);
d=data(19,:);%煤气阀门实际值
ds=data(18,:);%煤气阀门设定值
e=data(92,:);%煤气流量滤波实际值
es=data(82,:);%煤气流量设定值
f=data(96,:); %空气流量滤波值
fs=data(86,:);%空气流量设定值
subplot(4,1,1);
plot(c,'b');
hold on
plot(cs,'r');
subplot(4,1,2);
plot(d,'b')
hold on
plot(ds,'r')
subplot(4,1,3);
plot(e,'g')
hold on
plot(es,'r')
subplot(4,1,4);
plot(f,'g')
hold on
plot(fs,'r')


%均热温度和阀门、流量
% % % c=data(40,:);%炉温
% % % cs=data(122,:);
% % % e=data(93,:);%煤气流量滤波实际值
% % % es=data(83,:);%煤气流量设定值
% % % subplot(2,1,1);
% % % plot(c,'b');
% % % hold on
% % % plot(cs,'r');
% % % subplot(2,1,2);
% % % plot(e,'b')
% % % hold on
% % % plot(es,'r')

c=data(40,:); %温度
cs=data(122,:);
d=data(34,:); %煤气阀门实际值
ds=data(33,:);%煤气阀门设定值
e=data(93,:); %煤气流量滤波实际值
es=data(83,:); %煤气流量设定值
f=data(97,:); %空气流量滤波值
fs=data(87,:);%空气流量设定值
subplot(4,1,1);
plot(c,'b');
hold on
plot(cs,'r');
subplot(4,1,2);
plot(d,'b')
hold on
plot(ds,'r')
subplot(4,1,3);
plot(e,'g')
hold on
plot(es,'r')
subplot(4,1,4);
plot(f,'g')
hold on
plot(fs,'r')



%炉压、排烟阀门、流量
c=data(46,:); %炉压
d=data(11,:); %一段空烟阀
ds=data(13,:);%一段煤烟阀
e=data(26,:); %%二段空烟阀
es=data(28,:); %二段煤烟阀
f=data(41,:); %三段空烟阀
fs=data(43,:);%三段煤烟阀
subplot(4,1,1);
plot(c,'b');
subplot(4,1,2);
plot(d,'b')
hold on
plot(ds,'r')
subplot(4,1,3);
plot(e,'g')
hold on
plot(es,'r')
subplot(4,1,4);
plot(f,'g')
hold on
plot(fs,'r')

c=data(46,:); %炉压
d=data(5,:); %一段空气流量
ds=data(6,:);%一段煤气流量
e=data(20,:); %%二段空气流量
es=data(21,:); %二段煤气流量
f=data(35,:); %三段空气流量
fs=data(36,:);%三段煤气流量
subplot(4,1,1);
plot(c,'b');
subplot(4,1,2);
plot(d,'b')
hold on
plot(ds,'r')
subplot(4,1,3);
plot(e,'g')
hold on
plot(es,'r')
subplot(4,1,4);
plot(f,'g')
hold on
plot(fs,'r')

a=data(75,:);
plot(a,'r');

a=data(76,:);
plot(a,'r');

a=data(100,:);
plot(a,'r');

a=data(101,:);
plot(a,'r');

a=data(102,:);
plot(a,'r');

a=data(104,:);
plot(a,'r');

a=data(106,:);
plot(a,'r');

a=data(105,:);
plot(a,'r');


a=data(191,:); 
plot(a,'r');
hold on;
a=data(34,:); 
plot(a,'g');
hold on;
a=data(44,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');

a=data(190,:); 
plot(a,'r');
hold on;
a=data(19,:); 
plot(a,'g');
hold on;
a=data(28,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');


a=data(189,:); 
plot(a,'r');
hold on;
a=data(4,:); 
plot(a,'g');
hold on;
a=data(14,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');


a=data(185,:); 
plot(a,'r');
hold on;
a=data(2,:); 
plot(a,'g');
hold on;
a=data(12,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');

a=data(186,:); 
plot(a,'r');
hold on;
a=data(17,:); 
plot(a,'g');
hold on;
a=data(27,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');

a=data(187,:); 
plot(a,'r');
hold on;
a=data(32,:); 
plot(a,'g');
hold on;
a=data(42,:); 
plot(a,'b');
a=data(75,:); 
plot(a,'k');


a=filter2(data(5,:),8); 
b=data(5,:);
plot(a,'k');
hold on
plot(b);
%助燃风压力
a=filter2(data(51,:),5); 
c=data(76,:);
plot(c,'r');
hold on
b=data(51,:);
plot(b);
%炉压
a=filter2(data(50,:),8); 
c=data(75,:);
plot(c,'r');
hold on
b=data(50,:);
plot(b);
%烟温
c=filter2(data(173,:),8); 
a=data(173,:);
plot(a,'r');
hold on
b=data(191,:);
plot(b);

%煤气、空气
c=filter2(data(20,:),5); 
a=data(21,:);
plot(a,'r');
hold on
b=data(101,:);
plot(b);

%煤气、空气
c=filter2(data(5,:),6); 
a=data(5,:);
plot(a,'r');
hold on
b=data(104,:);
plot(b);

c=filter2(data(6,:),6); 
a=data(6,:);
plot(a,'r');
hold on
b=data(100,:);
plot(b);

c=filter2(data(20,:),5); 
a=data(20,:);
plot(a,'r');
hold on
b=data(105,:);
plot(b);

c=filter2(data(21,:),5); 
a=data(21,:);
plot(a,'r');
hold on
b=data(101,:);
plot(b);

c=filter2(data(35,:),5); 
a=data(35,:);
plot(a,'r');
hold on
b=data(106,:);
plot(b);

c=filter2(data(36,:),5); 
a=data(36,:);
plot(a,'r');
hold on
b=data(102,:);
plot(b);


%一加空烟pid
subplot(2,1,1)
a=data(154,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(167,:);%+data(15,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(11,:),'r');           %空烟阀门开度设定值

% 一加煤烟PID
figure;
subplot(2,1,1)                  %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(158,:);
b=data(171,:);%+data(16,:))./2;
plot(a,'r');
hold on
plot(b);
grid on;
subplot(2,1,2);
plot(data(13,:),'r');            %表示煤烟阀门开度设定值
grid on;

%二加空烟pid
figure;
subplot(2,1,1)
a=data(155,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(168,:);%+data(31,:))./2;
plot(a,'r');
hold on
plot(b);
grid on;
subplot(2,1,2);
plot(data(26,:),'r');           %空烟阀门开度设定值
grid on;

% 二加煤烟PID
figure;
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(159,:);
b=data(172,:);%+data(32,:))./2;
grid on;
plot(a,'r');
hold on;
plot(b);
subplot(2,1,2);
plot(data(28,:),'r');            %表示煤烟阀门开度设定值


%三加空烟pid
subplot(2,1,1)
a=data(156,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(169,:);%+data(31,:))./2;
plot(a,'r');
grid on;    
hold on
plot(b);
subplot(2,1,2);
plot(data(41,:),'r');  
grid on;

% 三加煤烟PID
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(160,:);
b=data(173,:);%+data(32,:))./2;
grid on;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(43,:),'r');            %表示煤烟阀门开度设定值
