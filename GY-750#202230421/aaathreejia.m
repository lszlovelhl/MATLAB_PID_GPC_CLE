%二加热段炉顶温度
a=data(143,:);      %二加热段炉顶温度回路设定值
b=data(127,:);      %二加热段炉顶温度实际使用值
c=data(138,:);      %二加热段内部空气流量pid设定值
d=data(117,32:end);  %（二加热段空气流量滤波，二加热段空气阀门开度反馈值）
% d=data(5,:);      %流量实际值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
ylim([1210,1350]);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%二加热段煤气流量
a=data(133,:);      %二加热段内部煤气流量pid设定值
b=data(112,:);    %流量滤波值
% b=data(36,:);        %流量实际值（二加热段煤气流量）
c=data(33,32:end);    %阀门设定值（二加热段煤气阀门开度设定值，二加热段空气阀门开度反馈值）
d=data(34,32:end);    %阀门测量值（二加热段煤气阀门开度反馈值，二加热段空气阀门开度反馈值）
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%二加热段空气流量
a=data(138,:);     %二加热段内部空气流量pid设定值
b=data(167,:);   %流量滤波值
% b=data(35,:);       %流量实际值（二加热段空气流量）
c=data(31,32:end);   %阀门设定值（二加热段空气阀门开度设定值，二加热段空气阀门开度反馈值）
d=data(32,32:end);   %阀门测量值（二加热段空气阀门开度反馈值，二加热段空气阀门开度反馈值）
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%二加热段空烟温度
a=data(148,:);    %二加热段空烟温度设定值
b=data(172,:);      %空烟温度测量值（二加热段空烟温度）
c=data(41,:);     %二加热段空烟阀门开度设定值
d=data(42,:);     %二加热段空烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
ylim([90,150]);
subplot(2,1,2);
plot(c,'r'); 
hold on
% plot(d);

%二加热段煤烟温度
a=data(153,:);    %二加热段煤烟温度设定值
b=data(167,:);      %二加热段煤烟温度测量值（二加热段煤烟温度）
c=data(43,:);     %二加热段煤烟阀门开度设定值
d=data(44,:);     %二加热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
% plot(d);



%  二加热段  煤气、空气流量滤波VS实际值对比
c=filter2(data(35,:),5); %（data(二加空气流量,:)预热空气流量）
a=data(35,:);% (二加空气流量)
plot(a,'r');
hold on
b=data(117,:);%（二加空气流量滤波）
plot(b);

c=filter2(data(36,:),5); %（data(二加煤气流量,:)预热空气流量）
a=data(36,:);%（二加煤气流量）
plot(a,'r');
hold on
b=data(112,:);%（二加煤气流量滤波）
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

