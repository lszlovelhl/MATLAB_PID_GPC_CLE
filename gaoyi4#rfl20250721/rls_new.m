
    % 首先应该对流量数据和温度数据进行归一化处理
     min_u=12000;
     max_u=19000;
     min_y=980;
     max_y=1050;
    u=u;
    y=c;
     u=(u-min_u)./(max_u-min_u);
     y=(y-min_y)./(max_y-min_y);
    
    % 选取辨识时的工作点 (avgu,avgy)
   
    avgu=sum(u(1:470))/470;   
    avgy=sum(y(1:470))/470;
    u=u-avgu;
    y=y-avgy;
    
    %递推最小二乘辨识
    d=1;                      % 均方误差
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
    %model validation
    for k=2:length(uu)
    %   my(k,1)=-A(2)*my(k-1)-A(1)*my(k-2)+B(2)*uu(k-1)+B(1)*uu(k-2);
        my(k,1)=-A(1)*my(k-1)+B(1)*uu(k-d);
    end
   
   subplot(2,1,1)
   plot(u);
   xlabel('u')
   subplot(2,1,2)
   plot(y);
   xlabel('y')
   hold on
   plot(my,'r');