function onTimer_io_4duan (obj, event,handles)
global group tempdata data itemset processtime tempdatavalue A B P yr workpoint airgaspotial 
global gpc_a gpc_lmd gap_on lastsave daobj pidloop deadzone gasmean 
global temp_open tempu upid_old b  loopnum tsp yy
global airmv gasmv flow_max flow_min gas_valve_max gas_valve_min air_valve_max air_valve_min 
global meiyan_valve_max meiyan_valve_min kongyan_valve_max kongyan_valve_min fengji_valve_min fengji_valve_max
global ts upid yp u1 u2 u3 u4 u5 up alarm_button_clicked alarm_sound_flag alarm_timer alarm_sound_flag2
global fcepress meiqizongfa_valve_max meiqizongfa_valve_min
global temp1_flag temp2_flag temp3_flag temp4_flag temp5_flag
global luyabili air_temp gas_temp choose_fj
global airsp steeldata
global air_open gas_open
global yure_flow_max_down jiayi_flow_max_down jiaer_flow_max_down junshang_flow_max_down junxia_flow_max_down airflow_max_down
global smoke_tg_up smoke_ta_up
global yureluwen_down jiayiluwen_down jiaerluwen_down junshangluwen_down junxialuwen_down
global m1 m2 m3 n1 n2 n3
global modTime single_change manaotu
global datetime fanchui cleanOnce
try
tic
%% opc实时数据
tempdata = read(group);               % length(tempdata) = 82
[~, b] = size(data);                  
for k = 1:length(tempdata)            % Wincc中的各变量值
    data(k,b+1)=tempdata(k).Value;
    tempdatavalue(k)=tempdata(k).Value;
end
% a=length(itemset);                  % a = 82

fcepress = data(76,b+1);  %炉膛压力
% catch
%     disp('opc实时数据部分异常');
% end


%% 快切自动关闭控制
set(handles.text1,'String','已连接');
set(handles.connectwincc,'BackgroundColor',[0 1 0]);
% 预热
if data(87,b+1) == 0
    temp_open(1,1)=0;
    pidloop(10,1)=1; 
    set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
    set(handles.apcon1_close,'BackgroundColor',[1 0 0]);%将close设置为红色
    pidloop(10,11)=1;%煤烟温度回路切自动
    pidloop(10,16)=1;%空烟温度回路切自动
    set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.tsc1_close,'BackgroundColor',[1 0 0]);
    gap_on(1)=0;
    pidloop(10,6)=1;
    % set(handles.gapon1,'String','关闭');
    set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gapon1_close,'BackgroundColor',[1 0 0]);
end

% 一加
if data(88,b+1) == 0
   temp_open(2,1)=0;
    pidloop(10,2)=1;
    set(handles.apcon2_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apcon2_close,'BackgroundColor',[1 0 0]);
    pidloop(10,12)=1;           %煤烟温度回路切自动
    pidloop(10,17)=1;            %空烟温度回路切自动
    set(handles.tsc2_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.tsc2_close,'BackgroundColor',[1 0 0]);
    gap_on(2)=0;
    pidloop(10,7)=1;
    % set(handles.gapon2,'String','关闭');
    set(handles.gapon2_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gapon2_close,'BackgroundColor',[1 0 0]);
end

% 二加
if data(89,b+1) == 0
    temp_open(3,1)=0;
    pidloop(10,3)=1;
    set(handles.apcon3_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apcon3_close,'BackgroundColor',[1 0 0]);
    pidloop(10,13)=1;           %煤烟温度回路切自动
    pidloop(10,18)=1;            %空烟温度回路切自动
    set(handles.tsc3_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.tsc3_close,'BackgroundColor',[1 0 0]);
    gap_on(3)=0;
    pidloop(10,8)=1;
    % set(handles.gapon3,'String','关闭');
    set(handles.gapon3_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gapon3_close,'BackgroundColor',[1 0 0]);
end

% 均热上
if data(90,b+1) == 0
    temp_open(4,1)=0;
    pidloop(10,4)=1;
    set(handles.apcon4_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apcon4_close,'BackgroundColor',[1 0 0]);
    pidloop(10,14)=1;           %煤烟温度回路切自动
    pidloop(10,19)=1;            %空烟温度回路切自动

    set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.tsc4_close,'BackgroundColor',[1 0 0]);
    gap_on(4)=0;
    pidloop(10,9)=1;
    % set(handles.gapon3,'String','关闭');
    set(handles.gapon4_open,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gapon4_close,'BackgroundColor',[1 0 0]);
end

% 均热下
if data(91,b+1) == 0
    temp_open(5,1)=0; 
    pidloop(10,5)=1;
    set(handles.pushbutton107,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.pushbutton108,'BackgroundColor',[1 0 0]);
    pidloop(10,15)=1;           %煤烟温度回路切自动
    pidloop(10,20)=1;           %空烟温度回路切自动
    set(handles.pushbutton109,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.pushbutton110,'BackgroundColor',[1 0 0]);
    gap_on(5)=0;
    pidloop(10,10)=1;
    % set(handles.gapon1,'String','开启');
    set(handles.pushbutton113,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.pushbutton114,'BackgroundColor',[1 0 0]);
end

%% 读取xml配置参数
val=1;
if 0 == mod(b,30)
    steeldata = xml_read('steel_set.xml');
end

%煤气流量上下限
flow_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.flow1_max;
flow_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.flow2_max;
flow_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.flow3_max;
flow_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.flow4_max;
flow_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.flow5_max;

flow_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.flow1_min;
flow_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.flow2_min;
flow_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.flow3_min;
flow_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.flow4_min;
flow_min(5)=steeldata.common(val,1).parameter.ATTRIBUTE.flow5_min;

%煤气流量上限jdz
yure_flow_max_down = steeldata.common(val,1).parameter.ATTRIBUTE.yure_flow_max_down;
jiayi_flow_max_down = steeldata.common(val,1).parameter.ATTRIBUTE.jiayi_flow_max_down;
jiaer_flow_max_down = steeldata.common(val,1).parameter.ATTRIBUTE.jiaer_flow_max_down;
junshang_flow_max_down = steeldata.common(val,1).parameter.ATTRIBUTE.junshang_flow_max_down;
junxia_flow_max_down = steeldata.common(val,1).parameter.ATTRIBUTE.junxia_flow_max_down;

%空气流量上限
airflow_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.airflow1_max;
airflow_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.airflow2_max;
airflow_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.airflow3_max;
airflow_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.airflow4_max;
airflow_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.airflow5_max;


%煤气阀门上下限
gas_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max1;
gas_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max2;
gas_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max3;
gas_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max4;
gas_valve_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max5;

gas_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min1;
gas_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min2;
gas_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min3;
gas_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min4;
gas_valve_min(5)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min5;

%空气阀门上下限
air_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max1;
air_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max2;
air_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max3;
air_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max4;
air_valve_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max5;

air_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min1;
air_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min2;
air_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min3;
air_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min4;
air_valve_min(5)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min5;

%煤烟阀门上下限
meiyan_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max1;
meiyan_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max2;
meiyan_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max3;
meiyan_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max4;
meiyan_valve_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max5;

meiyan_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min1;
meiyan_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min2;
meiyan_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min3;
meiyan_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min4;
meiyan_valve_min(5)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min5;

%空烟阀门上下限
kongyan_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max1;
kongyan_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max2;
kongyan_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max3;
kongyan_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max4;
kongyan_valve_max(5)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max5;

kongyan_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min1;
kongyan_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min2;
kongyan_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min3;
kongyan_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min4;
kongyan_valve_min(5)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min5;

%助燃风机阀门上下限
fengji_valve_max=steeldata.common(val,1).parameter.ATTRIBUTE.fengji_valve_max;
fengji_valve_min=steeldata.common(val,1).parameter.ATTRIBUTE.fengji_valve_min;

%煤气总管阀门上下限
meiqizongfa_valve_max=steeldata.common(val,1).parameter.ATTRIBUTE.meiqizongfa_valve_max;
meiqizongfa_valve_min=steeldata.common(val,1).parameter.ATTRIBUTE.meiqizongfa_valve_min;

% 引风机阀门上下限
yinfj_max = steeldata.common(val,1).parameter.ATTRIBUTE.yinfj_max;
yinfj_min = steeldata.common(val,1).parameter.ATTRIBUTE.yinfj_min;

%炉膛压力VS烟温对各段阀门分配比例
luyabili(1)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili1;
luyabili(2)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili2;
luyabili(3)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili3;
luyabili(4)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili4;
luyabili(5)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili5;

min_air_limit = steeldata.common(val,1).parameter.ATTRIBUTE.min_air_limit;

manalarmsound = steeldata.common(val,1).parameter.ATTRIBUTE.manalarmsound;

manaotu=steeldata.common(val,1).parameter.ATTRIBUTE.manaotu;
modTime=steeldata.common(val,1).parameter.ATTRIBUTE.modTime;
single_change=steeldata.common(val,1).parameter.ATTRIBUTE.single_change;
% 获取反吹时间
fanchui(1) = str2double(get(handles.yure_fanchui,'String'));
fanchui(2) = str2double(get(handles.yijia_fanchui,'String'));
fanchui(3) = str2double(get(handles.erjia_fanchui,'String'));
fanchui(4) = str2double(get(handles.junshang_fanchui,'String'));
fanchui(5) = str2double(get(handles.junxia_fanchui,'String'));
%% 赋值pidloop上下限
%煤气阀门上下限
pidloop(11,1)=gas_valve_max(1);
pidloop(11,2)=gas_valve_max(2);
pidloop(11,3)=gas_valve_max(3);
pidloop(11,4)=gas_valve_max(4);
pidloop(11,5)=gas_valve_max(5);

pidloop(12,1)=gas_valve_min(1);
pidloop(12,2)=gas_valve_min(2);
pidloop(12,3)=gas_valve_min(3);
pidloop(12,4)=gas_valve_min(4);
pidloop(12,5)=gas_valve_min(5);
%空气阀门上下限
pidloop(11,6)=air_valve_max(1);
pidloop(11,7)=air_valve_max(2);
pidloop(11,8)=air_valve_max(3);
pidloop(11,9)=air_valve_max(4);
pidloop(11,10)=air_valve_max(5);

pidloop(12,6)=air_valve_min(1);
pidloop(12,7)=air_valve_min(2);
pidloop(12,8)=air_valve_min(3);
pidloop(12,9)=air_valve_min(4);
pidloop(12,10)=air_valve_min(5);

%煤烟上下限
pidloop(11,11)=meiyan_valve_max(1);
pidloop(11,12)=meiyan_valve_max(2);
pidloop(11,13)=meiyan_valve_max(3);
pidloop(11,14)=meiyan_valve_max(4);
pidloop(11,15)=meiyan_valve_max(5);

pidloop(12,11)=meiyan_valve_min(1);
pidloop(12,12)=meiyan_valve_min(2);
pidloop(12,13)=meiyan_valve_min(3);
pidloop(12,14)=meiyan_valve_min(4);
pidloop(12,15)=meiyan_valve_min(5);

%空烟上下限
pidloop(11,16)=kongyan_valve_max(1);
pidloop(11,17)=kongyan_valve_max(2);
pidloop(11,18)=kongyan_valve_max(3);
pidloop(11,19)=kongyan_valve_max(4);
pidloop(11,20)=kongyan_valve_max(5);

pidloop(12,16)=kongyan_valve_min(1);
pidloop(12,17)=kongyan_valve_min(2);
pidloop(12,18)=kongyan_valve_min(3);
pidloop(12,19)=kongyan_valve_min(4);
pidloop(12,20)=kongyan_valve_min(5);

%炉压上下限
pidloop(11,21)=50;
pidloop(12,21)=0;

%助燃风机上下限
pidloop(11,22)=fengji_valve_max;
pidloop(12,22)=fengji_valve_min;

%煤气总管上下限
pidloop(11,23)=meiqizongfa_valve_max;
pidloop(12,23)=meiqizongfa_valve_min;

%引风机上下限
pidloop(11,24) = yinfj_max;
pidloop(12,24) = yinfj_min;
pidloop(11,25) = yinfj_max;
pidloop(12,25) = yinfj_min;
pidloop(11,26) = yinfj_max;
pidloop(12,26) = yinfj_min;


%% 获取设定值
ts1=str2double(get(handles.ts_1,'String'));   % 炉温设定值
ts2=str2double(get(handles.ts_2,'String'));
ts3=str2double(get(handles.ts_3,'String'));
ts4=str2double(get(handles.ts_4,'String'));
ts5=str2double(get(handles.text140,'String'));

% 获取炉温jdz
yureluwen_down = steeldata.common(val,1).parameter.ATTRIBUTE.yureluwen_down;
jiayiluwen_down = steeldata.common(val,1).parameter.ATTRIBUTE.jiayiluwen_down;
jiaerluwen_down = steeldata.common(val,1).parameter.ATTRIBUTE.jiaerluwen_down;
junshangluwen_down = steeldata.common(val,1).parameter.ATTRIBUTE.junshangluwen_down;
junxialuwen_down = steeldata.common(val,1).parameter.ATTRIBUTE.junxialuwen_down;

%NBJD炉温
ts1 = ts1 - yureluwen_down;
ts2 = ts2 - jiayiluwen_down;
ts3 = ts3 - jiaerluwen_down;
ts4 = ts4 - junshangluwen_down;
ts5 = ts5 - junxialuwen_down;

