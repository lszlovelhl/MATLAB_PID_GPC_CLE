
    % 首先应该对流量数据和温度数据进行归一化处理
%     min_u=0;
%     max_u=8500;
%     min_y=920;
%     max_y=980;
    
%     u=(u11-min_u)./(max_u-min_u);
%     y=(yy-min_y)./(max_y-min_y);
    
%滤波

    close all
    for i=1:3600
        coal_smooth(i) = sum(coal_total(1,4834+i:4998+i))/165;
    end
    
    % 选取辨识时的工作点 (avgu,avgy)
    tt=1200;
    u=coal_smooth(1,2400:3599);   %滞后80步
    y=(temp(2,7480:8679)+temp(3,7480:8679))/2;
    avgu=sum(u(1:tt))/tt;   
    avgy=sum(y(1:tt))/tt;
    u=u-avgu;
    y=y-avgy;
    
    %递推最小二乘辨识
    d=0;                      % 均方误差
    yy=y(d+1:length(y))';         % 输出数据长度
    uu=u(1:length(yy))';          % 输入数据长度
    A=[-1,1];                     % A为从高次幂到第次幂
    B=[0.5];
    na=length(A)-1;               % 1
    nb=length(B)-1;               % 0
    THETA=[-A(na:-1:1),B(nb+1:-1:1)]';      % theta为从低次幂到高次幂
    P=10^6*eye(na+nb+1);
    
    for k=2:length(yy)
        PHI=[-yy(k-1:-1:k-na),uu(k-d:-1:k-nb-d)]';
        THETA=THETA+P*PHI*(yy(k)-THETA'*PHI)/(1+PHI'*P*PHI);
        P=P-P*PHI*PHI'*P/(1+PHI'*P*PHI);
    end
    
    % 辨识结果
    A(na:-1:1)=THETA(1:na);
    B(nb+1:-1:1)=THETA(na+1:na+nb+1);
    
    my(1)=0;
    e(1)= 0;
    %model validation
    for k=2:length(uu)
    %   my(k,1)=-A(2)*my(k-1)-A(1)*my(k-2)+B(2)*uu(k-1)+B(1)*uu(k-2);
        my(k,1)=-A(1)*my(k-1)+B(1)*uu(k-d);
        myy(k,1)=-A(1)*y(k-1)+B(1)*u(k-d);
        e(k) = my(k)-y(k);
    end
   
   subplot(2,1,1)
   plot(u);
   xlabel('u')
   subplot(2,1,2)
   plot(y);
   xlabel('y')
   hold on
   plot(my,'r');
   figure;
   t=1:1200;
   plot(t,e);
   
   
%    %归一化
%    Y=y(1,3000:3500);
%    [Y1,PS]=mapminmax(Y,0,1);
%     figure;
%     plot(Y1,'r');