load('E:\豫鹤同力水泥\文档\data1205\data2018120609.mat')
bb=2;
[cc,c]=size(data);
for k=bb:c
 p21(k)=data(13,k)/data(5,k);   
  p31(k)=data(18,k)/data(5,k);      
   
end
t=bb:c;
figure;
plot(t,p21(bb:c),'k');
hold on;
plot(t,p31(bb:c),'r');





bb=2;
[cc,c]=size(data);t=bb:c;
plot(t,data(20,bb:c),'k');
hold on;
plot(t,data(22,bb:c),'r');



