function on_timer(obj, event,handles)
global group data tempdata itemset tempdatavalue daobj lastsave b temp_open time_count processtime upid_old apc_on upid feiqitemp_select  cxcx  max_airgaspotial min_airgaspotial feiqi_temp_set se_op_time max_min_timeFlag
global mv pressure pidloop A B workpoint P gpc_a gpc_lmd   tempu  airgaspotial loopnum deadzone time1_s time2_s time3_s gas_lower max_burning min_burning  gdwendu   wendu_max1 wendu_max2 wendu_max3  wendu_middle1 wendu_middle2 wendu_middle3
global gap_on default_airgaspotial  left_time temp_set1 temp_set2 temp_set3  gas_limit   gdtemp  gdtemp_average1_1  gdtemp_average1_2  gdtemp_average2_1  gdtemp_average2_2  gdtemp_average3_1  gdtemp_average3_2 tem_dec_flag  sumOfFlow a_write p_write ff1 ff2 ff3 ff1_max ff2_max ff3_max
global default_airgaspotial_set time1_set time2_set time3_set ts1 ts2 ts3 gas_lower1 gas_lower2 gas_lower3 air_pressure
global pophandles identifier pophandles2 alarm_sound_flag FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS alarm_button_clicked 
global ifalarmsound airpressupperlimit airpresslowerlimit alarm_timer autoswitch autoshaolu burning gas_pressure gaspressupperlimit gaspresslowerlimit
global  now_potial popmenuswitchorder selectedOrder airsp  paramdata menlucount songfenging smsf autoswitchdialog  alarmflags

global  errorpos tsp dlgopen javaFramedlg
global  contag fuzzyset t_sv2 t_real feiqi_average1 airmean gasmean test1210  tempswitch errortag huanludlg_tag test0330 wendu_middle
global  gassp fqtempswitch songfenging3 songfenging2 songfenging1
global  choose_fj gas_press_set
global avg_gas open_flag feiqi_average2 feiqi_average3 menluing3 pre_avg_gas
global gas1_up gas1_down air1_up air1_down gas2_up gas2_down air2_up air2_down gas3_up gas3_down air3_up air3_down
global air_pressure_offset cntcycle famenzhenfu liuliangzhenfu tem_dec_flag_up_cnt tem_dec_flag_down_cnt
global gas_co fj_min fj_max
global gd_gas1 gd_gas2 gd_gas3
%命令行调试 查看 global pidloop default_airgaspotial min_airgaspotial max_airgaspotial gas_co air_pressure

%% 获取Wincc中各变量的值
tic
try

    
contag=100+b;
tempdata = read(group);
 errortag=0; 
catch
   errortag=1; 
end
if ~errortag
[~, b] = size(data);
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end
a = length(itemset);       %此时a=71
for k=1:6                 %三段煤气和空气流量设定值（pid内回路）
    data(a+k,b+1)=pidloop(1,k);    %此时a=77
end
errorpos=1;
%% 参数设置
if mod(b,10) == 0
    paramdata=xml_read('parament_set.xml');
