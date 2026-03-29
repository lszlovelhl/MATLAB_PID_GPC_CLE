m = rand(3,4);
n = magic(5);
try
%      a = m*n;      %当程序碰到 a = m*n;错误后，就会跳转到catch里面的语句，继续执行，有点类似于if...else...end
%      disp(a)
b;
catch
     disp(size(m))
     disp(size(n))
end
disp(m)