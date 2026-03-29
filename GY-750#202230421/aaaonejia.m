a=data(104,:);% (预热段煤气流量)
subplot(2,1,1)
plot(a,'r');
subplot(2,1,2)
b=data(105,:);% (煤气流量滤波)
plot(b);


%预热段炉顶温度
a=data(141,:);      %预热段炉顶温度回路设定值
b=data(125,:);      %预热段炉顶温度实际使用值
c=data(136,:);      %预热段内部空气流量pid设定值
d=data(115,2:end);  %（预热段空气流量滤波，预热段空气阀门开度反馈值）
% d=data(5,:);      %流量实际值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
% ylim([1050,1150]);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%预热段煤气流量
a=data(131,:);      %预热段内部煤气流量pid设定值
b=data(110,:);    %流量滤波值
% b=data(6,:);        %流量实际值（预热段煤气流量）
c=data(3,2:end);    %阀门设定值（预热段煤气阀门开度设定值，预热段空气阀门开度反馈值）
d=data(4,2:end);    %阀门测量值（预热段煤气阀门开度反馈值，预热段空气阀门开度反馈值）
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
hold on
% plot(d)

%预热段空气流量
a=data(136,:);     %预热段内部空气流量pid设定值
% b=data(115,:);   %流量滤波值
b=data(5,:);       %流量实际值（预热段空气流量）
c=data(1,2:end);   %阀门设定值（预热段空气阀门开度设定值，预热段空气阀门开度反馈值）
d=data(2,2:end);   %阀门测量值（预热段空气阀门开度反馈值，预热段空气阀门开度反馈值）
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%预热段空烟温度
a=data(146,:);    %预热段空烟温度设定值
b=data(170,:);      %空烟温度测量值（预热段空烟温度）
c=data(11,:);     %预热段空烟阀门开度设定值
d=data(12,:);     %预热段空烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
% plot(d);

%预热段煤烟温度
a=data(151,:);    %预热段煤烟温度设定值
b=data(165,:);      %预热段煤烟温度测量值（预热段煤烟温度）
c=data(13,:);     %预热段煤烟阀门开度设定值
d=data(14,:);     %预热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
% plot(d);

%煤气总管
% a=data(122,:);    %
a=data(63,:);%
b=data(163,:);      %
c=data(68,:);     %
d=data(69   ,:);     %
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
% ylim([35,40]);
hold on
plot(d);


%助燃风机
a=data(121,:);    %预热段煤烟温度设定值
b=data(162,:);      %预热段煤烟温度测量值（预热段煤烟温度）
c=data(64,:);     %预热段煤烟阀门开度设定值
d=data(14,:);     %预热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
ylim([35,40]);
hold on
% plot(d);

%  预热段  煤气、空气流量滤波VS实际值对比
% c=filter2(data(5,:),6); %（data(预热段空气流量,:)预热段煤气流量）
a=data(5,:);% (预热段空气流量)
plot(a,'r');
hold on
b=data(115,:);% (空气流量滤波)
plot(b);

c=filter2(data(6,:),6); %（data(预热段煤气流量,:)预热段煤气流量）
a=data(6,:);% (预热段煤气流量)
plot(a,'r');
hold on
b=data(110,:);% (煤气流量滤波)
plot(b);


%炉压滤波VS实际值对比
a=filter2(data(76,:),8); %（data(炉压,:)预热段煤烟温度）
c=data(120,:);% （炉压滤波）
plot(c,'r');
hold on
b=data(61,:);%（炉压）
plot(b);

%助燃风压力滤波VS实际值对比
a=filter2(data(61,:),5); %（data(空气总管压力,:)预热段空气流量）
c=data(121,:);%（助燃风机压力滤波）
plot(c,'r');
hold on
b=data(62,:);%（空气总管压力）
plot(b);
%煤气总管滤波VS实际值对比
a=filter2(data(61,:),5); %（data(空气总管压力,:)预热段空气流量）
c=data(122,:);%（助燃风机压力滤波）
plot(c,'r');
hold on
b=data(63,:);%（空气总管压力）
plot(b);
