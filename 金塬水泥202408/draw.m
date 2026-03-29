% 一个图画俩曲线对照
global data 
bb=1;
%Temp = temp(2,5000:8599);
[cc,c]=size(data);
sizecon = 60;
t=2:c;
figure;
set(gcf,'color','w');
% plotyy(t,data(66,2:c),t,data(25,2:c));  


% p1 = plotyy(t,data(55,2:c),t,data(20,2:c));   %生料仓重 
% set(p1(1),'ylim',[10,40]);
% set(p1(2),'ylim',[-10,40]);

% p2=plotyy(t,data(52,2:c),t,data(51,2:c));  %一室篦床压力反馈值－－－设定值
% set(p2(1),'ylim',[10,11]);
% set(p2(2),'ylim',[10,11]);

p2=plotyy(t,data(52,2:c),t,data(6,2:c));  %一室篦床压力
set(p2(1),'ylim',[10,12]);
set(p2(2),'ylim',[10,20]);

p2 = plotyy(t,data(54,2:c),t,data(12,2:c));   %分解炉温度
set(p2(1),'ylim',[840,940]);
set(p2(2),'ylim',[6,12]);


 


% plot(t,data(1,2:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% axis([0 c 2000 3000]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
