function newpara=kalman_Filter( para )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    x = para(1);
    zk = para(2);
    xk = para(3);
    xk_1 = para(4);
    Pk = para(5);
    Pk_1 = para(6);


    A = 1;
    H = 1;
    Q = 0.05;                   % 反应两个时刻rssi方差
    R = 0.5;                   % 反应测量rssi的测量精度
    
    I = 1;
    if xk_1 == 0
        xk_1 = x;
        xk = x;
    else
        zk = H*x;                   % 观测量方程
        % 预测
        X = A*xk_1;                 % 状态预测
        P = A*Pk_1*A' + Q;          % 误差协方差预测
        % 更新(校正)
        K = P*H'*inv(H*P*H'+R);     % 卡尔曼增益更新
        xk = X + K*(zk - H*X);      % 更新校正
        xk_1 = xk;                  % 保存校正后的值，下一次滤波使用
        Pk = (I - K*H)*P;           % 更新误差协方差
        Pk_1 = Pk;                  % 保存校正后的误差协方差，下一次滤波使用
    end


newpara=[x,zk,xk,xk_1,Pk,Pk_1];
end

