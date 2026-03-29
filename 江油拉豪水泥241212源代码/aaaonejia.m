
% 分解炉与尾煤
a=data(47,:);      %预热段炉顶温度回路设定值
b=data(29,:);      %预热段炉顶温度实际使用值
c=data(72,:);      %预热段内部空气流量pid设定值
d=data(12,:);  %（预热段空气流量滤波，预热段空气阀门开度反馈值）
% d=data(5,:);      %流量实际值
e=data(11,2:end);
f=data(77,2:end);
subplot(3,1,1)
plot(a,'r');
hold on
plot(b)
ylim([1,5]);
subplot(3,1,2)
plot(c,'r')
hold on
plot(d)
ylim([3,8.5]);
subplot(3,1,3)
plot(e,'r')
hold on
plot(f,'b')
% plot(d)
% ylim([0,4]);


