function onTimer_io_4duan (obj, event,handles)
global group tempdata data itemset processtime tempdatavalue A B P yr workpoint apc_on airgaspotial 
global gpc_a gpc_lmd gap_on lastsave daobj pidloop deadzone gasmean 
global temp_open tempu upid_old b  loopnum tsp yy
global airmv gasmv flow_max flow_min gas_valve_max gas_valve_min air_valve_max air_valve_min meiyan_valve_max meiyan_valve_min kongyan_valve_max kongyan_valve_min fengji_valve_min fengji_valve_max
global ts upid yp u1 u2 u3 u4 up alarm_button_clicked alarm_sound_flag alarm_timer
global fcepress kongyan1prop kongyanprop meiyanprop addmvsign meiqizongfa_valve_max meiqizongfa_valve_min
global jureresult_g jureresult_a overtoptimes
global flowsetoff flowsetoffswitch flowsetoffflag choose_fj
global famen_ok famen_shang_xia airgaspotialos2
global air_temp gas_temp air_temp1 gas_temp1 airgaspotialos1
global temp1_flag temp2_flag temp3_flag temp4_flag agp1_set1 agp2_set1
global temp_sort temp_sort1 luyabili tp1 tp2 luyabili_a krb1 krb2 krb3
global huanxiang_first gas_first air_first airpv gas_second air_second huanxiang_second air_pressure_huanxiang
global wait_warm wait_minutes wait_minutes1 man1 man2 man3 hours minutes seconds
global flow_max1 flow_max2 flow_max3 flow_min1 flow_min2 flow_min3 runTime1 runTimeBili
global dengwen luya_press steel_num steeldata Value_open air_stop gas_stop runTime
global kongyan_kp kongyan_ki meiyan_kp meiyan_ki  air_kp air_ki gas_kp gas_ki gas_gpc_lmd gas_gpc_a  air_kp_da air_ki_da gas_kp_da gas_ki_da gas_gpc_lmd_da gas_gpc_a_da 
global fengji_canshu luya_canshu temp_buchang flow_buchang ts1 ts2 ts3 junheng_time jia_er_temp jun_re_temp time_clock1 during_time
%%%%%%%%%%%%%%%%%%这里注意每段打开自动控制时，需要保证OPC server端的组态原自动置空看这个temp_open变化逻辑%%%%%%%%%%%%%%%%
tic
tempdata = read(group);               % length(tempdata) = 53
[~, b] = size(data);                  % a = 53
for k = 1:length(tempdata)            % Wincc中的各变量值
    data(k,b+1)=tempdata(k).Value;
    tempdatavalue(k)=tempdata(k).Value;
end
a=length(itemset);                  % a = 53
% for k=1:6                           % 三段煤气和空气设定值
%     data(a+k,b+1)=pidloop(1,k);
% end
% time_set=data(25,b+1);  %换向标志位
% time_count=data(9,b+1);  %1加换向时间
fcepress = data(50,b+1);  %炉膛压力
%% 读取参数
val=1;
if 0 == mod(b,30)
    steeldata=xml_read('steel_set.xml');
end 
time_clock1 = steeldata.common(1,1).parameter.ATTRIBUTE.initime;
flowsetoff=steeldata.common(val,1).parameter.ATTRIBUTE.flowsetoff;
flowsetoffswitch=steeldata.common(val,1).parameter.ATTRIBUTE.flowsetoffswitch;
% 煤气流量上下限
% flow_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.flow4_max;
% flow_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.flow4_min;
% flow_max(3) = steeldata.common(val,1).parameter.ATTRIBUTE.flow3_max;
% flow_max(2) = steeldata.common(val,1).parameter.ATTRIBUTE.flow2_max;
% flow_max(1) = steeldata.common(val,1).parameter.ATTRIBUTE.flow1_max;
% 
% flow_min(1) = steeldata.common(val,1).parameter.ATTRIBUTE.flow1_min;
% flow_min(2) = steeldata.common(val,1).parameter.ATTRIBUTE.flow2_min;
% flow_min(3) = steeldata.common(val,1).parameter.ATTRIBUTE.flow3_min;