% ts1 = ts1 - 3;
% ts2 = ts2 + 2;
% ts3 = ts3 + 2;
% ts4 = ts4 - 3;
% ts5 = ts5 - 3;

smoke_tg1_set=str2double(get(handles.smoke_tg1_set,'String'));%煤烟温度设定
smoke_tg2_set=str2double(get(handles.smoke_tg2_set,'String'));
smoke_tg3_set=str2double(get(handles.smoke_tg3_set,'String'));
smoke_tg4_set=str2double(get(handles.smoke_tg4_set,'String'));
smoke_tg5_set=str2double(get(handles.text143,'String'));

smoke_tg_up=steeldata.common(val,1).parameter.ATTRIBUTE.smoke_tg_up;

%NBJD煤烟
smoke_tg1_set = smoke_tg1_set + smoke_tg_up;
smoke_tg2_set = smoke_tg2_set + smoke_tg_up;
smoke_tg3_set = smoke_tg3_set + smoke_tg_up;
smoke_tg4_set = smoke_tg4_set + smoke_tg_up;
smoke_tg5_set = smoke_tg5_set + smoke_tg_up;

smoke_ta1_set=str2double(get(handles.smoke_ta1_set,'String'));%空烟温度设定
smoke_ta2_set=str2double(get(handles.smoke_ta2_set,'String'));
smoke_ta3_set=str2double(get(handles.smoke_ta3_set,'String'));
smoke_ta4_set=str2double(get(handles.smoke_ta4_set,'String'));
smoke_ta5_set=str2double(get(handles.text144,'String'));

smoke_ta_up=steeldata.common(val,1).parameter.ATTRIBUTE.smoke_ta_up;

%NBJD空烟
smoke_ta1_set = smoke_ta1_set + smoke_ta_up;
smoke_ta2_set = smoke_ta2_set + smoke_ta_up;
smoke_ta3_set = smoke_ta3_set + smoke_ta_up;
smoke_ta4_set = smoke_ta4_set + smoke_ta_up;
smoke_ta5_set = smoke_ta5_set + smoke_ta_up;

luya_set = str2double(get(handles.luya_set,'String')); %炉压设定

agp1_set=str2double(get(handles.agp1_set,'String'));   %空燃比设定
agp2_set=str2double(get(handles.agp2_set,'String'));
agp3_set=str2double(get(handles.agp3_set,'String'));
agp4_set=str2double(get(handles.agp4_set,'String'));
agp5_set=str2double(get(handles.text147,'String'));

yinfj_buchang = str2double(get(handles.yfj_buchang,'String')); %引风机补偿值

%根据现场实际情况需要，可以内部修改设定空燃比偏差
airgaspotialos1 = steeldata.common(val,1).parameter.ATTRIBUTE.airgaspotialos1;
airgaspotialos2 = steeldata.common(val,1).parameter.ATTRIBUTE.airgaspotialos2;
airgaspotialos3 = steeldata.common(val,1).parameter.ATTRIBUTE.airgaspotialos3;
airgaspotialos4 = steeldata.common(val,1).parameter.ATTRIBUTE.airgaspotialos4;
airgaspotialos5 = steeldata.common(val,1).parameter.ATTRIBUTE.airgaspotialos5;

agp1_set = agp1_set - airgaspotialos1;
agp2_set = agp2_set - airgaspotialos2;
agp3_set = agp3_set - airgaspotialos3;
agp4_set = agp4_set - airgaspotialos4;
agp5_set = agp4_set - airgaspotialos5;

air_pressure_sp=str2double(get(handles.air_pressure_sp,'String'));%助燃风压力
gas_pressure_sp=str2double(get(handles.gas_pressure_sp,'String'));%煤气总管压力

ts=[ts1;ts2;ts3;ts4;ts5];                                        %炉温设定
tg=[smoke_tg1_set;smoke_tg2_set;smoke_tg3_set;smoke_tg4_set;smoke_tg5_set];    %煤烟温度设定
ta=[smoke_ta1_set;smoke_ta2_set;smoke_ta3_set;smoke_ta4_set;smoke_ta5_set];    %空烟温度设定
airgaspotial=[agp1_set,agp2_set,agp3_set,agp4_set,agp5_set];

%设定值存储
data(141,b+1)=ts(1);                      %炉顶温度设定值  
data(142,b+1)=ts(2);
data(143,b+1)=ts(3);
data(144,b+1)=ts(4);
data(145,b+1)=ts(5);

data(146,b+1)=ta(1);                      %空烟温度设定值
data(147,b+1)=ta(2);
data(148,b+1)=ta(3);
data(149,b+1)=ta(4);
data(150,b+1)=ta(5);

data(151,b+1)=tg(1);                      %煤烟温度设定值
data(152,b+1)=tg(2);
data(153,b+1)=tg(3);
data(154,b+1)=tg(4);
data(155,b+1)=tg(5);

data(156,b+1)=airgaspotial(1);            % 空燃比设定
data(157,b+1)=airgaspotial(2);
data(158,b+1)=airgaspotial(3);
data(159,b+1)=airgaspotial(4);
data(160,b+1)=airgaspotial(5);

data(161,b+1)=luya_set;                   % 炉膛压力设定值 
data(162,b+1)=air_pressure_sp;            % 空气总管压力设定值  
data(163,b+1)=gas_pressure_sp;            % 煤气总管压力设定值 


%% 赋值pidloop设定值
pidloop(1,11)=tg(1);           % 煤烟设定值
pidloop(1,12)=tg(2);
pidloop(1,13)=tg(3);
pidloop(1,14)=tg(4);
pidloop(1,15)=tg(5);

pidloop(1,16)=ta(1);            %空烟设定值
pidloop(1,17)=ta(2);
pidloop(1,18)=ta(3);
pidloop(1,19)=ta(4);
pidloop(1,20)=ta(5);

%炉压设定值
pidloop(2,21)=luya_set;      %反相关

pidloop(1,22)=air_pressure_sp;  %空气总管压力设定值
pidloop(1,23)=gas_pressure_sp;  %煤气总管压力设定值


%% 获取实际值
%炉顶温度平均值
data(164,b+1) = (data(10,b+1)+data(15,b+1))/2;
data(165,b+1) = (data(25,b+1)+data(30,b+1))/2;
data(166,b+1) = (data(40,b+1)+data(45,b+1))/2;
data(167,b+1) = (data(55,b+1)+data(60,b+1))/2;
data(168,b+1) = (data(70,b+1)+data(75,b+1))/2;
%炉顶温度实际值：2表示使用上下两侧平均温度，1表示使用东侧温度 ，0表示使用西侧温度
if temp1_flag == 2 
    tp1=data(164,b+1); 
elseif temp1_flag == 1 
    tp1=data(10,b+1);    %一加左侧炉顶温度
else
    tp1=data(15,b+1);  
end

if temp2_flag == 2 
    tp2=data(165,b+1); 
elseif temp2_flag == 1 
    tp2=data(25,b+1);    %二加左侧炉顶温度
else
    tp2=data(30,b+1); 
end

if temp3_flag == 2 
    tp3=data(166,b+1); 
elseif temp3_flag == 1 
    tp3=data(40,b+1);     %三加左侧炉顶温度
else
    tp3=data(45,b+1);
end

if temp4_flag == 2
   tp4=data(167,b+1); 
elseif temp4_flag == 1 
   tp4=data(55,b+1);    %均热左侧炉顶温度
else
   tp4=data(60,b+1);
end

if temp5_flag == 2 
   tp5=data(168,b+1); 
elseif temp5_flag == 1 
   tp5=data(70,b+1);    %均热左侧炉顶温度
else
   tp5=data(75,b+1);
end

tp=[tp1;tp2;tp3;tp4;tp5];

%煤烟温度实际值（如果多个，可以选取煤气两侧最大温度）
gas_temp(1) = data(8,b+1);
gas_temp(2) = data(23,b+1);
gas_temp(3) = data(38,b+1);
gas_temp(4) = data(53,b+1);
gas_temp(5) = data(68,b+1);

%煤烟阀门开度实际值
gas_open(1) = data(14,b+1);
gas_open(2) = data(29,b+1);
gas_open(3) = data(44,b+1);
gas_open(4) = data(59,b+1);
gas_open(5) = data(74,b+1);

%空烟温度实际值（如果多个，选取空气两侧最大温度）
air_temp(1) = data(7,b+1);
air_temp(2) = data(22,b+1);
air_temp(3) = data(37,b+1);
air_temp(4) = data(52,b+1);
air_temp(5) = data(67,b+1);

%空烟阀门开度实际值
air_open(1) = data(12,b+1);
air_open(2) = data(27,b+1);
air_open(3) = data(42,b+1);
air_open(4) = data(57,b+1);
air_open(5) = data(72,b+1);

%煤气空气流量差值填充
%预热段填充
huanxiangshijian = [60 60 60 60 60];
if b > 10
    %预热段煤气填充
    if data(9,b+1) >= huanxiangshijian(1) - fanchui(1) || data(9,b+1) <= 19
        data(6,b+1) = mean(data(6,b-5:b));
        data(5,b+1) = mean(data(5,b-5:b));
    end
    %加一煤气填充
    if data(24,b+1) >= huanxiangshijian(2) - fanchui(2) || data(24,b+1) <= 19
        data(21,b+1) = mean(data(21,b-5:b));
        data(20,b+1) = mean(data(20,b-5:b));
    end
    %加二煤气填充
    if data(39,b+1) >= huanxiangshijian(3) - fanchui(3) || data(39,b+1) <= 19
        data(36,b+1) = mean(data(36,b-5:b));
        data(35,b+1) = mean(data(35,b-5:b));
    end
    %均上煤气填充
    if data(54,b+1) >= huanxiangshijian(4) - fanchui(4) || data(54,b+1) <= 19
        data(51,b+1) = mean(data(51,b-5:b));
        data(50,b+1) = mean(data(50,b-5:b));
    end
    %均下煤气填充
    if data(69,b+1) >= huanxiangshijian(5) - fanchui(5) || data(69,b+1) <= 19
        data(66,b+1) = mean(data(66,b-5:b));
        data(65,b+1) = mean(data(65,b-5:b));
    end
end


%煤气空气流量
%煤气流量滤波
gas_lvbo_time = 12; %
%预热段煤气
if b > gas_lvbo_time
    data(110,b+1) = mean([data(110,b-gas_lvbo_time+2:b),data(6,b+1)]);
elseif b>2
    data(110,b+1)=mean([data(110,2:b),data(6,b+1)]);   
else
    data(110,b+1)=data(6,b+1);
end
%一段煤气
onejia_gas_lvbo_time = 14;
if b > onejia_gas_lvbo_time
    data(111,b+1) = mean([data(111,b-onejia_gas_lvbo_time+2:b),data(21,b+1)]);
elseif b>2
    data(111,b+1)=mean([data(111,2:b),data(21,b+1)]);   
else
    data(111,b+1)=data(21,b+1);
end
%二段煤气
gas_lvbo_time_erjia = 16;
if b > gas_lvbo_time_erjia
    data(112,b+1) = mean([data(112,b-gas_lvbo_time_erjia+2:b),data(36,b+1)]);
elseif b>2
    data(112,b+1)=mean([data(112,2:b),data(36,b+1)]);   
else
    data(112,b+1)=data(36,b+1);
end
%均热上煤气
gas_lvbo_time_junreshang = 16;
if b > gas_lvbo_time_junreshang
    data(113,b+1) = mean([data(113,b-gas_lvbo_time_junreshang+2:b),data(51,b+1)]);
elseif b>2
    data(113,b+1)=mean([data(113,2:b),data(51,b+1)]);
else
    data(113,b+1)=data(51,b+1);
end
%均热下煤气
gas_lvbo_time_jrx = 18;
if b > gas_lvbo_time_jrx
    data(114,b+1) = mean([data(114,b-gas_lvbo_time_jrx+2:b),data(66,b+1)]);
elseif b>2
    data(114,b+1)=mean([data(114,2:b),data(66,b+1)]);
else
    data(114,b+1)=data(66,b+1);
end

%空气流量滤波
air_lvbo_time = 6; %
%预热段
yure_air_lvbo_time = air_lvbo_time + 2;
if b > yure_air_lvbo_time
    data(115,b+1) = mean([data(115,b-yure_air_lvbo_time+2:b),data(5,b+1)]);
elseif b>2
    data(115,b+1)=mean([data(115,2:b),data(5,b+1)]);   
else
    data(115,b+1)=data(5,b+1);
end
%一段
onejia_air_lvbo_time = 12;
if b > onejia_air_lvbo_time
    data(116,b+1) = mean([data(116,b-onejia_air_lvbo_time+2:b),data(20,b+1)]);
elseif b>2
    data(116,b+1)=mean([data(116,2:b),data(20,b+1)]);   
else
    data(116,b+1)=data(20,b+1);
end
%二段
air_lvbo_time_erjia = air_lvbo_time + 2;
if b > air_lvbo_time_erjia
    data(117,b+1) = mean([data(117,b-air_lvbo_time_erjia+2:b),data(35,b+1)]);
elseif b>2
    data(117,b+1)=mean([data(117,2:b),data(35,b+1)]);   
else
    data(117,b+1)=data(35,b+1);
end
%均热段上
air_lvbo_time_jrs = air_lvbo_time + 18;
if b > air_lvbo_time_jrs
    data(118,b+1) = mean([data(118,b-air_lvbo_time_jrs+2:b),data(50,b+1)]);
elseif b>2
    data(118,b+1)=mean([data(118,2:b),data(50,b+1)]);   
else
    data(118,b+1)=data(50,b+1);
