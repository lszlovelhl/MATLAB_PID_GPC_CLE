global data
bb=1;
%Temp = temp(2,5000:8599);
[cc,c]=size(data);

t=2:c;
for i =2 : c-1
    delta_1(i) = data(2,i+1) - data(2,i);
    delta_2(i) = data(9,i+1) - data(9,i);
end
x = 1 : length(delta_1);
plotyy(x,delta_1,x,delta_2);