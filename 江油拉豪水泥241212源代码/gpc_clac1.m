function [ u ] = gpc_clac1( A,B,P,y,u,yr,a,lmd1 )
%UNTITLED2 Summary of this function goes here
%parameter
%柔化因子a
%a=0.8;
%系数λ 0-1
%lmd=0.05;
%预测时域和控制时域
N=50; %理论上1-30 越大越好，太大不好80
Nu=15; %理论上 1-3             % 控制步长没有必要取那么大，取小点可以简化计算20

%y(k)的最终给定值yr
% yr=50;

%β
b=1;
Z=[1,0];%表示z^(-1)
Zj=cell(1,N-1);%Zj中存储的为z^(-j)次
for j=1:N-1
    Zj{j}(1)=1;
    Zj{j}(2:j+1)=0;      
end
delta=[-1,1];%△
na=length(A)-1;
nb=length(B)-1;

%model迭代
THETA=[-A(na:-1:1),B(nb+1:-1:1)]';%%%%%%%%%%%%
%%%%%%%%%%%%%%%

PHI=[y(2),u(2)]';%%%%%%%%%%%%%%
THETA=THETA+P*PHI*(y(length(y))-THETA'*PHI)/(1+PHI'*P*PHI);
P=P-P*PHI*PHI'*P/(1+PHI'*P*PHI);
% if P(1,1)<0.001
%     P(1,1)=0.001
% end
% if P(1,2)<0.001
%     P(1,2)=0.001
% end
% if P(2,1)<0.001
%     P(2,1)=0.001
% end
% if P(2,2)<0.001
%     P(2,2)=0.001
% end
    
 %一步辨识结束，得到参数
%     A(na:-1:1)=-THETA(1:na);
%     B(nb+1:-1:1)=THETA(na+1:na+nb+1);
%     a1(k)=A(2);a2(k)=A(1);b0(k)=B(2);b1(k)=B(1);
    Adelta=conv(A,delta);%A△
    %迭代求第一个丢番图方程中的E,F
    E=cell(1,N);
    F=cell(1,N);
    E{1}=[1];
    F{1}=deconv(polyadd(1,-Adelta),Z);
    for j=1:N-1
        E{j+1}=polyadd(E{j},F{j}(na+1)*Zj{j});
        F{j+1}=deconv(polyadd(F{j},-(F{j}(na+1)*Adelta)),Z);
    end
    %求第二个丢番图方程中的G,H
    G=cell(1,N);
    H=cell(1,N);
    for j=1:N
        EB=conv(E{j},B);
        H{j}=EB(1:length(EB)-j+1);
        G{j}=EB(length(EB)-j+1:length(EB));
    end
    %将E,F,G,H左右翻转，因为MATLAB中的多项式系数是从高次到低次排列，而GPC算法中是相反的，这样翻转过来使用比较方便
    for j=1:N
        E{j}=fliplr(E{j});
        F{j}=fliplr(F{j});
        G{j}=fliplr(G{j});
        H{j}=fliplr(H{j});
    end
    %得出后边计算要用到的系数矩阵F_,H_,G_
    for j=1:N
        F_(j,1:na+1)=F{j};
        H_(j,1:nb+1)=H{j};
    end
    for i=1:Nu
        G_(1:N,i)=[zeros(1,i-1),G{N}(1:N+1-i)]';
    end

    %下面利用上面计算所得结果进行一步自校正GPC控制    
    %求Y0(k)
%     for j=1:(nb+2)
%     deltau(j)=u()-u(k-2);
%     
%     end
%     olddeltaU=[deltau(k-1:-1:k-nb)]';
    olddeltaU=u(2)-u(1);%%%%%%%%%%%%%warning
    oldY=[y(3:-1:2)]';
    Y0=F_*oldY+H_*olddeltaU;
    %求Yd(k)
    %计算柔化轨迹
    yd(1)=y(length(y));
    for j=2:N
        yd(j)=a*yd(j-1)+(1-a)*yr;
    end
    Yd=yd';
%     dd(k+1)=yd(2);
    %求最终用到的△U，将△U的第一个u(k)作为当前时刻的输入改变量
        %△U(k)=K(k)(Yd(k)-Y0(k))
%      dy=yr-y(3);
%      lmd=-0.00225*dy+0.1225
%     if lmd<0.01
%         lmd=0.01;
%     end
    ye=abs(yr-y(3));
   lmd=lmd1/15*ye+2/3*lmd1;
    K=(G_'*G_+lmd*eye(Nu))\G_';
    deltaU=K*(Yd-Y0);
%     if saturate==0 && deltaU(1)<0
%         deltaU(1)=0;
%     end
%     if saturate==2 && deltaU(1)>0
%         deltaU(1)=0;
%     end
    u=u(2)+0.7*deltaU(1);




















end