% 待温
if wait_warm == 1
    list = get(handles.wait_minutes,'string');
    if wait_minutes ~= str2double(list{get(handles.wait_minutes,'value')})
        wait_minutes = str2double(list{get(handles.wait_minutes,'value')});
        wait_minutes1 = wait_minutes * 60;
    end
    wait_minutes1 = wait_minutes1  - 1;    
    hours = fix(wait_minutes1/3600);
    minutes = fix(wait_minutes1/60)- hours*60;
    seconds = wait_minutes1 - hours * 3600 - minutes* 60;
    leftTime = [num2str(hours,'%02d'),'：',num2str(minutes,'%02d'),'：',num2str(seconds,'%02d')];
    set(handles.leftTime,'String',leftTime);
    
    %提前三分钟升温
   if wait_minutes1 >= 480 && wait_minutes1<=483
        %提前三分钟将温度生回来
        % 一段待温处理
        luwen1_temp = 1085;
        set(handles.T_slider1,'Value',luwen1_temp);
         set(handles.ts_1,'String',luwen1_temp);
        % 二段待温处理
        luwen2_temp = 1240;
        set(handles.T_slider2,'Value',luwen2_temp);
        set(handles.ts_2,'String',luwen2_temp);
        % 均热段待温处理
        luwen3_temp = 1260;
        set(handles.T_slider3,'Value',luwen3_temp);
        set(handles.ts_3,'String',luwen3_temp);
    elseif wait_minutes1 <= 3 
        wait_warm = 0; % 是否待温  1待温 0否
        set(handles.button_temp,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
        set(handles.leftTime1,'Visible','off');
        set(handles.leftTime,'Visible','off');
    end
end
% pid gpc 参数设置
fengji_canshu(1) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji1_kp;
fengji_canshu(2) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji1_ki;
fengji_canshu(3) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji2_kp;
fengji_canshu(4) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji2_ki;
luya_canshu(1) = steeldata.luya(val,1).parameter.ATTRIBUTE.luya_kp;
luya_canshu(2) = steeldata.luya(val,1).parameter.ATTRIBUTE.luya_ki;
liuliangfaxianfu = steeldata.luya(val,1).parameter.ATTRIBUTE.liuliangfaxianfu;
paiyanfaxianfu = steeldata.luya(val,1).parameter.ATTRIBUTE.paiyanfaxianfu;
pypidmodtime = steeldata.luya(val,1).parameter.ATTRIBUTE.pypidmodtime;

kongyan_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.flow_buchang;
jia_yi_temp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.fjl_vd;
jia_yi_temp(2) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.fjl_delvd1;
jia_yi_temp(3) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.fjl_delvd2;
jia_yi_temp(4) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.fjl_delvd3;
opc_buchang(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.opc_buchang;
air_flow_max(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_flow_max;

kongyan_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.flow_buchang;
jia_er_temp(1) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.fjl_vd;
jia_er_temp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.fjl_delvd1;
jia_er_temp(3) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.fjl_delvd2;
jia_er_temp(4) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.fjl_delvd3;
opc_buchang(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.opc_buchang;
air_flow_max(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_flow_max;

kongyan_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.flow_buchang;
jun_re_temp(1) = steeldata.junre(val,1).parameter.ATTRIBUTE.fjl_vd;
jun_re_temp(2) = steeldata.junre(val,1).parameter.ATTRIBUTE.fjl_delvd1;
jun_re_temp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.fjl_delvd2;
jun_re_temp(4) = steeldata.junre(val,1).parameter.ATTRIBUTE.fjl_delvd3;
opc_buchang(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.opc_buchang;
air_flow_max(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.air_flow_max;
%煤气阀门上下限
gas_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max1;
gas_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max2;
gas_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max3;
gas_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_max4;

gas_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min1;
gas_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min2;
gas_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min3;
gas_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.gas_valve_min4;
%空气阀门上下限
air_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max1;
air_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max2;
air_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max3;
air_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_max4;

air_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min1;
air_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min2;
air_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min3;
air_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.air_valve_min4;
%煤烟阀门上下限
meiyan_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max1;
meiyan_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max2;
meiyan_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max3;
meiyan_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_max4;

meiyan_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min1;
meiyan_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min2;
meiyan_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min3;
meiyan_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.meiyan_valve_min4;
%空烟阀门上下限
kongyan_valve_max(1)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max1;
kongyan_valve_max(2)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max2;
kongyan_valve_max(3)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max3;
kongyan_valve_max(4)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_max4;

kongyan_valve_min(1)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min1;
kongyan_valve_min(2)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min2;
kongyan_valve_min(3)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min3;
kongyan_valve_min(4)=steeldata.common(val,1).parameter.ATTRIBUTE.kongyan_valve_min4;
%助燃风机阀门上下限
fengji_valve_max=steeldata.common(val,1).parameter.ATTRIBUTE.fengji_valve_max;
fengji_valve_min=steeldata.common(val,1).parameter.ATTRIBUTE.fengji_valve_min;
%煤气总管阀门上下限
meiqizongfa_valve_max=steeldata.common(val,1).parameter.ATTRIBUTE.meiqizongfa_valve_max;
meiqizongfa_valve_min=steeldata.common(val,1).parameter.ATTRIBUTE.meiqizongfa_valve_min;
updownlimitos = steeldata.common(val,1).parameter.ATTRIBUTE.updownlimitos;
min_air_limit = steeldata.common(val,1).parameter.ATTRIBUTE.min_air_limit;

yanfaospower = steeldata.common(val,1).parameter.ATTRIBUTE.yanfaospower;
fcepresslimit = steeldata.common(val,1).parameter.ATTRIBUTE.fcepresslimit;


%炉压比例
luyabili(1)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili1_g;
luyabili(2)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili2_g;
luyabili(3)=steeldata.common(val,1).parameter.ATTRIBUTE.luyabili3_g;
luyabili_a(1) = steeldata.common(val,1).parameter.ATTRIBUTE.luyabili1_a;
luyabili_a(2) = steeldata.common(val,1).parameter.ATTRIBUTE.luyabili2_a;
luyabili_a(3) = steeldata.common(val,1).parameter.ATTRIBUTE.luyabili3_a;

junheng_time = steeldata.common(val,1).parameter.ATTRIBUTE.junheng_time;
runTimeBili=steeldata.common(val,1).parameter.ATTRIBUTE.runTimeBili;
%煤气流量上下限
flow_max(1)= flow_max1 - flow_buchang(1);
flow_max(2)= flow_max2 - flow_buchang(2);
flow_max(3)= flow_max3 - flow_buchang(3);

flow_min(1) = flow_min1;
flow_min(2) = flow_min2;
flow_min(3) = flow_min3;
%写入pidloop
%煤气上限
pidloop(11,1)=gas_valve_max(1);
pidloop(11,2)=gas_valve_max(2);
pidloop(11,3)=gas_valve_max(3);

%空气上限
pidloop(11,4)=air_valve_max(1);
pidloop(11,5)=air_valve_max(2);
pidloop(11,6)=air_valve_max(3);

%煤气下限
pidloop(12,1)=gas_valve_min(1);
pidloop(12,2)=gas_valve_min(2);
pidloop(12,3)=gas_valve_min(3);

%空气下限
pidloop(12,4)=air_valve_min(1);
pidloop(12,5)=air_valve_min(2);
pidloop(12,6)=air_valve_min(3);

%空烟上限
pidloop(11,7)=kongyan_valve_max(1);
pidloop(11,8)=kongyan_valve_max(2);
pidloop(11,9)=kongyan_valve_max(3);

%煤烟上限
pidloop(11,10)=meiyan_valve_max(1);
pidloop(11,11)=meiyan_valve_max(2);
pidloop(11,12)=meiyan_valve_max(3);


pidloop(11,13)=fengji_valve_max;
pidloop(11,14)=meiqizongfa_valve_max;
%空烟下限
pidloop(12,7)=kongyan_valve_min(1);
pidloop(12,8)=kongyan_valve_min(2);
pidloop(12,9)=kongyan_valve_min(3);

%煤烟下限
pidloop(12,10)=meiyan_valve_min(1);
pidloop(12,11)=meiyan_valve_min(2);
pidloop(12,12)=meiyan_valve_min(3);


% 炉压上下限
pidloop(12,19)=10;
pidloop(11,19)=80;

pidloop(12,13)=fengji_valve_min;
pidloop(12,14)=meiqizongfa_valve_min;


%% 获取各段温度以及压力设定值
ts1=str2double(get(handles.ts_1,'String'));   % 炉温
ts2=str2double(get(handles.ts_2,'String'));
ts3=str2double(get(handles.ts_3,'String'));
% ts1 = ts1-3;
% ts2 = ts2;
% ts3 = ts3;
ts1 = ts1 - temp_buchang(1);
ts2 = ts2 - temp_buchang(2);
ts3 = ts3 - temp_buchang(3);
smoke_tg1_set=str2double(get(handles.smoke_tg1_set,'String'));%煤烟温度设定
smoke_tg2_set=str2double(get(handles.smoke_tg2_set,'String'));
smoke_tg3_set=str2double(get(handles.smoke_tg3_set,'String'));

smoke_ta1_set=str2double(get(handles.smoke_ta1_set,'String'));%空烟温度设定
smoke_ta2_set=str2double(get(handles.smoke_ta2_set,'String'));
smoke_ta3_set=str2double(get(handles.smoke_ta3_set,'String'));

luya_set = str2double(get(handles.luya_set,'String')); %炉压设定

airgaspotialos1 = str2double(get(handles.agp1_set,'String'));
airgaspotialos2 = str2double(get(handles.agp2_set,'String'));
airgaspotialos3 = str2double(get(handles.agp3_set,'String'));

agp1_set = airgaspotialos1;
agp2_set = airgaspotialos2;
agp3_set = airgaspotialos3;

airgaspotial=[agp1_set,agp2_set,agp3_set];
air_pressure_sp=str2double(get(handles.air_pressure_sp,'String'));
gas_pressure_sp=str2double(get(handles.gas_pressure_sp,'String'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ts=[ts1;ts2;ts3];                                  %炉温设定
ta=[smoke_ta1_set;smoke_ta2_set;smoke_ta3_set];    %空烟温度
tg=[smoke_tg1_set;smoke_tg2_set;smoke_tg3_set];    %煤烟温度

data(150,b+1)=ts(1);                      %炉顶温度设定值  
data(151,b+1)=ts(2);
data(152,b+1)=ts(3);

data(154,b+1)=ta(1);                      %空烟温度设定值
data(155,b+1)=ta(2);
data(156,b+1)=ta(3);

data(158,b+1)=tg(1);                      %煤烟温度设定值
data(159,b+1)=tg(2);
data(160,b+1)=tg(3);

data(162,b+1)=air_pressure_sp;            % 空气总管压力设定值  

data(163,b+1)=airgaspotial(1);            % 空燃比设定
data(164,b+1)=airgaspotial(2);
data(165,b+1)=airgaspotial(3);

data(176,b+1)=gas_pressure_sp;            % 煤气总管压力设定值 
%% 每小时data数据更新
if b>=3900
    datetime=datestr(now,30);
%      if temp_open(2,1)==1 && temp_open(3,1)==1 %最起码二段和均热段打开时才表示自动控制记录数据，否则表示没有打开，不记录数据
        s=['save(''data',datetime(1:8),datetime(10:11),'.mat'',''data'');'];
        eval(s);
%      end

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
if temp_open(2,1)==1 || temp_open(3,1)==1 || pidloop(10,13) == 0
    runTime = runTime + 1;
    if runTimeBili <= 0        
        set(handles.runTime,'String',num2str(runTime/3600,'%.2f'));
        data(193,b+1)= runTime/3600;
    else
        runTime1 = clock;
        set(handles.runTime,'String',num2str((etime(runTime1,str2num(time_clock1))/3600 * runTimeBili)-during_time,'%.2f'));
        data(193,b+1) = (etime(runTime1,str2num(time_clock1))/3600 * runTimeBili) - during_time;
    end
end       
%% 1表示使用南侧温度  0表示使用北侧温度

if temp1_flag == 1 
    
    tp1=data(10,b+1);    %一加左侧炉顶温度
else
    tp1=data(15,b+1);  
end

if temp2_flag == 1 
    tp2=data(25,b+1);    %二加左侧炉顶温度
else
    tp2=data(30,b+1); 
end

if temp3_flag == 1 
    tp3=data(40,b+1);     %三加左侧炉顶温度
else
    tp3=data(45,b+1);
end

tp=[tp1;tp2;tp3];
%存储炉温的实际使用值
data(177,b+1) = tp1;
data(178,b+1) = tp2;
data(179,b+1) = tp3;

% 获取煤气流量
gas_flow1=data(6,b+1);
gas_flow2=data(21,b+1);
gas_flow3=data(36,b+1);
gas_flow=[gas_flow1;gas_flow2;gas_flow3];%此刻的煤气流量测量

%获取空气流量
air_flow1=data(5,b+1);
air_flow2=data(20,b+1);
air_flow3=data(35,b+1);
air_flow=[air_flow1;air_flow2;air_flow3];

%空气阀门设定值，因为反馈值不准确
air_f1=data(1,b+1);             
air_f2=data(16,b+1);            
air_f3=data(31,b+1); 
air_f=[air_f1;air_f2;air_f3];

% 煤气阀门设定值，因为反馈值不准确
gas_f1=data(3,b+1);            
gas_f2=data(18,b+1);            
gas_f3=data(33,b+1);
gas_f=[gas_f1;gas_f2;gas_f3];

pidloop(1,7)=ta(1);            %空烟温度设定值
pidloop(1,8)=ta(2);
pidloop(1,9)=ta(3);

pidloop(1,10)=tg(1);           % 煤烟设定值
pidloop(1,11)=tg(2);
pidloop(1,12)=tg(3);


%炉压设定值
pidloop(2,19)=luya_set; 

pidloop(1,13)=air_pressure_sp;  %空气总管压力设定值
pidloop(1,14)=gas_pressure_sp;  %空气总管压力设定值
  
%% 空煤烟温度采用均值
% disp('66666')
%空烟获取最大值
air_temp(1) = max(data(7,b+1),data(55,b+1));
air_temp(2) = max(data(22,b+1),data(57,b+1));
temp = [data(37,b+1),data(46,b+1),data(61,b+1),data(63,b+1),data(65,b+1)];
air_temp(3) = max(temp);
temp_sort1 = sort([data(37,b+1),data(46,b+1),data(61,b+1),data(63,b+1),data(65,b+1)]);
%煤烟选取最大值
gas_temp(1) = max(data(8,b+1),data(56,b+1));
gas_temp(2) = max(data(23,b+1),data(58,b+1));
temp1 = [data(38,b+1),data(47,b+1),data(49,b+1),data(62,b+1),data(64,b+1),data(66,b+1)];
gas_temp(3) = max(temp1);
temp_sort = sort([data(38,b+1),data(47,b+1),data(49,b+1),data(62,b+1),data(64,b+1),data(66,b+1)]);

data(167,b+1)=air_temp(1);
data(168,b+1)=air_temp(2);
data(169,b+1)=(temp_sort1(5) + temp_sort1(4))/2;

data(171,b+1)=gas_temp(1);                         %煤烟温度实际测量值
data(172,b+1)=gas_temp(2);                                
data(173,b+1)=(temp_sort(5) + temp_sort(6))/2;  

pidloop(2,7) = data(167,b+1);
pidloop(2,8) = data(168,b+1); 
pidloop(2,9) = data(169,b+1); 

pidloop(2,10) = data(171,b+1); 
pidloop(2,11) = data(172,b+1); 
pidloop(2,12) = data(173,b+1); 

%炉压滤波
luya_lvbo_time = 2; %20
if b > luya_lvbo_time
    data(75,b+1) = mean([data(75,b-luya_lvbo_time+2:b),data(50,b+1)]);
elseif b>2
    data(75,b+1)=mean([data(75,2:b),data(50,b+1)]); %下标从2开始，下标1无效   
else
    data(75,b+1)=data(50,b+1);
end
pidloop(1,19)=data(75,b+1);


%助燃风压力滤波
zhuran_lvbo_time = 6; %25
if b > zhuran_lvbo_time
    data(76,b+1) = mean([data(76,b-zhuran_lvbo_time+2:b),data(51,b+1)]);
elseif b>2
    data(76,b+1)=mean([data(76,2:b),data(51,b+1)]);   
else
    data(76,b+1)=data(51,b+1);
end
pidloop(2,13)=data(76,b+1); %下标从2开始，下标1无效

% pidloop(2,13)=data(51,b+1);                       %空气总管压力
pidloop(2,14)=data(52,b+1);                       %煤气总管压力

%测量值 存入data中
data(141,b+1) = data(6,b+1);
data(142,b+1) = data(21,b+1);
data(143,b+1) = data(36,b+1);

data(145,b+1) = data(5,b+1);
data(146,b+1) = data(20,b+1);
data(147,b+1) = data(35,b+1);

%% 煤气流量滤波
gas_lvbo_time = 8;
if b > gas_lvbo_time
    if data(141,b+1) == 0 && data(141,b)~=0
        data(141,b+1) = data(141,b);
    end
    if data(142,b+1) == 0 && data(142,b)~=0
        data(142,b+1) = data(142,b);
    end
    if data(143,b+1) == 0 && data(143,b)~=0
        data(143,b+1) = data(143,b);
    end
end
if b > gas_lvbo_time
    data(100,b+1) = mean([data(100,b-gas_lvbo_time+2:b),data(141,b+1)]);
elseif b>2
    data(100,b+1)=mean([data(100,2:b),data(141,b+1)]);   
else
    data(100,b+1)=data(141,b+1);
end
if b > gas_lvbo_time
    data(101,b+1) = mean([data(101,b-gas_lvbo_time+2:b),data(142,b+1)]);
elseif b>2
    data(101,b+1)=mean([data(101,2:b),data(142,b+1)]);   
else
    data(101,b+1)=data(142,b+1);
end
if b > gas_lvbo_time
    data(102,b+1) = mean([data(102,b-gas_lvbo_time+2:b),data(143,b+1)]);
elseif b>2
    data(102,b+1)=mean([data(102,2:b),data(143,b+1)]);   
else
    data(102,b+1)=data(143,b+1);
end
pidloop(2,1) = data(100,b+1);
pidloop(2,2) = data(101,b+1);
pidloop(2,3) = data(102,b+1);


%% 空气流量滤波
air_lvbo_time = 7;
if b > air_lvbo_time
    if data(145,b+1) == 0 && data(145,b)~=0
        data(145,b+1) = data(145,b);
    end
    if data(146,b+1) == 0 && data(146,b)~=0
        data(146,b+1) = data(146,b);
    end
    if data(147,b+1) == 0 && data(147,b)~=0
        data(147,b+1) = data(147,b);
    end
end
if b > air_lvbo_time
    data(104,b+1) = mean([data(104,b-air_lvbo_time+2:b),data(145,b+1)]);
elseif b>2
    data(104,b+1)=mean([data(104,2:b),data(145,b+1)]);   
else
    data(104,b+1)=data(145,b+1);
end
if b > air_lvbo_time
    data(105,b+1) = mean([data(105,b-air_lvbo_time+2:b),data(146,b+1)]);
elseif b>2
    data(105,b+1)=mean([data(105,2:b),data(146,b+1)]);   
else
    data(105,b+1)=data(146,b+1);
end
if b > air_lvbo_time
    data(106,b+1) = mean([data(106,b-air_lvbo_time+2:b),data(147,b+1)]);
elseif b>2
    data(106,b+1)=mean([data(106,2:b),data(147,b+1)]);   
else
    data(106,b+1)=data(147,b+1);
end
pidloop(2,4) = data(104,b+1);
pidloop(2,5) = data(105,b+1);
pidloop(2,6) = data(106,b+1);

% data(75,b+1) = pidloop(1,19);  %炉膛压力
% data(76,b+1) = pidloop(2,13);  %助燃风压力
%流量排烟阀比例 
%一加阀门比例设置
% % kongyanprop(1)=steeldata.hot(val,1).parameter.ATTRIBUTE.kongyan1_prop;
% % meiyanprop(1)=steeldata.hot(val,1).parameter.ATTRIBUTE.meiyan1_prop;   
% % %二加阀门比例设置
% % kongyanprop(2)=steeldata.hot(val,1).parameter.ATTRIBUTE.kongyan2_prop;
% % meiyanprop(2)=steeldata.hot(val,1).parameter.ATTRIBUTE.meiyan2_prop;   
% % 
% % kongyanprop(3)=steeldata.hot(val,1).parameter.ATTRIBUTE.kongyan3_prop;
% % meiyanprop(3)=steeldata.hot(val,1).parameter.ATTRIBUTE.meiyan3_prop;     


 %% 一加热段控制策略切换
if temp_open(1,1)==0
    apc_on(1)=0;
    pidloop(10,1)=1;                    % 完全关闭状态，“手动2”模式
    gap_on(1)=0;                        
   % pidloop(10,5)=1;
%    %%%%% %%% writeasync(itemset(9),2);            %这里注意关闭炉温控制时，2表示要恢复原项目的自动流量控制 (另外在断开中控时也要修改)
else 
    apc_on(1)=1;                        % 由GPC控制，“全自动”模式
    pidloop(10,1)=0;
    gap_on(1)=1;                        
   % pidloop(10,5)=0;         
%    %%%%% %%% writeasync(itemset(9),0);            %这里注意关闭炉温控制时，0表示要关闭原项目的自动流量控制
end
 
%% 二加热段控制策略切换
if temp_open(2,1)==0 
    apc_on(2)=0;
    pidloop(10,2)=1;                % 完全关闭状态，“手动2”模式
    gap_on(2)=0;
  %  pidloop(10,6)=1; 
%     %%%%% %%% writeasync(itemset(24),2);            %这里注意关闭炉温控制时，2表示要恢复原项目的自动流量控制
else
    apc_on(2)=1;
    pidloop(10,2)=0;
    gap_on(2)=1;
 %   pidloop(10,6)=0;                % 由GPC控制，“全自动”模式
%     %%%%% %%% writeasync(itemset(24),0);            %这里注意关闭炉温控制时，0表示要关闭原项目的自动流量控制
end    

%% 加三段控制策略切换
if temp_open(3,1)==0            % 完全关闭状态，“手动2”模式
    apc_on(3)=0;
    pidloop(10,3)=1;
    gap_on(3)=0;
 %   pidloop(10,7)=1;
%   %%%%% %%% writeasync(itemset(39),2);            %这里注意关闭炉温控制时，2表示要恢复原项目的自动流量控制
else                                % 由GPC控制，“全自动”模式
    apc_on(3)=1;
    pidloop(10,3)=0;
    gap_on(3)=1;
   % pidloop(10,7)=0;
%    %%%%% %%% writeasync(itemset(39),0);       %这里注意关闭炉温控制时，2表示要恢复原项目的自动流量控制
end

%% GPC计算流量设定值
% [~, na]=size(A);
% [~, nb]=size(B);  %nb=1
% na=na-1;          %na=1

%    set(handles.tp1,'String',num2str(50,'%.1f'));  
if b>10
    tsp=[ts1;ts2;ts3];      %4段的炉温设定值
    
    %针对炉顶温度异常时要剔除，防止gpc计算出现大幅偏差调整
    if temp1_flag == 1
        if abs(data(10,b+1) - data(10,b)) > 30
            data(10,b+1) = data(10,b);
        end
    else
        if abs(data(15,b+1) - data(15,b)) > 30
            data(15,b+1) = data(15,b);
        end
    end
    
    if temp2_flag == 1
         if abs(data(25,b+1) - data(25,b)) > 30
            data(25,b+1) = data(25,b);
         end
    else
         if abs(data(30,b+1) - data(30,b)) > 30
            data(30,b+1) = data(30,b);
         end
    end
    
    if temp3_flag == 1
          if abs(data(40,b+1) - data(40,b)) > 30
             data(40,b+1) = data(40,b);
          end
    else
        if abs(data(45,b+1) - data(45,b)) > 30
             data(45,b+1) = data(45,b);
         end
    end
    
     
    %这里的b-4:2:b+1间隔处理要和gpc mod时间周期匹配
    if temp1_flag == 1
         y1=data(10,b-8:3:b+1);    %3段的炉温测量值
    else
         y1=data(15,b-8:3:b+1);    %3段的炉温测量值
    end
    if temp2_flag == 1
         y2=data(25,b-8:3:b+1);
    else
         y2=data(30,b-8:3:b+1);
    end
    if temp3_flag == 1
         y3=data(40,b-8:3:b+1);
    else
         y3=data(45,b-8:3:b+1);
    end

    yp=[y1;y2;y3]; 
    
    %炉温显示
    if temp1_flag==1         
        set(handles.tp1,'String',num2str(data(10,b+1)-opc_buchang(1),'%.1f'));  
    else
        
        set(handles.tp1,'String',num2str(data(15,b+1)-opc_buchang(1),'%.1f')); 
    end
    
    if temp2_flag==1 
        set(handles.tp2,'String',num2str(data(25,b+1)-opc_buchang(2),'%.1f')); 
    else
        set(handles.tp2,'String',num2str(data(30,b+1)-opc_buchang(2),'%.1f')); 
    end
    
    if temp3_flag == 1 
        set(handles.tp3,'String',num2str(data(40,b+1)-opc_buchang(3),'%.1f'));
    else
        set(handles.tp3,'String',num2str(data(45,b+1)-opc_buchang(3),'%.1f'));
    end            
    %空烟温度显示
    set(handles.ta1,'String',num2str(round(pidloop(2,7))));
    set(handles.ta2,'String',num2str(round(pidloop(2,8)))); 
    set(handles.ta3,'String',num2str(round(pidloop(2,9)))); 
    %煤烟温度显示
    set(handles.tg1,'String',num2str(round(pidloop(2,10))));              
    set(handles.tg2,'String',num2str(round(pidloop(2,11))));
    set(handles.tg3,'String',num2str(round(pidloop(2,12)))); 
    
    set(handles.style_temp,'String',num2str(data(72,b+1),'%.1f')); %入炉钢坯温度
    set(handles.gas_value,'String',num2str(data(71,b+1),'%.0f'));  % 煤气热值
    set(handles.air_pressure_p,'String',num2str(data(51,b+1),'%.2f'));   %保留2位小数
    set(handles.text122,'String',num2str(data(76,b+1),'%.2f'));       %空气压力实际值
    set(handles.pressure_p,'String',num2str(data(75,b+1),'%.2f'));
    
        % 存入空燃比数据
    data(181,b+1) = data(5,b+1) / data(6,b+1);
    data(182,b+1) = data(20,b+1) / data(21,b+1);
    data(183,b+1) = data(35,b+1) / data(36,b+1);
%     set(handles.agp1_p,'String',num2str(pidloop(2,4)/pidloop(2,1),'%.2f')); %空燃比显示
%     set(handles.agp2_p,'String',num2str(pidloop(2,5)/pidloop(2,2),'%.2f'));
%     set(handles.agp3_p,'String',num2str(pidloop(2,6)/pidloop(2,3),'%.2f'));
    
    set(handles.agp1_p,'String',num2str(data(181,b+1),'%.2f')); %空燃比显示
    set(handles.agp2_p,'String',num2str(data(182,b+1),'%.2f'));
    set(handles.agp3_p,'String',num2str(data(183,b+1),'%.2f'));
    
    yr=tsp-workpoint(:,1);
          
    % 煤气流量设定值
    u1=[data(131,b-8) data(131,b)]; 
    u2=[data(132,b-8) data(132,b)];       
    u3=[data(133,b-8) data(133,b)];  
    up=[u1;u2;u3];
    
    %一加GPC和模糊控制
    if temp_open(1,1)==1
        if mod(b,10)==0 
            yy=yp(1,:)-workpoint(1,1);
            u=up(1,:)-workpoint(1,2);
            tempu(1)=gpc_clac(A(1,:),B(1,:),P,yy,u,yr(1),gpc_a(1),gpc_lmd(1));
            tempu(1)=tempu(1) + workpoint(1,2);
        end
        flow_limit = 1500;
        if tempu(1) - data(131,b) >= flow_limit
            tempu(1) = data(131,b) + flow_limit;
        end

        if tempu(1) - data(131,b) <= -flow_limit
            tempu(1) = data(131,b) - flow_limit;
        end
        if tempu(1) >= flow_max(1)
            tempu(1) = flow_max(1);
        end               
        if tempu(1) <= flow_min(1)
            tempu(1) = flow_min(1);
        end        
    end

    %二加GPC和模糊控制
    if temp_open(2,1)==1
        if mod(b,10)==0 % &&wait_on(2,1)==0
            yy=yp(2,:)-workpoint(2,1);
            u=up(2,:)-workpoint(2,2);
            tempu(2)=gpc_clac(A(2,:),B(2,:),P,yy,u,yr(2),gpc_a(2),gpc_lmd(2));
            tempu(2)=tempu(2) + workpoint(2,2);
        end
        flow_limit = 1500;
        if tempu(2) - data(132,b) >= flow_limit
            tempu(2) = data(132,b) + flow_limit;
        end

        if tempu(2) - data(132,b) <= -flow_limit
            tempu(2) = data(132,b) - flow_limit;
        end
        if tempu(2) >= flow_max(2)
            tempu(2)=flow_max(2);
        end               
        if tempu(2)<=flow_min(2)
            tempu(2)=flow_min(2);
        end
    end

    %三加GPC和模糊控制
    if temp_open(3,1)==1
        if mod(b,10)==0 % &&wait_on(2,1)==0
            yy=yp(3,:)-workpoint(3,1);
            u=up(3,:)-workpoint(3,2);
            tempu(3)=gpc_clac(A(3,:),B(3,:),P,yy,u,yr(3),gpc_a(3),gpc_lmd(3));
            tempu(3)=tempu(3) + workpoint(3,2);
        end
        flow_limit = 1500;
        if tempu(3) - data(133,b) >= flow_limit
            tempu(3) = data(133,b) + flow_limit;
        end

        if tempu(3) - data(133,b) <= -flow_limit
            tempu(3) = data(133,b) - flow_limit;
        end
        if tempu(3) >= flow_max(3)
            tempu(3)=flow_max(3);
        end               
        if tempu(3)<=flow_min(3)
            tempu(3)=flow_min(3);
        end
    end
end

%% 滤波的目的是为了求得煤气流量实时值，方便配比空燃比求得空气流量
for i=1:3
    if tempu(i) == 0
        tempu(i) = data(99+i,b+1);
    end
    airsp(i)=tempu(i).*airgaspotial(i);
    if airsp(i)<=min_air_limit  %空气流量不能低于2000
        airsp(i)=min_air_limit;
    end
end
if gap_on(1)==1
    pidloop(1,4)=airsp(1);
    data(135,b+1)=airsp(1);
end
if gap_on(2)==1
    pidloop(1,5)=airsp(2);
    data(136,b+1)=airsp(2);
end
if gap_on(3)==1
    pidloop(1,6)=airsp(3);
    data(137,b+1)=airsp(3);
end

%% 抗饱和处理
if b >= 8 
    %%解决控制器下限饱和
    airmv=[data(1,b+1);data(16,b+1);data(31,b+1)];    %空气阀设定
    gasmv=[data(3,b-3:b+1);data(18,b-3:b+1);data(33,b-3:b+1)];     %煤气阀设定
    airpv=[pidloop(2,4);pidloop(2,5);pidloop(2,6)];              %空气流量测量
    for i=1:3   
        if apc_on(i)==1
            switch i
                case 1
                    pidloop(1,1)=tempu(i);
                    if (tp1 < ts1)&&(data(100,b+1) <flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i)-1)==5)   % 当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零                       
                        pidloop(1,1)=data(100,b+1);                 % 此时相当于阀门全开，基本就限定在100%了
                        tempu(i)=data(100,b+1);                     % 煤气总管压力小的时候可以，但当总管压力大时会导致煤气流量很大
                    end
                    if (tp1 >= ts1)&&(sum(gasmv(i,:)<=gas_valve_min(i)+0.5)==5)    % 当实际温度大于设定温度时且煤气阀门连续五秒为零时，煤气设定值等于实际值 ，此时PID输出为零               
                        pidloop(1,1)=data(100,b+1);
                        tempu(i)=data(100,b+1);
                    end
                    if (tp1 >= ts1)&&(sum(airmv(i)<air_valve_min(i)+0.5)==1)
                        pidloop(1,4)=data(104,b+1);
                        tempu(i)=data(104,b+1)/airgaspotial(i);
                        pidloop(1,1)= tempu(i);
                    end
                    if (airmv(i)>=air_valve_max(i)-1)&&(tempu(i)>=airpv(i)/airgaspotial(i))     % 当空气阀开度为100且煤气设定值乘以空燃比大于空气最大流量时...
                        pidloop(1,1)=airpv(i)/airgaspotial(i);
                        tempu(i)=airpv(i)/airgaspotial(i);%避免空气不足引发降低煤气的情况
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,4)=airsp(i);
                        pidloop(2,4)=pidloop(1,4);
                    end
                    if tempu(i)*airgaspotial(i)>=air_flow_max(i)
                        pidloop(1,1)=air_flow_max(i)/airgaspotial(i);
                        tempu(i)=pidloop(1,1);%避免空气不足引发降低煤气的情况
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,4)=airsp(i);
                        pidloop(2,4)=pidloop(1,4);
                    end
                    airsp(i)=tempu(i).*airgaspotial(i);
                    if airsp(i)<=min_air_limit  %空气流量不能低于2000
                        airsp(i)=min_air_limit;
                    end
                    pidloop(1,4)=airsp(i); 
                    data(135,b+1)=airsp(i);
                    if tempu(i) == 0
                        data(131,b+1)=data(100,b+1);
                    else
                        data(131,b+1)=tempu(i);
                    end   
                case 2                  
                    pidloop(1,2)=tempu(i);
                    if (tp2 < ts2)&&(data(101,b+1) <flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i)-1)==5)   % 当实际温度小于设定温度时且煤气阀门连续五秒为100时，煤气设定值等于实际值 ，此时PID输出为零
                        pidloop(1,2)=data(101,b+1);                 % 此时相当于阀门全开，基本就限定在100%了
                        tempu(i)=data(101,b+1);                     % 煤气总管压力小的时候可以，但当总管压力大时会导致煤气流量很大
                    end
                    if (tp2 >= ts2)&&(sum(gasmv(i,:)<=gas_valve_min(i)+0.5)==5)    % 当实际温度大于设定温度时且煤气阀门连续五秒为零时，煤气设定值等于实际值 ，此时PID输出为零               
                        pidloop(1,2)=data(101,b+1);
                        tempu(i)=data(101,b+1);
                    end
                    if (tp2 >= ts2)&&(sum(airmv(i)<air_valve_min(i)+0.5)==1)
                        pidloop(1,5)=data(105,b+1);
                        tempu(i)=data(105,b+1)/airgaspotial(i);
                        pidloop(1,2)= tempu(i);
                     end
                    if (airmv(i)>=air_valve_max(i)-1)&&(tempu(i)>=airpv(i)/airgaspotial(i))     % 当空气阀开度为100且煤气设定值乘以空燃比大于空气最大流量时...
                        pidloop(1,2)=airpv(i)/airgaspotial(i);
                        tempu(i)=airpv(i)/airgaspotial(i);
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,5)=airsp(i);
                        pidloop(2,5)=pidloop(1,5);
                    end
                    if tempu(i)*airgaspotial(i)>=air_flow_max(i)
                        pidloop(1,2)=air_flow_max(i)/airgaspotial(i);
                        tempu(i)=pidloop(1,2);
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,5)=airsp(i);
                        pidloop(2,5)=pidloop(1,5);
                    end
                    airsp(i)=tempu(i).*airgaspotial(i);
                    if airsp(i)<=min_air_limit  %空气流量不能低于2000
                        airsp(i)=min_air_limit;
                    end
                    pidloop(1,5)=airsp(i);  
                    data(136,b+1)=airsp(i);
                    %data(132,b+1)=tempu(i);                       
                    if tempu(i) == 0
                        data(132,b+1)=data(101,b+1);
                    else
                        data(132,b+1)=tempu(i);
                    end
                case 3
                    pidloop(1,3)=tempu(i);
                    if (tp3 < ts3)&&(data(102,b+1) <flow_max(i))&&(sum(gasmv(i,:)>=gas_valve_max(i)-1)==5)
                        pidloop(1,3)=data(102,b+1);
                        tempu(i)=data(102,b+1);
                    end
                    if (tp3 >= ts3)&&(sum(gasmv(i,:)<gas_valve_min(i)+0.5)==5)
                        pidloop(1,3)=data(102,b+1);
                        tempu(i)=data(102,b+1);
                    end
                    if (tp3 >= ts3)&&(sum(airmv(i)<air_valve_min(i)+0.5)==1)
                        pidloop(1,6)=data(106,b+1);
                        tempu(i)=data(106,b+1)/airgaspotial(i);
                        pidloop(1,3)= tempu(i);
                    end
                     if (airmv(i)>=air_valve_max(i)-1)&&(tempu(i)>=airpv(i)/airgaspotial(i))    % 与二加的处理一样，解决了二加和均热自动失效的问题
                        pidloop(1,3)=airpv(i)/airgaspotial(i);
                        tempu(i)=airpv(i)/airgaspotial(i);
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,6)=airsp(i);
                        pidloop(2,6)=pidloop(1,6);
                     end
                    if tempu(i)*airgaspotial(i)>=air_flow_max(i)
                        pidloop(1,3)=air_flow_max(i)/airgaspotial(i);
                        tempu(i)=pidloop(1,3);
                        airsp(i)=tempu(i).*airgaspotial(i);
                        pidloop(1,6)=airsp(i);
                        pidloop(2,6)=pidloop(1,6);
                    end
                    airsp(i)=tempu(i).*airgaspotial(i);
                     if airsp(i)<=min_air_limit  %空气流量不能低于2000
                          airsp(i)=min_air_limit;
                    end
                    pidloop(1,6)=airsp(i);  
                    data(137,b+1) = airsp(i);
                    %data(133,b+1)=tempu(i);
                    if tempu(i) == 0
                        data(133,b+1)=data(102,b+1);
                    else
                        data(133,b+1)=tempu(i);
                    end           
                otherwise
                    'error from switch';
            end
        end
    end