end
% % % default_airgaspotial(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
% % % default_airgaspotial(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
% % % default_airgaspotial(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
wendu_middle(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmid;
wendu_middle(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmid;
wendu_middle(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmid;
feiqi_temp_set(1) =wendu_middle(1);
feiqi_temp_set(2) =wendu_middle(2);
feiqi_temp_set(3) =wendu_middle(3);
fuzzyset(1)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewtop;
fuzzyset(2)=paramdata.commdata(1).parameter(4).ATTRIBUTE.fwtop;
fuzzyset(3)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewmid;
fuzzyset(4)=paramdata.commdata(1).parameter(4).ATTRIBUTE.fwmid;
fuzzyset(5)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewfloor;
fuzzyset(6)=paramdata.commdata(1).parameter(4).ATTRIBUTE.fwfloor;
fuzzyset(7)=paramdata.commdata(1).parameter(4).ATTRIBUTE.fuzzytop;
fuzzyset(8)=paramdata.commdata(1).parameter(4).ATTRIBUTE.fuzzyfloor;
fuzzyset(9)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewtfloor;
fuzzyset(10)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewtmid;
fuzzyset(11)=paramdata.commdata(1).parameter(4).ATTRIBUTE.ewttop;

airgaspotialupsetoff=paramdata.commdata(1).parameter(5).ATTRIBUTE.airgaspotialupsetoff;
airgaspotialdownsetoff=paramdata.commdata(1).parameter(5).ATTRIBUTE.airgaspotialdownsetoff;
se_op_time=paramdata.commdata(1).parameter(5).ATTRIBUTE.se_op_time; %自寻优算法寻优周期 要求使用质数
%% 阀门上下限
gas1_up = paramdata.furnacetype(1).parameter(4).ATTRIBUTE.gas1_up;
gas1_down = paramdata.furnacetype(1).parameter(4).ATTRIBUTE.gas1_down;
air1_up = paramdata.furnacetype(1).parameter(4).ATTRIBUTE.air1_up;
air1_down = paramdata.furnacetype(1).parameter(4).ATTRIBUTE.air1_down;

gas2_up = paramdata.furnacetype(2).parameter(4).ATTRIBUTE.gas2_up;
gas2_down = paramdata.furnacetype(2).parameter(4).ATTRIBUTE.gas2_down;
air2_up = paramdata.furnacetype(2).parameter(4).ATTRIBUTE.air2_up;
air2_down = paramdata.furnacetype(2).parameter(4).ATTRIBUTE.air2_down;

gas3_up = paramdata.furnacetype(3).parameter(4).ATTRIBUTE.gas3_up;
gas3_down = paramdata.furnacetype(3).parameter(4).ATTRIBUTE.gas3_down;
air3_up = paramdata.furnacetype(3).parameter(4).ATTRIBUTE.air3_up;
air3_down = paramdata.furnacetype(3).parameter(4).ATTRIBUTE.air3_down;

ff1_set=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.f1;
ff1_max_set=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.f1_max;
ff2_set=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.f2;
ff2_max_set=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.f2_max;
ff3_set=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.f3;
ff3_max_set=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.f3_max;

fj_min = paramdata.commdata(1).parameter(2).ATTRIBUTE.fj_min;
fj_max = paramdata.commdata(1).parameter(2).ATTRIBUTE.fj_max;

cntcycle = paramdata.commdata(1).parameter(5).ATTRIBUTE.cntcycle; %模糊、pid计算周期
famenzhenfu = paramdata.commdata(1).parameter(5).ATTRIBUTE.famenzhenfu; %阀门每次计算结果振幅最大值
liuliangzhenfu = paramdata.commdata(1).parameter(5).ATTRIBUTE.liuliangzhenfu; %每次计算流量结果振幅最大值

ff1=ff1_set;
ff1_max=ff1_max_set;
ff2=ff2_set;
 ff2_max=ff2_max_set;
ff3=ff3_set;
ff3_max=ff3_max_set;

errorpos=2;
% se_op_time=17; %自寻优算法寻优周期 要求使用质数
%% 获取各热风炉燃烧室温度，废气温度，热风温度以及压力测量值
if tempswitch(1)==1
    tp1 = data(5,b+1);  %主：1#小炉拱顶温度
else
    tp1 = data(65,b+1);  %备：1#小炉燃烧室红外温度
end
if tempswitch(2)==1
    tp2 = data(66,b+1);  %主：2#小炉燃烧室S偶温度
else
    tp2 = data(24,b+1);  %备：2#小炉燃烧室红外温度
end
if tempswitch(3)==1
    tp3 = data(71,b+1);  %主：3#小炉拱顶温度
else
    tp3 = data(43,b+1);   %备：3#小炉燃烧室S偶温度
end

if fqtempswitch(1)==1
    tp_1 = data(6,b+1);  %废气温度
else
    tp_1 = data(8,b+1);  
end
if fqtempswitch(2)==1
    tp_2 = data(25,b+1);  
else
    tp_2 = data(27,b+1);  
end
if fqtempswitch(3)==1
    tp_3 = data(44,b+1);  
else
    tp_3 = data(46,b+1);  
end

% % % tp_1 = data(6,b+1);   %废气温度
% % % tp_2 = data(25,b+1);
% % % tp_3 = data(44,b+1);

tp_real1=tp1;
tp_real2=tp2;
tp_real3=tp3;
tp_real=[tp_real1 tp_real2 tp_real3];%三段拱顶温度实际值
t_real1=tp_1;
t_real2=tp_2;
t_real3=tp_3;
t_real=[t_real1;t_real2;t_real3];%%%三段废气温度实际值

t_hot_wind=data(58,b + 1);                     %获取热风温度
%t_hot_windA=data(59,b + 1);                     %获取热风温度
gas_co=data(60,b+1);                     %获取煤气CO
gas_pressure_1=data(61,b+1);                 %获取煤气总管压力
air_pressure_1=data(62,b+1);                   %获取助燃风压力

%空燃比需要跟随CO值变化

if gas_co >= 28
    default_airgaspotial_set = [0.75 0.75 0.75];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 28
        default_airgaspotial = [0.75 0.75 0.75];
    end
    
elseif gas_co >= 27
    default_airgaspotial_set = [0.7 0.7 0.7];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 27 || data(60,b) >= 28
        default_airgaspotial = [0.7 0.7 0.7];
    end
    
elseif gas_co >= 26
    default_airgaspotial_set = [0.68 0.68 0.68];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 26 || data(60,b) >= 27
        default_airgaspotial = [0.68 0.68 0.68];
    end
    
elseif gas_co >= 25
    default_airgaspotial_set = [0.65 0.65 0.65];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 25 || data(60,b) >= 26
        default_airgaspotial = [0.65 0.65 0.65];
    end
    
elseif gas_co >= 24
    default_airgaspotial_set = [0.64 0.64 0.64];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 24 || data(60,b) >= 25
        default_airgaspotial = [0.64 0.64 0.64];
    end

elseif gas_co >= 23.5
    default_airgaspotial_set = [0.60 0.64 0.60];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 23.5 || data(60,b) >= 24
        default_airgaspotial = [0.60 0.64 0.60];
    end
    
elseif gas_co >= 22.5
    default_airgaspotial_set = [0.55 0.62 0.55];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 22.5 || data(60,b) >= 23.5
        default_airgaspotial = [0.55 0.62 0.55];
    end
    
elseif gas_co >= 22
    default_airgaspotial_set = [0.54 0.6 0.54];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 22 || data(60,b) >= 22.5
        default_airgaspotial = [0.54 0.6 0.54];
    end
    
elseif gas_co >= 21
    default_airgaspotial_set = [0.53 0.53 0.53];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 21 || data(60,b) >= 22
        default_airgaspotial = [0.53 0.53 0.53];
    end
    
elseif gas_co >= 20
    default_airgaspotial_set = [0.50 0.50 0.50];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 20 || data(60,b) >= 21
        default_airgaspotial = [0.50 0.50 0.50];
    end
    
elseif gas_co >= 19
    default_airgaspotial_set = [0.48 0.48 0.48];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) < 19 || data(60,b) >= 20
        default_airgaspotial = [0.48 0.48 0.48];
    end
    
else
    default_airgaspotial_set = [0.45 0.45 0.45];
    %持续在该范围，空燃比保持已经自寻优结果;否则重置到该范围空燃比
    if data(60,b) >= 19 
        default_airgaspotial = [0.45 0.45 0.45];
    end
    
end

min_airgaspotial(1)=default_airgaspotial_set(1)-0.03;
min_airgaspotial(2)=default_airgaspotial_set(2)-0.03;
min_airgaspotial(3)=default_airgaspotial_set(3)-0.03;

max_airgaspotial(1)=default_airgaspotial_set(1)+0.03;
max_airgaspotial(2)=default_airgaspotial_set(2)+0.03;
max_airgaspotial(3)=default_airgaspotial_set(3)+0.03;

%% 获取各段时间设定值
% time1_set=str2double(get(handles.time1,'String'));
% time2_set=str2double(get(handles.time2,'String'));
% time3_set=str2double(get(handles.time3,'String'));
% 
% wendu_max1=str2double(get(handles.wendu_max1,'String'));
% wendu_max2=str2double(get(handles.wendu_max2,'String'));
% wendu_max3=str2double(get(handles.wendu_max3,'String'));
% 
% wendu_middle1=str2double(get(handles.wendu_middle1,'String'));
% wendu_middle2=str2double(get(handles.wendu_middle2,'String'));
% wendu_middle3=str2double(get(handles.wendu_middle3,'String'));

errorpos=3;
%% 根据剩余时间和现在的废气温度，计算出未来每一时刻的废气温度设定值
if time1_set~=left_time(1)   %判断设定时间有没有变化，如果变化了，需要重新计算每一时刻废气温度的设定值 1#炉
    left_time(1)=time1_set;
    time_count(1)=60*time1_set;
    time1_s=time_count(1);
     if (time_count(1)<=3600)||(tp_1>=wendu_middle1)
         for i=1:time_count(1)
             temp_set1(i)=(wendu_max1-tp_1)*i/time_count(1)+tp_1;
         end
     else
         for i=1:time_count(1)-3600
             temp_set1(i)=(wendu_middle1-tp_1)*i/(time_count(1)-3600)+tp_1;
          end
         for i=time_count(1)-3600:time_count(1)
             temp_set1(i)=(wendu_max1-wendu_middle1)*(i-time_count(1)+3601)/3600+wendu_middle1;
         end
     end
end
if (tp_1>=feiqi_temp_set(1)-0.3) && (tp_1<=feiqi_temp_set(1)+0.3)   %废气温度到达200的时候，重新计算每时刻废气温度的设定值          ？？？？？？？作用
     time1_s= time_count(1);
     if (time_count(1)<=3600)||(tp_1>=wendu_middle1)
         for i=1:time_count(1)
             temp_set1(i)=(wendu_max1-tp_1)*i/time_count(1)+tp_1;
         end
     else
          for i=1:time_count(1)-3600
             temp_set1(i)=(wendu_middle1-tp_1)*i/(time_count(1)-3600)+tp_1;
          end
         for i=time_count(1)-3600:time_count(1)
             temp_set1(i)=(wendu_max1-wendu_middle1)*(i-time_count(1)+3601)/3600+wendu_middle1;
        end
     end
end
    

if time2_set~=left_time(2) %判断设定时间有没有变化，如果变化了，需要重新计算每一时刻废气温度的设定值 2#炉
    left_time(2)=time2_set;
    time_count(2)=60*time2_set;
     time2_s= time_count(2);
     if (time_count(2)<=3600)||(tp_2>=wendu_middle2)
         for i=1:time_count(2)
             temp_set2(i)=(wendu_max2-tp_2)*i/time_count(2)+tp_2;
         end
     else
          for i=1:time_count(2)-3600
             temp_set2(i)=(wendu_middle2-tp_2)*i/(time_count(2)-3600)+tp_2;
          end
         for i=time_count(2)-3600:time_count(2)
             temp_set2(i)=(wendu_max2-wendu_middle2)*(i-time_count(2)+3601)/3600+wendu_middle2;
        end
     end
end
if (tp_2>=feiqi_temp_set(2)-0.3) && (tp_2<=feiqi_temp_set(2)+0.3)                    %判断废气温度有没有到200，如果到了，需要重新计算每一时刻废气温度的设定值 2#炉
    time2_s= time_count(2);
     if (time_count(2)<=3600)||(tp_2>=wendu_middle2)
         for i=1:time_count(2)
             temp_set2(i)=(wendu_max2-tp_2)*i/time_count(2)+tp_2;
         end
     else
          for i=1:time_count(2)-3600
             temp_set2(i)=(wendu_middle2-tp_2)*i/(time_count(2)-3600)+tp_2;
          end
         for i=time_count(2)-3600:time_count(2)
             temp_set2(i)=(wendu_max2-wendu_middle2)*(i-time_count(2)+3601)/3600+wendu_middle2;
         end
     end
end
    

if time3_set~=left_time(3) %判断设定时间有没有变化，如果变化了，需要重新计算每一时刻废气温度的设定值 3#炉
    left_time(3)=time3_set;
    time_count(3)=60*time3_set;
    time3_s= time_count(3);
     if (time_count(3)<=3600)||(tp_3>=wendu_middle3)
         for i=1:time_count(3)
             temp_set3(i)=(wendu_max3-tp_3)*i/time_count(3)+tp_3;
         end
    else
          for i=1:time_count(3)-3600
             temp_set3(i)=(wendu_middle3-tp_3)*i/(time_count(3)-3600)+tp_3;
          end
         for i=time_count(3)-3600:time_count(3)
             temp_set3(i)=(wendu_max3-wendu_middle3)*(i-time_count(3)+3601)/3600+wendu_middle3;
         end
     end
end
if (tp_3>=feiqi_temp_set(3)-0.3) && (tp_3<=feiqi_temp_set(3)+0.3)            %判断废气温度有没有到200，如果到了，需要重新计算每一时刻废气温度的设定值 3#炉
    time3_s= time_count(3);
     if (time_count(3)<=3600)||(tp_3>=wendu_middle3)
         for i=1:time_count(3)
             temp_set3(i)=(wendu_max3-tp_3)*i/time_count(3)+tp_3;
         end
     else
         for i=1:time_count(3)-3600
             temp_set3(i)=(wendu_middle3-tp_3)*i/(time_count(3)-3600)+tp_3;
         end
         for i=time_count(3)-3600:time_count(3)
             temp_set3(i)=(wendu_max3-wendu_middle3)*(i-time_count(3)+3601)/3600+wendu_middle3;
         end
     end
end
 errorpos=4;   
%% 倒计时
for i=1:3
    if temp_open(i)==1
        time_count(i)=time_count(i)-1;
    end
    if time_count(i)<0
        time_count(i)=0;
    end
end
%% 设定废气温度的设定值
if (temp_open(1)==0||tp_1<=feiqi_temp_set(1))   %%%？？？？？？？有疑问
        ts_1=tp_1;                         %%%？？？？？？要是temp_open(1)==1，tp_1<=feiqi_temp_set(1)，设定值一直是ts_1=tp_1怎么升温？
else
    if (time_count(1)>0&&temp_open(1)==1)               %1#炉
        ts_1=temp_set1(time1_s-time_count(1));
    else
        ts_1=wendu_max1;
    end
end

if (temp_open(2)==0||tp_2<=feiqi_temp_set(2))
    ts_2=tp_2;
else
    if (time_count(2)>0&&temp_open(2)==1)               %2#炉
    ts_2=temp_set2(time2_s-time_count(2));    
    else
        ts_2=wendu_max2;
    end
end

if( temp_open(3)==0||tp_3<=feiqi_temp_set(3))
    ts_3=tp_3;
else
    if(time_count(3)>0&&temp_open(3)==1)                %3#炉
    ts_3=temp_set3(time3_s-time_count(3));
    else
        ts_3=wendu_max3;
    end
end

t_sv1=ts_1;
t_sv2=ts_2;
t_sv3=ts_3;
t_sv=[t_sv1;t_sv2;t_sv3];%%%三段废气温度设定值

time_1=fix(time_count(1)/60);                %计算剩余时间
time_2=fix(time_count(2)/60);
time_3=fix(time_count(3)/60);

errorpos=5;
%% 获取各段温度,压力设定值,煤气空气流量测量值
% ts1=str2double(get(handles.ts1,'String'));
% ts2=str2double(get(handles.ts2,'String'));
% ts3=str2double(get(handles.ts3,'String'));
tsp=[ts1;ts2;ts3];
% gas_lower1=str2double(get(handles.gas_lower1,'String'));
% gas_lower2=str2double(get(handles.gas_lower2,'String'));
% gas_lower3=str2double(get(handles.gas_lower3,'String'));
gas_press_set = str2double(get(handles.gas_press,'String'));
% air_pressure=str2double(get(handles.air_press,'String'));

data(a+7,b+1)=ts1;                      % 三段炉顶温度设定值  a=78
data(a+8,b+1)=ts2;
data(a+9,b+1)=ts3;
data(a+10,b+1)=ts_1;               % 三段废气温度设定值 a=81
data(a+11,b+1)=ts_2;
data(a+12,b+1)=ts_3;
data(a+13,b+1)=gas_pressure;         % 多余的，为了不打乱顺序，所以保留了。
data(a+14,b+1)=air_pressure;          % 空气总管压力设定值 a=85
 gasFlowShow1=data(12,b+1);
 gasFlowShow2=data(31,b+1);
 gasFlowShow3=data(50,b+1);
 airFlowShow1=data(13,b+1);
 airFlowShow2=data(32,b+1);
 airFlowShow3=data(51,b+1);

%% 每小时data数据更新
if b >= 3900
    datetime = datestr(now,30);
%     if ~((sum(temp_open) == 0) && (sum(max_burning) == 0) && (sum(min_burning) == 0))
        s = ['save(''data',datetime(1:8),datetime(10:11),'.mat'',''data'');'];
        eval(s);
%     end
    
    lastsave = ['data',datetime(1:8),datetime(10:11),'.mat'];
    data(1 : 6,1) = fix(clock);
    data( : ,2 : 301) = data( : ,3602 : 3901);
    data( : ,302 : 3901) = [];
    b = 300;
    %处理程序有效期读写key文件
    load('key');
    usedtime = decodekey(key.usedtime);
    validtime = decodekey(key.validtime);
    warningtime = decodekey(key.warningtime);
    usedtime = usedtime + 1;
    key.usedtime = encodekey(usedtime);
    licensevalid=decodekey(key.licensevalid);
    save('key.mat','key');
    load('bak');
    usedtime1 = decodekey(bak.usedtime);
    usedtime1 = usedtime1 + 1;
    bak.usedtime = encodekey(usedtime1);
    save('bak.mat','bak');
    % 根据key文件做相应处理
    if (validtime - usedtime <= warningtime)
        % 有效期不足1周时提醒
        set(0,'CurrentFigure',validwarning)  
    end
    if (validtime-usedtime<=0) || (usedtime1~=usedtime)... %%防止授权激活后，拷贝key出去，再次使用
                               || (licensevalid ~= 101111)%表示license无效
        msgbox('授权有效期到期，请更新授权！');
        % 有效期过期，强制断开
        if ~isempty(timerfind)
            stop(timerfind);
            delete(timerfind);
        end
        if strcmp(daobj.Status,'connected')
            disconnect(daobj)
        end
        set(handles.text3,'String','已断开');
    end
end

errorpos=6;
%实际空燃比
real_kongranbi1 = (round(airFlowShow1/gasFlowShow1*100))/100;
real_kongranbi2 = (round(airFlowShow2/gasFlowShow2*100))/100;
real_kongranbi3 = (round(airFlowShow3/gasFlowShow3*100))/100;
%存入实际空燃比
data(95,b+1) = real_kongranbi1;
data(96,b+1) = real_kongranbi2;
data(97,b+1) = real_kongranbi3;
%% 将各热风炉拱顶温度，废气温度测量值，废气温度设定值,烧炉剩余时间，热风温度以及压力测量值实时显示
set(handles.tp1,'String',num2str(tp1,'%.1f'));
set(handles.tp2,'String',num2str(tp2,'%.1f'));
set(handles.tp3,'String',num2str(tp3,'%.1f'));
set(handles.tp_1,'String',num2str(tp_1,'%.1f'));
set(handles.tp_2,'String',num2str(tp_2,'%.1f'));
set(handles.tp_3,'String',num2str(tp_3,'%.1f'));
set(handles.ts_1,'String',num2str(round(ts_1)));
set(handles.ts_2,'String',num2str(round(ts_2)));
set(handles.ts_3,'String',num2str(round(ts_3)));
set(handles.time_1,'String',num2str(time_1));
set(handles.time_2,'String',num2str(time_2));
set(handles.time_3,'String',num2str(time_3));
set(handles.gasFlowShow1,'String',num2str(round(gasFlowShow1)));     %显示各支管煤气流量
set(handles.gasFlowShow2,'String',num2str(round(gasFlowShow2)));
set(handles.gasFlowShow3,'String',num2str(round(gasFlowShow3)));
set(handles.airFlowShow1,'String',num2str(round(airFlowShow1)));     %显示各支管空气流量
set(handles.airFlowShow2,'String',num2str(round(airFlowShow2)));
set(handles.airFlowShow3,'String',num2str(round(airFlowShow3)));
set(handles.t_hot_wind,'String',num2str((round(t_hot_wind*10))/10));               %显示热风温度
% set(handles.t_hot_windA,'String',num2str(t_hot_windA));             %显示热风温度
% set(handles.t_hot_windB,'String',num2str(t_hot_windB));             %显示热风温度
set(handles.text248,'String',num2str((round(data(68,b+1)*10))/10));    %显示煤气总管压力
set(handles.text249,'String',num2str((round(gas_co*10))/10));
set(handles.air_pressure,'String',num2str((round(air_pressure_1*10))/10));    %显示助燃风机检测压力
% set(handles.air_press,'String',num2str((round(air_press*10))/10));    %显示助燃风机设定压力
set(handles.airgaspotial_1,'String',num2str(real_kongranbi1)); %显示空燃比
set(handles.airgaspotial_2,'String',num2str(real_kongranbi2));
set(handles.airgaspotial_3,'String',num2str(real_kongranbi3));

set(handles.text282,'String',air_pressure_offset);


%% 获取各热风炉拱顶温度、废气测量温度偏差变化率(后一时刻温度值与前一时刻温度值之差)
%top_dt1 = data(5,b + 1) - data(5,b);
%top_dt2 = data(66,b + 1) - data(66,b);
%top_dt3 = data(43,b + 1) - data(43,b);

if fqtempswitch(1)==1
    bottom_dt1 = data(6,b + 1) - data(6,b);
else
    bottom_dt1 = data(8,b + 1) - data(8,b);
end
if fqtempswitch(2)==1
    bottom_dt2 = data(25,b + 1) - data(25,b);  
else
    bottom_dt2 = data(27,b + 1) - data(27,b); 
end
if fqtempswitch(3)==1
    bottom_dt3 = data(44,b + 1) - data(44,b); 
else
    bottom_dt3 = data(46,b + 1) - data(46,b); 
end
% % % bottom_dt1 = data(6,b + 1) - data(6,b);
% % % bottom_dt2 = data(25,b + 1) - data(25,b);
% % % bottom_dt3 = data(44,b + 1) - data(44,b);

%% 获取各热风炉煤气调节阀位、助燃空气调节阀位测量值
gas_fm1 = data(2,b + 1);
gas_fm2 = data(21,b + 1);
gas_fm3 = data(40,b + 1);
air_fm1 = data(4,b + 1);
air_fm2 = data(23,b + 1);
air_fm3 = data(42,b + 1);
gas_fm = [gas_fm1;gas_fm2;gas_fm3];

%% 获取热风炉的燃烧状态
songfenging1=data(9,b+1);
songfenging2=data(28,b+1);
songfenging3=data(47,b+1);

burning1=data(10,b+1);
burning2=data(29,b+1);
burning3=data(48,b+1);
menluing1=data(11,b+1);
menluing2=data(30,b+1);
menluing3=data(49,b+1);
songfenging = [songfenging1;songfenging2;songfenging3];
menluing = [menluing1;menluing2;menluing3];
burning = [burning1;burning2;burning3];
smsf=songfenging3+songfenging2+songfenging1;

% if mod(b,20)==1
%     ssssss = figure(autoswtichdialog);
%    set(ssssss, 'WindowStyle', 'modal');
% end
% 
%  if strcmp(autoswitchdialog,'是')
%      disp('dialog is true');
%      autoswitchdialog='null';
%  elseif  strcmp(autoswitchdialog,'否')   
%      disp('dialog is false');
%      autoswitchdialog='null';
%  end
 
 
%当第二个炉子开始送风后，menlucount s后再关闭第一个送风炉子 
if smsf>=2
    menlucount = menlucount - 1;
    if menlucount <= 0
        menlucount = 0;
    end
end
%%获取换炉操作涉及的信号变量
% hlxh = data(68,b+1); %换炉信号
% sfsjd(1) = data(8,b+1); % 送风时间到信号
% sfsjd(2) = data(27,b+1);
% sfsjd(3) = data(46,b+1);
% men_z_rs(1) = data(14,b+1); %焖炉转燃烧
% men_z_rs(2) = data(33,b+1);
% men_z_rs(3) = data(52,b+1);
% rs_z_men(1) = data(15,b+1); %燃烧转焖炉
% rs_z_men(2) = data(34,b+1);
% rs_z_men(3) = data(53,b+1);
% men_z_sf(1) = data(16,b+1); %焖炉转送风
% men_z_sf(2) = data(35,b+1);
% men_z_sf(3) = data(54,b+1);
% sf_z_men(1) = data(17,b+1); %送风转焖炉
% sf_z_men(2) = data(36,b+1);
% sf_z_men(3) = data(55,b+1);

errorpos=7;
%% 煤气空气流量测量值滤波
if b>=16
    airpv(1,1:16)=data(13,b-14:b+1);               % 一炉空气流量测量值==
    airpv(2,1:16)=data(32,b-14:b+1);               % 二炉空气流量测量值==
    airpv(3,1:16)=data(51,b-14:b+1);               % 三炉空气流量测量值==
    gaspv(1,1:16)=data(12,b-14:b+1);               % 一炉煤气流量测量值==
    gaspv(2,1:16)=data(31,b-14:b+1);               % 二炉煤气流量测量值==
    gaspv(3,1:16)=data(50,b-14:b+1);               % 三炉煤气流量测量值==   
    airmean=mean(airpv');
    gasmean=mean(gaspv');
    for i=1:16
        if abs(gaspv(1,i)-gasmean(1))>=3500
            gaspv(1,i)=gasmean(1);
        end
        if abs(airpv(1,i)-airmean(1))>=3500
            airpv(1,i)=airmean(1);
        end

        if abs(gaspv(2,i)-gasmean(2))>= 3500              
            gaspv(2,i)=gasmean(2);
        end
        if abs(airpv(2,i)-airmean(2)) >= 3500            
            airpv(2,i)=airmean(2);
        end

        if abs(gaspv(3,i)-gasmean(3))>= 3500           
            gaspv(3,i)=gasmean(3);
        end
        if abs(airpv(3,i)-airmean(3)) >= 3500            
            airpv(3,i)=airmean(3);
        end
    end
    gasmean=mean(gaspv');
    airmean=mean(airpv');
   elseif b>=10
        airpv(1,1:10)=data(13,b-8:b+1);               % 一炉空气流量测量值==
        airpv(2,1:10)=data(32,b-8:b+1);               % 二炉空气流量测量值==
        airpv(3,1:10)=data(51,b-8:b+1);               % 三炉空气流量测量值==
        gaspv(1,1:10)=data(12,b-8:b+1);               % 一炉煤气流量测量值==
        gaspv(2,1:10)=data(31,b-8:b+1);               % 二炉煤气流量测量值==
        gaspv(3,1:10)=data(50,b-8:b+1);               % 三炉煤气流量测量值==   
        airmean=mean(airpv');
        gasmean=mean(gaspv');
        for i=1:10
            if abs(gaspv(1,i)-gasmean(1))>=3500
                gaspv(1,i)=gasmean(1);
            end
            if abs(airpv(1,i)-airmean(1))>=3500
                airpv(1,i)=airmean(1);
            end

            if abs(gaspv(2,i)-gasmean(2))>= 3500              
                gaspv(2,i)=gasmean(2);
            end
            if abs(airpv(2,i)-airmean(2)) >= 3500              
                airpv(2,i)=airmean(2);
            end

            if abs(gaspv(3,i)-gasmean(3))>= 3500            
                gaspv(3,i)=gasmean(3);
            end
            if abs(airpv(3,i)-airmean(3)) >= 3500            
                airpv(3,i)=airmean(3);
            end
        end
        gasmean=mean(gaspv');
        airmean=mean(airpv');   
    else
        airmean(1)=data(13,b+1);
        airmean(2)=data(32,b+1);
        airmean(3)=data(51,b+1);
        gasmean(1)=data(12,b+1);
        gasmean(2)=data(31,b+1); 
        gasmean(3)=data(50,b+1);
end
if b>30

        airpv(1,1:28)=data(13,b-26:b+1);               % 一炉空气流量测量值==
        airpv(2,1:28)=data(32,b-26:b+1);               % 二炉空气流量测量值==
        airpv(3,1:28)=data(51,b-26:b+1);               % 三炉空气流量测量值==
        gaspv(1,1:28)=data(12,b-26:b+1);               % 一炉煤气流量测量值==
        gaspv(2,1:28)=data(31,b-26:b+1);               % 二炉煤气流量测量值==
        gaspv(3,1:28)=data(50,b-26:b+1);               % 三炉煤气流量测量值==   
        airmean=mean(airpv');
        gasmean=mean(gaspv');
        
        for i=1:28
            if abs(gaspv(1,i)-gasmean(1))>=3500
                gaspv(1,i)=gasmean(1);
            end
            if abs(airpv(1,i)-airmean(1))>=3500
                airpv(1,i)=airmean(1);
            end

            if abs(gaspv(2,i)-gasmean(2))>= 3500              
                gaspv(2,i)=gasmean(2);
            end
            if abs(airpv(2,i)-airmean(2)) >= 3500              
                airpv(2,i)=airmean(2);
            end

            if abs(gaspv(3,i)-gasmean(3))>= 3500            
                gaspv(3,i)=gasmean(3);
            end
            if abs(airpv(3,i)-airmean(3)) >= 3500            
                airpv(3,i)=airmean(3);
            end
        end
        gasmean=mean(gaspv');
        airmean=mean(airpv');
   
end
if b>10
    for i=1:3
        switch i
            case 1
                if max_min_timeFlag(i)>=0
                    airpv1(1:10)=data(13,b-8:b+1);               % 一炉空气流量测量值==
                    gaspv1(1:10)=data(12,b-8:b+1);               % 一炉煤气流量测量值==
                    airmean(i)=mean(airpv1);
                    gasmean(i)=mean(gaspv1);
                    for j=1:10
                        if abs(airpv1(j)-airmean(i)) >= 4500            
                            airpv1(j)=airmean(i);
                        end
                        if abs(gaspv1(j)-gasmean(i))>= 4500            
                            gaspv1(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv1);
                    gasmean(i)=mean(gaspv1);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
            case 2
                if max_min_timeFlag(i)>=0
                    airpv2(1:10)=data(32,b-8:b+1);               % 二炉空气流量测量值==
                    gaspv2(1:10)=data(31,b-8:b+1);               % 二炉煤气流量测量值==
                    airmean(i)=mean(airpv2);
                    gasmean(i)=mean(gaspv2);
                    for j=1:10
                        if abs(airpv2(j)-airmean(i)) >= 4500            
                            airpv2(j)=airmean(i);
                        end
                        if abs(gaspv2(j)-gasmean(i))>= 4500            
                            gaspv2(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv2);
                    gasmean(i)=mean(gaspv2);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
            case 3
                if max_min_timeFlag(i)>=0
                    airpv3(1:10)=data(51,b-8:b+1);               % 三炉空气流量测量值==
                    gaspv3(1:10)=data(50,b-8:b+1);               % 三炉煤气流量测量值==
                    airmean(i)=mean(airpv3);
                    gasmean(i)=mean(gaspv3);
                    for j=1:10
                        if abs(airpv3(j)-airmean(i)) >= 4500            
                            airpv3(j)=airmean(i);
                        end
                        if abs(gaspv3(j)-gasmean(i))>= 4500            
                            gaspv3(j)=gasmean(i);
                        end
                    end
                    airmean(i)=mean(airpv3);
                    gasmean(i)=mean(gaspv3);
                    max_min_timeFlag(i)=max_min_timeFlag(i)-1;
                end
        end
    end
end
%% 获取煤气空气流量
gas_f1=gasmean(1);
gas_f2=gasmean(2);
gas_f3=gasmean(3);
gas_f=[gas_f1;gas_f2;gas_f3];%此刻的煤气流量

air_f1=airmean(1);
air_f2=airmean(2);
air_f3=airmean(3);
air_f=[air_f1;air_f2;air_f3];

now_potial(1)=airmean(1)/(gasmean(1)+0.0001);
now_potial(2)=airmean(2)/(gasmean(2)+0.0001);
now_potial(3)=airmean(3)/(gasmean(3)+0.0001);

errorpos=8;
%% 煤气压力低于设定值，断开中控
if b > 10
   
    avg_gas = (data(61,b) + data(61,b-1) + data(61,b-2) + data(61,b-3) + data(61,b-4)) / 5;
    pre_avg_gas = (data(68,b)+ data(68,b-1) + data(68,b-2) + data(68,b-3) + data(68,b-4)) / 5;
    if pre_avg_gas < gas_press_set  
       % 1#炉子关闭
       set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        temp_open(1)=0;
        max_burning(1)=0;
        min_burning(1)=0;
        pidloop(10,1)=1;          %1#炉打开手动控制        
         pidloop(10,4)=1;
         autoshaolu = 0; %关闭自动烧炉功能
         set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
         set(handles.checkbox2,'Value',0) ;
         set(handles.checkbox2,'ForegroundColor',[0 0 0]);
         
        %  2#炉子关闭
         set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        temp_open(2)=0;
        max_burning(2)=0;
        min_burning(2)=0;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
        autoshaolu = 0; %关闭自动烧炉功能
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
        % 3#炉子关闭
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        temp_open(3)=0;
        max_burning(3)=0;
        min_burning(3)=0;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
        autoshaolu = 0; %关闭自动烧炉功能
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
        % 助燃风机关闭
         set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        pidloop(10,8)=1;     
    end
end

%% 固定流量控制策略
% 启用固定控制流量时，煤气流量设定值不能低于界面上设定的最小值，若超过设定时间模式的最大值，则更正。
%1#小炉固定煤气流量设定
if max_burning(1) == 1
    if ff1_max <= gd_gas1
        ff1_max = gd_gas1;
    end
    if gd_gas1 < gas_lower1
        gd_gas1 = gas_lower1;
    end
    set(handles.gas1_gd,'Visible','on');
    set(handles.text286,'Visible','on');
    set(handles.apc_1_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn1,'BackgroundColor',[0 1 0]);
    set(handles.gas1_gd,'String',gd_gas1);
end
if max_burning(1) == 0
    set(handles.gas1_gd,'Visible','off');
    set(handles.text286,'Visible','off');
end
% 2#小炉固定煤气流量设定
if max_burning(2) == 1
    if ff2_max <= gd_gas2
        ff2_max = gd_gas2;
    end
    if gd_gas2 < gas_lower2
        gd_gas2 = gas_lower2;
    end
    set(handles.gas2_gd,'Visible','on');
    set(handles.text288,'Visible','on');
    set(handles.apc_2_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn2,'BackgroundColor',[0 1 0]);
    set(handles.gas2_gd,'String',gd_gas2);
end
if max_burning(2) == 0
    set(handles.gas2_gd,'Visible','off');
    set(handles.text288,'Visible','off');
end
% 3#小炉固定煤气流量设定
if max_burning(3) == 1
    if ff3_max <= gd_gas3
        ff3_max = gd_gas3;
    end
    if gd_gas3 < gas_lower3
        gd_gas3 = gas_lower3;
    end
    set(handles.gas3_gd,'Visible','on');
    set(handles.text290,'Visible','on');
    set(handles.apc_3_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn3,'BackgroundColor',[0 1 0]);
    set(handles.gas3_gd,'String',gd_gas3);
end
if max_burning(3) == 0
    set(handles.gas3_gd,'Visible','off');
    set(handles.text290,'Visible','off');
end
%% 确定主烧，辅烧 
% 若同时有两个炉子处于固定模式流量状态，取消主烧副烧限制 
% 若1号送风，3号处于固定烧炉模式 或者 2号送风，1号处于固定烧炉模式，或者 3号送风，2号处于固定烧炉模式，取消主副烧、
if b >= 5  && (max_burning(1) + max_burning(2) + max_burning(3)) <= 1 ...
        && ~((songfenging1 == 1 && max_burning(3) == 1) || (songfenging2 == 1 && max_burning(1) == 1) || (songfenging3 == 1 && max_burning(2) ==1))
    %煤气压力
    avg_gas1 = (data(61,b) + data(61,b-1) + data(61,b-2) + data(61,b-3) + data(61,b-4)) / 5;
    % 1#废弃温度
     if fqtempswitch(1)==1
          feiqi_s1=data(6,b + 1)+data(6,b)+data(6,b - 1)+data(6,b - 2)+data(6,b - 3);    %连续5s的废气温度
     else
          feiqi_s1=data(8,b + 1)+data(8,b)+data(8,b - 1)+data(8,b - 2)+data(8,b - 3);    %连续5s的废气温度
     end
      feiqi_avg1=feiqi_s1/5;
    % 2# 废弃温度
     if fqtempswitch(2)==1 
         feiqi_s2=data(25,b + 1)+data(25,b)+data(25,b - 1)+data(25,b - 2)+data(25,b - 3);
     else
         feiqi_s2=data(27,b + 1)+data(27,b)+data(27,b - 1)+data(27,b - 2)+data(27,b - 3);
     end
    feiqi_avg2=feiqi_s2/5;
    % 3#废弃温度
     if fqtempswitch(3)==1
          feiqi_s3=data(44,b + 1)+data(44,b)+data(44,b - 1)+data(44,b - 2)+data(44,b - 3);
     else
          feiqi_s3=data(46,b + 1)+data(46,b)+data(46,b - 1)+data(46,b - 2)+data(46,b - 3);
     end
    feiqi_avg3=feiqi_s3/5;
    song_feng = [songfenging1 songfenging2 songfenging3];
    if songfenging1 == 1 && songfenging2 == 0 && songfenging3 == 0 && gasmean(2) >= 5000% 1号炉送风
       if feiqi_avg2 <= wendu_max2-15 % 此时 2# 为主
           ff3 = ff3 * 0.65;
           ff3_max = ff3_max * 0.65;
        elseif feiqi_avg2 <= wendu_max2-13
           ff3 = ff3 * 0.75;
           ff3_max = ff3_max * 0.75;
            
           ff2 =  ff2 * 0.75;
           ff2_max = ff2_max * 0.75;
       elseif feiqi_avg2 <= wendu_max2-10
           ff3 = ff3 * 0.8;
           ff3_max = ff3_max * 0.8;
           
           ff2 =  ff2 * 0.6;
           ff2_max = ff2_max * 0.6;
       elseif feiqi_avg2 <= wendu_max2-7  
           ff3 = ff3 * 0.85;
           ff3_max = ff3_max * 0.85;
           
           ff2 =  ff2 * 0.5;
           ff2_max = ff2_max * 0.5;
       elseif feiqi_avg2 <= wendu_max2-5           
           ff2 =  ff2 * 0.45;
           ff2_max = ff2_max * 0.45;
       elseif feiqi_avg2 <= wendu_max2-3 
           ff2 =  ff2 * 0.35;
           ff2_max = ff2_max * 0.35;

       else
           ff2 =  ff2 * 0.3;
           ff2_max = ff2_max * 0.3;
       end
       
    end
    
    if songfenging2 == 1 && songfenging1 == 0 && songfenging3 == 0 && gasmean(3) >= 5000% 2号炉送风
       if feiqi_avg3 <= wendu_max3-15 % 此时 3# 为主
           ff1 =  ff1 *0.65; %gasmean(3) * 0.9;
           ff1_max = ff1_max * 0.65;%gasmean(3) * 0.9;
       elseif feiqi_avg3 <= wendu_max3-13
           ff1 =  ff1 *0.75; %gasmean(3) * 0.9;
           ff1_max = ff1_max * 0.75;%gasmean(3) * 0.9;
           
           ff3 =  ff3 * 0.75;
           ff3_max = ff3_max * 0.75;
       elseif feiqi_avg3 <= wendu_max3-10
           ff1 =  ff1 *0.8; %gasmean(3) * 0.9;
           ff1_max = ff1_max * 0.8;%gasmean(3) * 0.9;
           
           ff3 =  ff3 * 0.6;
           ff3_max = ff3_max * 0.6;

       elseif feiqi_avg3 <= wendu_max3-7
           ff1 =  ff1 *0.85; %gasmean(3) * 0.9;
           ff1_max = ff1_max * 0.85;%gasmean(3) * 0.9;
           
           ff3 =  ff3 * 0.5;
           ff3_max = ff3_max * 0.5;

       elseif feiqi_avg3 <= wendu_max3-5
           ff3 =  ff3 * 0.35;
           ff3_max = ff3_max * 0.35;

       else
           ff3 =  ff3 * 0.3;
           ff3_max = ff3_max * 0.3;
       end                
    end
    if songfenging3 == 1 && songfenging2 == 0 && songfenging1 == 0 && gasmean(1) >= 5000% 3号炉送风
       if feiqi_avg1<= wendu_max1-15 % 此时 1# 为主
            ff2 = ff2*0.65;  %gasmean(1) * 0.7;
            ff2_max =ff2_max*0.65; %gasmean(1) * 0.7; 
       elseif feiqi_avg1 <= wendu_max1-12 
           ff2 = ff2*0.75;  %gasmean(1) * 0.7;
           ff2_max =ff2_max*0.75; %gasmean(1) * 0.7; 
           
           ff1 =  ff1 * 0.7;
           ff1_max = ff1_max * 0.7;
       elseif feiqi_avg1 <= wendu_max1-10 
           ff2 = ff2*0.85;  %gasmean(1) * 0.7;
           ff2_max =ff2_max*0.85; %gasmean(1) * 0.7; 
           
           ff1 =  ff1 * 0.6;
           ff1_max = ff1_max * 0.6;
       elseif feiqi_avg1 <= wendu_max1-7
           ff2 = ff2*0.85;  %gasmean(1) * 0.7;
           ff2_max =ff2_max*0.85; %gasmean(1) * 0.7; 
           
           ff1 =  ff1 * 0.5;
           ff1_max = ff1_max * 0.5;
       elseif feiqi_avg1 <= wendu_max1-5 
           ff1 =  ff1 * 0.4;
           ff1_max = ff1_max * 0.4;  
       else
           ff1 =  ff1 * 0.3;
           ff1_max = ff1_max * 0.3;
       end
    end
end

%% 控制策略部分
if b>=5
    if(mod(b,2)==0)
        %1#炉控制策略
        if(temp_open(1) == 1)                       %打开1#炉自动燃烧控制
             if(burning1==1)%||((songfenging1==0)&&(menluing1==0))
                 if fqtempswitch(1)==1
                    feiqi_sum1=data(6,b + 1)+data(6,b)+data(6,b - 1)+data(6,b - 2)+data(6,b - 3);    %连续5s的废气温度
                 else
                    feiqi_sum1=data(8,b + 1)+data(8,b)+data(8,b - 1)+data(8,b - 2)+data(8,b - 3);    %连续5s的废气温度
                end
%                 feiqi_sum1=data(6,b + 1)+data(6,b)+data(6,b - 1)+data(6,b - 2)+data(6,b - 3);    %连续5s的废气温度
                feiqi_average1=feiqi_sum1/5;
                pidloop(10,1)=0;          %1#炉打开自动控制        
                pidloop(10,4)=0;
                if feiqi_average1<feiqi_temp_set(1) %&& tp1 < tsp(1)
                     tempu(1)=ff1*default_airgaspotial(1);       %这里将煤气最大流量 修改为 空气最大流量
                else
                    if (mod(b,cntcycle)==0)
                       [tempu(1)]=FuzzyCompute1(t_sv1,t_real1,bottom_dt1,gas_f1,tempu(1),1);
% %                        if (t_sv(1)<t_real(1)-5)&&(t_real(1)>350)&&(tempu(1)>(fuzzyset(7)-5000)*default_airgaspotial(1))
% %                            tempu(1)=(fuzzyset(7)-5000)*default_airgaspotial(1);  %这里乘上default_airgaspotial系数表示更改为以空气流量计算
% %                        end
% %                        if (t_sv(1)<t_real(1)-15)&&(t_real(1)>350)&&(tempu(1)>(fuzzyset(7)-8000)*default_airgaspotial(1))
% %                            tempu(1)=(fuzzyset(7)-8000)*default_airgaspotial(1);
% %                        end
% %                        if (t_sv(1)<t_real(1)-15)&&(t_real(1)>380)&&(tempu(1)>(fuzzyset(7)-10000)*default_airgaspotial(1))
% %                            tempu(1)=(fuzzyset(7)-10000)*default_airgaspotial(1);
% %                        end
% %                        if (t_sv(1)>t_real(1)+10)&&(t_real(1)>350)&&(tempu(1)<(fuzzyset(7)-3000)*default_airgaspotial(1))
% %                            tempu(1)=(fuzzyset(7)-3000)*default_airgaspotial(1);
% %                            test0330=1;
% %                        end
                        apc_on(1)=1;    %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
                         test1210=b;
                    end
                end
                if(max_burning(1)==1)           %执行第一阶段：强化燃烧，阀门均为全开，快速升拱顶温度
                      tempu(1)=gd_gas1*default_airgaspotial(1);  %将煤气流量 更改为 空气流量
                end
                if(min_burning(1)==1)
                       tempu(1)=gas_lower1*default_airgaspotial(1); %将煤气流量 更改为 空气流量
                      
                       apc_on(1)=1;        %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
                end
             end
        else
           apc_on(1)=0;
           pidloop(10,1)=1;          %1#炉手动控制        
           pidloop(10,4)=1;
        end
    %2#炉控制策略 
        if(temp_open(2) == 1)
             if(burning2==1)%||((songfenging2==0)&&(menluing2==0))
                if fqtempswitch(2)==1 
                    feiqi_sum2=data(25,b + 1)+data(25,b)+data(25,b - 1)+data(25,b - 2)+data(25,b - 3);
                else
                    feiqi_sum2=data(27,b + 1)+data(27,b)+data(27,b - 1)+data(27,b - 2)+data(27,b - 3);
                end
%                 feiqi_sum2=data(25,b + 1)+data(25,b)+data(25,b - 1)+data(25,b - 2)+data(25,b - 3);
                feiqi_average2=feiqi_sum2/5;
                 pidloop(10,2)=0;          %2#炉打开自动控制        
                 pidloop(10,5)=0;
                 if feiqi_average2<feiqi_temp_set(2) %&& tp2 < tsp(2)
                     tempu(2)=ff2*default_airgaspotial(2);       %这里将煤气最大流量 修改为 空气最大流量;
                 else
                    if (mod(b,cntcycle)==0)
                     [tempu(2)]=FuzzyCompute1(t_sv2,t_real2,bottom_dt2,gas_f2,tempu(2),2);
                     
% % %                        if (t_sv(2)<t_real(2)-5)&&(t_real(2)>350)&&(tempu(2)>(fuzzyset(7)-5000)*default_airgaspotial(2))
% % %                            tempu(2)=(fuzzyset(7)-5000)*default_airgaspotial(2); %这里乘上default_airgaspotial系数表示更改为以空气流量计算
% % %                        end
% % %                        if (t_sv(2)<t_real(2)-15)&&(t_real(2)>350)&&(tempu(2)>(fuzzyset(7)-8000)*default_airgaspotial(2))
% % %                            tempu(2)=(fuzzyset(7)-8000)*default_airgaspotial(2);
% % %                        end
% % %                        if (t_sv(2)<t_real(2)-15)&&(t_real(2)>380)&&(tempu(2)>(fuzzyset(7)-10000)*default_airgaspotial(2))
% % %                            tempu(2)=(fuzzyset(7)-10000)*default_airgaspotial(2);
% % %                        end
% % %                        if (t_sv(2)>t_real(2)+10)&&(t_real(2)>350)&&(tempu(2)<(fuzzyset(7)-3000)*default_airgaspotial(2))
% % %                            tempu(2)=(fuzzyset(7)-3000)*default_airgaspotial(2);
% % %                        end
                       apc_on(2)=1;        %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
                    end
                 end
                 if (max_burning(2)==1)
                      tempu(2)=gd_gas2*default_airgaspotial(2);  %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                 end
                 if(min_burning(2)==1)
                      tempu(2)=gas_lower2*default_airgaspotial(2);
                      apc_on(2)=1;        %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
                 end
             end
        else
           pidloop(10,2)=1;          %2#炉手动控制        
           pidloop(10,5)=1;
           apc_on(2)=0;        
        end
        test0330=tempu;
    %3#炉控制策略
        if(temp_open(3) == 1)
           if(burning3==1)%||((songfenging3==0)&&(menluing3==0))
                if fqtempswitch(3)==1
                    feiqi_sum3=data(44,b + 1)+data(44,b)+data(44,b - 1)+data(44,b - 2)+data(44,b - 3);
                else
                    feiqi_sum3=data(46,b + 1)+data(46,b)+data(46,b - 1)+data(46,b - 2)+data(46,b - 3);
                end
%                 feiqi_sum3=data(44,b + 1)+data(44,b)+data(44,b - 1)+data(44,b - 2)+data(44,b - 3);
                feiqi_average3=feiqi_sum3/5;
                pidloop(10,3)=0;          %3#炉打开自动控制        
                pidloop(10,6)=0;
                if feiqi_average3<feiqi_temp_set(3) %&& tp3 < tsp(3)
                  tempu(3)=ff3*default_airgaspotial(3);       %这里将煤气最大流量 修改为 空气最大流量;;
                else
                  if (mod(b,cntcycle)==0)
                  [tempu(3)]=FuzzyCompute1(t_sv3,t_real3,bottom_dt3,gas_f3,tempu(3),3);
% % %                    if (t_sv(3)<t_real(3)-5)&&(t_real(3)>350)&&(tempu(3)>(fuzzyset(7)-5000)*default_airgaspotial(3))
% % %                        tempu(3)=(fuzzyset(7)-5000)*default_airgaspotial(3); %这里乘上default_airgaspotial系数表示更改为以空气流量计算
% % %                    end
% % %                    if (t_sv(3)<t_real(3)-15)&&(t_real(3)>350)&&(tempu(3)>(fuzzyset(7)-8000)*default_airgaspotial(3))
% % %                        tempu(3)=(fuzzyset(7)-8000)*default_airgaspotial(3);
% % %                    end
% % %                    if (t_sv(3)<t_real(3)-15)&&(t_real(3)>380)&&(tempu(3)>(fuzzyset(7)-10000)*default_airgaspotial(3))
% % %                        tempu(3)=(fuzzyset(7)-10000)*default_airgaspotial(3);
% % %                    end
% % %                    if (t_sv(3)>t_real(3)+10)&&(t_real(3)>350)&&(tempu(3)<(fuzzyset(7)-3000)*default_airgaspotial(3))
% % %                        tempu(3)=(fuzzyset(7)-3000)*default_airgaspotial(3);
% % %                    end
                  apc_on(3)=1;        %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
                  end
                end
                if (max_burning(3)==1)
                  tempu(3)=gd_gas3*default_airgaspotial(3);  %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                end
                if(min_burning(3)==1)
                  tempu(3)=gas_lower3*default_airgaspotial(3);  %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                  apc_on(3)=1; 
                end
           end
        else
           pidloop(10,3)=1;          %3#炉手动控制        
           pidloop(10,6)=1;
           apc_on(3)=0;        %标志位，当GPC打开后置1，标志着可以进行下一步对应的pid计算
        end
        
        %控制tempu流量振幅大小
                               
        if tempu(1) >= pidloop(1,4) + liuliangzhenfu       
            tempu(1) = pidloop(1,4) + liuliangzhenfu;
        end
        if tempu(1) <= pidloop(1,4) - liuliangzhenfu
            tempu(1) = pidloop(1,4) - liuliangzhenfu;
        end
         
        if tempu(2) >= pidloop(1,5) + liuliangzhenfu       
            tempu(2) = pidloop(1,5) + liuliangzhenfu;
        end
        if tempu(2) <= pidloop(1,5) - liuliangzhenfu
            tempu(2) = pidloop(1,5) - liuliangzhenfu;
        end
              
        if tempu(3) >= pidloop(1,6) + liuliangzhenfu       
            tempu(3) = pidloop(1,6) + liuliangzhenfu;
        end
        if tempu(3) <= pidloop(1,6) - liuliangzhenfu
            tempu(3) = pidloop(1,6) - liuliangzhenfu;
        end
        
        
        
        if b>32
            if tempswitch(1)==1
                gdtemp_sum1_1=sum(data(5,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum1_2=sum(data(5,b-8:b-4)); 
            else
                gdtemp_sum1_1=sum(data(65,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum1_2=sum(data(65,b-8:b-4)); 
            end
            gdtemp_average1_1=gdtemp_sum1_1/5;
            gdtemp_average1_2=gdtemp_sum1_2/5;
            
            
            if tempswitch(2)==1
                gdtemp_sum2_1=sum(data(66,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum2_2=sum(data(66,b-8:b-4));
            else
                gdtemp_sum2_1=sum(data(24,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum2_2=sum(data(24,b-8:b-4));
            end
            gdtemp_average2_1=gdtemp_sum2_1/5;
            gdtemp_average2_2=gdtemp_sum2_2/5;
         
            
            if tempswitch(3)==1
                gdtemp_sum3_1=sum(data(43,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum3_2=sum(data(43,b-8:b-4));
            else
                gdtemp_sum3_1=sum(data(43,b-3:b+1)); %连续5s的拱顶温度
                gdtemp_sum3_2=sum(data(43,b-8:b-4));
            end            
            gdtemp_average3_1=gdtemp_sum3_1/5;
            gdtemp_average3_2=gdtemp_sum3_2/5;

            gdtemp1=[gdtemp_average1_1 gdtemp_average1_2];
            gdtemp2=[gdtemp_average2_1 gdtemp_average2_2];
            gdtemp3=[gdtemp_average3_1 gdtemp_average3_2];
            gdtemp=[gdtemp1;gdtemp2;gdtemp3];
            
            if tempswitch(1)==1
                gdwendu(1)=(sum(data(5,b-13:b+1)))/15; %5
            else
                gdwendu(1)=(sum(data(65,b-13:b+1)))/15; 
            end
            if tempswitch(2)==1
                gdwendu(2)=(sum(data(66,b-13:b+1)))/15; 
            else
                gdwendu(2)=(sum(data(24,b-13:b+1)))/15;  
            end
            if tempswitch(3)==1
                gdwendu(3)=(sum(data(71,b-13:b+1)))/15; %43
            else
                gdwendu(3)=(sum(data(43,b-13:b+1)))/15; 
            end

            
        else
            
            if tempswitch(1)==1
                gdwendu(1)=data(5,b+1);%5
            else
                gdwendu(1)=data(65,b+1);
            end
            if tempswitch(2)==1
                gdwendu(2)=data(66,b+1);
            else
                gdwendu(2)=data(24,b+1); 
            end
            if tempswitch(3)==1
                gdwendu(3)=data(71,b+1);%43
            else
                gdwendu(3)=data(43,b+1);  
            end      

        end
     %温度回路输出煤气流量设定值上下限
        for i=1:3
            switch i
                case 1                                  % 1#
                    if tempu(i)>=ff1_max*default_airgaspotial(i)            %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                        tempu(i)=ff1_max*default_airgaspotial(i);
                    end
                    if tempu(i)<=gas_lower1*default_airgaspotial(i)
                        tempu(i)=gas_lower1*default_airgaspotial(i);
                    end
                case 2                                  % 2#
                    if tempu(i) >= ff2_max*default_airgaspotial(i)            %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                        tempu(i) = ff2_max*default_airgaspotial(i);
                    end
                    if tempu(i) <= gas_lower2*default_airgaspotial(i)
                        tempu(i) = gas_lower2*default_airgaspotial(i);
                    end
                case 3                                  % 3#
                    if tempu(i) >= ff3_max*default_airgaspotial(i)            %这里乘上default_airgaspotial系数表示更改为以空气流量计算
                        tempu(i) = ff3_max*default_airgaspotial(i);
                    end
                    if tempu(i) <= gas_lower3*default_airgaspotial(i)   
                        tempu(i) = gas_lower3*default_airgaspotial(i);
                    end
            end
        end
    end
end
 if b<=15
    if tempswitch(1)==1
        gdwendu(1)=data(5,b+1);%5
    else
        gdwendu(1)=data(65,b+1);
    end
    if tempswitch(2)==1
        gdwendu(2)=data(66,b+1);
    else
        gdwendu(2)=data(24,b+1); 
    end
    if tempswitch(3)==1
        gdwendu(3)=data(71,b+1);%43
    else
        gdwendu(3)=data(43,b+1);  
    end   

 end
% if mod(b,100)==0                   %每100s清屏
%     clc;
% end

errorpos=9;
%% 空燃比自寻优
if b>50
    if(mod(b,se_op_time)==0)
         if (temp_open(1) == 1)
             if (tp_real(1)<tsp(1)-5)&&(gdtemp(1,1)-gdtemp(1,2)<=-0.12)&&(tem_dec_flag(1)==1)
                  %如果实际空燃比本来就比设定空燃比小，则表示只是流量没有调整到设定空燃比的值不需要继续增加设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(1) < mean(data(95,b-8:b+1))  
                     default_airgaspotial(1)=default_airgaspotial(1)+airgaspotialupsetoff;
                 end
                 tem_dec_flag_up_cnt(1) = tem_dec_flag_up_cnt(1) + 1; %表示空燃比进行加加经过几次
            %              tem_dec_flag(1)=1;
             elseif (tp_real(1)<tsp(1)-5)&&(gdtemp(1,1)-gdtemp(1,2)<=-0.12)&&(tem_dec_flag(1)==-1)
                  %如果实际空燃比本来就比设定空燃比大，则表示只是流量没有调整到设定空燃比的值不需要继续减少设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(1) > mean(data(95,b-8:b+1)) 
                    default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialdownsetoff;
                 end
                 tem_dec_flag_down_cnt(1) = tem_dec_flag_down_cnt(1) + 1;%表示空燃比进行减减经过几次
            %              tem_dec_flag(1)=-1;
             end
         end
         
        if (temp_open(2) == 1)
            if (tp_real(2)<tsp(2)-5)&&(gdtemp(2,1)-gdtemp(2,2)<=-0.12)&&(tem_dec_flag(2)==1)
                  %如果实际空燃比本来就比设定空燃比小，则表示只是流量没有调整到设定空燃比的值不需要继续增加设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(2) < mean(data(96,b-8:b+1))  
                     default_airgaspotial(2)=default_airgaspotial(2)+airgaspotialupsetoff;
                 end
                  tem_dec_flag_up_cnt(2) = tem_dec_flag_up_cnt(2) + 1;
    %              tem_dec_flag(2)=1;
            elseif (tp_real(2)<tsp(2)-5)&&(gdtemp(2,1)-gdtemp(2,2)<=-0.12)&&(tem_dec_flag(2)==-1)
                 %如果实际空燃比本来就比设定空燃比大，则表示只是流量没有调整到设定空燃比的值不需要继续减少设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(2) > mean(data(96,b-8:b+1)) 
                    default_airgaspotial(2)=default_airgaspotial(2)-airgaspotialdownsetoff;
                 end
                 tem_dec_flag_down_cnt(2) = tem_dec_flag_down_cnt(2) + 1;%表示空燃比进行减减经过几次
    %              tem_dec_flag(2)=0;
            end 
        end
        
        if (temp_open(3) == 1)
            if (tp_real(3)<tsp(3)-5)&&(gdtemp(3,1)-gdtemp(3,2)<=-0.12)&&(tem_dec_flag(3)==1)
                  %如果实际空燃比本来就比设定空燃比小，则表示只是流量没有调整到设定空燃比的值不需要继续增加设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(3) < mean(data(97,b-8:b+1))  
                     default_airgaspotial(3)=default_airgaspotial(3)+airgaspotialupsetoff;
                 end
                  tem_dec_flag_up_cnt(3) = tem_dec_flag_up_cnt(3) + 1;
    %              tem_dec_flag(3)=1;
            elseif (tp_real(3)<tsp(3)-5)&&(gdtemp(3,1)-gdtemp(3,2)<=-0.12)&&(tem_dec_flag(3)==-1)
                 %如果实际空燃比本来就比设定空燃比大，则表示只是流量没有调整到设定空燃比的值不需要继续减少设定空燃比，等待流量调整稳定到设定空燃比
                 if default_airgaspotial(3) > mean(data(97,b-8:b+1)) 
                    default_airgaspotial(3)=default_airgaspotial(3)-airgaspotialdownsetoff;
                 end
                 tem_dec_flag_down_cnt(3) = tem_dec_flag_down_cnt(3) + 1;%表示空燃比进行减减经过几次
    %              tem_dec_flag(3)=0;
            end 
        end   
    end

  
    %% 升温再寻优
% % % %     if (temp_open(1) == 1)
% % % %         if((gdwendu(1)<tsp(1)-7)&&(t_real(1)>feiqi_temp_set(1))&&(default_airgaspotial(1)>=max_airgaspotial(1))&&(mod(b,199)==0))                             
% % % %             default_airgaspotial(1)=default_airgaspotial(1) - airgaspotialdownsetoff;
% % % %         end
% % % %         if((gdwendu(1)<tsp(1)-7)&&(t_real(1)>feiqi_temp_set(1))&&(default_airgaspotial(1)<=min_airgaspotial(1))&&(mod(b,199)==0))
% % % %             default_airgaspotial(1)=default_airgaspotial(1) + airgaspotialupsetoff;
% % % %         end
% % % %     end
% % % %      
% % % %     if (temp_open(2) == 1)
% % % %         if ((gdwendu(2)<tsp(2)-7)&&(t_real(2)>feiqi_temp_set(2))&&(default_airgaspotial(2)>=max_airgaspotial(2))&&(mod(b,199)==0))                   
% % % %             default_airgaspotial(2)=default_airgaspotial(2) - airgaspotialdownsetoff;
% % % %         end    
% % % %         if ((gdwendu(2)<tsp(2)-7)&&(t_real(2)>feiqi_temp_set(2))&&(default_airgaspotial(2)<=min_airgaspotial(2))&&(mod(b,199)==0))
% % % %             default_airgaspotial(2)=default_airgaspotial(2) + airgaspotialupsetoff;
% % % %         end 
% % % %     end
% % % %     
% % % %     if (temp_open(3) == 1)
% % % %         if ((gdwendu(3)<tsp(3)-7)&&(t_real(3)>feiqi_temp_set(3))&&(default_airgaspotial(3)>=max_airgaspotial(3))&&(mod(b,199)==0))                            
% % % %             default_airgaspotial(3)=default_airgaspotial(3) - airgaspotialdownsetoff;
% % % %         end   
% % % %         if (((gdwendu(3)<tsp(3)-7)&&(t_real(3)>feiqi_temp_set(3))&&(default_airgaspotial(3)<=min_airgaspotial(3))&&(mod(b,199)==0)))
% % % %             default_airgaspotial(3)=default_airgaspotial(3) + airgaspotialupsetoff;
% % % %         end 
% % % %     end
   
    %上坡下坡判断
    if mod(b,2)==0 && (temp_open(1) == 1)
        if tempswitch(1)==1
            tem1=data(5,b+1);
            tem2=data(5,b-1);
        else
            tem1=data(65,b+1);
            tem2=data(65,b-1);
        end               
        if (tem1-tem2)<=-0.5
            if tem_dec_flag(1) == 1 && tem_dec_flag_up_cnt(1) < 3
                tem_dec_flag(1)=tem_dec_flag(1);
            elseif tem_dec_flag(1) == 1 && tem_dec_flag_up_cnt(1) >= 3 %试探3步
                tem_dec_flag(1)=tem_dec_flag(1)*-1;
                tem_dec_flag_up_cnt(1) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            elseif tem_dec_flag(1) == -1 && tem_dec_flag_down_cnt(1) < 3
                tem_dec_flag(1)=tem_dec_flag(1);
            elseif tem_dec_flag(1) == -1 && tem_dec_flag_down_cnt(1) >= 3 %试探3步
                tem_dec_flag(1)=tem_dec_flag(1)*-1;
                tem_dec_flag_down_cnt(1) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            end
        elseif (tem1-tem2)>=0
            %复位
            tem_dec_flag_up_cnt(1) = 0; 
            tem_dec_flag_down_cnt(1) = 0;
        end
    end

    if mod(b,2)==0 && (temp_open(2) == 1)
        if tempswitch(2)==1
            tem1=data(66,b+1);
            tem2=data(66,b-1);
        else
            tem1=data(24,b+1);
            tem2=data(24,b-1);
        end
        if (tem1-tem2)<=-0.5
            if tem_dec_flag(2) == 1 && tem_dec_flag_up_cnt(2) < 3
                tem_dec_flag(2)=tem_dec_flag(2);
            elseif tem_dec_flag(2) == 1 && tem_dec_flag_up_cnt(2) >= 3 %试探3步
                tem_dec_flag(2)=tem_dec_flag(2)*-1;
                tem_dec_flag_up_cnt(2) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            elseif tem_dec_flag(2) == -1 && tem_dec_flag_down_cnt(2) < 3
                tem_dec_flag(2)=tem_dec_flag(2);
            elseif tem_dec_flag(2) == -1 && tem_dec_flag_down_cnt(2) >= 3 %试探3步
                tem_dec_flag(2)=tem_dec_flag(2)*-1;
                tem_dec_flag_down_cnt(2) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            end
        elseif (tem1-tem2)>=0
            %复位
            tem_dec_flag_up_cnt(2) = 0; 
            tem_dec_flag_down_cnt(2) = 0;
        end
    end

    if mod(b,2)==0 && (temp_open(3) == 1)
        if tempswitch(3)==0
            tem1=data(43,b+1);
            tem2=data(43,b-1);
        else
            tem1=data(71,b+1);
            tem2=data(71,b-1);
        end
        if (tem1-tem2)<=-0.5
            if tem_dec_flag(3) == 1 && tem_dec_flag_up_cnt(3) < 3
                tem_dec_flag(3)=tem_dec_flag(3);
            elseif tem_dec_flag(3) == 1 && tem_dec_flag_up_cnt(3) >= 3 %试探3步
                tem_dec_flag(3)=tem_dec_flag(3)*-1;
                tem_dec_flag_up_cnt(3) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            elseif tem_dec_flag(3) == -1 && tem_dec_flag_down_cnt(3) < 3
                tem_dec_flag(3)=tem_dec_flag(3);
            elseif tem_dec_flag(3) == -1 && tem_dec_flag_down_cnt(3) >= 3 %试探3步
                tem_dec_flag(3)=tem_dec_flag(3)*-1;
                tem_dec_flag_down_cnt(3) = 0; %复位
%                 default_airgaspotial(1)=default_airgaspotial(1)-airgaspotialupsetoff*2; %方向错误后，直接从最初加3次（2次）前的值反向找，节省从当前往回找的时间
            end
        elseif (tem1-tem2)>=0
            %复位
            tem_dec_flag_up_cnt(3) = 0; 
            tem_dec_flag_down_cnt(3) = 0;
        end
    end
end    

for i=1:3
    if default_airgaspotial(i)<min_airgaspotial(i)
       default_airgaspotial(i)=min_airgaspotial(i);
       %default_airgaspotial_set(i)=default_airgaspotial(i);
    end 
    if default_airgaspotial(i)>max_airgaspotial(i)
       default_airgaspotial(i)=max_airgaspotial(i);
       %default_airgaspotial_set(i)=default_airgaspotial(i);
    end
end




 for i=1:3      
     %根据空燃比配空气流量   修改为 根据空燃比配煤气流量
     % airsp(i)=tempu(i).*airgaspotial(i);
     %温度回路输出空气流量设定值上下限
     switch i
         case 1                              % 1#
             if(gdwendu(i)>tsp(i)&&gdwendu(i)<tsp(i)+4)
                 default_airgaspotial(1)=default_airgaspotial_set(1)+0.07;
             elseif(gdwendu(i)>=tsp(i)+4&&gdwendu(i)<tsp(i)+8)
                 default_airgaspotial(1)=default_airgaspotial_set(1)+0.12;
             elseif(gdwendu(i)>=tsp(i)+8&&gdwendu(i)<tsp(i)+10)
                 default_airgaspotial(1)=default_airgaspotial_set(1)+0.14;
             elseif(gdwendu(i)>=tsp(i)+10&&gdwendu(i)<tsp(i)+12)
                 default_airgaspotial(1)=default_airgaspotial_set(1)+0.16;
             elseif(gdwendu(i)>=tsp(i)+12)
                 default_airgaspotial(1)=default_airgaspotial_set(1)+0.28;  
             elseif(gdwendu(i)<tsp(i)+1&&gdwendu(i)>tsp(i)-5)
                 default_airgaspotial(1)=default_airgaspotial_set(1);
             end
      
             
             if(gap_on(1)==1)
%                  airsp(i)=tempu(i).*default_airgaspotial(1); %根据空燃比配空气流量   修改为 根据空燃比配煤气流量
                 gassp(i)=tempu(i)./default_airgaspotial(1);
             else
                 gassp(i)=tempu(i)./default_airgaspotial(i);
             end
             
             if gassp(i) >= pidloop(1,1) + liuliangzhenfu
                 gassp(i) = pidloop(1,1) + liuliangzhenfu;
             end
             if gassp(i) <= pidloop(1,1) - liuliangzhenfu
                 gassp(i) = pidloop(1,1) - liuliangzhenfu;
             end
             
             if gassp(i)>=ff1_max
                 gassp(i)=ff1_max;
             end
             if gassp(i)<=gas_lower1
                 gassp(i)=gas_lower1;
             end
         case 2                                  % 2#
             if(gdwendu(i)>tsp(i)&&gdwendu(i)<tsp(i)+4)
                 default_airgaspotial(2)=default_airgaspotial_set(2)+0.05;
             elseif(gdwendu(i)>=tsp(i)+4&&gdwendu(i)<tsp(i)+8)
                 default_airgaspotial(2)=default_airgaspotial_set(2)+0.08;
             elseif(gdwendu(i)>=tsp(i)+8&&gdwendu(i)<tsp(i)+10)
                 default_airgaspotial(2)=default_airgaspotial_set(2)+0.12;
             elseif(gdwendu(i)>=tsp(i)+10&&gdwendu(i)<tsp(i)+12)
                 default_airgaspotial(2)=default_airgaspotial_set(2)+0.18;
             elseif(gdwendu(i)>=tsp(i)+12)
                 default_airgaspotial(2)=default_airgaspotial_set(2)+0.28;  
             elseif(gdwendu(i)<tsp(i)&&gdwendu(i)>tsp(i)-5)
                 default_airgaspotial(2)=default_airgaspotial_set(2);
             end
             
             
             if(gap_on(2)==1)
                 gassp(i)=tempu(i)./default_airgaspotial(2);
             else
                 gassp(i)=tempu(i)./default_airgaspotial(i);
             end
             
             if gassp(i) >= pidloop(1,2) + liuliangzhenfu
                 gassp(i) = pidloop(1,2) + liuliangzhenfu;
             end
             if gassp(i) <= pidloop(1,2) - liuliangzhenfu
                 gassp(i) = pidloop(1,2) - liuliangzhenfu;
             end
             
             if gassp(i) >= ff2_max
                 gassp(i) = ff2_max;
             end
             if gassp(i) <= gas_lower2
                 gassp(i) = gas_lower2;
             end
         case 3                                  % 3# kongranbi
             if(gdwendu(i)>tsp(i)+1&&gdwendu(i)<tsp(i)+4)
                 default_airgaspotial(3)=default_airgaspotial_set(3)+0.05;
             elseif(gdwendu(i)>=tsp(i)+4&&gdwendu(i)<tsp(i)+8)
                 default_airgaspotial(3)=default_airgaspotial_set(3)+0.10;
             elseif(gdwendu(i)>=tsp(i)+8&&gdwendu(i)<tsp(i)+10)
                 default_airgaspotial(3)=default_airgaspotial_set(3)+0.12;
             elseif(gdwendu(i)>=tsp(i)+10&&gdwendu(i)<tsp(i)+12)
                 default_airgaspotial(3)=default_airgaspotial_set(3)+0.20;
             elseif(gdwendu(i)>=tsp(i)+12)
                 default_airgaspotial(3)=default_airgaspotial_set(3)+0.28;  
             elseif(gdwendu(i)<ts3+1&&gdwendu(i)>tsp(i)-5)
                 default_airgaspotial(3)=default_airgaspotial_set(3);
             end
             
             
             if(gap_on(3)==1)
                 gassp(i)=tempu(i)./default_airgaspotial(3);
             else
                 gassp(i)=tempu(i)./default_airgaspotial(i);
             end
             
             if gassp(i) >= pidloop(1,3) + liuliangzhenfu
                 gassp(i) = pidloop(1,3) + liuliangzhenfu;
             end
             if gassp(i) <= pidloop(1,3) - liuliangzhenfu
                 gassp(i) = pidloop(1,3) - liuliangzhenfu;
             end
             
             if gassp(i) >= ff3_max
                 gassp(i) = ff3_max;
             end
             if gassp(i) <= gas_lower3
                 gassp(i) = gas_lower3;
             end
     end
 end
      
%强制降温
if(gdwendu(1)>=tsp(1))
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.25;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.25;
end
if(gdwendu(1)>=tsp(1)+5)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.3;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.3;
end
if(gdwendu(1)>=tsp(1)+8)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.35;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.35;
end
if(gdwendu(1)>=tsp(1)+12)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.4;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.4;
end
if(gdwendu(1)>=tsp(1)+15)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.45;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.45;
end
if(gdwendu(1)>=tsp(1)+20)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.55;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.55;
end
if(gdwendu(1)>=tsp(1)+25)
     default_airgaspotial(1)=default_airgaspotial_set(1)+0.65;
     max_airgaspotial(1)=default_airgaspotial_set(1)+0.65;
end
% % % if(gdwendu(1)<tsp(1)+12)
% % %      max_airgaspotial(1)=default_airgaspotial_set(1)+0.05;
% % % end    
if(gdwendu(2)>=tsp(2))
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.25;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.25;
end
if(gdwendu(2)>=tsp(2)+5)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.35;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.35;
end
if(gdwendu(2)>=tsp(2)+8)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.4;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.4;
end
if(gdwendu(2)>=tsp(2)+12)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.45;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.45;
end
if(gdwendu(2)>=tsp(2)+15)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.55;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.55;
end
if(gdwendu(2)>=tsp(2)+18)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.55;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.55;
end
if(gdwendu(2)>=tsp(2)+25)
     default_airgaspotial(2)=default_airgaspotial_set(2)+0.6;
     max_airgaspotial(2)=default_airgaspotial_set(2)+0.6;
end
% % if(gdwendu(2)<tsp(2)+12)
% %      max_airgaspotial(2)=default_airgaspotial_set(2)+0.05;
% % end
if(gdwendu(3)>=tsp(3))
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.38;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.38;
end
if(gdwendu(3)>=tsp(3)+5)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.42;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.42;
end
if(gdwendu(3)>=tsp(3)+8)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.45;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.45;
end
if(gdwendu(3)>=tsp(3)+12)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.5;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.5;
end
if(gdwendu(3)>=tsp(3)+15)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.55;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.55;
end
if(gdwendu(3)>=tsp(3)+18)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.65;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.65;
end
if(gdwendu(3)>=tsp(3)+25)
     default_airgaspotial(3)=default_airgaspotial_set(3)+0.7;
     max_airgaspotial(3)=default_airgaspotial_set(3)+0.7;
end
% % % if(gdwendu(3)<tsp(3)+12)
% % %      max_airgaspotial(3)=default_airgaspotial_set(3)+0.05;
% % % end

 
 for i=1:3
    if default_airgaspotial(i)<min_airgaspotial(i)
       default_airgaspotial(i)=min_airgaspotial(i);
    end 
    if default_airgaspotial(i)>max_airgaspotial(i)
       default_airgaspotial(i)=max_airgaspotial(i);
    end
 end
 
 %% 根据富氧流量变换寻优区间
% % % %  if data(60,b+1)<10
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
% % % %  elseif data(60,b+1)<20
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_2;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_2;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_2;
% % % %  elseif data(60,b+1)<30    
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_3;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_3;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_3;
% % % %  elseif data(60,b+1)<40    
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_4;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_4;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_4;
% % % %  elseif data(60,b+1)<50    
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_5;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_5;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_5;
% % % %  elseif data(60,b+1)<55    
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_6;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_6;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_6;
% % % %  elseif data(60,b+1)<65   
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_7;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_7;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_7;
% % % %  else   
% % % %     default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_8;
% % % %     default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_8;
% % % %     default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_8;
% % % %  end
 
% % % % % % for i=1:3
% % % % % %     if((default_airgaspotial_set(i)-0.05)~=min_airgaspotial(i))
% % % % % %      %   default_airgaspotial(i)=default_airgaspotial_set(i);
% % % % % %         default_airgaspotial_set(i)=default_airgaspotial_set(i);
% % % % % %         min_airgaspotial(i)=default_airgaspotial_set(i)-0.05;
% % % % % %         max_airgaspotial(i)=default_airgaspotial_set(i)+0.2;
% % % % % %     end
% % % % % % end

%% 存入空燃比和煤气、空气流量滤波后的测量值
data(a+15,b+1)=default_airgaspotial(1);         % 三段空燃比设定值  a=86
data(a+16,b+1)=default_airgaspotial(2);
data(a+17,b+1)=default_airgaspotial(3);
data(a+18,b+1)=gasmean(1); 
data(a+19,b+1)=gasmean(2);
data(a+20,b+1)=gasmean(3);
data(a+21,b+1)=airmean(1);
data(a+22,b+1)=airmean(2);
data(a+23,b+1)=airmean(3);
 
%% 煤气空气测量值存入pidloop
pidloop(2,1)=data(12,b+1);%gasmean(1);                          % 煤气、空气流量滤波后的测量值==
if b > 10
    pidloop(2,2)=mean(data(31,b-8:b+1));%gasmean(2);
else
    pidloop(2,2)=data(31,b+1);%gasmean(2);
end

if b > 10
    pidloop(2,3)=mean(data(50,b-8:b+1));%gasmean(3);
else
    pidloop(2,3)=data(50,b+1);%gasmean(3);
end


pidloop(2,4)=data(13,b+1);%airmean(1);                             
pidloop(2,5)=data(32,b+1);%airmean(2);
pidloop(2,6)=data(51,b+1);%airmean(3);

pidloop(2,7)=gas_pressure_1;         % 煤气总管压力测量值存入pidloop
pidloop(2,8)=air_pressure_1;          % 空气总管压力测量值存入pidloop

%% 防止煤气饱和后引起震荡
% % % for i=1:3
% % %     if t_real(i)>feiqi_temp_set(i)
% % %         if min_burning(i)==0&&max_burning(i)==0
% % %              if tempu(i)>(gasmean(i)*default_airgaspotial(i)+3000)
% % %                 tempu(i)=gasmean(i)*default_airgaspotial(i)+3000;
% % %              end
% % %              if tempu(i)<(gasmean(i)*default_airgaspotial(i)-3000)
% % %                 tempu(i)=gasmean(i)*default_airgaspotial(i)-3000;
% % %              end
% % %         else
% % %              if tempu(i)>(gasmean(i)*default_airgaspotial(i)+5000)
% % %                 tempu(i)=gasmean(i)*default_airgaspotial(i)+5000;
% % %              end
% % %              if tempu(i)<(gasmean(i)*default_airgaspotial(i)-5000)
% % %                 tempu(i)=gasmean(i)*default_airgaspotial(i)-5000;
% % %              end
% % %         end
% % %     end
% % % end
 
%% 解决控制器上下限饱和    
if b>=20
gasmv=[data(1,b-3:b+1);data(20,b-3:b+1);data(39,b-3:b+1)];
airmv=[data(3,b-3:b+1);data(22,b-3:b+1);data(41,b-3:b+1)];
    for i=1:3   
        if temp_open(i)==1
            switch i
                case 1                   
                    if (tp_1 >= ts_1)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>tempu(i))    %当实际温度大于设定温度时且空气气阀门连续五秒为零时，空气气设定值等于实际值 ，此时PID输出为零               
                        pidloop(1,4)=airmean(i);
                        tempu(i)=airmean(i);
                        
                    end
                    if (min_burning(i)==1)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>gas_lower1*default_airgaspotial(i))
                        pidloop(1,4)=airmean(i);
                        tempu(i)=airmean(i);
                    end
                    
                    if (tp_1 <= ts_1||max_burning(i)==1)&&(sum(airmv(i,:)>=air1_up)==5)&&(airmean(i)<ff1_max*default_airgaspotial(i))   %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,4)=pidloop(2,4);
                        tempu(i)=pidloop(2,4);                      
                    end   
                    if (tp_1 <= ts_1||max_burning(i)==1)&&(min_burning(i)==0)&&(sum(gasmv(i,:)>=gas1_up)==5)&&(gasmean(i)<ff1_max)   %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,1)=pidloop(2,1);
                        gassp(i)=gasmean(i);
                        tempu(i)=gassp(i)*default_airgaspotial(i);
                    end      
                    if (sum(airmv(i,:)>=85)==5)||(sum(gasmv(i,:)>=98)==5)
                       if sum((data(75,b-7:b)-data(13,b-7:b))>20)==8
                            pidloop(1,4)=pidloop(2,4);
                            tempu(i)=pidloop(2,4);
                            
%                             pidloop(1,1)=airmean(i)./default_airgaspotial(i);
%                             tempu(i)=airmean(i)./default_airgaspotial(i);
%                             airsp(i)=airmean(i);
%                             pidloop(1,4)=airsp(i);
%                             pidloop(2,4)=pidloop(1,4);
                        end
                        if sum((data(72,b-7:b)-data(12,b-7:b))>30)==8
%                             pidloop(1,1)=pidloop(2,1);
%                             tempu(i)=pidloop(2,1);
                            
                            pidloop(1,4)=gasmean(i).*default_airgaspotial(i);
                            tempu(i)=gasmean(i).*default_airgaspotial(i);
                            gassp(i)=gasmean(i);
                            pidloop(1,1)=gassp(i);
                            pidloop(2,1)=pidloop(1,1);
                        end
 
                    end
                    gassp(i)=tempu(i)./default_airgaspotial(i);
                    data(75,b+1)=tempu(i);
                     if gassp(i)>=ff1_max
                         gassp(i)=ff1_max;
                     end
                     if gassp(i)<=gas_lower1
                         gassp(i)=gas_lower1;
                     end
                case 2
                    if (tp_2 >= ts_2)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>tempu(i))    %当实际温度大于设定温度时且煤气阀门连续五秒为零时，煤气设定值等于实际值 ，此时PID输出为零               
                        pidloop(1,5)=airmean(i);
                        tempu(i)=airmean(i);
                    end
                    if (min_burning(i)==1)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>gas_lower2*default_airgaspotial(i))
                        pidloop(1,5)=airmean(i);
                        tempu(i)=airmean(i);
                    end
                    if (tp_2 <= ts_2||max_burning(i)==1)&&(sum(airmv(i,:)>=air2_up)==5) && (airmean(i)<ff2_max*default_airgaspotial(i))   %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,5)=pidloop(2,5);
                        tempu(i)=pidloop(2,5);                      
                    end   
                    if (tp_2 <= ts_2||max_burning(i)==1)&&(min_burning(i)==0)&&(sum(gasmv(i,:)>=gas2_up)==5)&&(gasmean(i)<ff2_max)   %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,2)=pidloop(2,2);
                        gassp(i)=gasmean(i);
                        tempu(i)=gassp(i)*default_airgaspotial(i);
                    end 
                     if (sum(airmv(i,:)>=85)==5)||(sum(gasmv(i,:)>=98)==5)
                       if sum((data(76,b-7:b)-data(32,b-7:b))>20)==8
                            pidloop(1,5)=pidloop(2,5);
                            tempu(i)=pidloop(2,5);
                            
%                             pidloop(1,2)=airmean(i)./default_airgaspotial(i);
%                             tempu(i)=airmean(i)./default_airgaspotial(i);
%                             airsp(i)=airmean(i);
%                             pidloop(1,5)=airsp(i);
%                             pidloop(2,5)=pidloop(1,5);
                           
                        end 
                        if sum((data(73,b-7:b)-data(31,b-7:b))>30)==8
%                             pidloop(1,2)=pidloop(2,2);
%                             tempu(i)=pidloop(2,2);
                            
                            pidloop(1,5)=gasmean(i).*default_airgaspotial(i);
                            tempu(i)=gasmean(i).*default_airgaspotial(i);
                            gassp(i)=gasmean(i);
                            pidloop(1,2)=gassp(i);
                            pidloop(2,2)=pidloop(1,2);
                        end
                    end
                    gassp(i)=tempu(i)./default_airgaspotial(i);
                    data(76,b+1)=tempu(i);
                    if gassp(i)>=ff2_max
                        gassp(i)=ff2_max;
                    end
                    if gassp(i)<=gas_lower2
                        gassp(i)=gas_lower2;
                    end
                case 3                 
                    if (tp_3 >= ts_3)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>tempu(i))    %当实际温度大于设定温度时且煤气阀门连续五秒为零时，煤气设定值等于实际值 ，此时PID输出为零               
                        pidloop(1,6)=airmean(i);
                        tempu(i)=airmean(i);
                        
                    end
                    if (min_burning(i)==1)&&(sum(airmv(i,:)<=6)==5)&&(airmean(i)>gas_lower3*default_airgaspotial(i))
                        pidloop(1,6)=airmean(i);
                        tempu(i)=airmean(i);
                    end
                    if (tp_3 <=ts_3||max_burning(i)==1)&&(sum(airmv(i,:)>=air3_up)==5)&& (airmean(i)<ff3_max*default_airgaspotial(i))    %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,6)=pidloop(2,6);
                        tempu(i)=pidloop(2,6);
                    end
                    if (tp_3 <= ts_3||max_burning(i)==1)&&(min_burning(i)==0)&&(sum(gasmv(i,:)>=gas3_up)==5)&&(gasmean(i)<ff3_max)   %当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,3)=pidloop(2,3);
                        gassp(i)=gasmean(i);
                        tempu(i)=gassp(i)*default_airgaspotial(i);
                    end 
                    if (sum(airmv(i,:)>=85)==5)||(sum(gasmv(i,:)>=95)==5)
                        if sum((data(77,b-7:b)-data(51,b-7:b))>20)==8
                            pidloop(1,6)=pidloop(2,6);
                            tempu(i)=pidloop(2,6);
                            
%                             pidloop(1,3)=airmean(i)./default_airgaspotial(i);
%                             tempu(i)=airmean(i)./default_airgaspotial(i);
%                             airsp(i)=airmean(i);
%                             pidloop(1,6)=airsp(i);
%                             pidloop(2,6)=pidloop(1,6);
                        end 
                        if sum((data(74,b-7:b)-data(50,b-7:b))>30)==8
%                             pidloop(1,3)=pidloop(2,3);
%                             tempu(i)=pidloop(2,3);
                            
                            pidloop(1,6)=gasmean(i).*default_airgaspotial(i);
                            tempu(i)=gasmean(i).*default_airgaspotial(i);
                            gassp(i)=gasmean(i);
                            pidloop(1,3)=gassp(i);
                            pidloop(2,3)=pidloop(1,3);
                        end
                    end
                    gassp(i)=tempu(i)./default_airgaspotial(i);
                    data(77,b+1)=tempu(i);
                    if gassp(i)>=ff3_max
                       gassp(i)=ff3_max;
                    end
                    if gassp(i)<=gas_lower3
                       gassp(i)=gas_lower3;
                    end

                otherwise
                    'error from switch';
            end
        end
    end
end
errorpos=12;
%% 空气上下限处理
    % 1#
    if tempu(1)>=ff1_max*default_airgaspotial(1)
        tempu(1)=ff1_max*default_airgaspotial(1);
    end
    if (tempu(1)<=gas_lower1*default_airgaspotial(1))&&(min_burning(1)==0)
        tempu(1)=gas_lower1*default_airgaspotial(1);
    end
    % 2#
    if tempu(2) >= ff2_max*default_airgaspotial(2)
        tempu(2) = ff2_max*default_airgaspotial(2);
    end
    if (tempu(2) <= gas_lower2*default_airgaspotial(2))&&(min_burning(2)==0)
        tempu(2) = gas_lower2*default_airgaspotial(2);
    end
    % 3#
    if tempu(3) >= ff3_max*default_airgaspotial(3)
        tempu(3) = ff3_max*default_airgaspotial(3);
    end
    if (tempu(3) <= gas_lower3*default_airgaspotial(3))&&(min_burning(3)==0)    
        tempu(3) = gas_lower3*default_airgaspotial(3);
    end
%% 将计算出的煤气空气流量设定值以及压力设定值存入pidloop和data之中
    if ((temp_open(1) == 1) &&(burning1==1))
        pidloop(1,4)=tempu(1);
        pidloop(1,1)=gassp(1);
        data(75,b+1)=tempu(1);
        data(72,b+1)=gassp(1);
    end
    if ((temp_open(2) == 1) &&(burning2==1))
        pidloop(1,5)=tempu(2); 
        pidloop(1,2)=gassp(2);
        data(76,b+1)=tempu(2);
        data(73,b+1)=gassp(2);
    end
    if ((temp_open(3) == 1) &&(burning3==1))
        pidloop(1,6)=tempu(3);
        pidloop(1,3)=gassp(3);
        data(77,b+1)=tempu(3);
        data(74,b+1)=gassp(3);
    end
    pidloop(1,7)=gas_pressure;         % 没有煤气总管压力调节，为了删减会出现问题，故保留了此句话。此时PID不会调节
    
    
    
for i=1:3
    if max_burning(i)==0&&min_burning(i)==0
        if tempu(i)>data(74+i,b)+3000
            tempu(i)=data(74+i,b)+3000;
        end
        if tempu(i)<data(74+i,b)-3000
            tempu(i)=data(74+i,b)-3000;
        end
    end
end
    
[~, loopnum]=size(pidloop);
for i=1:loopnum
   pidloop(4,i)=pidloop(1,i)-pidloop(2,i);
end
%% 煤气空气支管阀门调试设定值，全自动后注释
% pidloop(1,4) = 350;
% pidloop(1,5) = 450;
% pidloop(1,6) = 500;
% 
% pidloop(1,1) = pidloop(1,4)/0.58;
% pidloop(1,2) = pidloop(1,5)/0.75;
% pidloop(1,3) = pidloop(1,6)/0.8;

%% 参数实时设定

%1#
%  1#煤气阀门
pidloop(7,1)=paramdata.furnacetype(1).parameter(3).ATTRIBUTE.gasPara1_1;
pidloop(8,1)=paramdata.furnacetype(1).parameter(3).ATTRIBUTE.gasPara1;
% pidloop(9,1)=0.1;
if mod(b,2)==0
    if pidloop(11,1) <= gas1_up
        pidloop(11,1)=pidloop(11,1)+1;
    end
    if pidloop(11,1) > gas1_up
        pidloop(11,1)=pidloop(11,1)-1;
    end

    if pidloop(12,1) <= gas1_down
        pidloop(12,1)=pidloop(12,1)+1;
    end
    if pidloop(12,1) > gas1_down
        pidloop(12,1)=pidloop(12,1)-1;
    end
end
pidloop(13,1)=0.5;
%  1#空气阀门
pidloop(7,4)=paramdata.furnacetype(1).parameter(3).ATTRIBUTE.airPara1_1;
pidloop(8,4)=paramdata.furnacetype(1).parameter(3).ATTRIBUTE.airPara1;
if mod(b,2) == 0
    if pidloop(11,4) <= air1_up
        pidloop(11,4)=pidloop(11,4)+1;
    end
    if pidloop(11,4) > air1_up
        pidloop(11,4)=pidloop(11,4)-1;
    end

    if pidloop(12,4) <= air1_down
        pidloop(12,4)=pidloop(12,4)+1;
    end
    if pidloop(12,4) > air1_down
        pidloop(12,4)=pidloop(12,4)-1;
    end
end
pidloop(13,4)=0.5;


%2#
pidloop(7,2)=paramdata.furnacetype(2).parameter(3).ATTRIBUTE.gasPara2_1;
pidloop(8,2)=paramdata.furnacetype(2).parameter(3).ATTRIBUTE.gasPara2;
pidloop(9,2)=0.1;
if mod(b,2)==0
    if pidloop(11,2) <= gas2_up
        pidloop(11,2)=pidloop(11,2)+1;
    end
    if pidloop(11,2) > gas2_up
        pidloop(11,2)=pidloop(11,2)-1;
    end

    if pidloop(12,2) <= gas2_down
        pidloop(12,2)=pidloop(12,2)+1;
    end
    if pidloop(12,2) > gas2_down
        pidloop(12,2)=pidloop(12,2)-1;
    end
end
pidloop(13,2)=0.5;


pidloop(7,5)=paramdata.furnacetype(2).parameter(3).ATTRIBUTE.airPara2_1;  %空气
pidloop(8,5)=paramdata.furnacetype(2).parameter(3).ATTRIBUTE.airPara2;
if mod(b,2) == 0
    if pidloop(11,5) <= air2_up
        pidloop(11,5)=pidloop(11,5)+1;
    end
    if pidloop(11,5) > air2_up
        pidloop(11,5)=pidloop(11,5)-1;
    end

    if pidloop(12,5) <= air2_down
        pidloop(12,5)=pidloop(12,5)+1;
    end
    if pidloop(12,5) > air2_down
        pidloop(12,5)=pidloop(12,5)-1;
    end
end
pidloop(13,5)=0.5;

%3# 3hao

pidloop(7,3)=paramdata.furnacetype(3).parameter(3).ATTRIBUTE.gasPara3_1;
pidloop(8,3)=paramdata.furnacetype(3).parameter(3).ATTRIBUTE.gasPara3;
if mod(b,2)==0
    if pidloop(11,3) <= gas3_up
        pidloop(11,3)=pidloop(11,3)+1;
    end
    if pidloop(11,3) > gas3_up
        pidloop(11,3)=pidloop(11,3)-1;
    end

    if pidloop(12,3) <= gas3_down
        pidloop(12,3)=pidloop(12,3)+1;
    end
    if pidloop(12,3) > gas3_down
        pidloop(12,3)=pidloop(12,3)-1;
    end
end
pidloop(13,3)=0.5;

pidloop(7,6)=paramdata.furnacetype(3).parameter(3).ATTRIBUTE.airPara3_1;  %空气
pidloop(8,6)=paramdata.furnacetype(3).parameter(3).ATTRIBUTE.airPara3;
if mod(b,2) == 0
    if pidloop(11,6) <= air3_up
        pidloop(11,6)=pidloop(11,6)+1;
    end
    if pidloop(11,6) > air3_up
        pidloop(11,6)=pidloop(11,6)-1;
    end

    if pidloop(12,6) <= air3_down
        pidloop(12,6)=pidloop(12,6)+1;
    end
    if pidloop(12,6) > air3_down
        pidloop(12,6)=pidloop(12,6)-1;
    end
end
pidloop(13,6)=0.5;


pidloop(7,7)=5;  %煤气管网压力
pidloop(8,7)=40;
pidloop(11,7)=98;
pidloop(12,7)=10;



% if (abs(pidloop(5,8))>=1)
%     pidloop(7,8)=4;
%     if (abs(pidloop(5,8))>=2)
%     pidloop(7,8)=5;
%     end
%        
% end
% 22#
if b > 15 && mod(b,15) == 0
    if ((gasmean(1) > 3000 && gasmean(2) <= 100 && gasmean(3) <= 100 ) ||...  %只有一个小炉处于烧炉状态时
         (gasmean(1) <= 100  && gasmean(2) > 3000 && gasmean(3) <= 100) ||...
         (gasmean(1) <= 100  && gasmean(2) <= 100  && gasmean(3) > 3000))
        if avg_gas <= 6
          air_pressure = 7.5;
        elseif avg_gas <= 8.5
            air_pressure = 8.8;
        elseif avg_gas <= 9.5
            air_pressure = 9.5;
        elseif avg_gas <= 10.5
            air_pressure = 9.6;
        elseif avg_gas <= 11.5
            air_pressure = 9.6;
        elseif avg_gas <= 12.5
            air_pressure = 9.8; %9.3
        elseif avg_gas <= 15
            air_pressure = 9.8; %9.5
        else
            air_pressure = 10;
        end    
    else  %两个炉子处于烧炉状态时
        if avg_gas <= 6
          air_pressure = 8.5;
        elseif avg_gas <= 8.5
            air_pressure = 9.5;
        elseif avg_gas <= 9.5
            air_pressure = 9.6;
        elseif avg_gas <= 10.5
            air_pressure = 9.8;
        elseif avg_gas <= 11.5
            air_pressure = 10;
        elseif avg_gas <= 12.5
            air_pressure = 10;
        elseif avg_gas <= 15
            air_pressure = 10.5;
        else
            air_pressure = 10.5;
        end  
    end
    
    %这里将助燃风压力跟踪CO含量变化
    if gas_co < 21
        air_pressure = air_pressure - 0.7;
    elseif gas_co < 22
        air_pressure = air_pressure - 0.6;
    elseif gas_co < 23
        air_pressure = air_pressure - 0.5;
    end
    air_pressure = air_pressure + air_pressure_offset;
    if air_pressure >= 11.5
        air_pressure = 11.5;
    end
    if air_pressure <= 7
        air_pressure = 7;
    end
    set(handles.air_press,'String',air_pressure);
%     set(handles.air_slider,'Value',air_pressure);
end
pidloop(1,8)=air_pressure;          % 空气总管压力设定值存入pidloop

pidloop(7,8)=3.2;  %空气总管压力
pidloop(8,8)=87;
if choose_fj == 1
    pidloop(11,8)=fj_max;
    pidloop(12,8)=fj_min;
else
    pidloop(11,8)=85;
    pidloop(12,8)=30;
end

pidloop(13,8)=0.1;
% % % if pidloop(3,8) <= 40
% % %     pidloop(7,8)=3.2;  %空气总管压力
% % %     pidloop(8,8)=85;
% % % elseif pidloop(3,8) <= 60
% % %     pidloop(7,8)=5.5;  %空气总管压力
% % %     pidloop(8,8)=135;
% % % elseif pidloop(3,8) <= 70
% % %     pidloop(7,8)=7.5;  %空气总管压力
% % %     pidloop(8,8)=205;
% % % else
% % %     pidloop(7,8)=8.0;  %空气总管压力
% % %     pidloop(8,8)=285;
% % % end


deadzone=[1 1 1];
 %%   无扰切换处理
%SP跟随PV MV跟随手动值
%因为现场有PID自动控制，导致现场自动状态下设定值始终为0（或者说拿不到设定值，所以使用反馈值data(2,b+1)，2）
for i=1:loopnum
    switch i
        case 1
            if pidloop(10,i)==1
%           %writeasync(itemset(2),data(1,b+1));
            pidloop(1,i)=pidloop(2,i);
            pidloop(3,i)=data(1,b+1);  
%           upid_old(i)=pidloop(3,i);
%                 if b>3
%                     default_airgaspotial(1)=(data(13,b+1)/data(12,b+1)+data(13,b)/data(12,b)+data(13,b-1)/data(12,b-1))/3;
%                 end
            end
        case 2
            if pidloop(10,i)==1
            pidloop(1,i)=pidloop(2,i);%==
            pidloop(3,i)=data(20,b+1);%==
%             upid_old(i)=pidloop(3,i);         
%                 if b>3
%                     default_airgaspotial(2)=(data(32,b+1)/data(31,b+1)+data(32,b)/data(31,b)+data(32,b-1)/data(31,b-1))/3;
%                 end
            end
        case 3
            if pidloop(10,i)==1
            pidloop(1,i)=pidloop(2,i);%==
            pidloop(3,i)=data(39,b+1);%==
%             upid_old(i)=pidloop(3,i);
%                 if b>3
%                     default_airgaspotial(3)=(data(51,b+1)/data(50,b+1)+data(51,b)/data(50,b)+data(51,b-1)/data(50,b-1))/3;
%                 end
            end
        case 4
            if pidloop(10,i)==1
            pidloop(1,i)=pidloop(2,i);%==
            pidloop(3,i)=data(3,b+1);%==
%             upid_old(i)=pidloop(3,i);
            end
        case 5
            if pidloop(10,i)==1
%             %writeasync(itemset(21),data(20,b+1));
            pidloop(1,i)=pidloop(2,i);%==
            pidloop(3,i)=data(22,b+1);%==
%             upid_old(i)=pidloop(3,i);
            end
        case 6
            if pidloop(10,i)==1
%             %writeasync(itemset(36),data(35,b+1));
            pidloop(1,i)=pidloop(2,i);%==
            pidloop(3,i)=data(41,b+1);%==
%             upid_old(i)=pidloop(3,i);
            end
        case 7                                 %煤气主管压力的无扰切换
            if pidloop(10,i)==1
            pidloop(1,i)=pidloop(2,i);
%             pidloop(3,i)=data(69,b+1);           %使用烟气总管站位，没有作用
%             upid_old(i)=pidloop(3,i);
            end
            
        case 8                                     %助燃风机压力的无扰切换
            if pidloop(10,i)==1
            pidloop(1,i)=pidloop(2,i);
            if choose_fj == 1
               pidloop(3,i)=data(70,b+1);%==
            else
               pidloop(3,i)=data(63,b+1);%==
            end
            upid_old(i)=pidloop(3,i);
            end
    end
end   

%1#
% tempu(1)=500;
% airsp(1)=350;
 errorpos=13; 
 %% 计算PID控制量
upid=zeros(1,loopnum);    
% 各控制量的PID计算式
pidmodcnt = 2;
if (mod(b,pidmodcnt)==0) %由于阀门反馈跟随较慢，减缓计算周期
    for i=1:loopnum    %pid回路的计算
        pidloop(:,i)=pid_calc(pidloop(:,i)');
    end
    if b > 5
    %控制振幅大小
        if pidloop(3,1)-data(1,b) >= famenzhenfu 
            pidloop(3,1) = data(1,b) + famenzhenfu;
        elseif pidloop(3,1)-data(1,b) <= -famenzhenfu 
            pidloop(3,1) = data(1,b) - famenzhenfu;
        end
        if pidloop(3,2)-data(20,b) >= famenzhenfu 
            pidloop(3,2) = data(20,b) + famenzhenfu;
        elseif pidloop(3,2)-data(20,b) <= -famenzhenfu 
            pidloop(3,2) = data(20,b) - famenzhenfu;
        end
        if pidloop(3,3)-data(39,b) >= famenzhenfu 
            pidloop(3,3) = data(39,b) + famenzhenfu;
        elseif pidloop(3,3)-data(39,b) <= -famenzhenfu 
            pidloop(3,3) = data(39,b) - famenzhenfu;
        end
        if pidloop(3,4)-data(3,b+1) >= famenzhenfu 
            pidloop(3,4) = data(3,b+1) + famenzhenfu;
        elseif pidloop(3,4)-data(3,b+1) <= -famenzhenfu 
            pidloop(3,4) = data(3,b+1) - famenzhenfu;
        end
        if pidloop(3,5)-data(22,b+1) >= famenzhenfu 
            pidloop(3,5) = data(22,b+1) + famenzhenfu;
        elseif pidloop(3,5)-data(22,b+1) <= -famenzhenfu 
            pidloop(3,5) = data(22,b+1) - famenzhenfu;
        end
        if pidloop(3,6)-data(41,b+1) >= famenzhenfu 
            pidloop(3,6) = data(41,b+1) + famenzhenfu;
        elseif pidloop(3,6)-data(41,b+1) <= -famenzhenfu 
            pidloop(3,6) = data(41,b+1) - famenzhenfu;
        end 
    end
end
 %% 助燃风机逻辑控制输出值
if mod(b,8) == 0
    if pidloop(1,8) - pidloop(2,8) <= -3
        pidloop(3,8)= pidloop(3,8) - 4;
    elseif pidloop(1,8) - pidloop(2,8) <= -2
        pidloop(3,8)=pidloop(3,8) - 3;
    elseif pidloop(1,8) - pidloop(2,8) <= -1
         pidloop(3,8)= pidloop(3,8) - 2;   
    end
    
    if pidloop(1,8) - pidloop(2,8) >= 3
        pidloop(3,8)= pidloop(3,8) + 4;
    elseif pidloop(1,8) - pidloop(2,8) >= 2
       pidloop(3,8)= pidloop(3,8) + 3;
    elseif pidloop(1,8) - pidloop(2,8) >= 1
         pidloop(3,8)= pidloop(3,8) + 2;   
    end
    if pidloop(3,8) > pidloop(11,8)
        pidloop(3,8) = pidloop(11,8);
    end
    if pidloop(3,8) < pidloop(12,8)
        pidloop(3,8) = pidloop(12,8);
    end
    
    upid(8)=pidloop(3,8); 
end
%  a_write=[0 0 0];
%  p_write=0;
%  for i=1:3
%      if pidloop(10,i)==0
%          a_write(i)=p_write;
%          p_write=p_write+1;
%      end
%  end

%更新现场DCS界面的空燃比设定
% % % % for i=1:3
% % % %     if (temp_open(i)==1)&&(roundn(data(7+19*(i-1),b+1),-2)~=default_airgaspotial(i))
% % % %         write(itemset(7+19*(i-1)),default_airgaspotial(i));
% % % %         
% % % %     end
% % % % end
errorpos=14;
deadzone=[0.001 0.001 1];%煤气流量阀位
 %%    写PID控制量   
for i = 1:loopnum
    if pidloop(3,i) > pidloop(11,i)
        pidloop(3,i) = pidloop(11,i);
    end
    if pidloop(3,i) < pidloop(12,i)
        pidloop(3,i) = pidloop(12,i);
    end
    upid(i)=pidloop(3,i);
end
for i=1:loopnum
    switch i
        case 1
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)
              if abs(upid(i)-upid_old(i))>=deadzone(1)    
                  writeasync(itemset(1),upid(i))                    
              end
              upid_old(i)=data(1,b+1);    %存入当前阀门的实际值为upid_old
            end
        case 2
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)
                %设置PID控制器的死区
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    writeasync(itemset(20),upid(i))
                end
                upid_old(i)=data(20,b+1);
            end
        case 3
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)
                %设置PID控制器的死区
                  if abs(upid(i)-upid_old(i))>=deadzone(1)
                      writeasync(itemset(39),upid(i))
                  end
                  upid_old(i)=data(39,b+1);
            end
        case 4
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)
                 if abs(upid(i)-upid_old(i))>=deadzone(2)
%                      upid(i)=round(upid(i));
                     writeasync(itemset(3),upid(i))
                 end
                 upid_old(i)=data(3,b+1);
            end
        case 5
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)                % 减缓二加空气阀的动作
                if abs(upid(i)-upid_old(i))>=deadzone(2)
%                     upid(i)=round(upid(i));
                    writeasync(itemset(22),upid(i))
                end
                upid_old(i)=data(22,b+1);
           end
        case 6
            if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)              % 减缓均热空气阀的动作
                if abs(upid(i)-upid_old(i))>=deadzone(2)
%                     upid(i)=round(upid(i));
                    writeasync(itemset(41),upid(i))
                end
                upid_old(i)=data(41,b+1);
            end
        case 7
              if (mod(b,pidmodcnt)==0) && pidloop(10,i)==0
                 if abs(upid(i)-upid_old(i))>=deadzone(3)
% % %                         %writeasync(itemset(70),round(upid(i)))
                    upid_old(i)=pidloop(3,i);
                 end
              end
        case 8
              if pidloop(10,i)==0 && (mod(b,pidmodcnt)==0)
                  if abs(upid(i)-upid_old(i))>=deadzone(3)
                    if choose_fj == 1
                        writeasync(itemset(69),round(upid(i)))               %用是1#风机
                    else
                        writeasync(itemset(63),round(upid(i)))               %用是2#风机
                    end
                        upid_old(i)=pidloop(3,i);                                                
                  end
              end
    end
end

%%如果在烧炉状态或者加烧、减烧状态，则强制将现场DCS中PID控制的自动煤气空气支管必须切成手动
% % % % % % % for i=1:3
% % % % % % %     if temp_open(i) == 1
% % % % % % %         if data(18+(i-1)*19,b+1) == 1         
% % % % % % %             write(itemset(18+(i-1)*19),0);
% % % % % % %         end
% % % % % % %         if data(19+(i-1)*19,b+1) == 1
% % % % % % %             write(itemset(19+(i-1)*19),0);
% % % % % % %         end
% % % % % % %     end
% % % % % % % end
errorpos=16;
%%%%%%%%%%%%%%%%%%%%%%%%%%自动换炉控制过程%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % if autoshaolu  %只要打开自动烧炉，DCS控制上煤气空气支管必须切成手动
% % %     if data(18,b+1) == 1
% % %         write(itemset(18),0);
% % %     end
% % %     if data(19,b+1) == 1
% % %         write(itemset(19),0);
% % %     end
% % %     if data(37,b+1) == 1
% % %         write(itemset(37),0);
% % %     end
% % %     if data(38,b+1) == 1
% % %         write(itemset(38),0);
% % %     end
% % %     if data(56,b+1) == 1
% % %         write(itemset(56),0);
% % %     end
% % %     if data(57,b+1) == 1
% % %         write(itemset(57),0);
% % %     end
% % % end
% % % 
% % % 
% % % %%获取换炉操作涉及的信号变量
% % % hlxh = data(68,b+1); %换炉信号
% % % sfsjd(1) = data(8,b+1); % 送风时间到信号
% % % sfsjd(2) = data(27,b+1);
% % % sfsjd(3) = data(46,b+1);
% % % men_z_rs(1) = data(14,b+1); %焖炉转燃烧
% % % men_z_rs(2) = data(33,b+1);
% % % men_z_rs(3) = data(52,b+1);
% % % rs_z_men(1) = data(15,b+1); %燃烧转焖炉
% % % rs_z_men(2) = data(34,b+1);
% % % rs_z_men(3) = data(53,b+1);
% % % men_z_sf(1) = data(16,b+1); %焖炉转送风
% % % men_z_sf(2) = data(35,b+1);
% % % men_z_sf(3) = data(54,b+1);
% % % sf_z_men(1) = data(17,b+1); %送风转焖炉
% % % sf_z_men(2) = data(36,b+1);
% % % sf_z_men(3) = data(55,b+1);
% % % airdef = 65;  %默认打开空气阀时大小
% % % gasdef = 50;  %默认打开煤气阀时大小
% % % airdef1 = 5;  %默认关闭空气阀时大小
% % % gasdef1 = 0;   %默认关闭煤气阀时大小
% % % % button2='null';
% % % if autoswitch
% % %     %状态1：1#焖炉转燃烧阶段
% % %     if men_z_rs(popmenuswitchorder(1))==1 && burning(popmenuswitchorder(1)) == 1
% % %         if gas_fm(popmenuswitchorder(1)) < 5 %说明关闭状态
% % %             write(itemset(selectedOrder(popmenuswitchorder(1),1)),airdef);
% % %             write(itemset(selectedOrder(popmenuswitchorder(1),2)),gasdef);
% % %             disp('状态码1：men_z_rs(1)==1 && burning1 == 1；gas_fm1 < 5----操作：打开1#炉子：并且打开阀门50,65.');
% % %         else
% % %              %todo：是否进行Envieo烧炉按钮自动打开操作？？
% % %             %否则需要人工点击组态上阀门从手动转自动PID调节
% % %             if autoshaolu && (temp_open(popmenuswitchorder(1)) == 0) && ...
% % %                 (data(selectedOrder(popmenuswitchorder(1),3),b+1) >= data(selectedOrder(popmenuswitchorder(1),4),b+1)-10) && ...
% % %                 (data(selectedOrder(popmenuswitchorder(1),5),b+1) >= data(selectedOrder(popmenuswitchorder(1),6),b+1)-10)
% % %                 set(selectedOrder(popmenuswitchorder(1),11),'BackgroundColor',[0 1 0]);
% % %                 set(selectedOrder(popmenuswitchorder(1),12),'BackgroundColor',[0.941 0.941 0.941]);
% % %                 set(selectedOrder(popmenuswitchorder(1),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                 set(selectedOrder(popmenuswitchorder(1),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                 temp_open(popmenuswitchorder(1))=1;
% % %                 max_burning(popmenuswitchorder(1))=0;
% % %                 min_burning(popmenuswitchorder(1))=0;
% % %                 a_write=[0 0 0];             %标志位控制阀门写入速度，让写入操作一次只对一个阀门起作用
% % %                 a_write(popmenuswitchorder(1)) = 1;
% % %                 default_airgaspotial(popmenuswitchorder(1))=min_airgaspotial(popmenuswitchorder(1))+0.05;
% % %                 default_airgaspotial_set(popmenuswitchorder(1))=min_airgaspotial(popmenuswitchorder(1))+0.05;
% % %                 left_time(popmenuswitchorder(1))=-1;
% % %                 pidloop(10,popmenuswitchorder(1))=0;          %1#炉打开自动控制        
% % %                 pidloop(10,popmenuswitchorder(1)+3)=0;
% % %                 disp('状态码2：men_z_rs(1)==1 && burning1 == 1；~gas_fm1 < 5；autoshaolu==1(temp_open(1) == 0)----打开Envieo自动烧炉功能：1#炉子打开烧炉按钮');
% % %             end
% % %             
% % %         end
% % %         if men_z_rs(popmenuswitchorder(2)) && burning(popmenuswitchorder(2)) == 1
% % %             if gas_fm(popmenuswitchorder(2)) < 5 %说明关闭状态
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),1)),airdef);
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),2)),gasdef);
% % %                 disp('状态码3：men_z_sf(1) == 1 && burning1 == 1；men_z_rs(2) && burning2 == 1；gas_fm2 < 5----打开2#炉子：并且打开阀门50,65.');
% % %             else
% % %                 %todo：是否进行Envieo烧炉按钮自动打开操作？？
% % %                 %否则需要人工点击组态上阀门从手动转自动PID调节
% % %                 if autoshaolu && (temp_open(popmenuswitchorder(2)) == 0) && ...
% % %                         (data(selectedOrder(popmenuswitchorder(2),3),b+1) >= data(selectedOrder(popmenuswitchorder(2),4),b+1)-10) && ...
% % %                         (data(selectedOrder(popmenuswitchorder(2),5),b+1) >= data(selectedOrder(popmenuswitchorder(2),6),b+1)-10)
% % % 
% % %                     set(selectedOrder(popmenuswitchorder(2),11),'BackgroundColor',[0 1 0]);
% % %                     set(selectedOrder(popmenuswitchorder(2),12),'BackgroundColor',[0.941 0.941 0.941]);
% % %                     set(selectedOrder(popmenuswitchorder(2),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                     set(selectedOrder(popmenuswitchorder(2),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                     max_burning(popmenuswitchorder(2))=0;
% % %                     min_burning(popmenuswitchorder(2))=0;
% % %                     temp_open(popmenuswitchorder(2))=1;
% % %                     a_write=[0 0 0];
% % %                     a_write(popmenuswitchorder(2)) = 1;
% % %                     default_airgaspotial(popmenuswitchorder(2))=min_airgaspotial(popmenuswitchorder(2))+0.05;
% % %                     default_airgaspotial_set(popmenuswitchorder(2))=min_airgaspotial(popmenuswitchorder(2))+0.05;
% % %                     left_time(popmenuswitchorder(2))=-1;
% % %                     pidloop(10,popmenuswitchorder(2))=0;          %2#炉打开自动控制        
% % %                     pidloop(10,popmenuswitchorder(2)+3)=0;
% % %                     disp('状态码4：men_z_sf(1) == 1 && burning1 == 1；men_z_rs(2) && burning2 == 2；~gas_fm2 < 5；autoshaolu(temp_open(2) == 0)-----打开Envieo自动烧炉功能：2#炉子打开烧炉按钮');
% % %                 end
% % %                 
% % %             end
% % %             if sfsjd(popmenuswitchorder(3)) == 1 %3# 送风时间到
% % %                 if burning(popmenuswitchorder(1)) == 1&&huanludlg_tag==0
% % %                     huanludlg_tag=1;
% % % %                     button2=questdlg('确定自动换炉？','自动换炉','是','否','否');
% % %                     hf = figure(autoswtichdialog);
% % %                     set(hf, 'WindowStyle', 'modal');
% % %                 end
% % %                 if strcmp(autoswitchdialog,'是')
% % %                     
% % %                     if gas_fm(popmenuswitchorder(1)) > 5  %说明没有关闭
% % %                         disp('状态码5：men_z_sf(1) == 1 && burning1 == 1；men_z_rs(2) && burning2 == 2；sfsjd(3) == 1；gas_fm1 > 5---3#送风时间到，1#进入燃烧转焖炉阶段；并且关闭1#煤气和空气阀');
% % %                         if (temp_open(popmenuswitchorder(1)) == 1)
% % %                             set(selectedOrder(popmenuswitchorder(1),11),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(1),12),'BackgroundColor',[1 0 0]);
% % %                             set(selectedOrder(popmenuswitchorder(1),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(1),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             temp_open(popmenuswitchorder(1))=0;
% % %                             max_burning(popmenuswitchorder(1))=0;
% % %                             min_burning(popmenuswitchorder(1))=0;
% % %                             pidloop(10,popmenuswitchorder(1))=1;          %1#炉打开手动控制        
% % %                             pidloop(10,popmenuswitchorder(1)+3)=1;
% % %                              disp('状态码6：men_z_sf(1) == 1 && burning1 == 1；men_z_rs(2) && burning2 == 2；sfsjd(3) == 1；gas_fm1 > 5；autoshaolu == 1(temp_open(1) == 1)---3#送风时间到，Envieo自动关闭1#烧炉按钮，进入关闭按钮');
% % %                         end
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),7)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),8)),1); %1#进入燃烧转焖炉阶段
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),9)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),10)),0);
% % % 
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),15)),0);  %煤气阀和空气阀切换到手动
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),16)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),1)),airdef1);  %关闭煤气阀和空气阀
% % %                         write(itemset(selectedOrder(popmenuswitchorder(1),2)),gasdef1);
% % %                         %todo:是否进行Envieo烧炉按钮自动关闭操作？？
% % % 
% % %                        disp('状态码22：正在换炉ing');
% % %                        write(itemset(68),1);%发出正在换炉信号！！！！
% % %                        autoswitchdialog = 'null';
% % %                     end
% % %                 elseif strcmp(autoswitchdialog,'否')
% % %                     huanludlg_tag=0;
% % %                     autoswitch = 0;
% % %                     set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
% % %                     autoshaolu = 0; %连锁 关闭自动烧炉
% % %                     set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
% % %                     set(handles.checkbox2,'Value',0) ;
% % %                     set(handles.checkbox2,'Enable','off');
% % %                     set(handles.checkbox2,'ForegroundColor',[0 0 0]);
% % %                     autoswitchdialog = 'null';
% % %                 end
% % % 
% % %             end
% % %         end
% % %         if men_z_sf(popmenuswitchorder(2)) == 1 && songfenging(popmenuswitchorder(2)) == 1
% % %             if sfsjd(popmenuswitchorder(2)) == 1 %2# 送风时间到
% % %                 if burning(popmenuswitchorder(3)) == 1&&huanludlg_tag==0
% % %                     huanludlg_tag=1;
% % % %                     button2=questdlg('确定自动换炉？','自动换炉','是','否','否');
% % % %                     start(dialogtimer);
% % %                     hf = figure(autoswtichdialog);
% % %                     set(hf, 'WindowStyle', 'modal');
% % %                 end
% % %                 if strcmp(autoswitchdialog,'是')
% % %                     
% % %                     if gas_fm(popmenuswitchorder(3)) > 5
% % %                         disp('状态码7：men_z_sf(1) == 1 && burning1 == 1；men_z_sf(2) == 1 && songfenging2 == 1；sfsjd(2) == 1；gas_fm3 > 5---2#送风时间到，3#进入燃烧转焖炉阶段；并且关闭3#煤气和空气阀');
% % %                         if (temp_open(popmenuswitchorder(3)) == 1)
% % %                             set(selectedOrder(popmenuswitchorder(3),11),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(3),12),'BackgroundColor',[1 0 0]);
% % %                             set(selectedOrder(popmenuswitchorder(3),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(3),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             temp_open(popmenuswitchorder(3))=0;
% % %                             max_burning(popmenuswitchorder(3))=0;
% % %                             min_burning(popmenuswitchorder(3))=0;
% % %                             pidloop(10,popmenuswitchorder(3))=1;          %3#炉打开手动控制        
% % %                             pidloop(10,popmenuswitchorder(3)+3)=1;
% % %                             disp('状态码8：men_z_sf(1) == 1 && burning1 == 1；men_z_sf(2) == 1 && songfenging2 == 1；sfsjd(2) == 1；gas_fm3 > 5；autoshaolu == 1(temp_open(3) == 1)---2#送风时间到，Envieo自动关闭3#烧炉按钮，进入关闭按钮');
% % %                         end
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),7)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),8)),1); %3#进入燃烧转焖炉阶段
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),9)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),10)),0);
% % % 
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),15)),0);  %煤气阀和空气阀切换到手动
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),16)),0);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),1)),airdef1);  %关闭煤气阀和空气阀
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),2)),gasdef1);
% % %                         %todo:是否进行Envieo烧炉按钮自动关闭操作？？
% % % 
% % %                        disp('状态码23：正在换炉ing');
% % %                        write(itemset(68),1);%发出正在换炉信号！！！！
% % %                        autoswitchdialog = 'null';
% % %                     end
% % %                 elseif strcmp(autoswitchdialog,'否')
% % %                     huanludlg_tag=0;
% % %                     autoswitch = 0;
% % %                     set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
% % %                     autoshaolu = 0; %连锁 关闭自动烧炉
% % %                     set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
% % %                     set(handles.checkbox2,'Value',0) ;
% % %                     set(handles.checkbox2,'Enable','off');
% % %                     set(handles.checkbox2,'ForegroundColor',[0 0 0]);
% % %                     autoswitchdialog = 'null';
% % %                 end
% % %                 if rs_z_men(popmenuswitchorder(3)) == 1 && menluing(popmenuswitchorder(3)) == 1
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),7)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),8)),0); 
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),9)),1);%3#进入焖炉转送风阶段
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),10)),0);
% % %                     disp('状态码9：men_z_sf(1) == 1 && burning1 == 1；men_z_sf(2) == 1 && songfenging2 == 1；sfsjd(2) == 1；rs_z_men(3) == 1 && menluing3 == 1---，3#进入焖炉转送风阶段');
% % %                     huanludlg_tag=0;
% % %                 end
% % %                 if men_z_sf(popmenuswitchorder(3)) == 1 && songfenging(popmenuswitchorder(3)) == 1 && (menlucount==0)
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),7)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),8)),0); 
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),9)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),10)),1);%2#进入送风转焖炉阶段
% % %                     write(itemset(68),0);%发出关闭换炉信号！！！！
% % %                     menlucount = paramdata.commdata(1).parameter(2).ATTRIBUTE.menlucount;
% % %                     disp('状态码10：men_z_sf(1) == 1 && burning1 == 1；men_z_sf(2) == 1 && songfenging2 == 1；sfsjd(2) == 1；men_z_sf(3) == 1 && songfenging3 == 1---，2#进入送风转焖炉阶段；发出关闭换炉信号！！！！');
% % %                 end
% % %             end
% % %         end
% % %         if sf_z_men(popmenuswitchorder(2)) == 1 && menluing(popmenuswitchorder(2)) == 1
% % %             write(itemset(selectedOrder(popmenuswitchorder(2),7)),1);%2#进入焖炉转燃烧阶段
% % %             write(itemset(selectedOrder(popmenuswitchorder(2),8)),0); 
% % %             write(itemset(selectedOrder(popmenuswitchorder(2),9)),0);
% % %             write(itemset(selectedOrder(popmenuswitchorder(2),10)),0);
% % %             disp('状态码11：men_z_sf(1) == 1 && burning1 == 1；sf_z_men(2) == 1 && menluing2 == 1---2#进入焖炉转燃烧阶段');
% % %         end
% % %     end
% % %     %状态2: 1#燃烧转焖炉阶段
% % %     if rs_z_men(popmenuswitchorder(1)) == 1 && menluing(popmenuswitchorder(1)) == 1
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),7)),0);
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),8)),0); 
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),9)),1);%1#进入焖炉转送风阶段
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),10)),0);
% % %         disp('状态码12：rs_z_men(1) == 1 && menluing1 == 1---1#进入焖炉转送风阶段');
% % %         huanludlg_tag=0;
% % %     end
% % %     %状态3： 1#焖炉转送风阶段
% % %     if men_z_sf(popmenuswitchorder(1)) == 1 && songfenging(popmenuswitchorder(1)) == 1
% % %         if sfsjd(popmenuswitchorder(1)) == 1 %送风时间到
% % %             if burning(popmenuswitchorder(2)) == 1&&huanludlg_tag==0
% % %                 huanludlg_tag=1;
% % % %                 button2=questdlg('确定自动换炉？','自动换炉','是','否','否');
% % % %                 start(dialogtimer);
% % %                 hf = figure(autoswtichdialog);
% % %                 set(hf, 'WindowStyle', 'modal');
% % %             end
% % %             if strcmp(autoswitchdialog,'是')
% % %                 
% % %                 if gas_fm(popmenuswitchorder(2)) > 5
% % %                     disp('状态码13：men_z_sf(1) == 1 && songfenging1 == 1；sfsjd(1) == 1；gas_fm2 > 5---%2#进入燃烧转焖炉阶段；关闭2#煤气空气阀');
% % %                     if (temp_open(popmenuswitchorder(2)) == 1)
% % %                         set(selectedOrder(popmenuswitchorder(2),11),'BackgroundColor',[0.941 0.941 0.941]);
% % %                         set(selectedOrder(popmenuswitchorder(2),12),'BackgroundColor',[1 0 0]);
% % %                         set(selectedOrder(popmenuswitchorder(2),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                         set(selectedOrder(popmenuswitchorder(2),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                         temp_open(popmenuswitchorder(2))=0;
% % %                         max_burning(popmenuswitchorder(2))=0;
% % %                         min_burning(popmenuswitchorder(2))=0;
% % %                         pidloop(10,popmenuswitchorder(2))=1;          %2#炉打开手动控制        
% % %                         pidloop(10,popmenuswitchorder(2)+3)=1;
% % %                         disp('状态码14：men_z_sf(1) == 1 && songfenging1 == 1；sfsjd(1) == 1；gas_fm2 > 5；autoshaolu && (temp_open(2) == 1)---%Envieo自动关闭2#炉子进入关闭状态');
% % %                     end
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),7)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),8)),1); %2#进入燃烧转焖炉阶段
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),9)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),10)),0);
% % % 
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),15)),0);  %煤气阀和空气阀切换到手动
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),16)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),1)),airdef1);  %关闭煤气阀和空气阀
% % %                     write(itemset(selectedOrder(popmenuswitchorder(2),2)),gasdef1);
% % %                     %todo:是否进行Envieo烧炉按钮自动关闭操作？？
% % % 
% % %                     disp('状态码23：正在换炉ing');
% % %                     write(itemset(68),1);%发出正在换炉信号！！！！
% % %                     autoswitchdialog = 'null';
% % %                 end
% % %             elseif strcmp(autoswitchdialog,'否') 
% % %                 huanludlg_tag=0;
% % %                 autoswitch = 0;
% % %                 set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
% % %                 autoshaolu = 0; %连锁 关闭自动烧炉
% % %                 set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
% % %                 set(handles.checkbox2,'Value',0) ;
% % %                 set(handles.checkbox2,'Enable','off');
% % %                 set(handles.checkbox2,'ForegroundColor',[0 0 0]);
% % %                 autoswitchdialog = 'null';
% % %             end  
% % %             if rs_z_men(popmenuswitchorder(2)) == 1 && menluing(popmenuswitchorder(2)) == 1
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),7)),0);
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),8)),0);
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),9)),1); %2#进入焖炉转送风阶段
% % %                 write(itemset(selectedOrder(popmenuswitchorder(2),10)),0);
% % %                 disp('状态码15：men_z_sf(1) == 1 && songfenging1 == 1；sfsjd(1) == 1；rs_z_men(2) == 1 && menluing2 == 1---%2#进入焖炉转送风阶段');
% % %                 huanludlg_tag=0;
% % %             end
% % %             if men_z_sf(popmenuswitchorder(2)) == 1 && songfenging(popmenuswitchorder(2)) == 1 && (menlucount==0)
% % %                 write(itemset(selectedOrder(popmenuswitchorder(1),7)),0);
% % %                 write(itemset(selectedOrder(popmenuswitchorder(1),8)),0); 
% % %                 write(itemset(selectedOrder(popmenuswitchorder(1),9)),0);
% % %                 write(itemset(selectedOrder(popmenuswitchorder(1),10)),1);%1#进入送风转焖炉阶段
% % %                 write(itemset(68),0);%发出关闭换炉信号！！！！
% % %                 menlucount = paramdata.commdata(1).parameter(2).ATTRIBUTE.menlucount;
% % %                 disp('状态码16：men_z_sf(1) == 1 && songfenging1 == 1；sfsjd(1) == 1；men_z_sf(2) == 1 && songfenging2 == 1---%1#进入送风转焖炉阶段；发出关闭换炉信号！！！！');
% % %             end
% % %         else
% % %                 if men_z_rs(popmenuswitchorder(3)) == 1 && burning(popmenuswitchorder(3)) == 1
% % %                     if gas_fm(popmenuswitchorder(3)) < 5
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),1)),airdef);
% % %                         write(itemset(selectedOrder(popmenuswitchorder(3),2)),gasdef);
% % %                         disp('状态码17：men_z_sf(1) == 1 && songfenging1 == 1；~sfsjd(1) == 1； men_z_rs(3) == 1 && burning3 == 1；gas_fm3 < 5---%3#打开煤气空气阀');
% % %                     else
% % %                         %%todo：是否进行Envieo烧炉按钮自动打开操作？？
% % %                         %否则需要人工点击组态上阀门从手动转自动PID调节
% % %                         if autoshaolu && (temp_open(popmenuswitchorder(3)) == 0) && ...
% % %                                 (data(selectedOrder(popmenuswitchorder(3),3),b+1) >= data(selectedOrder(popmenuswitchorder(3),4),b+1)-10) && ...
% % %                                 (data(selectedOrder(popmenuswitchorder(3),5),b+1) >= data(selectedOrder(popmenuswitchorder(3),6),b+1)-10)%组态必须为手动状态
% % %                             set(selectedOrder(popmenuswitchorder(3),11),'BackgroundColor',[0 1 0]);
% % %                             set(selectedOrder(popmenuswitchorder(3),12),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(3),13),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             set(selectedOrder(popmenuswitchorder(3),14),'BackgroundColor',[0.941 0.941 0.941]);
% % %                             max_burning(popmenuswitchorder(3))=0;
% % %                             min_burning(popmenuswitchorder(3))=0;
% % %                             temp_open(popmenuswitchorder(3))=1;
% % %                             a_write=[0 0 0];
% % %                             a_write(popmenuswitchorder(3)) = 1;
% % %                             default_airgaspotial(popmenuswitchorder(3))=min_airgaspotial(popmenuswitchorder(3))+0.05;
% % %                             default_airgaspotial_set(popmenuswitchorder(3))=min_airgaspotial(popmenuswitchorder(3))+0.05;
% % %                             left_time(popmenuswitchorder(3))=-1;
% % %                             pidloop(10,popmenuswitchorder(3))=0; %3#炉打开自动控制       
% % %                             pidloop(10,popmenuswitchorder(3)+3)=0;
% % %                             disp('状态码18：men_z_sf(1) == 1 && songfenging1 == 1；~sfsjd(1) == 1； men_z_rs(3) == 1 && burning3 == 1；~gas_fm3 < 5；autoshaolu && (temp_open(3) == 0)---%Enveio自动打开烧炉按钮');
% % %                         end
% % % 
% % %                     end
% % %                 end
% % %                 if men_z_sf(popmenuswitchorder(3)) == 1 && songfenging(popmenuswitchorder(3)) == 1 && (menlucount==0)
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),7)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),8)),0); 
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),9)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),10)),1);%3#进入送风转焖炉阶段
% % %                     write(itemset(68),0);%发出关闭换炉信号！！！！
% % %                     menlucount = paramdata.commdata(1).parameter(2).ATTRIBUTE.menlucount;
% % %                     disp('状态码19：men_z_sf(1) == 1 && songfenging1 == 1；~sfsjd(1) == 1；men_z_sf(3) == 1 && songfenging1 == 1；---%3#进入送风转焖炉阶段；%发出关闭换炉信号！！！！');
% % %                 end
% % %                 if sf_z_men(popmenuswitchorder(3)) == 1 && menluing(popmenuswitchorder(3)) == 1
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),7)),1);%3#进入焖炉转燃烧阶段
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),8)),0); 
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),9)),0);
% % %                     write(itemset(selectedOrder(popmenuswitchorder(3),10)),0);
% % %                     disp('状态码20：men_z_sf(1) == 1 && songfenging1 == 1；~sfsjd(1) == 1；sf_z_men(3) == 1 && menluing3 == 1；---%3#进入送风转焖炉阶段；%发出换炉信号！！！！');
% % %                 end
% % %             
% % %         end
% % %     end
% % %     %状态4： 1#送风转焖炉阶段
% % %     if sf_z_men(popmenuswitchorder(1)) == 1 && menluing(popmenuswitchorder(1)) == 1
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),7)),1);%1#进入焖炉转燃烧阶段
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),8)),0); 
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),9)),0);
% % %         write(itemset(selectedOrder(popmenuswitchorder(1),10)),0);
% % %         disp('状态码21：sf_z_men(1) == 1 && menluing1 == 1；---%1#进入焖炉转燃烧阶段');
% % %     end
% % % end
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%自动换炉过程结束；若自动换炉对话框被最小化，则强制取消%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % errorpos=17;
% % % try
% % %     if dlgopen
% % %     set(javaFramedlg,'Minimized',0);
% % %     end
% % % catch
% % % end


