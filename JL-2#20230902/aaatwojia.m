for i = 1:3901
    data(168,i) = (data(25,i)+data(30,i))/2;
end
%一加热段炉顶温度
a=data(142,:);      %一加热段炉顶温度回路设定值
b=data(126,:);      %一加热段炉顶温度实际使用值
c=data(137,:);      %一加热段内部空气流量pid设定值
d=data(116,17:end);  %（一加热段空气流量滤波，一加热段空气阀门开度反馈值）
% d=data(5,:);      %流量实际值
e=data(168,:); 
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
hold on
plot(e,'g')
ylim([1050,1170]);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%一加热段煤气流量 15s
a=data(132,:);      %一加热段内部煤气流量pid设定值
e=data(111,:);    %流量滤波值
b=data(21,1:end);        %流量实际值（一加热段煤气流量）
c=data(18,2:end);    %阀门设定值（一加热段煤气阀门开度设定值，一加热段空气阀门开度反馈值）
d=data(19,2:end);    %阀门测量值（一加热段煤气阀门开度反馈值，一加热段空气阀门开度反馈值）
f=data(24,:); 
figure(1);
subplot(3,1,1)
% plot(a,'r');
hold on
plot(b)
hold on
% plot(e,'g')
subplot(3,1,2)
plot(c,'r')
hold on
plot(d)
subplot(3,1,3)
plot(f,'r')


air_lvbo_time = 12;
for i=1:3900
    if i > air_lvbo_time
        data(116,i+1) = mean([data(116,i-air_lvbo_time+2:i),data(20,i+1)]);
    elseif i>2
        data(116,i+1)=mean([data(116,2:i),data(20,i+1)]);   
    else
        data(116,i+1)=data(20,i+1);
    end
end
%一加热段空气流量
a=data(137,:);     %一加热段内部空气流量pid设定值
e=data(116,:);   %流量滤波值
b=data(20,:);       %流量实际值（一加热段空气流量）
c=data(16,17:end);   %阀门设定值（一加热段空气阀门开度设定值，一加热段空气阀门开度反馈值）
d=data(17,17:end);   %阀门测量值（一加热段空气阀门开度反馈值，一加热段空气阀门开度反馈值）
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
% hold on
% plot(e,'g');
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

%一加热段空烟温度
a=data(147,:);    %一加热段空烟温度设定值
b=data(22,:);      %空烟温度测量值（一加热段空烟温度）
c=data(26,:);     %一加热段空烟阀门开度设定值
d=data(27,:);     %一加热段空烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);

%一加热段煤烟温度
a=data(152,:);    %一加热段煤烟温度设定值
b=data(23,:);      %一加热段煤烟温度测量值（一加热段煤烟温度）
c=data(28,:);     %一加热段煤烟阀门开度设定值
d=data(29,:);     %一加热段煤烟阀门开度反馈值
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(c,'r'); 
hold on
plot(d);



%  一加热段  煤气、空气流量滤波VS实际值对比
c=filter2(data(20,:),5); %（data(一加空气流量,:)预热段空气流量）
a=data(20,:);% (一加空气流量)
plot(a);
hold on
b=data(116,:);%（一加空气流量滤波）
plot(c,'r');

c=filter2(data(21,:),5); %（data(一加煤气流量,:)预热段空气流量）
a=data(21,:);%（一加煤气流量）
plot(a);
hold on
b=data(111,:);%（一加煤气流量滤波）
plot(b,'r');



%炉压滤波VS实际值对比
a=filter2(data(76,:),8); %（data(炉压,:)预热段煤烟温度）
c=data(120,:);% （炉压滤波）
plot(c,'r');
hold on
b=data(76,:);%（炉压）
plot(b);

%助燃风压力滤波VS实际值对比
a=filter2(data(77,:),5); %（data(空气总管压力,:)预热段空气流量）
c=data(121,:);%（助燃风机压力滤波）
plot(c,'r');
hold on
b=data(77,:);%（空气总管压力）
plot(b);

