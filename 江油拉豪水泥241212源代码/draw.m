% 一个图画俩曲线对照
global data
bb=1;
%Temp = temp(2,5000:8599);
[cc,c]=size(data);

t=2:c;
figure;
set(gcf,'color','w');
% p1 = plotyy(t,data(84,2:c),t,data(79,2:c));     %提升机电流
% set(p1(1),'ylim',[90,120]);
% set(p1(2),'ylim',[90,120]);
% p2 = plotyy(t,data(13,2:c),t,data(11,2:c));   %分解炉温度
% set(p2(1),'ylim',[850,890]);
% set(p2(2),'ylim',[850,890]);
p3 = plotyy(t,data(76,2:c),t,data(23,2:c));   %篦冷机压力
% set(p3(1),'ylim',[2,4]);
% set(p3(2),'ylim',[1000,1080]);
% p4 = plotyy(t,data(82,2:c),t,data(78,2:c));   %头煤压力
% set(p4(1),'ylim',[10,18]);
% set(p4(2),'ylim',[10,18]);
% p5 = plotyy(t,data(91,2:c),t,data(92,2:c)); % 窑头负压 
% set(p5(1),'ylim',[-100,0]);
% set(p5(2),'ylim',[-100,0]);
% p3 = plotyy(t,data(8,2:c),t,data(99,2:c));   %篦冷机压力900
% set(p3(1),'ylim',[8.3,9.5]);
% set(p3(2),'ylim',[8.3,9.5]);

%  plot(t,data(12,2:c));
%  p3 = plotyy(t,data(100,2:c),t,data(101,2:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% axis([0 c 2000 3000]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