%%%%%%%%%%%%%%%%%%%%%% 报警系统控制 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%报警弹出框时动态更新当前显示值
try
    %% identifier:1、2、3分别表示1#、2#、3#号炉和t_real值1、2、3对应
    set(pophandles.text10,'String',num2str(tp_real(identifier)));
    set(pophandles.text11,'String',num2str(t_real(identifier)));
catch
%          disp('没有打开报警设置窗口');
end

% % % try
% % %     %% identifier:1、2、3分别表示1#、2#、3#号炉和t_real值1、2、3对应
% % %     set(pophandles2.text9,'String',num2str(roundn(air_pressure_1,-2)));
% % %     set(pophandles2.text24,'String',num2str(roundn(gas_pressure_1,-2)));
% % % catch
%          disp('没有打开报警设置窗口');
end

%%取消报警声%%%
for i = 1:3
    if ~(t_real(i) >= FQTmpupperlimitS(i) || t_real(i) <= FQTmplowerlimitS(i) || ...
        tp_real(i) >= GDupperlimitS(i) || tp_real(i) <= GDlowerlimitS(i)|| alarmflags(i)==1)
%         alarm_sound_flag = 0;
        ifalarmsound(1) = 0;
    else
        ifalarmsound(1) = 1;
    end
end
errorpos=17.1;
if (b > 17) && (burning1==1) && ((temp_open(1)==1)||(max_burning(1)==1)||(min_burning(1)==1))
    if ~((sum(abs(data(1,b-13:b+1)-data(2,b-13:b+1))>10)==10) || (sum(abs(data(3,b-13:b+1)-data(4,b-13:b+1))>10)==10)||...
            ((mean(data(2,b-13:b+1))>80&&mean(data(12,b-13:b+1))<24000)||(mean(data(2,b-13:b+1))<25&&mean(data(12,b-13:b+1))>36000))||...
            ((mean(data(4,b-13:b+1))>80&&mean(data(13,b-13:b+1))<18000)||(mean(data(4,b-13:b+1))<20&&mean(data(13,b-13:b+1))>24000)))
        ifalarmsound(2) = 0;
    else
        ifalarmsound(2) = 1;
    end