end
%均热段下
air_lvbo_time_jrx = air_lvbo_time + 8;
if b > air_lvbo_time_jrx
    data(119,b+1) = mean([data(119,b-air_lvbo_time_jrx+2:b),data(65,b+1)]);
elseif b>2
    data(119,b+1)=mean([data(119,2:b),data(65,b+1)]);   
else
    data(119,b+1)=data(65,b+1);
end

%炉压滤波
luya_lvbo_time = 5;
if b > luya_lvbo_time
    data(120,b+1) = mean([data(120,b-luya_lvbo_time+2:b),data(76,b+1)]);
elseif b>2
    data(120,b+1)=mean([data(120,2:b),data(76,b+1)]); %下标从2开始，下标1无效   
else
    data(120,b+1)=data(76,b+1);
end
 
%助燃风压力滤波
zhuran_lvbo_time = 12;
if b > zhuran_lvbo_time
    data(121,b+1) = mean([data(121,b-zhuran_lvbo_time+2:b),data(77,b+1)]);
elseif b>2
    data(121,b+1)=mean([data(121,2:b),data(77,b+1)]);   
else
    data(121,b+1)=data(77,b+1);
end

%煤气流量实际滤波值
pidloop(2,1)=data(110,b+1);   
pidloop(2,2)=data(111,b+1);
pidloop(2,3)=data(112,b+1);
pidloop(2,4)=data(113,b+1);
pidloop(2,5)=data(114,b+1);

%空气流量实际滤波值
pidloop(2,6)=data(115,b+1);
pidloop(2,7)=data(116,b+1);                                 
pidloop(2,8)=data(117,b+1);
pidloop(2,9)=data(118,b+1);
pidloop(2,10)=data(119,b+1);

%煤烟温度实际测量值
pidloop(2,11)=gas_temp(1); %data(8,b+1);                        
pidloop(2,12)=gas_temp(2); %data(23,b+1);                                 
pidloop(2,13)=gas_temp(3); %data(38,b+1);
pidloop(2,14)=gas_temp(4); %data(53,b+1);
pidloop(2,15)=gas_temp(5); %data(68,b+1);

% % % % % %煤烟阀门开度实际测量值
% % % % % pidloop(14,1) = gas_open(1);
% % % % % pidloop(14,2) = gas_open(2);
% % % % % pidloop(14,3) = gas_open(3);
% % % % % pidloop(14,4) = gas_open(4);
% % % % % pidloop(14,5) = gas_open(5);

%空烟温度实际测量值
pidloop(2,16)=air_temp(1); %  data(7,b+1);       
pidloop(2,17)=air_temp(2); %  data(22,b+1);
pidloop(2,18)=air_temp(3); %  data(37,b+1);
pidloop(2,19)=air_temp(4);%  data(52,b+1);
pidloop(2,20)=air_temp(5);%  data(67,b+1);

% % % % % %空烟阀门开度实际测量值
% % % % % pidloop(14,6) = air_open(1);
% % % % % pidloop(14,7) = air_open(2);
% % % % % pidloop(14,8) = air_open(3);
% % % % % pidloop(14,9) = air_open(4);
% % % % % pidloop(14,10) = air_open(5);

%炉压实际测量值
pidloop(1,21) = data(120,b+1); %反相关
%空气总管压力
pidloop(2,22)=data(121,b+1);        
%煤气总管压力
pidloop(2,23)=data(78,b+1);                       

%% 实际值存入data中
%存储炉温的实际使用值
data(125,b+1) = tp1;
data(126,b+1) = tp2;
data(127,b+1) = tp3;
data(128,b+1) = tp4;
data(129,b+1) = tp5;

% % % %煤烟温度实际使用值
% % % data(245,b+1) = pidloop(2,11);
% % % data(246,b+1) = pidloop(2,12);
% % % data(247,b+1) = pidloop(2,13);
% % % data(248,b+1) = pidloop(2,14);
% % % data(249,b+1) = pidloop(2,15);
% % % 
% % % %空烟温度实际使用值
% % % data(250,b+1) = pidloop(2,16);
% % % data(251,b+1) = pidloop(2,17);
% % % data(252,b+1) = pidloop(2,18);
% % % data(253,b+1) = pidloop(2,19);
% % % data(254,b+1) = pidloop(2,20);

%% 实际值GUI显示
%炉温显示
set(handles.tp1,'String',num2str(tp1,'%.1f')); 
set(handles.tp2,'String',num2str(tp2,'%.1f')); 
set(handles.tp3,'String',num2str(tp3,'%.1f'));
set(handles.tp4,'String',num2str(tp4,'%.1f'));
set(handles.text139,'String',num2str(tp5,'%.1f'));

%煤烟温度显示
set(handles.tg1,'String',num2str(round(gas_temp(1))));              
set(handles.tg2,'String',num2str(round(gas_temp(2))));
set(handles.tg3,'String',num2str(round(gas_temp(3)))); 
set(handles.tg4,'String',num2str(round(gas_temp(4)))); 
set(handles.text142,'String',num2str(round(gas_temp(5)))); 

%空烟温度显示
set(handles.ta1,'String',num2str(round(air_temp(1))));
set(handles.ta2,'String',num2str(round(air_temp(2)))); 
set(handles.ta3,'String',num2str(round(air_temp(3)))); 
set(handles.ta4,'String',num2str(round(air_temp(4))));
set(handles.text141,'String',num2str(round(air_temp(5))));

%空燃比显示
set(handles.agp1_p,'String',num2str(data(5,b+1)/data(6,b+1),'%.2f')); 
set(handles.agp2_p,'String',num2str(data(20,b+1)/data(21,b+1),'%.2f'));
set(handles.agp3_p,'String',num2str(data(35,b+1)/data(36,b+1),'%.2f'));
set(handles.agp4_p,'String',num2str(data(50,b+1)/data(51,b+1),'%.2f'));
set(handles.text148,'String',num2str(data(65,b+1)/data(66,b+1),'%.2f'));

%炉压显示
set(handles.pressure_p,'String',num2str(data(76,b+1),'%.0f'));
%助燃风压力显示
set(handles.air_pressure_p,'String',num2str(data(77,b+1),'%.2f'));
%煤气总管压力显示
set(handles.text122,'String',num2str(data(78,b+1),'%.2f'));

%引风机显示
set(handles.ky_sj,'String',num2str(data(81,b+1),'%.0f'));
set(handles.my_sj,'String',num2str(data(82,b+1),'%.0f'));
set(handles.by_sj,'String',num2str(data(83,b+1),'%.0f'));

