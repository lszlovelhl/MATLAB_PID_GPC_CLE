%  clear all;
dt=1;
[N,~]=size(temp);
n=1:N-1;t=1:N-1;                                         %时间序列
f=n/(N*dt);                                             %频率序列    
%已知原始信号的频率成分

title('时域信号');xlabel('时间/s');
y=fft(temp(:,1));
f1=900000;                                             %要滤除频率的上下限
yy=zeros(1,length(y));                                  %设置与y相同的元素数组
for m=0:N-1                                             %将频率落在该频率范围内及其大于奈奎斯特的波滤除
    %小于奈奎斯特频率的滤波范围
    if (m/(N*dt)>f1)||(m/(N*dt)<(1/dt-f1))
        %大于奈奎斯特频率的滤波范围
        %1/dt为一个频率周期
        yy(m+1)=0;                                      %将落在此频率范围内的振幅设置为0
    else
        if m<N-1                                      %确定数组y(m+1)不溢出
        yy(m+1)=y(m+1);                                 %其余频率范围内的信号保持不变
        end
    end
end

data1=real(ifft(yy));



[cc,c]=size(temp);
t=1:cc;
p2 = plotyy(t,data1(1,1:cc),t,temp(1:cc,1));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);