end
% disp('22222')
%% 无扰切换处理
%SP跟随PV MV跟随手动值
loopnum=19;
for i=1:loopnum
    switch i
        case 1
            if pidloop(10,i)==1                 %一加煤气设定
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(3,b+1);
                upid_old(i)=pidloop(3,i);
                data(131,b+1)=data(100,b+1);      %一加煤气流量设定值
                tempu(i) = pidloop(2,i);       %%!!!!这里防止tempu进行gpc计算时初始值为0，导致打开控制按钮瞬间波动变0
            end
        case 2
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(18,b+1);
                upid_old(i)=pidloop(3,i);
                data(132,b+1)=data(101,b+1); 
                tempu(i) = pidloop(2,i);
            end
        case 3
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(33,b+1);
                upid_old(i)=pidloop(3,i);
                data(133,b+1)=data(102,b+1); 
                tempu(i) = pidloop(2,i);
            end
        case 4                                  %一加空气设定
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(1,b+1);
                upid_old(i)=pidloop(3,i);
                data(135,b+1)=data(104,b+1); 
                airsp(1) = pidloop(2,i);
            end
        case 5
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(16,b+1);
                upid_old(i)=pidloop(3,i);
                data(136,b+1)=data(105,b+1); 
                airsp(2) = pidloop(2,i);
            end
        case 6
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(31,b+1);
                upid_old(i)=pidloop(3,i);
                data(137,b+1)=data(106,b+1); 
                airsp(3) = pidloop(2,i);
            end
        case 7                                  %一加空烟设定
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(11,b+1);
                upid_old(i)=pidloop(3,i);
            end
        case 8
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(26,b+1);
                upid_old(i)=pidloop(3,i);
            end
        case 9
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);              
                pidloop(3,i)=data(41,b+1);
                upid_old(i)=pidloop(3,i);
            end
        case 10                                  %一加煤烟设定
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(13,b+1);
                upid_old(i)=pidloop(3,i);
            end
        case 11
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(28,b+1);  
                upid_old(i)=pidloop(3,i);
            end
        case 12
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                pidloop(3,i)=data(43,b+1);   
                upid_old(i)=pidloop(3,i);
            end
        case 13                                  %助燃风机设定
            if pidloop(10,i)==1
                pidloop(1,i)=pidloop(2,i);
                if choose_fj == 1
                    pidloop(3,i)=data(53,b+1);
                elseif choose_fj == 2
                    pidloop(3,i)=data(54,b+1);
                end
                upid_old(i)=pidloop(3,i);
            end