%% 无扰切换处理
%SP跟随PV MV跟随手动值
[~, loopnum]=size(pidloop);
for i=1:loopnum
    switch i
        case 1
            if pidloop(10,i)==1                 %煤气
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(3,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(131,b+1)=data(110,b+1);      %一加煤气流量设定值
                tempu(i)=data(110,b+1);       %%!!!!这里防止tempu进行gpc计算时初始值为0，导致打开控制按钮瞬间波动变0
            end
        case 2
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(18,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(132,b+1)=data(111,b+1); 
                tempu(i)=data(111,b+1); 
            end
        case 3
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(33,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(133,b+1)=data(112,b+1); 
                tempu(i)=data(112,b+1); 
            end
        case 4                                  
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(48,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(134,b+1)=data(113,b+1); 
                tempu(i)=data(113,b+1); 
            end
        case 5
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(63,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(135,b+1)=data(114,b+1); 
                tempu(i)=data(114,b+1); 
            end
        case 6                                  %空气
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(1,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(136,b+1)=data(115,b+1); 
                airsp(i-5)=data(115,b+1); 
            end
        case 7
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(16,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(137,b+1)=data(116,b+1); 
                airsp(i-5)=data(116,b+1); 
            end
        case 8
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(31,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(138,b+1)=data(117,b+1); 
                airsp(i-5)=data(117,b+1); 
            end
        case 9
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(46,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(139,b+1)=data(118,b+1); 
                airsp(i-5)=data(118,b+1); 
            end
        case 10
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(61,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
                data(140,b+1)=data(119,b+1); 
                airsp(i-5)=data(119,b+1); 
            end
        case 11                                  %煤烟
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(13,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 12
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(28,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 13
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);              
                pidloop(3,i)=data(43,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 14                                  
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(58,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 15
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(73,b+1);  
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 16                          %空烟
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(11,b+1);   
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 17                                  
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(26,b+1);   
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
        case 18                                 
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(41,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
         case 19                                 
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(56,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
         case 20                                
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(71,b+1);
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
         case 21                                  %炉膛压力
            if pidloop(10,i)==1
%                 pidloop(1,i)=pidloop(2,i);
                pidloop(2,i)=pidloop(1,i);        %反相关
                upid(i)=pidloop(3,i);
            end
         case 22                                  %助燃风机设定
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                if choose_fj == 1
                    pidloop(3,i)=data(79,b+1);
                elseif choose_fj == 2
                    pidloop(3,i)=data(80,b+1);
                end
                upid_old(i)=pidloop(3,i);
                upid(i)=pidloop(3,i);
            end
% % %          case 23                                  %煤气总管压力设定
% % %             if pidloop(10,i)==1
% % %                 pidloop(1,i)=pidloop(2,i);
% % %                 pidloop(3,i)=data(78,b+1);        %煤气总管无法调节，无阀门大小值，用78 站位
% % %                 upid_old(i)=pidloop(3,i);
% % %                 upid(i)=pidloop(3,i);
% % %             end
        case 24
            if pidloop(10,i)==1
                pidloop(3,i) = data(81,b+1);
                upid(i) = pidloop(3,i);
            end
        case 25
            if pidloop(10,i)==1
                pidloop(3,i) = data(82,b+1);
                upid(i) = pidloop(3,i);
            end
        case 26
            if pidloop(10,i)==1
                pidloop(3,i) = data(83,b+1);
                upid(i) = pidloop(3,i);
            end
    end
end    

%% 如果所有排烟控制器都关闭，则炉压控制关闭，否则开启
if sum(pidloop(10,11:20)) == 10
    pidloop(10,21)=1;
else
    pidloop(10,21)=0;
end

%% GPC计算煤气流量设定值
if b>=15
    tsp=[ts1;ts2;ts3;ts4;ts5];      %5段的炉温设定值
    
    %针对炉顶温度异常时要剔除，防止gpc计算出现大幅偏差调整
    if temp1_flag == 2
        if abs(data(164,b+1) - data(164,b)) > 30
            data(164,b+1) = data(164,b);
        end
    elseif temp1_flag == 1
        if abs(data(10,b+1) - data(10,b)) > 30
            data(10,b+1) = data(10,b);
        end
    else
        if abs(data(15,b+1) - data(15,b)) > 30
            data(15,b+1) = data(15,b);
        end
    end
    
    if temp2_flag == 2
         if abs(data(165,b+1) - data(165,b)) > 30
            data(165,b+1) = data(165,b);
         end
    elseif temp2_flag == 1
         if abs(data(25,b+1) - data(25,b)) > 30
            data(25,b+1) = data(25,b);
         end
    else
         if abs(data(30,b+1) - data(30,b)) > 30
            data(30,b+1) = data(30,b);
         end
    end
    
    if temp3_flag == 2
          if abs(data(166,b+1) - data(166,b)) > 30
             data(166,b+1) = data(166,b);
          end
    elseif temp3_flag == 1
          if abs(data(40,b+1) - data(40,b)) > 30
             data(40,b+1) = data(40,b);
          end
    else
        if abs(data(45,b+1) - data(45,b)) > 30
             data(45,b+1) = data(45,b);
         end
    end
    
    if temp4_flag == 2
          if abs(data(167,b+1) - data(167,b)) > 30
              data(167,b+1) = data(167,b);
          end
    elseif temp4_flag == 1
          if abs(data(55,b+1) - data(55,b)) > 30
              data(55,b+1) = data(55,b);
          end
    else
         if abs(data(60,b+1) - data(60,b)) > 30
             data(60,b+1) = data(60,b);
         end
    end
    
    if temp5_flag == 2
          if abs(data(168,b+1) - data(168,b)) > 30
              data(168,b+1) = data(168,b);
          end
    elseif temp5_flag == 1
          if abs(data(70,b+1) - data(70,b)) > 30
              data(70,b+1) = data(70,b);
          end
    else
         if abs(data(75,b+1) - data(75,b)) > 30
             data(75,b+1) = data(75,b);
         end
    end
    if temp1_flag == 2
         y1=data(164,b-3:2:b+1); 
    elseif temp1_flag == 1
         y1=data(10,b-3:2:b+1);    %5段的炉温测量值
    else
         y1=data(15,b-3:2:b+1);    
    end
    
    if temp2_flag == 2
         y2=data(165,b-3:2:b+1);
    elseif temp2_flag == 1
         y2=data(25,b-3:2:b+1);
    else
         y2=data(30,b-3:2:b+1);
    end
    
    if temp3_flag == 2
         y3=data(166,b-3:2:b+1);
    elseif temp3_flag == 1
         y3=data(40,b-3:2:b+1);
    else
         y3=data(45,b-3:2:b+1);
    end
    
    if temp4_flag == 2
         y4=data(167,b-8:4:b+1);
    elseif temp4_flag == 1
         y4=data(55,b-8:4:b+1);
    else
         y4=data(60,b-8:4:b+1);
    end
    
    if temp5_flag == 2
         y5=data(168,b-3:2:b+1);
    elseif temp5_flag == 1
         y5=data(70,b-3:2:b+1);
    else
         y5=data(75,b-3:2:b+1);
    end
   
    yp=[y1;y2;y3;y4;y5];
    
    yr=tsp-workpoint(:,1);
          
    u1=data(131,b-4:2:b);       % 一加煤气流量设定值(neibujiangdi)
    if u1 >= flow_max(1)
        u1 = u1 - yure_flow_max_down;
    end
    u2=data(132,b-4:2:b);% 二加煤气流量设定值
    if u2 >= flow_max(2)
        u2 = u2 - jiayi_flow_max_down;
    end
    u3=data(133,b-4:2:b);
    if u3 >= flow_max(3)
        u3 = u3 - jiaer_flow_max_down;
    end
    u4=data(134,b-9:4:b);
    if u4 >= flow_max(4)
        u4 = u4 - junshang_flow_max_down;
    end
    u5=data(135,b-4:2:b);
    if u5 >= flow_max(5)
        u5 = u5 - junxia_flow_max_down;
    end

    up=[u1;u2;u3;u4;u5];
    
    %一加GPC
    if temp_open(1,1)==1
        if mod(b,5)==0 
            yy=yp(1,:)-workpoint(1,1);
            u=up(1,:)-workpoint(1,2);
            tempu(1)=gpc_clac(A(1,:),B(1,:),P,yy,u,yr(1),gpc_a(1),gpc_lmd(1));
            tempu(1)=tempu(1) + workpoint(1,2);
            
            if tempu(1) >= flow_max(1)
                tempu(1) = flow_max(1);
            end               
            if tempu(1) <= flow_min(1)
                tempu(1) = flow_min(1);
            end
        end
    end

    %二加GPC
    if temp_open(2,1)==1
        if mod(b,5)==1
            yy=yp(2,:)-workpoint(2,1);
            u=up(2,:)-workpoint(2,2);
            tempu(2)=gpc_clac(A(2,:),B(2,:),P,yy,u,yr(2),gpc_a(2),gpc_lmd(2));
            tempu(2)=tempu(2) + workpoint(2,2);
            if tempu(2) >= flow_max(2)
                tempu(2)=flow_max(2);
            end               
            if tempu(2)<=flow_min(2)
                tempu(2)=flow_min(2);
            end
        end
    end
    
    %三加GPC
    if temp_open(3,1)==1
        if mod(b,8)==0 %mod(b,5)==2
            yy=yp(3,:)-workpoint(3,1);
            u=up(3,:)-workpoint(3,2);
            tempu(3)=gpc_clac(A(3,:),B(3,:),P,yy,u,yr(3),gpc_a(3),gpc_lmd(3));
            tempu(3)=tempu(3) + workpoint(3,2);
            if tempu(3) >= flow_max(3)
                tempu(3)=flow_max(3);
            end               
            if tempu(3)<=flow_min(3)
                tempu(3)=flow_min(3);
            end
        end
    end
    
    %均热上gpc
    if temp_open(4,1)==1
        if mod(b,10)==3
            yy=yp(4,:)-workpoint(4,1);
            u=up(4,:)-workpoint(4,2);
            tempu(4)=gpc_clac(A(4,:),B(4,:),P,yy,u,yr(4),gpc_a(4),gpc_lmd(4));
            tempu(4)=tempu(4) + workpoint(4,2);
            if tempu(4) >= flow_max(4)
                tempu(4)=flow_max(4);
            end               
            if tempu(4)<=flow_min(4)
                tempu(4)=flow_min(4);
            end
        end
    end
    %均热下gpc
    if temp_open(5,1)==1
        if mod(b,5)==4
            yy=yp(5,:)-workpoint(5,1);
            u=up(5,:)-workpoint(5,2);
            tempu(5)=gpc_clac(A(5,:),B(5,:),P,yy,u,yr(5),gpc_a(5),gpc_lmd(5));
            tempu(5)=tempu(5) + workpoint(5,2);
            if tempu(5) >= flow_max(5)
                tempu(5)=flow_max(5);
            end               
            if tempu(5)<=flow_min(5)
                tempu(5)=flow_min(5);
            end
        end
    end
end

%% 抗饱和处理
if b >= 8 
    %%解决控制器下限饱和
    airmv=[data(1,b+1);data(16,b+1);data(31,b+1);data(46,b+1);data(61,b+1)];    %空气阀设定
    gasmv=[data(3,b-3:b+1);data(18,b-3:b+1);data(33,b-3:b+1);data(48,b-3:b+1);data(63,b-3:b+1)];     %煤气阀设定
%     airpv=[data(5,b+1);data(20,b+1);data(35,b+1);data(50,b+1);data(65,b+1)];              %空气流量测量
    for i=1:5
        if temp_open(i)==1
            switch i
                case 1
                    if (tp1<ts1)&&(data(110,b+1)<flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i))==5)   % 当实际温度小于设定温度时且煤气阀门连续五秒为gas_valve_max时，煤气设定值等于实际值 ，此时PID输出为零
                        tempu(i)=data(110,b+1);
                    end
                    if (tp1>=ts1)&&(sum(gasmv(i,:)<=gas_valve_min(i))==5)    % 当实际温度大于设定温度时且煤气阀门连续五秒为gas_valve_min时，煤气设定值等于实际值 ，此时PID输出为零               
                        tempu(i)=data(110,b+1);
                    end
                    if pidloop(10,6)==0 
                        if (tp1>=ts1)&&(sum(airmv(i)<air_valve_min(i))==1) %空气阀降到最小
                            tempu(i)=data(115,b+1)/airgaspotial(i); %通过空气配煤气
                        end
                        if (airmv(i)>=air_valve_max(i))&&(tempu(i)>=data(115,b+1)/airgaspotial(i)) %当空气阀开度为air_valve_max且煤气设定值乘以空燃比大于空气最大流量时...
                            tempu(i)=data(115,b+1)/airgaspotial(i); %通过空气配煤气
                        end
                        if (tempu(i)>=airflow_max(i)/airgaspotial(i)) %当空气最大流量时...
                            tempu(i)=airflow_max(i)/airgaspotial(i); %通过空气配煤气
                        end
                    end
                case 2
                    if (tp2<ts2)&&(data(111,b+1)<flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i))==5)   % 同上                
                        tempu(i)=data(111,b+1);                    
                    end
                    if (tp2>=ts2)&&(sum(gasmv(i,:)<=gas_valve_min(i))==5)
                        tempu(i)=data(111,b+1);
                    end
                    if pidloop(10,7)==0
                        if (tp2>=ts2)&&(sum(airmv(i)<air_valve_min(i))==1)
                            tempu(i)=data(116,b+1)/airgaspotial(i);
                         end
                        if (airmv(i)>=air_valve_max(i))&&(tempu(i)>=data(116,b+1)/airgaspotial(i)) 
                            tempu(i)=data(116,b+1)/airgaspotial(i);
                        end
                        if (tempu(i)>=airflow_max(i)/airgaspotial(i)) %当空气最大流量时...
                            tempu(i)=airflow_max(i)/airgaspotial(i); %通过空气配煤气
                        end
                    end 
                case 3
                    if (tp3<ts3)&&(data(112,b+1)<flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i))==5)
                        tempu(i)=data(112,b+1);
                    end
                    if (tp3>=ts3)&&(sum(gasmv(i,:)<=gas_valve_min(i))==5)
                        tempu(i)=data(112,b+1);
                    end
                    if pidloop(10,8)==0
                        if (tp3>=ts3)&&(sum(airmv(i)<air_valve_min(i))==1)
                            tempu(i)=data(117,b+1)/airgaspotial(i);
                        end
                        if (airmv(i)>=air_valve_max(i))&&(tempu(i)>=data(117,b+1)/airgaspotial(i))
                            tempu(i)=data(117,b+1)/airgaspotial(i);
                        end
                        if (tempu(i)>=airflow_max(i)/airgaspotial(i)) %当空气最大流量时...
                            tempu(i)=airflow_max(i)/airgaspotial(i); %通过空气配煤气
                        end
                    end
                 case 4
                    if (tp4<ts4)&&(data(113,b+1)<flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i))==5)
                        tempu(i)=data(113,b+1);
                    end
                    if (tp4>=ts4)&&(sum(gasmv(i,:)<=gas_valve_min(i))==5)
                        tempu(i)=data(113,b+1);
                    end
                    if pidloop(10,9)==0
                        if (tp4>=ts4)&&(sum(airmv(i)<air_valve_min(i))==1)
                            tempu(i)=data(118,b+1)/airgaspotial(i);
                        end
%                         if (airmv(i)>=air_valve_max(i))&&(tempu(i)>=data(118,b+1)/airgaspotial(i))
%                             tempu(i)=data(118,b+1)/airgaspotial(i);
%                         end
                        if (tempu(i)>=airflow_max(i)/airgaspotial(i)) %当空气最大流量时...
                            tempu(i)=airflow_max(i)/airgaspotial(i); %通过空气配煤气
                        end
                    end
                case 5
                    if (tp5<ts5)&&(data(114,b+1)<flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i))==5)
                        tempu(i)=data(114,b+1);
                    end
                    if (tp5>=ts5)&&(sum(gasmv(i,:)<=gas_valve_min(i))==5)
                        tempu(i)=data(114,b+1);
                    end
                    if pidloop(10,10)==0
                        if (tp5>=ts5)&&(sum(airmv(i)<air_valve_min(i))==1)
                            tempu(i)=data(119,b+1)/airgaspotial(i);
                        end
%                         if (airmv(i)>=air_valve_max(i))&&(tempu(i)>=data(119,b+1)/airgaspotial(i))
%                             tempu(i)=data(119,b+1)/airgaspotial(i);
%                         end
                        if (tempu(i)>=airflow_max(i)/airgaspotial(i)) %当空气最大流量时...
                            tempu(i)=airflow_max(i)/airgaspotial(i); %通过空气配煤气
                        end
                    end
                otherwise
                    'error from switch';
            end
        end
    end
end

%对计算出的tempu限幅
tempuMax = 2000;
for i=1:5
    if temp_open(i) == 1
        if tempu(i) - data(130+i,b) > tempuMax
            tempu(i) = data(130+i,b) + tempuMax;
        end
        if tempu(i) - data(130+i,b) < -tempuMax
            tempu(i) = data(130+i,b) - tempuMax;
        end
        if tempu(i) >= flow_max(i)
            tempu(i)=flow_max(i);
        end               
        if tempu(i)<=flow_min(i)
            tempu(i)=flow_min(i);
        end
    end
end

%% 根据煤气流量设定值和空燃比计算空气流量设定值
for i=1:5
    if gap_on(i)==1
        airsp(i)=tempu(i)*airgaspotial(i); %空气流量
        if airsp(i)<=min_air_limit  %空气流量不能低于min_air_limit
            airsp(i)=min_air_limit;
        end
        if airsp(i)>=airflow_max(i)  %空气流量不能低于min_air_limit
            airsp(i)=airflow_max(i);
        end
    end
end

%% 煤气空气交叉锁定：煤气上升，先加空气再加煤气；煤气下降，先降煤气再降空气
for i=1:5
    if gap_on(i)==1
        if tempu(i) > data(130+i,b)         %煤气上升(这里需根据现场实际情况是否使用实际滤波值比较？)
            pidloop(1,i)=data(130+i,b);     %煤气保持
            pidloop(1,5+i)=airsp(i);        %先加空气
        elseif tempu(i) < data(130+i,b)     %煤气下降(这里需根据现场实际情况是否使用实际滤波值比较？)
            pidloop(1,i)=tempu(i);          %先减煤气
            pidloop(1,5+i)=data(135+i,b);   %空气保持
        else
            pidloop(1,i)=tempu(i);
            pidloop(1,5+i)=airsp(i);
        end
        data(130+i,b+1)=tempu(i);            %保存流量设定值
        data(135+i,b+1)=airsp(i);
    end
end

% % % %% 设置pidloop设定值
% % % %煤气流量设定值
% % % pidloop(1,1)=tempu(1);
% % % pidloop(1,2)=tempu(2);
% % % pidloop(1,3)=tempu(3);
% % % pidloop(1,4)=tempu(4);
% % % pidloop(1,5)=tempu(5);
% % % 
% % % %空气流量设定值
% % % pidloop(1,6)=airsp(1);
% % % pidloop(1,7)=airsp(2);
% % % pidloop(1,8)=airsp(3);
% % % pidloop(1,9)=airsp(4);
% % % pidloop(1,10)=airsp(5);
% % % 
% % % %% 流量设定值存入data
% % % %煤气流量设定值
% % % data(131,b+1)=tempu(1);
% % % data(132,b+1)=tempu(2);
% % % data(133,b+1)=tempu(3);
% % % data(134,b+1)=tempu(4);
% % % data(135,b+1)=tempu(5);
% % % %空气流量设定值
% % % data(136,b+1)=airsp(1);
% % % data(137,b+1)=airsp(2);
% % % data(138,b+1)=airsp(3);
% % % data(139,b+1)=airsp(4);
% % % data(140,b+1)=airsp(5);


%% 各控制量的PID控制参数
%预热煤烟空烟
pidloop(7,11)=0.15; %0.25
pidloop(8,11)=51;
pidloop(7,16)=0.09; %0.25
pidloop(8,16)=40;
  
%一加煤烟空烟
pidloop(7,12)=0.08; %0.035
pidloop(8,12)=37; %55
pidloop(7,17)=0.02; %0.32
pidloop(8,17)=20; %56

%二加煤烟空烟
pidloop(7,13)=0.06; %0.4
pidloop(8,13)=36; %55
pidloop(7,18)=0.09; %0.43
pidloop(8,18)=21; %50

%均热上煤烟空烟
pidloop(7,14)=0.14; %0.4
pidloop(8,14)=28; %55
pidloop(7,19)=0.1; %0.43
pidloop(8,19)=32; %50

%均热下煤烟空烟
pidloop(7,15)=0.06; %0.4
pidloop(8,15)=21; %55
pidloop(7,20)=0.07; %0.43
pidloop(8,20)=27; %50

%炉压pid参数
pidloop(7,21)=1.5; %0.4
pidloop(8,21)=120; %55

%风机PID
if choose_fj == 1
    pidloop(7,22)=5.5;
    pidloop(8,22)=48;
    pidloop(13,22)=0.1;
elseif choose_fj == 2
    pidloop(7,22)=5.5;
    pidloop(8,22)=45;
    pidloop(13,22)=0.1;
end

%煤气总管阀
pidloop(7,23)=0.9;
pidloop(8,23)=30;
pidloop(13,23)=0.1;

%% GPC多模型参数 (中间参数lmd更小调节作用大，两边lmd大些，作用量小些)
%预热段 参数调整
% % % if ~isempty(ts) && ~isempty(tp) && abs(ts(1)-tp(1))>=35
% % %     pidloop(7,1)=0.0015;%0.00555
% % %     pidloop(7,6)=0.0016;%0.00555
% % %     pidloop(8,1)=40;%40
% % %     pidloop(8,6)=46;%32
% % %     gpc_lmd(1)=0.0065;%0.002;%0.09
% % %     gpc_a(1,1)=0.98;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(1)-tp(1))>=20
% % %     pidloop(7,1)=0.0013;%0.0026
% % %     pidloop(7,6)=0.0012;%0.0029
% % %     pidloop(8,1)=35;%40
% % %     pidloop(8,6)=38;%32
% % %     gpc_lmd(1)=0.0067;%0.002;%0.09
% % %     gpc_a(1,1)=0.985;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(1)-tp(1))>=12
% % %     pidloop(7,1)=0.001;%0.0042
% % %     pidloop(7,6)=0.001;%0.0032
% % %     pidloop(8,1)=32;%50
% % %     pidloop(8,6)=35;%32
% % %     gpc_lmd(1)=0.0068;%0.01;%0.07
% % %     gpc_a(1,1)=0.989;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(1)-tp(1))>=8
% % %     pidloop(7,1)=0.0009;%0.004
% % %     pidloop(7,6)=0.0008;%0.0032
% % %     pidloop(8,1)=30;%40
% % %     pidloop(8,6)=33;%32
% % %     gpc_lmd(1)=0.007;%0.045;%0.09
% % %     gpc_a(1,1)=0.99;
% % % else
% % %     pidloop(7,1)=0.00065;%0.0034
% % %     pidloop(7,6)=0.00065;%0.0033
% % %     pidloop(8,1)=30;%32
% % %     pidloop(8,6)=33;%32
% % %     gpc_lmd(1)=0.01;%0.06;%0.12
% % %     gpc_a(1,1)=0.992;
% % % end
pidloop(7,1)=0.001;%0.0034 0.00067
pidloop(7,6)=0.0015;%0.0033 0.0007
pidloop(8,1)=25;%32
pidloop(8,6)=25;%32
gpc_lmd(1)=0.0160;%0.06;%0.12 0.01
gpc_a(1,1)=0.9700;%0.992
%加一段
% % if ~isempty(ts) && ~isempty(tp) && abs(ts(2)-tp(2))>=35
% %     pidloop(7,2)=0.001;%0.00555
% %     pidloop(7,7)=0.0012;%0.00555
% %     pidloop(8,2)=40;
% %     pidloop(8,7)=46;
% %     gpc_lmd(2)=0.005;%0.025;%0.16
% %     gpc_a(1,2)=0.988;%0.9
% % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(2)-tp(2))>=20
% %     pidloop(7,2)=0.0008;%0.0043
% %     pidloop(7,7)=0.001;%0.0045
% %     pidloop(8,2)=38;
% %     pidloop(8,7)=40;
% %     gpc_lmd(2)=0.006;%0.025;%0.16
% %     gpc_a(1,2)=0.99;%0.9
% % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(2)-tp(2))>=12
% %     pidloop(7,2)=0.0006;
% %     pidloop(7,7)=0.0008;
% %     pidloop(8,2)=35;
% %     pidloop(8,7)=37;
% %     gpc_lmd(2)=0.008;%0.035;%0.0036
% %     gpc_a(1,2)=0.992;%0.9
% % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(2)-tp(2))>=8
% %     pidloop(7,2)=0.0005; %0.0043
% %     pidloop(7,7)=0.0007; %0.0043
% %     pidloop(8,2)=33;
% %     pidloop(8,7)=35;
% %     gpc_lmd(2)=0.01;%0.15;%0.0018
% %     gpc_a(1,2)=0.995;%0.9
% % else
% %     pidloop(7,2)=0.0005; %0.0042
% %     pidloop(7,5)=0.0007; %0.004
% %     pidloop(8,2)=33;
% %     pidloop(8,5)=35;
% %     gpc_lmd(2)=0.012;%0.2;%0.072
% %     gpc_a(1,2)=0.997;%0.95
% % end
% % % % pidloop(7,2)=0.0011; %0.0042
% % % % pidloop(7,5)=0.0011; %0.004
% % % % pidloop(8,2)=40;
% % % % pidloop(8,5)=40;
% % % % gpc_lmd(2)=0.01;%0.2;%0.072
% % % % gpc_a(1,2)=0.99;%0.95
if abs(ts(2)-tp(2))>=10
    pidloop(7,2)=0.004;
    pidloop(7,7)=0.0044;
    pidloop(8,2)=66;
    pidloop(8,7)=66;
    gpc_lmd(2)=0.008;%0.25; %0.32
    gpc_a(1,2)=0.995;
