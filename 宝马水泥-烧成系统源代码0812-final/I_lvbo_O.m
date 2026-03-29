 clear all;
 load('temp');
dt=0.00001; 
%  [N,~]=size(temp);
  N=86400;  
n=1:N-1;t=[0:N-1]*dt;                                        %时间序列
f=n/(N*dt);                                            %频率序列    
%已知原始信号的频率成分

title('时域信号');xlabel('时间/s');
y=fft(temp(:,1));
f1=1000;                                             %要滤除频率的上下限
yy=zeros(1,length(y));                                  %设置与y相同的元素数组
c=0;
for m=0:N-1                                             %将频率落在该频率范围内及其大于奈奎斯特的波滤除
    %小于奈奎斯特频率的滤波范围
   
    data2=m/(N*dt);
    if (m/(N*dt)>f1)
        %大于奈奎斯特频率的滤波范围
        %1/dt为一个频率周期
        c=c+1
         yy(m+1)=0;                                   %将落在此频率范围内的振幅设置为0
    else
        
        if m<N-1                                      %确定数组y(m+1)不溢出
        yy(m+1)=y(m+1);                                 %其余频率范围内的信号保持不变
        end
    end
end

 data1=real(ifft(yy))*2-550;
% data1=(ifft(yy));
subplot(2,2,1);
plot(abs(y)*2/N); 
xlabel('频率/Hz');ylabel('振幅');
xlim([0 90000]);ylim([0 10]);
title('原始振幅谱');

subplot(2,2,2);
plot(abs(yy)*2/N);     
xlabel('频率/Hz');ylabel('振幅');
xlim([0 90000]);ylim([0 10]);
title('滤波振幅');

[cc,c]=size(temp);
t=1:cc;
subplot(2,2,3);
plot(temp(1:86400,1)); 
ylim([400 700]);
title('时域信号');
subplot(2,2,4);
plot(data1(1,:)); 
 ylim([400 700]);
title('滤波后时域信号');
% xlim([0 90000]);ylim([0 10]);

figure;
p2 = plotyy(t,temp(:,1),t,data1(1,:));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
  ylim([450 650]);