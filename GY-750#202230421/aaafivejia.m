%下均热段炉顶温度
a=data(145,:);      %下均热段炉顶温度回路设定值
b=data(129,:);      %下均热段炉顶温度实际使用值
c=data(140,:);      %下均热段内部空气流量pid设定值
d=data(119,62:end);  %（下均热段空气流量滤波，下均热段空气阀门开度反馈值）
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

%下均热段煤气流量
a=data(135,:);      %下均热段内部煤气流量pid设定值
% b=data(110,:);    %流量滤波值
b=data(66,:);        %流量实际值（下均热段煤气流量）
c=data(63,62:end);    %阀门设定值（下均热段煤气阀门开度设定值，下均热段空气阀门开度反馈值）
d=data(64,62:end);    %阀门测量值（下均热段煤气阀门开度反馈值，下均热段空气阀门开度反馈值）
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%下均热段空气流量
a=data(140,:);     %下均热段内部空气流量pid设定值
% b=data(115,:);   %流量滤波值
b=data(65,:);       %流量实际值（下均热段空气流量）
c=data(61,62:end);   %阀门设定值（下均热段空气阀门开度设定值，下均热段空气阀门开度反馈值）
d=data(62,62:end);   %阀门测量值（下均热段空气阀门开度反馈值，下均热段空气阀门开度反馈值）
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%下均热段空烟温度
a=data(150,:);    %下均热段空烟温度设定值
b=data(67,:);      %空烟温度测量值（下均热段空烟温度）
c=data(71,:);     %下均热段空烟阀门开度设定值
d=data(72,:);     %下均热段空烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);

%下均热段煤烟温度
a=data(155,:);    %下均热段煤烟温度设定值
b=data(68,:);      %下均热段煤烟温度测量值（下均热段煤烟温度）
c=data(73,:);     %下均热段煤烟阀门开度设定值
d=data(74,:);     %下均热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);


%  下均热段  煤气、空气流量滤波VS实际值对比
c=filter2(data(65,:),5); %（data(均热下空气流量,:)预热空气流量）
a=data(65,:);% (均热下空气流量)
plot(a,'r');
hold on
b=data(119,:);%（均热下空气流量滤波）
plot(b);

c=filter2(data(66,:),5); %（data(均热下煤气流量,:)预热空气流量）
a=data(66,:);%（均热下煤气流量）
plot(a,'r');
hold on
b=data(114,:);%（均热下煤气流量滤波）
plot(b);

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