else
    ifalarmsound(2) = 0;
end
if (b > 17) && (burning2==1)&&((temp_open(2)==1)||(max_burning(2)==1)||(min_burning(2)==1))
    if ~((sum(abs(data(20,b-13:b+1)-data(21,b-13:b+1))>10)==10)||(sum(abs(data(22,b-13:b+1)-data(23,b-13:b+1))>10)==10)||...
            ((mean(data(21,b-13:b+1))>80&&mean(data(31,b-13:b+1))<24000)||(mean(data(21,b-13:b+1))<25&&mean(data(31,b-13:b+1))>36000))||...
            ((mean(data(23,b-13:b+1))>80&&mean(data(32,b-13:b+1))<18000)||(mean(data(23,b-13:b+1))<20&&mean(data(32,b-13:b+1))>24000)))
        ifalarmsound(3) = 0;
    else
        ifalarmsound(3) = 1;
    end
else
    ifalarmsound(3) = 0;
end
if (b > 17) && (burning3==1)&&((temp_open(3)==1)||(max_burning(3)==1)||(min_burning(3)==1))
    if ~((sum(abs(data(39,b-13:b+1)-data(40,b-13:b+1))>10)==10)||(sum(abs(data(41,b-13:b+1)-data(42,b-13:b+1))>10)==10)||...
            ((mean(data(40,b-13:b+1))>80&&mean(data(50,b-13:b+1))<24000)||(mean(data(40,b-13:b+1))<25&&mean(data(50,b-13:b+1))>36000))||...
            ((mean(data(42,b-13:b+1))>80&&mean(data(51,b-13:b+1))<18000)||(mean(data(42,b-13:b+1))<20&&mean(data(51,b-13:b+1))>24000)))
        ifalarmsound(4) = 0;
    else
        ifalarmsound(4) = 1;
    end