%         case 14                                  %煤气总管调节阀设定
%             if pidloop(10,i)==1
%                 pidloop(1,i)=pidloop(2,i);
%                 pidloop(3,i)=data(55,b+1);
%                 upid_old(i)=pidloop(3,i);
%             end
    end
end    

%% 计算PID控制量
[~, loopnum]=size(pidloop);
for i=1:loopnum
    pidloop(4,i)=pidloop(1,i)-pidloop(2,i);
end 
% upid=zeros(1,loopnum);

%% 各控制量的PID计算式
%一加空烟煤烟
pidloop(7,7)=kongyan_kp(1); %0.45
pidloop(8,7)=kongyan_ki(1);
pidloop(7,10)=meiyan_kp(1); %0.55
pidloop(8,10)=meiyan_ki(1);
  
%二加空烟煤烟
pidloop(7,8)=kongyan_kp(2); %0.0.35
pidloop(8,8)=kongyan_ki(2); %55
pidloop(7,11)=meiyan_kp(2); %0.32
pidloop(8,11)=meiyan_ki(2); %56

%三加空烟煤烟
pidloop(7,9)=kongyan_kp(3); %0.4
pidloop(8,9)=kongyan_ki(3); %55
pidloop(7,12)=meiyan_kp(3); %0.43
pidloop(8,12)=meiyan_ki(3); %50