else
    pidloop(7,2)=0.002; %0.0042
    pidloop(7,7)=0.0024; %0.004
    pidloop(8,2)=34;
    pidloop(8,7)=34;
    gpc_lmd(2)=0.01;%0.2;%0.072
    gpc_a(1,2)=0.993;%0.95
end
%加二段
% % % if ~isempty(ts) && ~isempty(tp) && abs(ts(3)-tp(3))>=30
% % %     pidloop(7,3)=0.0041;%0.002
% % %     pidloop(7,8)=0.0038;%0.0021
% % %     pidloop(8,3)=63;
% % %     pidloop(8,8)=63;
% % %     gpc_lmd(3)=0.004;%0.08;%0.18
% % %     gpc_a(1,3)=0.963;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(3)-tp(3))>=20
% % %     pidloop(7,3)=0.00415;%0.002
% % %     pidloop(7,8)=0.0038;%0.0021
% % %     pidloop(8,3)=56;
% % %     pidloop(8,8)=45;
% % %     gpc_lmd(3)=0.006;%0.08;%0.18
% % %     gpc_a(1,3)=0.965;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(3)-tp(3))>=12
% % %     pidloop(7,3)=0.00370;
% % %     pidloop(7,8)=0.0042;
% % %     pidloop(8,3)=58;
% % %     pidloop(8,8)=48;
% % %     gpc_lmd(3)=0.004;%0.1; %0.22
% % %     gpc_a(1,3)=0.96;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(3)-tp(3))>=8
% % %     pidloop(7,3)=0.00305;
% % %     pidloop(7,8)=0.0033;
% % %     pidloop(8,3)=48;
% % %     pidloop(8,8)=43;
% % %     gpc_lmd(3)=0.01;%0.18; %0.28
% % %     gpc_a(1,3)=0.97;
% % % else
% % %     pidloop(7,3)=0.003;
% % %     pidloop(7,8)=0.0033;
% % %     pidloop(8,3)=45;
% % %     pidloop(8,8)=40;
% % %     gpc_lmd(3)=0.01;%0.25; %0.32
% % %     gpc_a(1,3)=0.97;
% % % end
if abs(ts(3)-tp(3))>=10
    pidloop(7,3)=0.002;
    pidloop(7,8)=0.0034;
    pidloop(8,3)=55;
    pidloop(8,8)=55;
    gpc_lmd(3)=0.01;%0.25; %0.32
    gpc_a(1,3)=0.988;
else
    pidloop(7,3)=0.001;
    pidloop(7,8)=0.0024;
    pidloop(8,3)=51;%53
    pidloop(8,8)=51;%53
    gpc_lmd(3)=0.012;%0.25; %0.32
    gpc_a(1,3)=0.99;
end

%均热段上
% % % if ~isempty(ts) && ~isempty(tp) && abs(ts(4)-tp(4))>=30
% % %     pidloop(7,4)=0.002;%0.002
% % %     pidloop(7,9)=0.00395;%0.0021
% % %     pidloop(8,4)=63;
% % %     pidloop(8,9)=53;
% % %     gpc_lmd(4)=0.002;%0.08;%0.18
% % %     gpc_a(1,4)=0.96;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(4)-tp(4))>=20
% % %     pidloop(7,4)=0.0018;%0.002
% % %     pidloop(7,9)=0.00397;%0.0021
% % %     pidloop(8,4)=55;
% % %     pidloop(8,9)=53;
% % %     gpc_lmd(4)=0.003;%0.08;%0.18
% % %     gpc_a(1,4)=0.97;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(4)-tp(4))>=12
% % %     pidloop(7,4)=0.0015;
% % %     pidloop(7,9)=0.0040;
% % %     pidloop(8,4)=58;
% % %     pidloop(8,9)=56;
% % %     gpc_lmd(4)=0.004;%0.1; %0.22
% % %     gpc_a(1,4)=0.97;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(4)-tp(4))>=8
% % %     pidloop(7,4)=0.0013;
% % %     pidloop(7,9)=0.0030;
% % %     pidloop(8,4)=53;
% % %     pidloop(8,9)=50;
% % %     gpc_lmd(4)=0.008;%0.18; %0.28
% % %     gpc_a(1,4)=0.97;
% % % else
% % %     pidloop(7,4)=0.0012;
% % %     pidloop(7,9)=0.00240;
% % %     pidloop(8,4)=50;
% % %     pidloop(8,9)=40;
% % %     gpc_lmd(4)=0.0085;%0.25; %0.32
% % %     gpc_a(1,4)=0.975;
% % % end
% if ts(4) > tp(4)
pidloop(7,4)=0.0027;
pidloop(7,9)=0.003;
pidloop(8,4)=55;
pidloop(8,9)=55;
gpc_lmd(4)=0.044;%0.25; %0.32
gpc_a(1,4)=0.998;
% else
%     pidloop(7,4)=0.0027;
%     pidloop(7,9)=0.0027;
%     pidloop(8,4)=55;
%     pidloop(8,9)=55;
%     gpc_lmd(4)=0.08;%0.25; %0.32
%     gpc_a(1,4)=0.998;
% end  

%均热段下
% % % if ~isempty(ts) && ~isempty(tp) && abs(ts(5)-tp(5))>=30
% % %     pidloop(7,5)=0.00495;%0.002
% % %     pidloop(7,10)=0.00395;%0.0021
% % %     pidloop(8,5)=63;
% % %     pidloop(8,10)=53;
% % %     gpc_lmd(5)=0.002;%0.08;%0.18
% % %     gpc_a(1,5)=0.96;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(5)-tp(5))>=20
% % %     pidloop(7,5)=0.0045;%0.002
% % %     pidloop(7,10)=0.00397;%0.0021
% % %     pidloop(8,5)=55;
% % %     pidloop(8,10)=53;
% % %     gpc_lmd(5)=0.003;%0.08;%0.18
% % %     gpc_a(1,5)=0.97;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(5)-tp(5))>=12
% % %     pidloop(7,5)=0.0053;
% % %     pidloop(7,10)=0.0040;
% % %     pidloop(8,5)=58;
% % %     pidloop(8,10)=56;
% % %     gpc_lmd(5)=0.002;%0.1; %0.22
% % %     gpc_a(1,5)=0.95;
% % % elseif ~isempty(ts) && ~isempty(tp) && abs(ts(5)-tp(5))>=8
% % %     pidloop(7,5)=0.0047;
% % %     pidloop(7,10)=0.0030;
% % %     pidloop(8,5)=53;
% % %     pidloop(8,10)=50;
% % %     gpc_lmd(5)=0.004;%0.18; %0.28
% % %     gpc_a(1,5)=0.96;
% % % else
% % %     pidloop(7,5)=0.00323;
% % %     pidloop(7,10)=0.00240;
% % %     pidloop(8,5)=50;
% % %     pidloop(8,10)=40;
% % %     gpc_lmd(5)=0.0067;%0.25; %0.32
% % %     gpc_a(1,5)=0.957;
% % % end
% % % % pidloop(7,5)=0.0014;
% % % % pidloop(7,10)=0.0016;
% % % % pidloop(8,5)=50;
% % % % pidloop(8,10)=50;
% % % % gpc_lmd(5)=0.06;%0.25; %0.32
% % % % gpc_a(1,5)=0.998;
if abs(ts(5)-tp(5))>=10
    pidloop(7,5)=0.0032;
    pidloop(7,10)=0.0036;
    pidloop(8,5)=60;
    pidloop(8,10)=60;
    gpc_lmd(5)=0.043;%0.25; %0.32
    gpc_a(1,5)=0.988;
else
    pidloop(7,5)=0.0022;
    pidloop(7,10)=0.0026;
    pidloop(8,5)=53;
    pidloop(8,10)=53;
    gpc_lmd(5)=0.048;%0.25; %0.32
    gpc_a(1,5)=0.998;
