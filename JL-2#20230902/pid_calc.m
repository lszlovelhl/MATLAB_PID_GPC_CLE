function newpara=pid_calc( para )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
kp=para(7);
ti=para(8);
td=para(9);
sp=para(1);
pv=para(2);
e0=para(1)-para(2);
e1=para(5);
e2=para(6);
mv=para(3);
man_on=para(10);
ulim=para(11);
llim=para(12);
deadzone=para(13);
du=kp*((e0-e1)+1/ti*e0+td*(e0-2*e1+e2));
if abs(pv-sp)<deadzone  %流量设置死区，防止阀门动作太快
    du=0;
end
mv=mv+du;
if mv>=ulim
    mv=ulim;
end
if mv<=llim
    mv=llim;
end
e2=e1;
e1=e0;

newpara=[sp pv mv e0 e1 e2 kp ti td man_on ulim llim deadzone]';
end