%炉压pid参数
pidloop(7,19)=luya_canshu(1); %0.4
pidloop(8,19)=luya_canshu(2); %55

%风机PID
if choose_fj == 1
    pidloop(7,13)=fengji_canshu(1);
    pidloop(8,13)=fengji_canshu(2);
    pidloop(13,13)=0.1;
elseif choose_fj == 2
    pidloop(7,13)=fengji_canshu(3);
    pidloop(8,13)=fengji_canshu(4);
    pidloop(13,13)=0.1;
end

%煤气总管阀
pidloop(7,14)=8.5;
pidloop(8,14)=40;
pidloop(13,14)=0.1;

%% GPC多模型参数 (中间参数lmd更小调节作用大，两边lmd大些，作用量小些)  % 问题，这里使用CLE代替多模型？？

%% 加一段 参数调整
if ~isempty(ts) && ~isempty(yp) && abs(ts(1)-yp(1,3))>=10
    pidloop(7,1)=gas_kp_da(1);%0.0034
    pidloop(7,4)=air_kp_da(1);%0.0033
    pidloop(8,1)=gas_ki_da(1);%32
    pidloop(8,4)=air_ki_da(1);%32
    gpc_lmd(1)=gas_gpc_lmd_da(1);%0.06;%0.12
    gpc_a(1,1)=gas_gpc_a_da(1);
