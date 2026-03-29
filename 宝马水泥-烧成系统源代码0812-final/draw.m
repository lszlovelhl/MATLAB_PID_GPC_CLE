% 一个图画俩曲线对照
global data
bb=1;
%Temp = temp(2,5000:8599);
[cc,c]=size(data);

t=2:c;
figure;
set(gcf,'color','w');
% plot(t,data(15,2:c));
% p1 = plotyy(t,data(43,2:c),t,data(46,2:c));     %提升机电流
% set(p1(1),'ylim',[100,130]);
% set(p1(2),'ylim',[100,130]);
% p2 = plotyy(t,data(64,2:c),t,data(40,2:c));   %稳压仓仓重
% set(p2(1),'ylim',[8,20]);
% set(p2(2),'ylim',[8,20]);
p3 = plotyy(t,data(61,2:c),t,data(62,2:c));   %篦冷机压力
set(p3(1),'ylim',[830,890]);
set(p3(2),'ylim',[830,890]);
% p4 = plotyy(t,data(74,2:c),t,data(30,2:c));   %头煤压力
% set(p4(1),'ylim',[18,22]);
% set(p4(2),'ylim',[18,22]);
% p5 = plotyy(t,data(15,2:c),t,data(11,2:c)); 
% p4 = plotyy(t,data(71,2:c),t,data(72,2:c));   %
% set(p4(1),'ylim',[1160,1220]);
% set(p4(2),'ylim',[1160,1220]);

% plot(t,data(6,2:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% axis([0 c 2000 3000]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