end

%% 煤气总管快切阀，煤气总管压力<4时，关闭加一段流量（根据现场实际情况，是否需要开启或关闭）
% % kuaiqievalue = str2double(get(handles.text137,'String')); %快切阀设定
% % if data(78,b+1) < kuaiqievalue && temp_open(1,1)==1 && gap_on(1)==1
% %     temp_open(1,1)=0;
% %     pidloop(10,1)=1;
% %     set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
% %     set(handles.apcon1_close,'BackgroundColor',[1 0 0]);%将close设置为红色
% %     
% %     pidloop(10,11)=1;%煤烟温度回路切自动
% %     pidloop(10,16)=1;%空烟温度回路切自动
% %     
% %     set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
% %     set(handles.tsc1_close,'BackgroundColor',[1 0 0]);
% %     
% %     gap_on(1)=0;
% %     pidloop(10,6)=1;
% %     % set(handles.gapon1,'String','关闭');
% %     set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
% %     set(handles.gapon1_close,'BackgroundColor',[1 0 0]);
% %     
% %     %空气阀和煤气阀关闭
% %     write(itemset(1),0);
% %     write(itemset(3),0);
% %     write(itemset(11),0);
% %     write(itemset(13),0);
% %     alarm_sound_flag2 = 1; %提示报警声音
% % end 

% temp_up = steeldata.common(val,1).parameter.ATTRIBUTE.kongmeitempuplimit; %空煤烟温度上限
% value_off = steeldata.common(val,1).parameter.ATTRIBUTE.famensetoffValue;  %空煤烟阀门每次下调幅度
% mod_time = 10;% 控制周期

%% 调用PID计算输出结果
for i=1:loopnum 
    if pidloop(10,i) == 0
        %煤烟CLE
        if (i >=11 && i <= 15) && (b > 150)
            %趋势数据
            dindex = 8+(i-11)*15;     %煤烟温度实际值索引
            famenindex = 13+(i-11)*15; %煤气阀门设定值索引
            mx1 = max(data(dindex,b-8:b+1)); %10s的数据间隔
            mx2 = max(data(dindex,b-18:b-9));
            mx3 = max(data(dindex,b-28:b-19));
            mn1 = min(data(dindex,b-8:b+1));
            mn2 = min(data(dindex,b-18:b-13));
            mn3 = min(data(dindex,b-28:b-19));
            
            mx11 = max(data(dindex,b-48:b+1)); %50s的数据间隔
            mx21 = max(data(dindex,b-98:b-49));
            mx31 = max(data(dindex,b-148:b-99));

            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);
            
            CLE_mod = 35;
            %温度高于设定值，并且是还保持上升趋势
            if (mn_min>=tg(i-10)-10) && (mod(b,CLE_mod)==0)...
                    && ((mx1>mx2) && (mx2>mx3)||...
                        (mx11>mx21) && (mx21>mx31))
                default_vd = 1;
                delvd = 0;
                if mn_min-tg(i-10)>=20
                    delvd=5;
                elseif mn_min-tg(i-10)>=8
                    delvd=2;
                elseif mn_min-tg(i-10)>=5
                    delvd=2;
                elseif mn_min-tg(i-10)>=3
                    delvd=2;
                elseif mn_min-tg(i-10)>=2
                    delvd=1;
                end
                T_upid = data(famenindex,b+1);
                pidloop(3,i) = T_upid - (default_vd + delvd);  %温度高，需要减阀门
            %温度低于设定值，并且是还保持下降趋势
            elseif (mx_max<=tg(i-10)+10) && (mod(b,CLE_mod)==0)...
                    && ((mx1<mx2) && (mx2<mx3)||...
                        (mx11<mx21) && (mx21<mx31))
                default_vd = 1;
                delvd = 0;
                if tg(i-10)-mx_max>=20
                    delvd=5;
                elseif tg(i-10)-mx_max>=8
                    delvd=2;
                elseif tg(i-10)-mx_max>=5
                    delvd=2;
                elseif tg(i-10)-mx_max>=3
                    delvd=2;
                elseif tg(i-10)-mx_max>=2
                    delvd=1;
                end
                
                T_upid = data(famenindex,b+1);
                pidloop(3,i) = T_upid + (default_vd + delvd);  %温度低，需要加大阀门
            else
                pidloop(4,i)=pidloop(1,i)-pidloop(2,i);
                pidloop(:,i)=pid_calc(pidloop(:,i)');
            end
        elseif (i >=16 && i <= 20) && (b > 150)  %空烟CLE
            %趋势数据
            dindex = 7+(i-16)*15;     %空烟温度实际值索引
            famenindex = 11+(i-16)*15; %空气阀门设定值索引
            mx1 = max(data(dindex,b-8:b+1)); %10s的数据间隔
            mx2 = max(data(dindex,b-18:b-9));
            mx3 = max(data(dindex,b-28:b-19));
            mn1 = min(data(dindex,b-8:b+1));
            mn2 = min(data(dindex,b-18:b-13));
            mn3 = min(data(dindex,b-28:b-19));
            
            mx11 = max(data(dindex,b-48:b+1)); %50s的数据间隔
            mx21 = max(data(dindex,b-98:b-49));
            mx31 = max(data(dindex,b-148:b-99));

            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);
            
            CLE_mod = 35;
            %温度高于设定值，并且是还保持上升趋势
            if (mn_min>=ta(i-15)-10) && (mod(b,CLE_mod)==0)...
                    && ((mx1>mx2) && (mx2>mx3)||...
                        (mx11>mx21) && (mx21>mx31))
                default_vd = 1;
                delvd = 0;
                if mn_min-tg(i-15)>=20
                    delvd=5;
                elseif mn_min-ta(i-15)>=8
                    delvd=2;
                elseif mn_min-ta(i-15)>=5
                    delvd=2;
                elseif mn_min-ta(i-15)>=3
                    delvd=2;
                elseif mn_min-ta(i-15)>=2
                    delvd=1;
                end
                T_upid = data(famenindex,b+1);
                pidloop(3,i) = T_upid - (default_vd + delvd);  %温度高，需要减阀门
            %温度低于设定值，并且是还保持下降趋势
            elseif (mx_max<=ta(i-15)+10) && (mod(b,CLE_mod)==0)...
                    && ((mx1<mx2) && (mx2<mx3)||...
                        (mx11<mx21) && (mx21<mx31))
                default_vd = 1;
                delvd = 0;
                if tg(i-15)-mx_max>=20
                    delvd=5;
                elseif ta(i-15)-mx_max>=8
                    delvd=2;
                elseif ta(i-15)-mx_max>=5
                    delvd=2;
                elseif ta(i-15)-mx_max>=3
                    delvd=2;
                elseif ta(i-15)-mx_max>=2
                    delvd=1;
                end
                
                T_upid = data(famenindex,b+1);
                pidloop(3,i) = T_upid + (default_vd + delvd);  %温度低，需要加大阀门
            else
                pidloop(4,i)=pidloop(1,i)-pidloop(2,i);
                pidloop(:,i)=pid_calc(pidloop(:,i)');
            end
        elseif (i >= 24 && i <= 26)
            continue;
        else
            pidloop(4,i)=pidloop(1,i)-pidloop(2,i);
            pidloop(:,i)=pid_calc(pidloop(:,i)');
        end
        
        if pidloop(3,i) > pidloop(11,i)
            pidloop(3,i) = pidloop(11,i);
        end
        if pidloop(3,i) < pidloop(12,i)
            pidloop(3,i) = pidloop(12,i);
        end
        
        %防止炉膛压力被抽成负值加入排烟阀门变化量限制
        %煤烟与煤气阀门绑定
% % %         if pidloop(3,11) - pidloop(3,1) >= 20
% % %             pidloop(3,11) = pidloop(3,1) + 20;
% % %         else
% % %             pidloop(3,11) = pidloop(3,1) + (pidloop(3,11) - pidloop(3,1));
% % %         end
% % %         if pidloop(3,12) - pidloop(3,2) >= 20
% % %             pidloop(3,12) = pidloop(3,2) + 20;
% % %         else
% % %             pidloop(3,12) = pidloop(3,2) + (pidloop(3,12) - pidloop(3,2));
% % %         end
% % %         if pidloop(3,13) - pidloop(3,3) >= 20
% % %             pidloop(3,13) = pidloop(3,3) + 20;
% % %         else
% % %             pidloop(3,13) = pidloop(3,3) + (pidloop(3,13) - pidloop(3,3));
% % %         end
% % %         if pidloop(3,14) - pidloop(3,4) >= 20
% % %             pidloop(3,14) = pidloop(3,4) + 20;
% % %         else
% % %             pidloop(3,14) = pidloop(3,4) + (pidloop(3,14) - pidloop(3,4));
% % %         end
% % %         
% % %         %空烟与空气阀门绑定
% % %         if pidloop(3,16) - pidloop(3,6) >= 20
% % %             pidloop(3,16) = pidloop(3,6) + 20;
% % %         else
% % %             pidloop(3,16) = pidloop(3,6) + (pidloop(3,16) - pidloop(3,6));
% % %         end
% % %         if pidloop(3,17) - pidloop(3,7) >= 20
% % %             pidloop(3,17) = pidloop(3,7) + 20;
% % %         else
% % %             pidloop(3,17) = pidloop(3,7) + (pidloop(3,17) - pidloop(3,7));
% % %         end
% % %         if pidloop(3,18) - pidloop(3,8) >= 20
% % %             pidloop(3,18) = pidloop(3,8) + 20;
% % %         else
% % %             pidloop(3,18) = pidloop(3,8) + (pidloop(3,18) - pidloop(3,8));
% % %         end
% % %         if pidloop(3,19) - pidloop(3,9) >= 20
% % %             pidloop(3,19) = pidloop(3,9) + 20;
% % %         else
% % %             pidloop(3,19) = pidloop(3,9) + (pidloop(3,19) - pidloop(3,9));
% % %         end
        upid(i)=pidloop(3,i);
    end
end

%% 对10个排烟设定温度进行与实际温度差值大小排序，作为炉压输出值进行阀门补偿
members=zeros(1,5);
if pidloop(10,21) == 0 %炉压和排烟偶合处理
    paiyan_Dvalue = zeros(1,20)-500; %初始化，默认给值-500排序不可能出现影响的差值
    paiyan_Dvalue(11) = pidloop(1,11) - pidloop(2,11);   %煤烟
    paiyan_Dvalue(12) = pidloop(1,12) - pidloop(2,12);
    paiyan_Dvalue(13) = pidloop(1,13) - pidloop(2,13);
    paiyan_Dvalue(14) = pidloop(1,14) - pidloop(2,14);
    paiyan_Dvalue(15) = pidloop(1,15) - pidloop(2,15);

    paiyan_Dvalue(16) = pidloop(1,16) - pidloop(2,16);    %空烟
    paiyan_Dvalue(17) = pidloop(1,17) - pidloop(2,17);
    paiyan_Dvalue(18) = pidloop(1,18) - pidloop(2,18);
    paiyan_Dvalue(19) = pidloop(1,19) - pidloop(2,19);
    paiyan_Dvalue(20) = pidloop(1,20) - pidloop(2,20);

    [sort_paiyan_Dvalue,ind] = sort(paiyan_Dvalue); %默认是升序；降序使用sort(paiyan_Dvalue,'descend')
    %最大差值：sort_paiyan_Dvalue(20)，原索引位置：ind(20)
    %如果该段排烟控制器打开，并且温度没有超过上限，则该段排烟阀可以被炉压合力控制
    temppidV = pidloop(1,21) - pidloop(2,21);
    if temppidV >= 40
        members(1) = ind(20);
        members(2) = ind(19);
        members(3) = ind(18);
        members(4) = ind(17);
%         members(5) = ind(16);
    elseif temppidV >= 30 && temppidV < 40
        members(1) = ind(20);
        members(2) = ind(19);
        members(3) = ind(18);
%         members(4) = ind(17);
    elseif temppidV >= 20 && temppidV < 30
        members(1) = ind(20);
        members(2) = ind(19);
%         members(3) = ind(18);
    elseif temppidV >= 15 && temppidV < 20
        members(1) = ind(20);
%         members(2) = ind(19);
    end
end

%% 引风机控制
%空+煤
if pidloop(10,24) == 0 && pidloop(10,25) == 0
    %引风机下限不低于鼓风机频率 + 补偿值 yinfj_buchang
    pidloop(12,24) = yinfj_buchang;
    pidloop(12,25) = yinfj_buchang;
    
    yfj_control_time = 60; %控制时间
    yfj_judge_time = 50; %判定时间
    over_luya = 65; %炉压上限
    lower_luya = 15; %炉压下限
    bili = 2; %比例
    if b > yfj_judge_time * 4 && mod(b,yfj_control_time) == 0 %如果时间大于判定时间*4且是控制时间的整数倍
        
        m1 = sum(data(76,b-yfj_judge_time+2:b+1) > over_luya);        
        m2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) > over_luya);
        m3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) > over_luya); %三段判定时间内大于炉压上限的数有多少
        
        n1 = sum(data(76,b-yfj_judge_time+2:b+1) < lower_luya);
        n2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) < lower_luya);
        n3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) < lower_luya); %三段判定时间内小于炉压下限的数有多少
        
        if (m1+m2+m3) > yfj_judge_time * 3 / bili %按比例整除，若在总时间内有比例时间的次数出现高于炉压上限则引风机+1
            pidloop(3,24) = pidloop(3,24) + 1;
            pidloop(3,25) = pidloop(3,25) + 1;
        elseif (n1+n2+n3) > yfj_judge_time * 3 / bili %同理-1
            pidloop(3,24) = pidloop(3,24) - 1;
            pidloop(3,25) = pidloop(3,25) - 1;
        end       
    end
   
   % 将计算值写入upid
   for i = 24:25
       if pidloop(3,i) <= pidloop(12,i)
          pidloop(3,i) = pidloop(12,i);
       end
       if pidloop(3,i) >= pidloop(11,i)
          pidloop(3,i) = pidloop(11,i);
       end
       upid(i) = pidloop(3,i);
   end
