% 一个图画俩曲线对照
global data
bb=1;
%Temp = temp(2,5000:8599);

[cc,c]=size(data);
t=2:c;
figure;
set(gcf,'color','w');
% tempdata(:,1)=data(1,:);
% tempdata(:,2)=data(4,:);
%     for i=1:c-60
%         u(i) = sum(tempdata(i:59+i,1))/60;
%         y(i) = sum(tempdata(i:59+i,2))/60;  %滞后500步
%     end
% [bb,b]=size(u);
% t=2:b;
% p1 = plotyy(t,u(t),t,y(t));     %提升机电流
%     for i=25709:25878
%        data(4,i) = 62.4;
%     end
p1 = plotyy(t,data(1,2:c),t,data(4,2:c));     %提升机电流


% set(p1(1),'ylim',[860,880]);
% set(p1(2),'ylim',[860,880]);
% figure;
% p2 = plotyy(t,data(64,2:c),t,data(1,2:c));     %提升机电流
% set(p2(1),'ylim',[5500,6500]);
% set(p2(2),'ylim',[5500,6500]);
% plot(t,data(23,2:c));
% p2 = plotyy(t,data(65,2:c),t,data(35,2:c));     %头煤压力
% p1 = plotyy(t,data(43,2:c),t,data(46,2:c));     %提升机电流
% set(p1(1),'ylim',[100,130]);
% set(p1(2),'ylim',[100,130]);
% p2 = plotyy(t,data(42,2:c),t,data(3,2:c));   %稳压仓仓重
% set(p2(1),'ylim',[8,20]);
% set(p2(2),'ylim',[8,20]);
% p3 = plotyy(t,data(1,2:c),t,data(6,2:c));   %篦冷机压力
% set(p3(1),'ylim',[200,230]);
% set(p3(2),'ylim',[12,13]);
% p4 = plotyy(t,data(74,2:c),t,data(30,2:c));   %头煤压力
% set(p4(1),'ylim',[18,22]);
% set(p4(2),'ylim',[18,22]);
% p5 = plotyy(t,data(57,2:c),t,data(11,2:c));   

% plot(t,data(1,2:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% axis([0 c 2000 3000]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
