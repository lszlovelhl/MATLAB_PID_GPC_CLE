function realtimeshow_gui(showcontent)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%tempertature analysis
%junre 
global data lastsave
% puredata=data;
% puredata(:,1)=[];
[templ ld]=size(data);
if ~strcmp(lastsave,'none')
    hisdata=load(lastsave);
    rtdata=[hisdata.data,data(:,2:ld)];
else
    rtdata=data(:,2:ld);
end
showtime=3000;
[templ l]=size(rtdata);
                %      一加温度   二加温度   均热温度    出钢时间   空煤流量  煤气总管   
% showcontent=[            1          1          1         0         0       0          ;
if l>=showtime
          t1top=rtdata(9,l-showtime:l);
          t1a=rtdata(10,l-showtime:l);
          t1b=rtdata(11,l-showtime:l);
          t1avg=(t1a+t1b)./2;
          t2top=rtdata(24,l-showtime:l);
          t2a=rtdata(25,l-showtime:l);
          t2b=rtdata(26,l-showtime:l);
          t2avg=(t2a+t2b)./2;
          t3top=rtdata(39,l-showtime:l);
          t3a=rtdata(40,l-showtime:l);
          t3b=rtdata(41,l-showtime:l);
          t3avg=(t3a+t3b)./2;
          gas1pv=rtdata(1,l-showtime:l);
          gas2pv=rtdata(16,l-showtime:l);
          gas3pv=rtdata(31,l-showtime:l);
          air1pv=rtdata(5,l-showtime:l);
          air2pv=rtdata(20,l-showtime:l);
          air3pv=rtdata(35,l-showtime:l);
          gas1sp=rtdata(60,l-showtime:l);
          gas2sp=rtdata(61,l-showtime:l);
          gas3sp=rtdata(62,l-showtime:l);
          air1sp=rtdata(63,l-showtime:l);
          air2sp=rtdata(64,l-showtime:l);
          air3sp=rtdata(65,l-showtime:l);
          t1sp=rtdata(66,l-showtime:l);
          t2sp=rtdata(67,l-showtime:l);
          t3sp=rtdata(68,l-showtime:l);
          
%         tpv=rtdata(72,l-showtime:l);
%         tsp=rtdata(73,l-showtime:l);
%         tupleft=rtdata(64,l-showtime:l);
%         tupright=rtdata(65,l-showtime:l);
%         tdownleft=rtdata(66,l-showtime:l);
%         tdownright=rtdata(67,l-showtime:l);
%         to1=rtdata(68,l-showtime:l);
%         to2=rtdata(69,l-showtime:l);
%         gaspv=rtdata(75,l-showtime:l);
%         gassp=rtdata(76,l-showtime:l);
%         t3pv=rtdata(51,l-showtime:l);
%         t3sp=rtdata(52,l-showtime:l);
%         t3upleft=rtdata(45,l-showtime:l);
%         t3upright=rtdata(46,l-showtime:l);
%         t3downleft=rtdata(47,l-showtime:l);
%         t3downright=rtdata(48,l-showtime:l);
%         t2pv=rtdata(32,l-showtime:l);
%         t2sp=rtdata(33,l-showtime:l);
%         t2upleft=rtdata(26,l-showtime:l);
%         t2upright=rtdata(27,l-showtime:l);
%         t2downleft=rtdata(28,l-showtime:l);
%         t2downright=rtdata(29,l-showtime:l);
%         t1pv=rtdata(13,l-showtime:l);
%         t1sp=rtdata(14,l-showtime:l);
%         t1upleft=rtdata(4,l-showtime:l);
%         t1upright=rtdata(5,l-showtime:l);
%         t1downleft=rtdata(6,l-showtime:l);
%         t1downright=rtdata(7,l-showtime:l);
%         t1o1=rtdata(8,l-showtime:l);
%         t1o2=rtdata(9,l-showtime:l);
%         gas1pv=rtdata(16,l-showtime:l);
%         gas1sp=rtdata(17,l-showtime:l);
%         steelnum=rtdata(87,l-showtime:l);
%         airpvj=rtdata(79,l-showtime:l);
%         airspj=rtdata(80,l-showtime:l);
%         gaspvj=rtdata(75,l-showtime:l);
%         gasspj=rtdata(76,l-showtime:l);
%         airpv3=rtdata(58,l-showtime:l);
%         airsp3=rtdata(59,l-showtime:l);
%         gaspv3=rtdata(54,l-showtime:l);
%         gassp3=rtdata(55,l-showtime:l);
%         gas3pv=rtdata(54,l-showtime:l);
%         gas3sp=rtdata(55,l-showtime:l);
%         airpv2=rtdata(39,l-showtime:l);
%         airsp2=rtdata(40,l-showtime:l);
%         gaspv2=rtdata(35,l-showtime:l);
%         gassp2=rtdata(36,l-showtime:l);
%         airpv2=rtdata(20,l-showtime:l);
%         airsp2=rtdata(21,l-showtime:l);
%         gaspv2=rtdata(16,l-showtime:l);
%         gassp2=rtdata(17,l-showtime:l);
%         gas2pv=rtdata(35,l-showtime:l);
%         gas2sp=rtdata(36,l-showtime:l);
%         main_gas_pressure=rtdata(83,l-showtime:l);
%         main_gas_flow=rtdata(84,l-showtime:l)./5000;
%         tavg=(tupleft+tupright+tdownleft+tdownright+to1+to2)/6;
%         gasmv1=rtdata(18,l-showtime:l);
%         gasmv2=rtdata(37,l-showtime:l);
%         gasmv3=rtdata(56,l-showtime:l);
%         gasmvj=rtdata(77,l-showtime:l);
else 
          t1top=rtdata(9,2:l);
          t1a=rtdata(10,2:l);
          t1b=rtdata(11,2:l);
          t1avg=(t1a+t1b)./2;
          t2top=rtdata(24,2:l);
          t2a=rtdata(25,2:l);
          t2b=rtdata(26,2:l);
          t2avg=(t2a+t2b)./2;
          t3top=rtdata(39,2:l);
          t3a=rtdata(40,2:l);
          t3b=rtdata(41,2:l);
          t3avg=(t3a+t3b)./2;
          gas1pv=rtdata(1,2:l);
          gas2pv=rtdata(16,2:l);
          gas3pv=rtdata(31,2:l);
          air1pv=rtdata(5,2:l);
          air2pv=rtdata(20,2:l);
          air3pv=rtdata(35,2:l);
          gas1sp=rtdata(60,2:l);
          gas2sp=rtdata(61,2:l);
          gas3sp=rtdata(62,2:l);
          air1sp=rtdata(63,2:l);
          air2sp=rtdata(64,2:l);
          air3sp=rtdata(65,2:l);
          t1sp=rtdata(66,2:l);
          t2sp=rtdata(67,2:l);
          t3sp=rtdata(68,2:l);
%         tpv=rtdata(72,2:l);
%         tsp=rtdata(73,2:l);
%         tupleft=rtdata(64,2:l);
%         tupright=rtdata(65,2:l);
%         tdownleft=rtdata(66,2:l);
%         tdownright=rtdata(67,2:l);
%         to1=rtdata(68,2:l);
%         to2=rtdata(69,2:l);
%         gaspv=rtdata(75,2:l);
%         gassp=rtdata(76,2:l);
%         t3pv=rtdata(51,2:l);
%         t3sp=rtdata(52,2:l);
%         t3upleft=rtdata(45,2:l);
%         t3upright=rtdata(46,2:l);
%         t3downleft=rtdata(47,2:l);
%         t3downright=rtdata(48,2:l);
%         t2pv=rtdata(32,2:l);
%         t2sp=rtdata(33,2:l);
%         t2upleft=rtdata(26,2:l);
%         t2upright=rtdata(27,2:l);
%         t2downleft=rtdata(28,2:l);
%         t2downright=rtdata(29,2:l);
%         t1pv=rtdata(13,2:l);
%         t1sp=rtdata(14,2:l);
%         t1upleft=rtdata(4,2:l);
%         t1upright=rtdata(5,2:l);
%         t1downleft=rtdata(6,2:l);
%         t1downright=rtdata(7,2:l);
%         t1o1=rtdata(8,2:l);
%         t1o2=rtdata(9,2:l);
%         gas1pv=rtdata(16,2:l);
%         gas1sp=rtdata(17,2:l);
%         steelnum=rtdata(87,2:l);
%         airpvj=rtdata(79,2:l);
%         airspj=rtdata(80,2:l);
%         gaspvj=rtdata(75,2:l);
%         gasspj=rtdata(76,2:l);
%         airpv3=rtdata(58,2:l);
%         airsp3=rtdata(59,2:l);
%         gaspv3=rtdata(54,2:l);
%         gassp3=rtdata(55,2:l);
%         gas3pv=rtdata(54,2:l);
%         gas3sp=rtdata(55,2:l);
%         airpv2=rtdata(39,2:l);
%         airsp2=rtdata(40,2:l);
%         gaspv2=rtdata(35,2:l);
%         gassp2=rtdata(36,2:l);
%         airpv2=rtdata(20,2:l);
%         airsp2=rtdata(21,2:l);
%         gaspv2=rtdata(16,2:l);
%         gassp2=rtdata(17,2:l);
%         gas2pv=rtdata(35,2:l);
%         gas2sp=rtdata(36,2:l);
%         main_gas_pressure=rtdata(83,2:l);
%         main_gas_flow=rtdata(84,2:l)./5000;
%         tavg=(tupleft+tupright+tdownleft+tdownright+to1+to2)/6;
%         gasmv1=rtdata(18,2:l);
%         gasmv2=rtdata(37,2:l);
%         gasmv3=rtdata(56,2:l);
%         gasmvj=rtdata(77,2:l);
end

if showcontent(1)
    figure
    subplot(2,1,1)
     plot(t1sp,'-b')
     hold on
    
    plot(t1top,'-g')
    % plot(tupright,'-g')
    % plot(tdownleft,'-g')
    % plot(tdownright,'-g')
    % plot(to1,'-g')
    % plot(to2,'-g')
%      plot(tpv,'-r')
%      legend('温度设定值','4测点温度平均值','温度测量值PV','Location','NorthEastOutside')
%     legend('炉顶温度','Location','NorthEastOutside')
    legend('温度设定值','炉顶温度','Location','NorthEastOutside')
    title('一加热段温度曲线图')
%     'average temperature of tpv is'
%     mean(tpv)

    % axis([0 5000 1100 1190])
    subplot(2,1,2)
    plot(gas1pv,'-r')
    hold on
    plot(gas1sp,'-b','LineWidth',2)
    legend('煤气流量测量值','煤气流量设定值','Location','NorthEastOutside')
    title('一加热段煤气流量曲线图')
% axis([0 5000 0 5000])
%               
end
%3jia temperature
if showcontent(2)
figure

% t3o1=puredata(68,:);
% t3o2=puredata(69,:);

subplot(2,1,1)
plot(t2sp,'-b')
hold on
plot(t2top,'-g')
% plot(tupright,'-g')
% plot(tdownleft,'-g')
% plot(tdownright,'-g')
% plot(to1,'-g')
% plot(to2,'-g')
%  plot(t3pv,'-r')
% legend('温度设定值','4测点温度平均值','温度测量值PV','Location','NorthEastOutside')
% legend('炉顶温度','Location','NorthEastOutside')
legend('温度设定值','炉顶温度','Location','NorthEastOutside')
title('二加热段温度曲线图')
%  'average temperature of t3pv is'
% mean(t3pv)
 %ylim([1120 1200])

subplot(2,1,2)
plot(gas2pv,'-r')
hold on
plot(gas2sp,'-b','LineWidth',2)
legend('煤气流量测量值','煤气流量设定值','Location','NorthEastOutside')
title('二加热段煤气流量曲线图')
%  ylim([0000 10000])
end

if showcontent(3)
%2jia temperature
figure

% t2o1=puredata(68,:);
% t2o2=puredata(69,:);

subplot(2,1,1)
plot(t3top,'-b')
hold on
plot(t3avg,'-g')
% plot(tupright,'-g')
% plot(tdownleft,'-g')
% plot(tdownright,'-g')
% plot(to1,'-g')
% plot(to2,'-g')
%  plot(t2pv,'-r')
% legend('温度设定值','4测点温度平均值','温度测量值PV','Location','NorthEastOutside')
% legend('炉顶温度','Location','NorthEastOutside')
legend('温度设定值','炉顶温度','Location','NorthEastOutside')
title('均热段温度曲线图')
% 'average temperature of t2pv is'
% mean(t2pv)
% axis([0 22560 1100 1200])

subplot(2,1,2)
plot(gas3pv,'-r')
hold on
plot(gas3sp,'-b','LineWidth',2)
legend('煤气流量测量值','煤气流量设定值','Location','NorthEastOutside')
title('均热段煤气流量曲线图')
end

if showcontent(4)
%1jia temperature
figure

t1avg=(t1upleft+t1upright+t1downleft+t1downright)/4;
subplot(2,1,1)
plot(t1sp,'-b')
hold on
plot(t1avg,'-g')
% plot(tupright,'-g')
% plot(tdownleft,'-g')
% plot(tdownright,'-g')
% plot(to1,'-g')
% plot(to2,'-g')
 plot(t1pv,'-r')
legend('温度设定值','4测点温度平均值','温度测量值PV','Location','NorthEastOutside')
title('一加热段温度曲线图')
% 'average temperature of t1pv is'
% mean(t1pv)
% axis([0 22560 1100 1200])

subplot(2,1,2)
plot(gas1pv,'-r')
hold on
plot(gas1sp,'-b','LineWidth',2)
legend('煤气流量测量值','煤气流量设定值','Location','NorthEastOutside')
title('一加热段煤气流量曲线图')
end

if showcontent(5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%steel push speed analysis
figure

temp=length(steelnum);
steelf=[];
tempv=steelnum(1);
tempi=1;
% steeli=1;
steelf(1)=0;
for i=2:temp
    if steelnum(i)~=tempv
        steelf(i)=i-tempi;
        tempi=i;
        tempv=steelnum(i);
%         steeli=steeli+1;
    else
        steelf(i)=steelf(i-1);
    end
end
 subplot(2,1,1)       
plot(steelf);
title('出钢时间图')
subplot(2,1,2)
plot(steelnum)
title('出钢计数图')
end
if showcontent(6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%air gas analysis
%junre
figure
subplot(2,2,1)

% subplot(2,1,1)
plot(airpvj,'-r')
hold on
plot(airspj,'-b')
% subplot(2,1,2)
plot(gaspvj,'-g')
hold on
plot(gasspj,'-y','LineWidth',2)
legend('空气流量测量值','空气流量设定值','煤气流量测量值','煤气流量设定值')
title('均热段空气流量煤气流量图')


%3jia
subplot(2,2,2)

% subplot(2,1,1)
plot(airpv3,'-r')
hold on
plot(airsp3,'-b')
% subplot(2,1,2)
plot(gaspv3,'-g')
hold on
plot(gassp3,'-y','LineWidth',2)
legend('空气流量测量值','空气流量设定值','煤气流量测量值','煤气流量设定值')
title('三加热段空气流量煤气流量图')


%2jia
subplot(2,2,3)

% subplot(2,1,1)
plot(airpv2,'-r')
hold on
plot(airsp2,'-b')
% subplot(2,1,2)
plot(gaspv2,'-g')
hold on
plot(gassp2,'-y','LineWidth',2)
legend('空气流量测量值','空气流量设定值','煤气流量测量值','煤气流量设定值')
title('二加热段空气流量煤气流量图')


%1jia
subplot(2,2,4)

% subplot(2,1,1)
plot(airpv2,'-r')
hold on
plot(airsp2,'-b')
% subplot(2,1,2)
plot(gaspv2,'-g')
hold on
plot(gassp2,'-y','LineWidth',2)
legend('空气流量测量值','空气流量设定值','煤气流量测量值','煤气流量设定值')
title('一加热段空气流量煤气流量图')
end
% 
% if showcontent(7)
% %%%%%%%%%%%%%%%%%煤气总管分析
% 
% figure
% 
% plot(main_gas_pressure)
% xlim([10000 11000])
% hold on
% plot(main_gas_flow,'r')
% legend('煤气总管压力/Kpa','煤气总管流量/5000m^3perh','Location','NorthEastOutside')
% end



end
