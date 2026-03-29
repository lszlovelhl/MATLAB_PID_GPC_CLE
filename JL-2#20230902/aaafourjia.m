%上均热段炉顶温度
a=data(144,:);      %上均热段炉顶温度回路设定值
b=data(128,:);      %上均热段炉顶温度实际使用值
c=data(139,:);      %上均热段内部空气流量pid设定值
d=data(118,47:end);  %（上均热段空气流量滤波，上均热段空气阀门开度反馈值）
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

%上均热段煤气流量
a=data(134,:);      %上均热段内部煤气流量pid设定值
e=data(113,:);    %流量滤波值
b=data(51,:);        %流量实际值（上均热段煤气流量）
c=data(48,47:end);    %阀门设定值（上均热段煤气阀门开度设定值，上均热段空气阀门开度反馈值）
d=data(49,47:end);    %阀门测量值（上均热段煤气阀门开度反馈值，上均热段空气阀门开度反馈值）
f=data(54,:);
figure(1);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b)
hold on
plot(e,'g')
subplot(3,1,2)
plot(c,'r')
hold on
plot(d)
plot(d)
subplot(3,1,3)
plot(f,'r')
%上均热段空气流量 
a=data(139,:);     %上均热段内部空气流量pid设定值
% b=data(115,:);   %流量滤波值
b=data(50,:);       %流量实际值（上均热段空气流量）
c=data(46,47:end);   %阀门设定值（上均热段空气阀门开度设定值，上均热段空气阀门开度反馈值）
d=data(47,47:end);   %阀门测量值（上均热段空气阀门开度反馈值，上均热段空气阀门开度反馈值）
subplot(2,1,1)
% plot(a,'r');
% hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%上均热段空烟温度
a=data(149,:);    %上均热段空烟温度设定值
b=data(52,:);      %空烟温度测量值（上均热段空烟温度）
c=data(56,:);     %上均热段空烟阀门开度设定值
d=data(57,:);     %上均热段空烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);

%上均热段煤烟温度
a=data(154,:);    %上均热段煤烟温度设定值
b=data(53,:);      %上均热段煤烟温度测量值（上均热段煤烟温度）
c=data(58,:);     %上均热段煤烟阀门开度设定值
d=data(59,:);     %上均热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);


%  上均热段  煤气、空气流量滤波VS实际值对比
c=filter2(data(50,:),3); %（data(均热上空气流量,:)预热空气流量）
a=data(50,:);% (均热上空气流量)
plot(a);
hold on
b=data(118,:);%（均热上空气流量滤波）
plot(b,'r');

c=filter2(data(51,:),3); %（data(均热上煤气流量,:)预热空气流量）
a=data(51,:);%（均热上煤气流量）
plot(a);
hold on
b=data(113,:);%（均热上煤气流量滤波）
plot(b,'r');


%炉压滤波VS实际值对比
a=filter2(data(76,:),8); %（data(炉压,:)预热煤烟温度）
c=data(120,:);% （炉压滤波）
plot(c,'r');
hold on
b=data(76,:);%（炉压）
plot(b);

%助燃风压力滤波VS实际值对比
a=filter2(data(77,:),5); %（data(空气总管压力,:)预热空气流量）
c=data(121,:);%（助燃风机压力滤波）
plot(c,'r');
hold on
b=data(77,:);%（空气总管压力）
plot(b);