%空+备
elseif pidloop(10,24) == 0 && pidloop(10,26) == 0
    %引风机下限不低于鼓风机频率 + 补偿值 yinfj_buchang
    pidloop(12,24) = yinfj_buchang;
    pidloop(12,26) = yinfj_buchang;
    
    yfj_control_time = 60; %控制时间
    yfj_judge_time = 50; %判定时间
    over_luya = 65; %炉压上限
    lower_luya = 15; %炉压下限
    bili = 2; %比例
    if b > yfj_judge_time * 4 && mod(b,yfj_control_time) == 0 %如果时间大于判定时间*4且是控制时间的整数倍
        
        m1 = sum(data(76,b-yfj_judge_time+2:b+1) > over_luya);        
        m2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) > over_luya);
        m3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) > over_luya); %三段判定时间内大于炉压上限的数有多少
        
        n1 = sum(data(76,b-yfj_judge_time+2:b+1) < lower_luya);
        n2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) < lower_luya);
        n3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) < lower_luya); %三段判定时间内小于炉压下限的数有多少
        
        if (m1+m2+m3) > yfj_judge_time * 3 / bili %按比例整除，若在总时间内有比例时间的次数出现高于炉压上限则引风机+1
            pidloop(3,24) = pidloop(3,24) + 1;
            pidloop(3,26) = pidloop(3,26) + 1;
        elseif (n1+n2+n3) > yfj_judge_time * 3 / bili %同理-1
            pidloop(3,24) = pidloop(3,24) - 1;
            pidloop(3,26) = pidloop(3,26) - 1;
        end       
    end
   
   % 将计算值写入upid
    if pidloop(3,24) <= pidloop(12,24)
      pidloop(3,24) = pidloop(12,24);
    end
    if pidloop(3,24) >= pidloop(11,24)
      pidloop(3,24) = pidloop(11,24);
    end
    upid(24) = pidloop(3,24);
    
    if pidloop(3,26) <= pidloop(12,26)
      pidloop(3,26) = pidloop(12,26);
    end
    if pidloop(3,26) >= pidloop(11,26)
      pidloop(3,26) = pidloop(11,26);
    end
    upid(26) = pidloop(3,26);
%煤+备
elseif pidloop(10,25) == 0 && pidloop(10,26) == 0
    %引风机下限不低于鼓风机频率 + 补偿值 yinfj_buchang
    pidloop(12,25) = yinfj_buchang;
    pidloop(12,26) = yinfj_buchang;
    
    yfj_control_time = 60; %控制时间
    yfj_judge_time = 50; %判定时间
    over_luya = 65; %炉压上限
    lower_luya = 15; %炉压下限
    bili = 2; %比例
    if b > yfj_judge_time * 4 && mod(b,yfj_control_time) == 0 %如果时间大于判定时间*4且是控制时间的整数倍
        
        m1 = sum(data(76,b-yfj_judge_time+2:b+1) > over_luya);        
        m2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) > over_luya);
        m3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) > over_luya); %三段判定时间内大于炉压上限的数有多少
        
        n1 = sum(data(76,b-yfj_judge_time+2:b+1) < lower_luya);
        n2 = sum(data(76,b-yfj_judge_time * 2 + 2:b-yfj_judge_time + 1) < lower_luya);
        n3 = sum(data(76,b-yfj_judge_time * 3 + 2:b-yfj_judge_time * 2 + 1) < lower_luya); %三段判定时间内小于炉压下限的数有多少
        
        if (m1+m2+m3) > yfj_judge_time * 3 / bili %按比例整除，若在总时间内有比例时间的次数出现高于炉压上限则引风机+1
            pidloop(3,25) = pidloop(3,24) + 1;
            pidloop(3,26) = pidloop(3,25) + 1;
        elseif (n1+n2+n3) > yfj_judge_time * 3 / bili %同理-1
            pidloop(3,25) = pidloop(3,24) - 1;
            pidloop(3,26) = pidloop(3,25) - 1;
        end       
    end
   
   % 将计算值写入upid
   for i = 25:26
       if pidloop(3,i) <= pidloop(12,i)
          pidloop(3,i) = pidloop(12,i);
       end
       if pidloop(3,i) >= pidloop(11,i)
          pidloop(3,i) = pidloop(11,i);
       end
       upid(i) = pidloop(3,i);
   end
end

js_fmxf_Max = 5;
if temp_open(4) == 1
    if upid(4) - data(48,b+1) > js_fmxf_Max
        upid(4) = data(48,b+1) + js_fmxf_Max;
    end
    if upid(4) - data(48,b+1) < -js_fmxf_Max
        upid(4) = data(48,b+1) - js_fmxf_Max;
    end
end
%% 写PID控制量 
%煤烟振幅判断
if manaotu == 0
    if upid(11) - data(13,b+1) >= abs(single_change)
        upid(11) = data(13,b+1) + (abs(single_change)/2);
    end
    if upid(12) - data(28,b+1) >= abs(single_change)
        upid(12) = data(28,b+1) + (abs(single_change)/2);
    end
    if upid(13) - data(43,b+1) >= abs(single_change)
        upid(13) = data(43,b+1) + (abs(single_change)/2);
    end
    if upid(14) - data(58,b+1) >= abs(single_change)
        upid(14) = data(58,b+1) + (abs(single_change)/2);
    end
end



for i=1:loopnum
    switch i
        case 1                                                  %一加煤气
            if pidloop(10,i)==0 && mod(b,modTime)==0 
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                   P_write(3,round(upid(i)),gas_valve_max(1),gas_valve_min(1));
                end
                upid_old(i)=data(3,b+1);
            end
        case 2
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(18,round(upid(i)),gas_valve_max(2),gas_valve_min(2));
                end
                upid_old(i)=data(18,b+1);
            end
        case 3
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(33,round(upid(i)),gas_valve_max(3),gas_valve_min(3));
                end
                upid_old(i)=data(33,b+1);
            end
        case 4
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(48,round(upid(i)),gas_valve_max(4),gas_valve_min(4));
                end
                upid_old(i)=data(48,b+1);
            end
        case 5
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(63,round(upid(i)),gas_valve_max(5),gas_valve_min(5));
                end
                upid_old(i)=data(63,b+1);
            end
        case 6                                                  %一加空气
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                   P_write(1,round(upid(i)),air_valve_max(1),air_valve_min(1));
                end
                upid_old(i)=data(1,b+1);
            end
        case 7
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                   P_write(16,round(upid(i)),air_valve_max(2),air_valve_min(2));
                end
                upid_old(i)=data(16,b+1);
            end
        case 8
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                    P_write(31,round(upid(i)),air_valve_max(3),air_valve_min(3));
                end
                upid_old(i)=data(31,b+1);
            end
        case 9
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                   P_write(46,round(upid(i)),air_valve_max(4),air_valve_min(4));
                end
                upid_old(i)=data(46,b+1);
            end
        case 10
            if pidloop(10,i)==0 && mod(b,modTime)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                    P_write(61,round(upid(i)),air_valve_max(5),air_valve_min(5));
                end
                upid_old(i)=data(61,b+1);
            end
        case 11                                                 %一加煤烟
            if pidloop(10,i)==0 %&& abs(upid(i)-upid_old(i))>=deadzone(3) 
               if ismember(11,members)
                   zhi = upid(i) * (1-luyabili(1)) + upid(21) * luyabili(1);
               else
                   zhi = upid(i);
               end
%                if meiyan_valve_max(1) - kongyan_valve_max(1)
               P_write(13,round(zhi),meiyan_valve_max(1),meiyan_valve_min(1));
               upid_old(i)=zhi;
            end
        case 12
            if pidloop(10,i)==0 %abs(upid(i)-upid_old(i))>=deadzone(3)
               if ismember(12,members)
                   zhi = upid(i) * (1-luyabili(2)) + upid(21) * luyabili(2);
               else
                   zhi = upid(i);
               end
               P_write(28,round(zhi),meiyan_valve_max(2),meiyan_valve_min(2));
               upid_old(i)=zhi;
            end
        case 13
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
               if ismember(13,members)
                   zhi = upid(i) * (1-luyabili(3)) + upid(21)* luyabili(3);
               else
                   zhi = upid(i);
               end
               P_write(43,round(zhi),meiyan_valve_max(3),meiyan_valve_min(3));
               upid_old(i)=zhi;
            end
        case 14                                                 
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
                if ismember(14,members)
                   zhi = upid(i) * (1-luyabili(4)) + upid(21) * luyabili(4);
               else
                   zhi = upid(i);
               end
               P_write(58,round(zhi),meiyan_valve_max(4),meiyan_valve_min(4));
               upid_old(i)=zhi;
            end
        case 15
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
                if ismember(15,members)
                   zhi = upid(i) * (1-luyabili(5)) + upid(21) * luyabili(5);
                else
                   zhi = upid(i);
                end
                P_write(73,round(zhi),meiyan_valve_max(5),meiyan_valve_min(5));
                upid_old(i)=zhi;
            end
        case 16                                                 %一加空烟
            if pidloop(10,i)==0 %&& abs(upid(i)-upid_old(i))>=deadzone(3) 
               if ismember(16,members)
                   zhi = upid(i) * (1-luyabili(1)) + upid(21) * luyabili(1);
               else
                   zhi = upid(i);
               end
               P_write(11,round(zhi),kongyan_valve_max(1),kongyan_valve_min(1));
               upid_old(i)=zhi;
            end
        case 17
            if pidloop(10,i)==0 %abs(upid(i)-upid_old(i))>=deadzone(3)
               if ismember(17,members)
                   zhi = upid(i) * (1-luyabili(2)) + upid(21) * luyabili(2);
               else
                   zhi = upid(i);
               end
               P_write(26,round(zhi),kongyan_valve_max(2),kongyan_valve_min(2));
               upid_old(i)=zhi;
            end
        case 18
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
               if ismember(18,members)
                   zhi = upid(i) * (1-luyabili(3)) + upid(21)* luyabili(3);
               else
                   zhi = upid(i);
               end
               P_write(41,round(zhi),kongyan_valve_max(3),kongyan_valve_min(3));
               upid_old(i)=zhi;
            end
        case 19                                                 
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
                if ismember(19,members)
                   zhi = upid(i) * (1-luyabili(4)) + upid(21) * luyabili(4);
               else
                   zhi = upid(i);
               end
               P_write(56,round(zhi),kongyan_valve_max(4),kongyan_valve_min(4));
               upid_old(i)=zhi;
            end
        case 20
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
                if ismember(20,members)
                   zhi = upid(i) * (1-luyabili(5)) + upid(21) * luyabili(5);
                else
                   zhi = upid(i);
                end
                P_write(71,round(zhi),kongyan_valve_max(5),kongyan_valve_min(5));
                upid_old(i)=zhi;
            end
        case 22                                               %助燃风
            if pidloop(10,i)==0 %if abs(upid(i)-upid_old(i))>=deadzone(3)
                if choose_fj == 1
                     P_write(79,round(upid(i)),fengji_valve_max,fengji_valve_min);
                elseif choose_fj == 2
                     P_write(80,round(upid(i)),fengji_valve_max,fengji_valve_min);
                end
            end
            upid_old(i)=pidloop(3,i);

% % %         case 23                                                 %煤气总管
% % %             if pidloop(10,i)==0 %&& (mod(b,2)==0)%if abs(upid(i)-upid_old(i))>=deadzone(3)
% % %                  write(itemset(72),round(upid(i)));
% % %             end
% % %             upid_old(i)=pidloop(3,i);        
        case 24
            if pidloop(10,i) ==0
                P_write(81,round(upid(i)),yinfj_max,yinfj_min);
            end
        case 25
            if pidloop(10,i) ==0
                P_write(82,round(upid(i)),yinfj_max,yinfj_min);
            end
        case 26
            if pidloop(10,i) ==0
                P_write(83,round(upid(i)),yinfj_max,yinfj_min);
            end
    end
end

