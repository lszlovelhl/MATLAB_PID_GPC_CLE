function y=polyadd(x1,x2)
%计算两多项式相加的函数
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
nl=length (x1);
n2=length(x2);
if nl>n2 
    x2=[zeros(1,nl-n2),x2];
elseif nl<n2
    x1=[zeros(1,n2-nl),x1];
end
y=x1+x2;
end


