function drawrealtime()
% global data decomposing_furnace_tempr_1_sp 
% global upid gui_2nd_chamber_pressure_sp chongban_flow_sp
global data
bb=1;
%Temp = temp(2,5000:8599);
[cc,c]=size(data);

t=2:c;
% 
% figure(1);
% p1 = plotyy(t,data(11,2:c),t,data(14,2:c));   %分解炉温度
% set(p1(1),'ylim',[865,885]);
% set(p1(2),'ylim',[7,10]);

figure(2);
p3 = plotyy(t,data(56,2:c),t,data(2,2:c));   %篦冷机压力
set(p3(1),'ylim',[6.8,8.2]);
set(p3(2),'ylim',[15,35]);

% p4 = plotyy(t,data(74,2:c),t,data(30,2:c));   %头煤压力
% set(p4(1),'ylim',[18,22]);
% set(p4(2),'ylim',[18,22]);
% p5 = plotyy(t,data(57,2:c),t,data(11,2:c));   

% plot(t,data(1,2:c));
set(findobj(get(gca,'Children'),'LineWidth',4),'LineWidth',6);
% axis([0 c 2000 3000]);
%hold on;plot(t,2.2,'r:','LineWidth',3);
xlabel('时间(s)');  % 为X轴加标签 ;