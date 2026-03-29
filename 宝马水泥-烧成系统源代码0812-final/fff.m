clear all;
dt=0.02;N=1024;
n=1:N-1;t=n*dt;                                         %时间序列
f=n/(N*dt);                                             %频率序列
f1=3;f2=10;                                             %已知原始信号的频率成分
x=0.5*sin(2*pi*3*n*dt)+cos(2*pi*10*n*dt);               %原始信号
subplot(2,2,1);plot(t,x);                               %时域信号图
title('时域信号');xlabel('时间/s');


y=fft(x);                                               %对时域信号进行FFT变换
xlim([0 12]);ylim([-1.5 1.5]);
subplot(2,2,2);plot(f,abs(y)*2/N);                      %绘制原始信号的振幅图
xlabel('频率/Hz');ylabel('振幅');
xlim([0 100]);title('原始振幅谱');
ylim([0 0.8]);


f1=8;f2=40;               % 8  15                              %要滤除频率的上下限
yy=zeros(1,length(y));                                  %设置与y相同的元素数组
for m=0:N-1                                             %将频率落在该频率范围内及其大于奈奎斯特的波滤除
    %小于奈奎斯特频率的滤波范围
     if (m/(N*dt)>f1|m/(N*dt)<(1/dt-f1));

        %大于奈奎斯特频率的滤波范围
        %1/dt为一个频率周期
        yy(m+1)=0;                                      %将落在此频率范围内的振幅设置为0
    else
        if m<511;                                       %确定数组y(m+1)不溢出
        yy(m+1)=y(m+1);                                 %其余频率范围内的信号保持不变
        end
    end
end
subplot(2,2,4);plot(abs(yy)*2/N);                     %绘制滤波后的振幅谱
xlim([0 100]);ylim([0 0.5]);
xlabel('频率/Hz');ylabel('振幅');
gstext=sprintf('自%4.1f-%4.1fHz的频率被滤除',f1,f2);
%将滤波范围显示作为标题
title(gstext);


subplot(2,2,3);plot(real(ifft(yy)));
%绘制滤波后的数据运用ifft变换回时域并绘图
title('通过IFFT回到时域');
xlabel('时间/s');
ylim([-0.6 0.6]);xlim([0 12]);