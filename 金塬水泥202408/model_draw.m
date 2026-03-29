% 一个图画俩曲线对照
global data
% bb=1;
% %Temp = temp(2,5000:8599);
% [cc,c]=size(data);
% 
% t=2:c;
% figure;
% set(gcf,'color','w');
% [p1,p2,p3]=plotyy(t,data(1,2:c),t,data(2,2:c));
% set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% %axis([0 400 0 10]);
% %hold on;plot(t,2.2,'r:','LineWidth',3);
% xlabel('时间(s)');  % 为X轴加标签 ;
[len,wid] = size(data);
t = 1 : wid;
plotyy(t,data(4,:),t,data(16,:))