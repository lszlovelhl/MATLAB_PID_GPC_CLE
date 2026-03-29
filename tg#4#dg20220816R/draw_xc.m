% figure;
% [~,c]=size(data);
% plot(data(90,2:c),'Color','r');
% 
% plot(data(85,2:c));
global data
%% 三段曲线

[~,c]=size(data);
%   c=3900;
t=2:c;
figure;
% set(gcf,'color','w');
% [p1,p2,p3]=plotyy(t,data(120,2:c),t,data(1,2:c));
% set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
%axis([0 400 0 10]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
plot(data(120,2:c));
hold on;
plot(data(15,2:c),'Color','r');
xlabel('时间(s)');  % 为X轴加标签 ;

figure;
plot(data(123,2:c));
hold on;
plot(data(60,2:c),'Color','r');
xlabel('时间(s)');  % 为X轴加标签 ;
% 
% [~,c]=size(data);
% %   c=3900;
% t=2:c;
% figure;
% set(gcf,'color','w');
% [p1,p2,p3]=plotyy(t,data(123,2:c),t,data(60,2:c));
% set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% %axis([0 400 0 10]);
% %hold on;plot(t,2.2,'r:','LineWidth',3);
% hold on;
% plot(data(91,2:c),'Color','r');
% xlabel('时间(s)');  % 为X轴加标签 ;