else
    pidloop(7,1)=gas_kp(1);%0.0034
    pidloop(7,4)=air_kp(1);%0.0033
    pidloop(8,1)=gas_ki(1);%32
    pidloop(8,4)=air_ki(1);%32
    gpc_lmd(1)=gas_gpc_lmd(1);%0.06;%0.12
    gpc_a(1,1)=gas_gpc_a(1);
end
%% 加二段
if ~isempty(ts) && ~isempty(yp) && abs(ts(2)-yp(2,3))>=10
    pidloop(7,2)=gas_kp_da(2); %0.0042
    pidloop(7,5)=air_kp_da(2); %0.004
    pidloop(8,2)=gas_ki_da(2);
    pidloop(8,5)=air_ki_da(2);
    gpc_lmd(2)=gas_gpc_lmd_da(2);%0.2;%0.072
    gpc_a(1,2)=gas_gpc_a_da(2);%0.95
else
    pidloop(7,2)=gas_kp(2); %0.0042
    pidloop(7,5)=air_kp(2); %0.004
    pidloop(8,2)=gas_ki(2);
    pidloop(8,5)=air_ki(2);
    gpc_lmd(2)=gas_gpc_lmd(2);%0.2;%0.072
    gpc_a(1,2)=gas_gpc_a(2);%0.95