%% 阀门卡死报警
soundspath = '';
set(handles.pushbutton34,'visible','off');
alarm_sound_flag = 0; %表示当前哪个报警
% alarmsndwicth = 0; %表示当前哪个报警
%一加煤气 二加煤气 均热煤气 一加空气 二加空气 均热空气 一加空烟 二加空烟 均热空烟 一加煤烟 二加煤烟 均热煤烟 空气总管压力
if b>30 % b>10 大于100000表示不执行
   %需要根据现场阀门反馈值偏差更改 5 这个值
    if(sum(abs(data(3,b-6:b+1)-data(4,b-6:b+1))>20)==8) && pidloop(10,1)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','预热段煤气阀门卡死报警');
        soundspath = 'sounds/yijia_gasalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 1;
    end
    if(sum(abs(data(18,b-6:b+1)-data(19,b-6:b+1))>20)==8) && pidloop(10,2)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加一段煤气阀门卡死报警');
        soundspath = 'sounds/erjia_gasalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 2;
    end
    if(sum(abs(data(33,b-6:b+1)-data(34,b-6:b+1))>20)==8) && pidloop(10,3)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加二段煤气阀门卡死报警');
        soundspath = 'sounds/junre_gasalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 3;
    end
    if(sum(abs(data(48,b-6:b+1)-data(49,b-6:b+1))>20)==8) && pidloop(10,4)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段上煤气阀门卡死报警');
        soundspath = 'sounds/junre_gasalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 4;
    end
    if(sum(abs(data(63,b-6:b+1)-data(64,b-6:b+1))>20)==8) && pidloop(10,5)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段下煤气阀门卡死报警');
        soundspath = 'sounds/junre_gasalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 5;
    end
    if(sum(abs(data(1,b-6:b+1)-data(2,b-6:b+1))>20)==8) && pidloop(10,6)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','预热段空气阀门卡死报警');
        soundspath = 'sounds/yijia_airalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 6;
    end
    if(sum(abs(data(16,b-6:b+1)-data(17,b-6:b+1))>20)==8) && pidloop(10,7)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加一段空气阀门卡死报警');
        soundspath = 'sounds/erjia_airalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 7;
    end
    if(sum(abs(data(31,b-6:b+1)-data(32,b-6:b+1))>20)==8) && pidloop(10,8)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加二段空气阀门卡死报警');
        soundspath = 'sounds/junre_airalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 8;
    end
    if(sum(abs(data(46,b-6:b+1)-data(47,b-6:b+1))>20)==8) && pidloop(10,9)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段上空气阀门卡死报警');
        soundspath = 'sounds/junre_airalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 9;
    end
    if(sum(abs(data(61,b-6:b+1)-data(62,b-6:b+1))>20)==8) && pidloop(10,10)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段下空气阀门卡死报警');
        soundspath = 'sounds/junre_airalarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 10;
    end
    
    if(sum(abs(data(11,b-6:b+1)-data(12,b-6:b+1))>20)==8) && pidloop(10,16)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','预热段空烟阀门卡死报警');
        soundspath = 'sounds/yijia_airsmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 16;
    end
    if(sum(abs(data(26,b-6:b+1)-data(27,b-6:b+1))>20)==8) && pidloop(10,17)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加一段空烟阀门卡死报警');
        soundspath = 'sounds/erjia_airsmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 17;
    end
    if(sum(abs(data(41,b-6:b+1)-data(42,b-6:b+1))>20)==8) && pidloop(10,18)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加二段空烟阀门卡死报警');
        soundspath = 'sounds/junre_airsmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 18;
    end
    if(sum(abs(data(56,b-6:b+1)-data(57,b-6:b+1))>20)==8) && pidloop(10,19)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段上空烟阀门卡死报警');
        soundspath = 'sounds/junre_airsmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 19;
    end
    if(sum(abs(data(71,b-6:b+1)-data(72,b-6:b+1))>20)==8) && pidloop(10,20)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段下空烟阀门卡死报警');
        soundspath = 'sounds/junre_airsmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 20;
    end
    if(sum(abs(data(13,b-6:b+1)-data(14,b-6:b+1))>20)==8) && pidloop(10,11)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','预热段煤烟阀门卡死报警');
        soundspath = 'sounds/yijia_gassmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 11;
    end
    if(sum(abs(data(28,b-6:b+1)-data(29,b-6:b+1))>20)==8) && pidloop(10,12)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加一段煤烟阀门卡死报警');
        soundspath = 'sounds/erjia_gassmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 12;
    end
    if(sum(abs(data(43,b-6:b+1)-data(44,b-6:b+1))>20)==8) && pidloop(10,13)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','加二段煤烟阀门卡死报警');
        soundspath = 'sounds/junre_gassmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 13;
    end
    if(sum(abs(data(58,b-6:b+1)-data(59,b-6:b+1))>20)==8) && pidloop(10,14)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段上煤烟阀门卡死报警');
        soundspath = 'sounds/junre_gassmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 14;
    end
    if(sum(abs(data(73,b-6:b+1)-data(74,b-6:b+1))>20)==8) && pidloop(10,15)==0 && ~alarm_button_clicked
        set(handles.pushbutton34,'visible','on');
        set(handles.pushbutton34,'String','均热段下煤烟阀门卡死报警');
        soundspath = 'sounds/junre_gassmokealarm.mp3';
        if (mod(b,2)==1)
           set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
        else
           set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
        end
        alarm_sound_flag = 15;
    end

% % % %    if(abs(data(125,b+1) - data(125,b))>30) && ~alarm_button_clicked %加一段炉温热电偶报警 
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','预热段炉顶温度异常报警');
% % % %         soundspath = 'sounds/yijia_luding.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 1;
% % % %    end
% % % %     if(abs(data(126,b+1) - data(126,b))>30) && ~alarm_button_clicked 
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','加一段炉顶温度异常报警');
% % % %         soundspath = 'sounds/erjia_luding.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 2;
% % % %     end
% % % %     if(abs(data(127,b+1) - data(127,b))>30) && ~alarm_button_clicked %data(40,b+1)
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','加二段炉顶温度异常报警');
% % % %         soundspath = 'sounds/junre_luding.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 3;
% % % %     end
% % % %     if(abs(data(128,b+1) - data(128,b))>30) && ~alarm_button_clicked 
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','均热段上炉顶温度异常报警');
% % % %         soundspath = 'sounds/junre_luding.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 4;
% % % %     end
% % % %     if(abs(data(129,b+1) - data(129,b))>30) && ~alarm_button_clicked 
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','均热段下炉顶温度异常报警');
% % % %         soundspath = 'sounds/junre_luding.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 5;
% % % %     end

% % % %     if(data(78,b+1)>25) && (data(78,b+1)<4) && pidloop(10,23)==0 && ~alarm_button_clicked
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','煤气总管压力报警');
% % % %         soundspath = 'sounds/mqzgyl.mp3';
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %         alarm_sound_flag = 23;
% % % %     end

% % % %     if alarm_sound_flag2
% % % %         set(handles.pushbutton34,'visible','on');
% % % %         set(handles.pushbutton34,'String','<html>煤压过低<br>一加热段关闭<br><html>');
% % % %         if (mod(b,2)==1)
% % % %            set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % % %         else
% % % %            set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % % %         end
% % % %     end
end
% % % catch
% % %     %暂时通过catch异常，简单作为网络断开异常判断
% % %     %前提先保证try内部代码运行都正常才行，唯一出现异常就是网络断开才可用
% % %     
% % %     %%%%需要现场测试断开网络时，会报告什么错误，然后，通过catch 
% % %     %%%%捕捉到更可靠的错误码语句做判断
% % %     if ~alarm_button_clicked
% % %         set(handles.pushbutton34,'visible','on');
% % %         set(handles.pushbutton34,'String','网络出现故障');
% % %         soundspath = 'sounds/networkerror.mp3';
% % %         if (mod(b,2)==1)
% % %             set(handles.pushbutton34,'BackgroundColor',[1 0 0]);
% % %         else
% % %             set(handles.pushbutton34,'BackgroundColor',[0 1 0]);
% % %         end
% % %         alarm_sound_flag = 1;
% % %     end
% % % end

%%%%%%%这里可以实现语音播报报警功能，根据需要可以切换使用，默认使用普通报警铃声%%%%%%%%%%%%
if manalarmsound  %alarmsound == 1使用人工语音报警
    if alarm_sound_flag && ~isempty(soundspath) && pidloop(10,alarm_sound_flag)==0 && mod(b,4)==0
        [x,fs] = audioread(soundspath);
        sound(x,fs);
    end
else
    if alarm_sound_flag && pidloop(10,alarm_sound_flag)==0 && mod(b,2)==0
        load chirp
        sound(y,Fs)
    elseif alarm_sound_flag2 && mod(b,2)==0
        load chirp
        sound(y,Fs)
    end
end


if alarm_button_clicked
    if alarm_timer == 0
        alarm_timer = 120;      %%点击取消报警后，120s后会再次恢复
        alarm_button_clicked = 0;
    else
        alarm_timer = alarm_timer - 1;
    end
end
%% 每小时data数据更新
if b>=3900
    datetime=datestr(now,30);
%     if temp_open(2,1)==1 && temp_open(3,1)==1 %最起码二段和均热段打开时才表示自动控制记录数据，否则表示没有打开，不记录数据
        s=['save(''data',datetime(1:8),datetime(10:11),'.mat'',''data'');'];
        eval(s);
%     end

    lastsave=['data',datetime(1:8),datetime(10:11),'.mat'];
%     set(handles.lastsavetime,'String',datestr(now,31));
    data(1:6,1)=fix(clock);
    data(:,2:301)=data(:,3602:3901);
    data(:,302:3901)=[];
    b=300;
    %处理程序有效期
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
                               || (licensevalid ~= 101011010100)%表示license无效
        msgbox('授权有效期到期，请更新授权！');
        % 有效期过期，强制断开
        if ~isempty(timerfind)
            stop(timerfind);
            delete(timerfind);
        end
        if strcmp(daobj.Status,'connected')
            disconnect(daobj)
        end
        set(handles.text1,'String','已断开');
    end
end
processtime=toc;
catch lasterror
       soundspath = 'sounds/networkerror.mp3';
       [x,fs] = audioread(soundspath);
       sound(x,fs);

       set(handles.text1,'String','已断开，请点断开中控，重新连接');
       set(handles.connectwincc,'BackgroundColor',[1 0 0]);
       
       %% 炉温开关全部关闭
        temp_open(1,1)=0;
        temp_open(2,1)=0;
        temp_open(3,1)=0;
        temp_open(4,1)=0;
        temp_open(5,1)=0;
        pidloop(10,1)=1;
        pidloop(10,2)=1;
        pidloop(10,3)=1;
        pidloop(10,15)=1;
        pidloop(10,20)=1;
        set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apcon1_close,'BackgroundColor',[1 0 0]);
        set(handles.apcon2_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apcon2_close,'BackgroundColor',[1 0 0]);
        set(handles.apcon3_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apcon3_close,'BackgroundColor',[1 0 0]);
        set(handles.apcon4_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apcon4_close,'BackgroundColor',[1 0 0]);
        set(handles.pushbutton107,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.pushbutton108,'BackgroundColor',[1 0 0]);

        %% 烟温以及压力开关全部关闭
        pidloop(10,7)=1;
        pidloop(10,8)=1;
        pidloop(10,9)=1;
        pidloop(10,10)=1;
        pidloop(10,11)=1;
        pidloop(10,12)=1;
        pidloop(10,13)=1;
        pidloop(10,14)=1;
        pidloop(10,17)=1;
        pidloop(10,18)=1;
        pidloop(10,19)=1;
        pidloop(10,22)=1;
        pidloop(10,23)=1;
        pidloop(10,24)=1;
        pidloop(10,25)=1;
        pidloop(10,26)=1;

        set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tsc1_close,'BackgroundColor',[1 0 0]);
        set(handles.tsc2_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tsc2_close,'BackgroundColor',[1 0 0]);
        set(handles.tsc3_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tsc3_close,'BackgroundColor',[1 0 0]);
        set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tsc4_close,'BackgroundColor',[1 0 0]);
        set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tsc4_close,'BackgroundColor',[1 0 0]);
        set(handles.pushbutton109,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.pushbutton110,'BackgroundColor',[1 0 0]);
        set(handles.air_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.air_pressure_close,'BackgroundColor',[1 0 0]);
% % %         set(handles.gas_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
% % %         set(handles.gas_pressure_close,'BackgroundColor',[1 0 0]);
        %% 空燃比开关全部关闭
        gap_on=[0;0;0;0;0];
        pidloop(10,4)=1;
        pidloop(10,5)=1;
        pidloop(10,6)=1;
        pidloop(10,16)=1;
        pidloop(10,21)=1;
        set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gapon1_close,'BackgroundColor',[1 0 0]);
        set(handles.gapon2_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gapon2_close,'BackgroundColor',[1 0 0]);
        set(handles.gapon3_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gapon3_close,'BackgroundColor',[1 0 0]);
        set(handles.gapon4_open,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gapon4_close,'BackgroundColor',[1 0 0]);
        set(handles.pushbutton113,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.pushbutton114,'BackgroundColor',[1 0 0]);
       
       tete = lasterror.message;
       fiderror = fopen('logFile.txt','a+');
       fprintf(fiderror,'%s\n',tete);
       for e=1:length(lasterror.stack)
           fprintf(fiderror,'%s at %i at %s \n',lasterror.stack(e).name, lasterror.stack(e).line,datestr(clock));
       end
       fclose(fiderror);
       
       
       %%定期清理数据
       %获取星期
       weekdayNum = weekday(date);
       
       %复位
       if weekdayNum ~= 3
           cleanOnce = 0;
       end
       % 周二清理所有.mat文件；3表示周二
       if weekdayNum == 3 && cleanOnce == 0
           cleanOnce = 1;
            % 设置文件夹路径，根目录
           folderPath = pwd;
           % 获取文件夹内所有.mat文件，这里需要将文件属性显示后缀，不能隐藏！！！
           matFiles = dir(fullfile(folderPath, '*.mat'));
           for k = 1:length(matFiles)
               if (strcmp(matFiles(k).name,'bak.mat') == 1 || strcmp(matFiles(k).name,'key.mat') == 1)
                   continue;
               end
               filePath = fullfile(folderPath, matFiles(k).name);
               delete(filePath);
           end
       end
       
end