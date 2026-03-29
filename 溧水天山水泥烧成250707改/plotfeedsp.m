% if  ((0==tempcountdown)&&(((tempulogic>feed_sp)&&(o>2)&&(fm<98))||(tempulogic<feed_sp)))
%              upid= tempulogic; 
% end
bb=2;
[cc,c]=size(data); 
figure;
plot(data(77,bb:c)-data(20,bb:c));
%hold on;plot (data(22,:));
hold on;
plot (data(22,bb:c)-80,'r');




bb=2;
[cc,c]=size(data);
figure;
set(gcf,'color','w');

plot (data(83,bb:c));
hold on;plot (data(22,bb:c),'r');
grid on;




plot (data(78,bb:c),'r');






bb=2;
[cc,c]=size(data);
figure;
plot(data(77,bb:c)-data(20,bb:c),'r');
hold on;
plot (data(83,bb:c)-80);