end

%% 加三段
if ~isempty(ts) && ~isempty(yp) && abs(ts(3)-yp(3,3))>=10
    pidloop(7,3)=gas_kp_da(3);
    pidloop(7,6)=air_kp_da(3);
    pidloop(8,3)=gas_ki_da(3);
    pidloop(8,6)=air_ki_da(3);
    gpc_lmd(3)=gas_gpc_lmd_da(3);%0.25; %0.32
    gpc_a(1,3)=gas_gpc_a_da(3);
else
    pidloop(7,3)=gas_kp(3);
    pidloop(7,6)=air_kp(3);
    pidloop(8,3)=gas_ki(3);
    pidloop(8,6)=air_ki(3);
    gpc_lmd(3)=gas_gpc_lmd(3);%0.25; %0.32
    gpc_a(1,3)=gas_gpc_a(3);
end

%% 调用PID
temp_up = 155; %空煤烟温度上限
value_off = 0.97;  %空煤烟阀门每次下调幅度
mod_time = 10;% 控制周期
%温度补偿114622
luwen_temp = 6;
for i=1:loopnum 
    if i == 7
        if mod(b,pypidmodtime) == 0
            pidloop(:,i)=pid_calc(pidloop(:,i)');
            % 如果烟温最大值超过160， 阀位降低 30%;
            if mod(b,mod_time) == 0 && air_temp(1) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
                pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
        end
    elseif i == 8
        if mod(b,pypidmodtime) == 0
            pidloop(:,i)=pid_calc(pidloop(:,i)');
            % 如果烟温最大值超过160， 阀位降低 30%;
            if mod(b,mod_time) == 0 && air_temp(2) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
                pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
        end
     elseif i == 9
         if mod(b,pypidmodtime) == 0
            pidloop(:,i)=pid_calc(pidloop(:,i)');
             % 如果烟温最大值超过160， 阀位降低 30%;
            if mod(b,mod_time) == 0 && air_temp(3) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
               pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
         end
    elseif i == 10
        if mod(b,pypidmodtime) == 0
             %这里添加上排烟阀波动调节范围要在空气、煤气阀上下20个阀位，防止过大、过小；波动太大
            pidloop(:,i)=pid_calc(pidloop(:,i)');
             % 如果烟温最大值超过160， 阀位降低 30%;
            if mod(b,mod_time) == 0 && gas_temp(1) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
                pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
        end
    elseif i == 11
        if mod(b,pypidmodtime) == 0
             %这里添加上排烟阀波动调节范围要在空气、煤气阀上下20个阀位，防止过大、过小；波动太大
            pidloop(:,i)=pid_calc(pidloop(:,i)');
             % 如果烟温最大值超过160， 阀位降低 30%;
            if  mod(b,mod_time) == 0 && gas_temp(2) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
                 pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
        end
    elseif i == 12
        if mod(b,pypidmodtime) == 0
             %这里加三段添加上排烟阀波动调节范围要在空气、煤气阀上下20个阀位，防止过大、过小；波动太大
            pidloop(:,i)=pid_calc(pidloop(:,i)');
             % 如果烟温最大值超过160， 阀位降低 30%;
            if mod(b,mod_time) == 0 && gas_temp(3) >= temp_up
                pidloop(3,i) = pidloop(3,i) - 4;
            end
            if pidloop(3,i) < pidloop(12,i)
                pidloop(3,i) = pidloop(12,i);
            end
            if pidloop(3,i) > pidloop(11,i)
                pidloop(3,i) = pidloop(11,i);
            end
            upid(i)=pidloop(3,i);
        end
    else
        pidloop(:,i)=pid_calc(pidloop(:,i)');
        upid(i)=pidloop(3,i);
    end
end

%% 对煤气空气流量每次调节进行限幅
Value_open = [data(3,b),data(18,b),data(33,b),data(1,b),data(16,b),data(31,b)];
% Value_open = [data(4,b),data(19,b),data(34,b),data(2,b),data(17,b),data(32,b)];
up_val = liuliangfaxianfu;
down_val = liuliangfaxianfu;
for i = 1:3
    if upid(i) - Value_open(i) >=up_val
        switch i
            case 1
                if data(6,b+1) < flow_max(i)
                    upid(i) = Value_open(i)+up_val;
                else
                    upid(i) = Value_open(i);
                end
            case 2
                if data(21,b+1) < flow_max(i)
                    upid(i) = Value_open(i)+up_val;
                else
                    upid(i) = Value_open(i);
                end
            case 3
                if data(36,b+1) < flow_max(i)
                    upid(i) = Value_open(i)+up_val;
                else
                    upid(i) = Value_open(i);
                end
        end       
    elseif upid(i) - Value_open(i) <= -down_val
        upid(i) = Value_open(i) - down_val;        
    end
end
for i = 4:6
    if upid(i) - Value_open(i) >=(up_val+2) %升空气时大些，保证空燃比充分
        upid(i) = Value_open(i)+(up_val+2);
    elseif upid(i) - Value_open(i) <= -(down_val-1)%降空气时小些，保证空燃比充分
        upid(i) = Value_open(i) - (down_val-1);  
    end
end
%对排烟阀阀位变化限幅
Value_open2 = [data(11,b+1),data(26,b+1),data(41,b+1),data(13,b+1),data(28,b+1),data(43,b+1)];
up_val2 = paiyanfaxianfu;
down_val2 = paiyanfaxianfu;
for i = 7:12
    if upid(i) - Value_open2(i-6) >=up_val2
        upid(i) = Value_open2(i-6)+up_val2;
    elseif upid(i) - Value_open2(i-6) <= -down_val2
        upid(i) = Value_open2(i-6) - down_val2;        
    end
end

%% 写PID控制量
for i=1:loopnum
    switch i
        case 1                                                  %一加煤气
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(3,round(upid(i)),gas_valve_max(1),gas_valve_min(1));
                end
                upid_old(i)=data(3,b+1);
            end
        case 2
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                    P_write(18,round(upid(i)),gas_valve_max(2),gas_valve_min(2));
                end
                upid_old(i)=data(18,b+1);
            end
        case 3
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(1)
                     P_write(33,round(upid(i)),gas_valve_max(3),gas_valve_min(3));
                end
                upid_old(i)=data(33,b+1);
            end
        case 4                                                  %一加空气
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                      P_write(1,round(upid(i)),air_valve_max(1),air_valve_min(1));
                end
                upid_old(i)=data(1,b+1);
            end
        case 5
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                   P_write(16,round(upid(i)),air_valve_max(2),air_valve_min(2));
                end
                upid_old(i)=data(16,b+1);
            end
        case 6
            if (mod(b,2)==0)&&pidloop(10,i)==0
                if abs(upid(i)-upid_old(i))>=deadzone(2)
                    P_write(31,round(upid(i)),air_valve_max(3),air_valve_min(3));
                end
                upid_old(i)=data(31,b+1);
            end
        case 7                                                 %一加空烟
            if (mod(b,10)==0)&& pidloop(10,i)==0 %abs(upid(i)-upid_old(i))>=deadzone(3) 
               if  upid(i) < 0
                   upid(i) = 0;
               end
               
               zhi = upid(i) * (1-luyabili_a(1)) +upid(19)* luyabili_a(1);
                 P_write(11,round(zhi),kongyan_valve_max(1),kongyan_valve_min(1));
                 upid_old(i)=zhi;
            end
        case 8
            if (mod(b,10)==0)&& pidloop(10,i)==0 
               zhi = upid(i) * (1-luyabili_a(2)) +upid(19)* luyabili_a(2);
                  P_write(26,round(zhi),kongyan_valve_max(2),kongyan_valve_min(2));
                 upid_old(i)=zhi;
            end
        case 9         
            if(mod(b,10)==0)&& pidloop(10,i)==0 
                zhi = upid(i) * (1-luyabili_a(3)) +upid(19)* luyabili_a(3);
                 P_write(41,round(zhi),kongyan_valve_max(3),kongyan_valve_min(3));
                 upid_old(i)=zhi;
            end         
        case 10                                                 %一加煤烟
            if (mod(b,10)==0)&& pidloop(10,i)==0 
                zhi = upid(i) * (1-luyabili(1)) +upid(19)* luyabili(1);
                 P_write(13,round(zhi),meiyan_valve_max(1),meiyan_valve_min(1));
                 upid_old(i)=zhi;
            end
        case 11
            if (mod(b,10)==0)&& pidloop(10,i)==0 
                zhi = upid(i) * (1-luyabili(2)) +upid(19)* luyabili(2);
                 P_write(28,round(zhi),meiyan_valve_max(2),meiyan_valve_min(2));
                upid_old(i)=zhi;
            end
        case 12
            if (mod(b,10)==0)&& pidloop(10,i)==0 
                 zhi = upid(i) * (1-luyabili(3)) +upid(19)* luyabili(3);
                 P_write(43,round(zhi),meiyan_valve_max(3),meiyan_valve_min(3));
                 upid_old(i)=zhi;
            end
        case 13                                                 %助燃风
            if pidloop(10,i)==0 
                if choose_fj == 1
                     P_write(53,round(upid(i)),fengji_valve_max,fengji_valve_min);
                elseif choose_fj == 2
                     P_write(54,round(upid(i)),fengji_valve_max,fengji_valve_min);
                end
            end
            upid_old(i)=pidloop(3,i);
        case 14                                                 %煤气总管
            if pidloop(10,i)==0 %&& (mod(b,2)==0)%if abs(upid(i)-upid_old(i))>=deadzone(3)
                 %%% write(itemset(72),round(upid(i)));
            end
            upid_old(i)=pidloop(3,i);
    end
end
% disp('4444444')
processtime=toc;
end