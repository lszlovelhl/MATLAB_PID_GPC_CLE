%% 二室篦床压力
bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(20,bb:c),t,data(19,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;

%% 二室篦床压力
bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(4,bb:c),t,data(72,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
%% 二室篦床压力
bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(4,bb:c),t,data(74,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;

%% 二室篦床压力
bb=2;
[cc,c]=size(data);
t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(4,bb:c),t,data(7,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;


%% G11风机电流
%% 二室篦床压力
bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(39,bb:c),t,data(63,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;




bb=2;
[cc,c]=size(data);
t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(39,bb:c),t,data(73,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
grid on


bb=2;
[cc,c]=size(data);
t=bb:c;
figure;
plot(t,data(20,bb:c),'k');
hold on;
plot(t,data(63,bb:c),'r');
% load('E:\豫鹤同力水泥\文档\data1205\data2018120613.mat')
% bb=2;
% [cc,c]=size(data);
% t=bb:c;
% figure;
% set(gcf,'color','w');
% [p1,p2,p3]=plotyy(t,data(20,bb:c),t,data(27,bb:c));
% set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% %axis([0 400 0 10]);
% %hold on;plot(t,2.2,'r:','LineWidth',3);
% xlabel('时间(s)');  % 为X轴加标签 ;
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% bb=2215;
% c=3570;
% 
% t=bb:c;
% figure;
% set(gcf,'color','w');
% [p1,p2,p3]=plotyy(t,data(83,bb:c),t,data(22,bb:c));
% ylabel(p1(1),'温度控制器空跑 下料量设定计算值(t/h)') % left y-axis
% ylabel(p1(2),'现场炉工实际下料量设定(t/h)') % right y-axis
% %axis([0 400 0 10]);
% %hold on;plot(t,2.2,'r:','LineWidth',3);
% xlabel('时间(s)');  % 为X轴加标签 ;
bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(27,bb:c),t,data(20,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;



bb=2;
[cc,c]=size(data);

t=bb:c;
figure;
set(gcf,'color','w');
[p1,p2,p3]=plotyy(t,data(13,bb:c),t,data(18,bb:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;