else
    ifalarmsound(4) = 0;
end
errorpos=17.2;
% % % if ~(air_pressure_1 >= airpressupperlimit || air_pressure_1 <= airpresslowerlimit)
% % %     ifalarmsound(5) = 0;
% % % else
% % %     ifalarmsound(5) = 1;
% % % end
if b > 30 && ~(pre_avg_gas < gas_press_set)
    ifalarmsound(5) = 0;
else
    ifalarmsound(5) = 1;
end
%%%以上所有条件都没有触发报警时才取消报警声音，否则需要维持上次继续报警声音或者继续关闭报警声音
if sum(ifalarmsound)==0
    alarm_sound_flag = 0;
end

%%需要重置到原色，否则会停止在报警停止后随即的红色或者灰色上
set(handles.pushbutton53,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色 [0.941 0.941 0.941]
set(handles.pushbutton54,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.pushbutton55,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.pushbutton56,'BackgroundColor',[0.941 0.941 0.941]);
errorpos=17.3;
%1#炉报警
if (t_real(1) >= FQTmpupperlimitS(1) || t_real(1) <= FQTmplowerlimitS(1) || ...
    tp_real(1) >= GDupperlimitS(1) || tp_real(1) <= GDlowerlimitS(1)|| alarmflags(1)==1) && ~alarm_button_clicked(1)
    if(mod(b,2)==1)
        set(handles.pushbutton53,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
        set(handles.pushbutton53,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end
if (b > 17) && (burning1==1) && ((temp_open(1)==1)||(max_burning(1)==1)||(min_burning(1)==1))
    if ((sum(abs(data(1,b-13:b+1)-data(2,b-13:b+1))>6)==10) || (sum(abs(data(3,b-13:b+1)-data(4,b-13:b+1))>6)==10)||...
            ((mean(data(2,b-13:b+1))>80&&mean(data(12,b-13:b+1))<24000)||(mean(data(2,b-13:b+1))<25&&mean(data(12,b-13:b+1))>36000))||...
            ((mean(data(4,b-13:b+1))>80&&mean(data(13,b-13:b+1))<18000)||(mean(data(4,b-13:b+1))<20&&mean(data(13,b-13:b+1))>24000))) && ~alarm_button_clicked(1)
        if(mod(b,2)==1)
            set(handles.pushbutton53,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
        else
            set(handles.pushbutton53,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
        end
        alarm_sound_flag = 1;
    end
end
errorpos=17.4;
%2#炉报警
if (t_real(2) >= FQTmpupperlimitS(2) || t_real(2) <= FQTmplowerlimitS(2) || ...
    tp_real(2) >= GDupperlimitS(2) || tp_real(2) <= GDlowerlimitS(2) ||alarmflags(2)==1) && ~alarm_button_clicked(2)
    if(mod(b,2)==1)
        set(handles.pushbutton54,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
        set(handles.pushbutton54,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end
if (b > 17) && (burning2==1)&&((temp_open(2)==1)||(max_burning(2)==1)||(min_burning(2)==1))
    if ((sum(abs(data(20,b-13:b+1)-data(21,b-13:b+1))>6)==10)||(sum(abs(data(22,b-13:b+1)-data(23,b-13:b+1))>6)==10)||...
            ((mean(data(21,b-13:b+1))>80&&mean(data(31,b-13:b+1))<24000)||(mean(data(21,b-13:b+1))<25&&mean(data(31,b-13:b+1))>36000))||...
            ((mean(data(23,b-13:b+1))>80&&mean(data(32,b-13:b+1))<18000)||(mean(data(23,b-13:b+1))<20&&mean(data(32,b-13:b+1))>24000))) && ~alarm_button_clicked(2)
        if(mod(b,2)==1)
            set(handles.pushbutton54,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
        else
            set(handles.pushbutton54,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
        end
        alarm_sound_flag = 1;
    end
end
errorpos=17.5;
%3#炉报警
if (t_real(3) >= FQTmpupperlimitS(3) || t_real(3) <= FQTmplowerlimitS(3) || ...
    tp_real(3) >= GDupperlimitS(3) || tp_real(3) <= GDlowerlimitS(3)||alarmflags(3)==1 )&& ~alarm_button_clicked(3)
    if(mod(b,2)==1)
        set(handles.pushbutton55,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
        set(handles.pushbutton55,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end
if (b > 17) && (burning3==1)&&((temp_open(3)==1)||(max_burning(3)==1)||(min_burning(3)==1))
    if ((sum(abs(data(39,b-13:b+1)-data(40,b-13:b+1))>6)==10)||(sum(abs(data(41,b-13:b+1)-data(42,b-13:b+1))>6)==10)||...
            ((mean(data(40,b-13:b+1))>80&&mean(data(50,b-13:b+1))<24000)||(mean(data(40,b-13:b+1))<25&&mean(data(50,b-13:b+1))>36000))||...
            ((mean(data(42,b-13:b+1))>80&&mean(data(51,b-13:b+1))<18000)||(mean(data(42,b-13:b+1))<20&&mean(data(51,b-13:b+1))>24000))) && ~alarm_button_clicked(3)
        if(mod(b,2)==1)
            set(handles.pushbutton55,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
        else
            set(handles.pushbutton55,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
        end
        alarm_sound_flag = 1;
    end
end
errorpos=17.6;
% % % %%空气压力报警
% % % if (air_pressure_1 >= airpressupperlimit || air_pressure_1 <= airpresslowerlimit) && ~alarm_button_clicked(4)
% % %     if(mod(b,2)==1)
% % %         set(handles.pushbutton56,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
% % %     else
% % %         set(handles.pushbutton56,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
% % %     end
% % %     alarm_sound_flag = 1;
% % % end
% % % %%煤气压力报警
if b > 30 && (pre_avg_gas < gas_press_set) && ~alarm_button_clicked(4)
    if(mod(b,2)==1)
        set(handles.pushbutton56,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
        set(handles.pushbutton56,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end
errorpos=17.7;
%%%重置弹出报警框显示，防止上次报警取消后，继续停留原状
try
   set(pophandles.text12,'ForegroundColor',[0 0 0]);%将当前拱顶温度为黑色
   set(pophandles.text13,'ForegroundColor',[0 0 0]);
   set(pophandles.text14,'ForegroundColor',[0 0 0]);
   set(pophandles.text15,'ForegroundColor',[0 0 0]);
   set(pophandles.text18,'ForegroundColor',[0 0 0]);
   set(pophandles.text19,'ForegroundColor',[0 0 0]);
   set(pophandles.text21,'ForegroundColor',[0 0 0]);
   set(pophandles.text22,'ForegroundColor',[0 0 0]);
   set(pophandles.text18,'String','煤气阀正常');
   set(pophandles.text19,'String','空气阀正常');
   set(pophandles.text21,'String','煤气流量计正常');
   set(pophandles.text22,'String','空气流量计正常');
catch
%     disp('没有打开报警设置窗口');
end

% % % try
% % %    set(pophandles2.text11,'ForegroundColor',[0 0 0]);%黑色
% % %    set(pophandles2.text12,'ForegroundColor',[0 0 0]);
% % % catch
% % % %     disp('没有打开报警设置窗口');
% % % end
errorpos=17.8;
for i = 1:3
    if (tp_real(i) >= GDupperlimitS(i)) && identifier == i
        try
            if(mod(b,2)==1)
                set(pophandles.text12,'ForegroundColor',[1 0 0]);%红色
            else
                set(pophandles.text12,'ForegroundColor',[0 0 0]);%黑色
            end
        catch
            %disp('没有打开报警设置窗口');
        end
    end
    if (tp_real(i) <= GDlowerlimitS(i)) && identifier == i
        try
            if(mod(b,2)==1)
                set(pophandles.text13,'ForegroundColor',[1 0 0]);%红色
            else
                set(pophandles.text13,'ForegroundColor',[0 0 0]);%黑色
            end
        catch
            %disp('没有打开报警设置窗口');
        end
    end
    if (t_real(i) >= FQTmpupperlimitS(i)) && identifier == i
        try
            if(mod(b,2)==1)
                set(pophandles.text14,'ForegroundColor',[1 0 0]);%红色
            else
                set(pophandles.text14,'ForegroundColor',[0 0 0]);%黑色
            end
        catch
            %disp('没有打开报警设置窗口');
        end
    end
    if (t_real(i) <= FQTmplowerlimitS(i)) && identifier == i
        try
            if(mod(b,2)==1)
                set(pophandles.text15,'ForegroundColor',[1 0 0]);%红色
            else
                set(pophandles.text15,'ForegroundColor',[0 0 0]);%黑色
            end
        catch
            %disp('没有打开报警设置窗口');
        end
    end
end
errorpos=17.9;
alarmflags = [0,0,0];  %%%阀门报警后，根据这个标志位来判断是否继续进行写入操作。
if b>17

        if (sum(abs(data(1,b-13:b+1)-data(2,b-13:b+1))>10)==10)
            alarmflags(1) = 1;
         if identifier == 1
            try
                set(pophandles.text18,'String','煤气阀卡死');
                if(mod(b,2)==1)
                    set(pophandles.text18,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text18,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
         end
        end
        
        if(sum(abs(data(3,b-13:b+1)-data(4,b-13:b+1))>10)==10)
            
            alarmflags(1) = 1;
           if identifier == 1
            try
                set(pophandles.text19,'String','空气阀卡死');
                if(mod(b,2)==1)
                    set(pophandles.text19,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text19,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
           end
        end
  
        if (sum(abs(data(20,b-13:b+1)-data(21,b-13:b+1))>10)==10)
           
            alarmflags(2) = 1;
          if identifier == 2
            try
                set(pophandles.text18,'String','煤气阀卡死');
                if(mod(b,2)==1)
                    set(pophandles.text18,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text18,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
          end
        end
        if(sum(abs(data(22,b-13:b+1)-data(23,b-13:b+1))>10)==10)
            
            alarmflags(2) = 1;
           if identifier == 2
            try
                set(pophandles.text19,'String','空气阀卡死');
                if(mod(b,2)==1)
                    set(pophandles.text19,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text19,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
           end
        end

        if (sum(abs(data(39,b-13:b+1)-data(40,b-13:b+1))>15)==10)
           
            alarmflags(3) = 1;
                if identifier == 3
            try
                set(pophandles.text18,'String','煤气阀卡死');
                if(mod(b,2)==1)
                    set(pophandles.text18,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text18,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
                end
        end
        if (sum(abs(data(41,b-13:b+1)-data(42,b-13:b+1))>10)==10)
            
            alarmflags(3) = 1;
            if identifier == 3
                try
                    set(pophandles.text19,'String','空气阀卡死');
                    if(mod(b,2)==1)
                        set(pophandles.text19,'ForegroundColor',[1 0 0]);%红色
                    else
                        set(pophandles.text19,'ForegroundColor',[0 0 0]);%黑色
                    end
                catch
                    %disp('没有打开报警设置窗口');
                end
            end
        end
    
    
        if (mean(data(2,b-13:b+1))>80&&mean(data(12,b-13:b+1))<24000)||(mean(data(2,b-13:b+1))<25&&mean(data(12,b-13:b+1))>36000)&& identifier == 1
            alarmflags(1) = 1;
            try
                set(pophandles.text21,'String','煤气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text21,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text21,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
        
        if (mean(data(4,b-13:b+1))>80&&mean(data(13,b-13:b+1))<18000)||(mean(data(4,b-13:b+1))<20&&mean(data(13,b-13:b+1))>24000)&& identifier == 1
            alarmflags(1) = 1;
            try
                set(pophandles.text22,'String','空气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text22,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text22,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
        
        if (mean(data(21,b-13:b+1))>80&&mean(data(31,b-13:b+1))<24000)||(mean(data(21,b-13:b+1))<25&&mean(data(31,b-13:b+1))>36000)&& identifier == 2
            alarmflags(2) = 1;
            try
                set(pophandles.text21,'String','煤气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text21,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text21,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
        
        if (mean(data(23,b-13:b+1))>80&&mean(data(32,b-13:b+1))<18000)||(mean(data(23,b-13:b+1))<20&&mean(data(32,b-13:b+1))>24000)&& identifier == 2
            alarmflags(2) = 1;
            try
                set(pophandles.text22,'String','空气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text22,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text22,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
        
        if (mean(data(40,b-13:b+1))>80&&mean(data(50,b-13:b+1))<24000)||(mean(data(40,b-13:b+1))<25&&mean(data(50,b-13:b+1))>36000)&& identifier == 3
            alarmflags(3) = 1;
            try
                set(pophandles.text21,'String','煤气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text21,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text21,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
        
        if (mean(data(42,b-13:b+1))>80&&mean(data(51,b-13:b+1))<18000)||(mean(data(42,b-13:b+1))<20&&mean(data(51,b-13:b+1))>24000)&& identifier == 3
            alarmflags(3) = 1;
            try
                set(pophandles.text22,'String','空气流量计异常');
                if(mod(b,2)==1)
                    set(pophandles.text22,'ForegroundColor',[1 0 0]);%红色
                else
                    set(pophandles.text22,'ForegroundColor',[0 0 0]);%黑色
                end
            catch
                %disp('没有打开报警设置窗口');
            end
        end
end
errorpos=17.95;
% % % if air_pressure_1 >= airpressupperlimit
% % %     try
% % %         if(mod(b,2)==1)
% % %             set(pophandles2.text11,'ForegroundColor',[1 0 0]);%红色
% % %         else
% % %             set(pophandles2.text11,'ForegroundColor',[0 0 0]);%黑色
% % %         end
% % %     catch
% % %         %disp('没有打开报警设置窗口');
% % %     end
% % % end
% % % if air_pressure_1 <= airpresslowerlimit
% % %     try
% % %         if(mod(b,2)==1)
% % %             set(pophandles2.text12,'ForegroundColor',[1 0 0]);%红色
% % %         else
% % %             set(pophandles2.text12,'ForegroundColor',[0 0 0]);%黑色
% % %         end
% % %     catch
% % %         %disp('没有打开报警设置窗口');
% % %     end
% % % end
% % % 
% % % if gas_pressure_1 >= gaspressupperlimit
% % %     try
% % %         if(mod(b,2)==1)
% % %             set(pophandles2.text25,'ForegroundColor',[1 0 0]);%红色
% % %         else
% % %             set(pophandles2.text25,'ForegroundColor',[0 0 0]);%黑色
% % %         end
% % %     catch
% % %         %disp('没有打开报警设置窗口');
% % %     end
% % % end
% % % if gas_pressure_1 <= gaspresslowerlimit
% % %     try
% % %         if(mod(b,2)==1)
% % %             set(pophandles2.text26,'ForegroundColor',[1 0 0]);%红色
% % %         else
% % %             set(pophandles2.text26,'ForegroundColor',[0 0 0]);%黑色
% % %         end
% % %     catch
% % %         %disp('没有打开报警设置窗口');
% % %     end
% % % end

errorpos=17.99;
if alarm_sound_flag
    load chirp
    sound(y,Fs)
end
for i=1:4
    if alarm_button_clicked(i)
        if alarm_timer(i) == 0
            alarm_timer(i) = 120;  %%每2分钟进行一次判断
            alarm_button_clicked(i) = 0;
        else
            alarm_timer(i) = alarm_timer(i) - 1;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%% 报警系统控制结束 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
errorpos=18;

processtime=toc;
% end
if errortag
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
end
errorpos=19+b;
end