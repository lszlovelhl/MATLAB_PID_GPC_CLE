function on_timer(obj,event,handles)
global daobj group   lastsave  data b tempdata tempdatavalue itemset pidloop upid 
global shengliao_junliao_on u_decomposing_furnace_tempr_write decomposing_furnace_tempr_on
global workpoint Up  A B P gpc_a gpc_lmd  first_time_connect_flag_ontimer  
global u_decomposing_furnace_tempr workpoint2 A2 B2 u_write shengliao_qiankui
global coalklinpresp coalklin_on pophandles coaljunhua_sign chongban_flow_sp 
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS 
global snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS wlc_weight_upperlimitS 
global wlc_weight_lowerlimitS alarm_sound_flag alarm_button_clicked alarm_timer sign_furnace_pressure
global yout1 Up1 gpc_decomposing_furnace_tempr_1_sp decomposing_furnace_tempr_1_sp paramdata
global blj_freqMAX blj_freqMIN yaotou_coalMAX yaotou_coalMIN yaowei_coalMAX yaowei_coalMIN NH3_MAX NH3_MIN
global NOX_SP NOX_upperlimits NOX_lowerlimits NOX_PV flag sign_NH3 workpoint3 A3 B3 NH3_limit NOX_limit
global u_NH3 sign_NH3_ctrl Up3 yout3 gpc_a3 gpc_lmd3 first data1 junhua_MAX junhua_MIN anshui_wentai 
global gaowenfengji_MAX gaowenfengji_MIN frequency_pressure_sp
global temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma delta_3cf
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1 gaowenfengji_rati
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2 wei_toucaol_rati gaowenfengji_compensate
global junhua_alpha junhua_beta junhua_gamma gwfj_alpha gwfj_beta gwfj_gamma 
global NH3_alpha1 NH3_beta1 NH3_gamma1 NH3_alpha2 NH3_beta2 NH3_gamma2
global B4 A4 workpoint4 gpc_a4 gpc_lmd4 ecfw_on blj_speed_stop_flag man_in_fjl
global slqkxs scfqkxs blj_low_time_cnt blj_low_pressure blj_high_speed man_in_blj man_zhuansu
global man_weimei man_toumei man_in_ydl pressure_vd yachuang_mv zhuansu_mid
global kypcnt kypcntflag ydlDBH ydlUBH ydlBHcnt ydlBHFlag gui_fjlT_sp
global ecfw_spcnt ecfw_sp ecfw_cnt_inner_sp
%% 获取OPC中各变量的值 
tic
tempdata = read(group);              % length(tempdata) = 35
[~, b] = size(data);        % b=1
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end
first_time_connect_flag_ontimer = first_time_connect_flag_ontimer - 1;
if first_time_connect_flag_ontimer<=0
   first_time_connect_flag_ontimer=0;
end    
% a = length(itemset);       %此时a=60
data1(1,b+1) = data(10,b+1);
    
%% 从xml文件中给变量赋值
if mod(b,10) == 0 %每10s读取一次xml文件
    paramdata = xml_read('param_set.xml');
end

blj_freqMAX = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.uplimit;
blj_freqMIN = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.downlimit;
pressure_vd = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.pressure_vd;
yachuang_mv = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.yachuang_mv;
zhuansu_mid = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.zhuansu_mid;
ysphfjdl = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ysphfjdl;
ysphfjdlDV = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ysphfjdlDV;
ecfw_sp = paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ecfwsp;

yaotou_coalMAX = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.uplimit;
yaotou_coalMIN = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.downlimit;
ydl_vd = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.ydl_vd;
ydl_kzzq = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.ydl_kzzq;
kypA = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.kypA;
ydlBHcntMax = paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.ydlBHcntMax;

yaowei_coalMAX = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.uplimit;
yaowei_coalMIN = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.downlimit;
slqkxs = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.slqkxs;
scfqkxs = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.scfqkxs;
fjl_vd = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.fjl_vd; 
NH3_MAX = paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.uplimit;
NH3_MIN = paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.downlimit;
junhua_MAX = paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.uplimit;
junhua_MIN = paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.downlimit;
gaowenfengji_MAX = paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.uplimit;
gaowenfengji_MIN = paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.downlimit;   
gaowenfengji_compensate = paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.compensate;   
gaowenfengji_rati = paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.rati;   

%分解炉
temp_fjl_alpha1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1;     %  稳态
temp_fjl_lambda1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1;
temp_fjl_alpha2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2;      % 大偏差
temp_fjl_lambda2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2;



%头煤压力 %更改为窑电流控制头煤喂煤
temp_toumei_alpha = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_alpha;
temp_toumei_beta = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta;
temp_toumei_gamma = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_gamma;

%篦冷机
temp_blj_alpha1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1;   % 大偏差
temp_blj_beta1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1;
temp_blj_gamma1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1;

temp_blj_alpha2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2;   % 小偏差
temp_blj_beta2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2;
temp_blj_gamma2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2;

%均化库
junhua_alpha = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_alpha;  
junhua_beta = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_beta;
junhua_gamma = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_gamma;

%高温分机
gwfj_alpha = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_alpha;  
gwfj_beta = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_beta;
gwfj_gamma = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_gamma;

%  氨水
NH3_alpha1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_alpha1;   % 内
NH3_beta1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_beta1;
NH3_gamma1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_gamma1;

NH3_alpha2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_alpha2;   % 外
NH3_beta2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_beta2;
NH3_gamma2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_gamma2;

%% 获取设定值
% ydl_sp=str2double(get(handles.gui_klin_head_tempr_sp_display,'String')); %窑电流控制头煤喂煤（原头煤压力控制头煤喂煤量）
gui_klin_head_tempr_sp=str2double(get(handles.gui_klin_head_tempr_sp_display,'String'));     %回转窑头煤压力
% decomposing_furnace_tempr_1_sp=str2double(get(handles.gui_decomposing_furnace_tempr_1_sp_display,'String'));
chongban_flow_sp=str2double(get(handles.chongban_flow_sp,'String'));
NOX_SP = str2double(get(handles.NOX_SP,'String'));
NOX_limit=NOX_SP+2;
% NH3_limit =str2double(get(handles.NH3_limit_show,'String'));   % 氨水流量（上限）设定
frequency_pressure_sp =str2double(get(handles.frequency_pressure_sp,'String')); 
% ecfw_sp = str2double(get(handles.ecfw_sp,'String'));
data(71,b + 1)=ecfw_sp;
data(74,b + 1)=gui_klin_head_tempr_sp;
data(77,b+1)=gui_fjlT_sp; %gui界面设定值
data(78,b+1)=chongban_flow_sp;
data(79,b+1)=NOX_SP;
%% 每小时data数据更新
if b >= 3900
    first=0;
    datetime = datestr(now,30);
    s = ['save(''data',datetime(1:8),datetime(10:11),'.mat'',''data'');'];
    eval(s);
    lastsave = ['data',datetime(1:8),datetime(10:11),'.mat'];
    data(1 : 6,1) = fix(clock);
    try
    data1(:,3902:7500)=[];
    catch
        first=2;
    end
    data1(2,2:3900)=data(67,2:3900);
    data( : ,2 : 301) = data( : ,3602 : 3901);
    data( : ,302 : 3901) = [];

    b = 300;
    % 根据key文件做相应处理
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

%% 氨逃逸过去一小时平均
if first==1
    data(67,b+1)=sum(data(10,2:b+1))/b;
    data1(2,b+1)=data(67,b+1);
    set(handles.NH3_escape_lvbo,'String',num2str(round(10*(data(67,b+1)))/10)); 
else
    
   data(67,b+1)=sum(data1(1,302:3901))/3600;
   data1(2,3601+b)=data(67,b+1);
   set(handles.NH3_escape_lvbo,'String',num2str(round(10*(data(67,b+1)))/10)); 
end

%% 测量值实时显示
formatSpec='%3.1f';
snd_chamber_pressure_pv_round=(round(data(1,b+1)*100))/100;   %一室篦床压力
decomposing_furnace_tempr_1_pv_round = round(10*data(11,b+1))/10;  %分解炉温度
wlc_weight_round=round(10*data(37,b+1))/10;    % 生料仓反馈值
NOX_round = round(10*data(38,b+1))/10;    % 氮氧化物含量
NOX_PV = data(38,b+1);
%斗提和高温风机转速
set(handles.NOX_PV,'String',num2str(round(10*data(38,b+1))/10,'%3.1f'));    
set(handles.frequency_pressure_pv,'String',num2str(round(100*data(9,b+1))/100,'%3.2f'));  
set(handles.gui_fan_frequency_pv_display,'String',num2str(round(100*data(32,b+1))/100,'%4.2f'));  
set(handles.gui_fan_frequency_sp_display,'String',num2str(round(100*data(31,b+1))/100,'%4.2f')); 
set(handles.system_pressure,'String',num2str(round(data(33,b+1))));  
set(handles.NH3_PV,'String',num2str(round(10*data(40,b+1))/10,'%3.1f'));
set(handles.NH3_SP,'String',num2str(round(10*data(39,b+1))/10,'%4.1f')); 
%二次风温
set(handles.gui_1st_cooler_rev_sp_display,'String',num2str(round(100*data(2,b+1))/100,'%4.2f'));
set(handles.text382,'String',num2str(round(100*data(1,b+1))/100,'%4.2f'));
% set(handles.ecfw_sp,'String',[num2str(ecfw_sp),'/',num2str(ecfw_cnt_inner_sp,'%.0f')]);
set(handles.ecfw_sp,'String',num2str(ecfw_sp));
%分解炉
set(handles.NH3_escape_pv,'String',num2str(round(10*data(10,b+1))/10));   % 氨逃逸实时值
set(handles.gui_decomposing_furnace_tempr_1_pv_display,'String',num2str(round(10*data(11,b+1))/10,'%4.1f'));
set(handles.gui_decomposing_furnace_coal_sp_display,'String',num2str(round(100*data(13,b+1))/100,'%3.2f'));      
%回转窑
set(handles.gui_klin_head_pv_display,'String',num2str(round(10*data(16,b+1))/10,'%4.1f'));   %窑头窑尾
set(handles.gui_klin_rev_pv_display,'String',num2str(round(100*data(23,b+1))/100));     %回转窑转速
set(handles.gui_klin_coal_sp_display,'String',num2str(round(100*data(18,b+1))/100,'%4.2f'));     %窑头喂煤给定
set(handles.gui_klin_coal_pv_display,'String',num2str(round(100*data(19,b+1))/100,'%4.2f'));
set(handles.gui_klin_head_tempr_pv_display,'String',num2str(round(100*data(30,b+1))/100,'%4.2f'));


%生料均化库冲板流量
set(handles.chongban_flow_pv,'String',num2str(round(10*data(28,b+1))/10,'%5.1f'));     %冲板流量测量
set(handles.shengliao_junhua_pv,'String',num2str(round(10*data(37,b+1))/10,'%3.1f'));     %均化库测量
set(handles.shengliao_junhua_sp,'String',num2str(round(10*data(36,b+1))/10,'%3.1f'));     %均化库测量
%头煤尾煤比值wei_toucaol_rati
if b<62
    wei_toucaol_rati=data(14,b+1)/data(19,b+1);
else
    wei_toucaol_rati=mean(data(14,b-58:b+1))/mean(data(19,b-58:b+1));
end
set(handles.wei_toucoal_rati,'String',num2str(round(100*wei_toucaol_rati)/100));   
data(69,b+1)=wei_toucaol_rati;
%% 警报窗口设置
try
    %% identifier:1、2、3、4分别表示21#、22#、23#、24#号炉和UpTemPv值1、2、3、4对应
    set(pophandles.text11,'String',num2str(snd_chamber_pressure_pv_round));
    set(pophandles.text10,'String',num2str(decomposing_furnace_tempr_1_pv_round));
    set(pophandles.text23,'String',num2str(wlc_weight_round));
    set(pophandles.NOX_now,'String',num2str(NOX_round));
catch
%     disp('没有打开报警设置窗口');
end

%% 获取自动控制开关信息
data(41,b+1)=sign_NH3;                      %NOx控制
data(42,b+1)=coalklin_on;                   %头煤压力控制头煤喂煤
data(43,b+1)=shengliao_junliao_on;          %下料量控制
data(45,b+1)=decomposing_furnace_tempr_on;  %分解炉出口温度控制
data(70,b+1)=ecfw_on;                       %二次风温控制
data(75,b+1)=sign_furnace_pressure;         %系统负压控制

%% 开关启动判断
%二次风温控制篦冷机转速
if 1==ecfw_on
    pidloop(10,8)=0;
else
    pidloop(10,8)=1;     
end

%下料量控制
if 1==shengliao_junliao_on
    pidloop(10,4)=0;
else
    pidloop(10,4)=1;     
end

%NOx控制
if 0==sign_NH3
    pidloop(10,6)=1;
    anshui_wentai=0;%内回路标志
end
%sign_NH3_GPC代表开启外回路GPC控制
if b>5  
    if (data(38,b+1)>NOX_limit||data(40,b+1)>NH3_limit)      % 氮氧化物pv>界面sp+2  or  氨水流量>界面上限
        data(66,b+1)=1;           %  氨水流量超标     
    else 
        data(66,b+1)=0;
    end
end
if 1==sign_NH3&&b>55
    if sum(data(66,b-48:b+1))>48
        sign_NH3_ctrl=1;
    elseif sum(data(66,b-48:b+1))<10
        sign_NH3_ctrl=0;
    end
end

%系统负压控制
if 1==sign_furnace_pressure
    pidloop(10,7)=0;
else
    pidloop(10,7)=1;
end

%窑头煤压力控制头煤喂煤
if 1==coalklin_on
    pidloop(10,2)=0;
else
    pidloop(10,2)=1;
end

%% 参数设置
% 设定值
pidloop(1,2)=gui_klin_head_tempr_sp;        %头煤压力控制头煤喂煤量
pidloop(1,4)=chongban_flow_sp;              %下料量
pidloop(2,8)=ecfw_sp;                       %二次风温（反特性）

pidloop(2,2)=data(30,b+1);
pidloop(2,4)=data(28,b+1);
pidloop(1,8)=data(16,b+1);
   
if b>=13
    pidloop(2,4)=sum(data(28,b-9:b+1))/11; %喂料量
    pidloop(1,8)=sum(data(16,b-9:b+1))/11; %二次风温
%     pidloop(2,2)=sum(data(22,b-9:b+1))/11; %窑电流
    pidloop(2,2)=sum(data(30,b-9:b+1))/11;
end
data(72,b+1) = pidloop(1,8);

data(76,b+1)=pidloop(2,2); %头煤压力

%% 头煤压力控制头煤喂煤
pidloop(7,2)=temp_toumei_alpha;%kuc    应增大 0.3
pidloop(8,2)=temp_toumei_beta;%k  10
pidloop(9,2)=temp_toumei_gamma;%kec  0.01
pidloop(11,2)=yaotou_coalMAX; 
pidloop(12,2)=yaotou_coalMIN;
pidloop(13,2)=0.005;%0.3 

%% 氨水GPC
workpoint3 = [4.505738821464533e+02,23.358848880767830];  %  氨水流量、NOX
A3 = [-0.9931, 1];
B3 = -0.001244;

if b > 13
    data(64,b+1) = sum(data(40,b-9:b+1))/11;
else
    data(64,b+1) = data(40,b+1);
end

pidloop(2,5)=data(64,b+1);
pidloop(7,5)=NH3_alpha1;%kuc   0.06
pidloop(8,5)=NH3_beta1;%k   40
pidloop(9,5)=NH3_gamma1;%kec   0.01
pidloop(13,5)=0.01;%0.3
pidloop(11,5)=NH3_MAX; %修改：根据现场调节上限   70
pidloop(12,5)=NH3_MIN;

pidloop(1,6)=data(38,b+1);
pidloop(2,6)=NOX_SP;
pidloop(7,6)=NH3_alpha2;%kuc     1.3
pidloop(8,6)=NH3_beta2;%k   20
pidloop(9,6)=NH3_gamma2;%kec  0.01
pidloop(13,6)=2;%0.3
pidloop(11,6)=700; %修改：根据现场调节上限   70
pidloop(12,6)=200; 
pidloop(13,6)=0.01;% 30

%% 生料均化
pidloop(7,4)=junhua_alpha;%kuc    0.26
pidloop(8,4)=junhua_beta;%ke    20
pidloop(9,4)=junhua_gamma;%kec   0.01

pidloop(11,4)=junhua_MAX;
pidloop(12,4)=junhua_MIN;
pidloop(13,4)=0.01;%0.3

%% 二次风温   
pidloop(7,8)=temp_blj_alpha1;%0.021;%kuc     1.3
pidloop(8,8)=temp_blj_beta1;%50;%k   20
pidloop(9,8)=temp_blj_gamma1;%0;%kec  0.01
pidloop(11,8)=blj_freqMAX;
pidloop(12,8)=blj_freqMIN;
pidloop(13,8)=0.01;% 30

%% 系统负压高温风机
pidloop(1,7)=-frequency_pressure_sp;
pidloop(2,7)=-data(9,b+1);
pidloop(7,7)=gwfj_alpha;%kuc   0.12
pidloop(8,7)=gwfj_beta;%k   40
pidloop(9,7)=gwfj_gamma;%kec  0.01

pidloop(13,7)=0.01;%0.3
pidloop(11,7)=gaowenfengji_MAX; %修改：根据现场调节上限   70
pidloop(12,7)=gaowenfengji_MIN; 

data(55,b+1)=pidloop(2,2);

%% 各段回路控制计算过程（目前共6个控制回路）
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%二次风温控制回路模块%%%%%%%%%%%%%%%%%%%%%%%%%
if 1==ecfw_on
    %控制开关启动时，设定值与实际值差值缓慢缩小过程,防止差值过大调节幅度太大
    if -1 == ecfw_spcnt %-1表示打开控制时第一次触发且只使用一次
        if ecfw_sp - pidloop(1,8) > 30 
            ecfw_cnt_inner_sp = pidloop(1,8) + 30; %二次风温反特性，1,3是测量值
        else
            ecfw_cnt_inner_sp = ecfw_sp; %二次风温内部设定值
        end
        ecfw_spcnt = 0; %排除掉-1，只是第一次使用一次
    else
        if ecfw_cnt_inner_sp < ecfw_sp
            ecfw_spcnt = ecfw_spcnt + 1;
            if ecfw_spcnt >= 300 %每5min，ecfw_cnt_inner_sp+30
                if ecfw_cnt_inner_sp < pidloop(1,8)
                    ecfw_cnt_inner_sp = pidloop(1,8) + 30; 
                else
                    ecfw_cnt_inner_sp = ecfw_cnt_inner_sp + 30; 
                end
                if ecfw_cnt_inner_sp >= ecfw_sp
                    ecfw_cnt_inner_sp = ecfw_sp;
                end
                ecfw_spcnt = 0;
            end
        else
            ecfw_cnt_inner_sp = ecfw_sp; %二次风温内部设定值
        end      
    end
    %防止出现意外，给一个安全保护
    if 0 == ecfw_cnt_inner_sp
        ecfw_cnt_inner_sp = ecfw_sp; %二次风温内部设定值
    end
    %这里注意已经将外部ecfw_sp重置为ecfw_cnt_inner_sp设定
    pidloop(2,8) = ecfw_cnt_inner_sp; %反特性 控制量由篦压变为二次风温
    
    %%一段篦冷机积分分离
    if pidloop(10,8)==0
        if ((pidloop(1,8)>=pidloop(2,8))&&(pidloop(3,8)>=blj_freqMAX))  %当测量值大于设定值时，并且阀门已经最大，反特性
            pidloop(2,8)= pidloop(1,8);
            pidloop(3,8)=blj_freqMAX;
        end

        if ((pidloop(1,8)<=pidloop(2,8))&&(pidloop(3,8)<=blj_freqMIN)) %当测量值小于设定值时，并且阀门已经最小，反特性
            pidloop(2,8)= pidloop(1,8);
            pidloop(3,8)=blj_freqMIN;
        end
    end
    %%判断是否触发红线
    if b > 30
        if (max(data(1,b-8:b+1)) > pressure_vd)...
                ||(max(data(5,b-8:b+1)) <= ysphfjdl) %一室平衡风机电流过小于61A表示不透风
            blj_speed_stop_flag = true;
        end
    end

    %触发红线则data(73,b+1)置1 
    if (blj_speed_stop_flag == true) && (mod(b,30) == 0)
        if upid(8) < blj_freqMIN
            upid(8) = blj_freqMIN + yachuang_mv;
        else
            upid(8) = upid(8) + yachuang_mv;
        end

        data(73,b+1) = 1;
        if upid(8) >= blj_freqMAX
            upid(8) = blj_freqMAX;
        end
        pidloop(3,8) = upid(8);
        blj_speed_stop_flag = false; %复位
    end

    %%二次风温控制回路
    if mod(b,10)==0 
        pidloop(:,8)=pid_calc(pidloop(:,8)');
        if blj_speed_stop_flag == false
           pidloop(3,8)=round(pidloop(3,8)*1000)/1000;%修改：根据现场调节给定精度
           upid(8)=round(pidloop(3,8)*1000)/1000;
        else
           pidloop(3,8) = upid(8);
        end
    end
    %篦冷机转速振幅,防止回中场时被限制，所以去掉振幅
%     umax = 1;
%     if (upid(8)<data(2,b+1)-umax)
%         upid(8)=data(2,b+1)-umax;
%     end
%     if (upid(8)>data(2,b+1)+umax)
%         upid(8)=data(2,b+1)+umax;
%     end
    %篦冷机转速返回中场速度，这部分不可再控制振幅之前
    if b > 300
        % 如果趋势已经发生转折，则判断为趋势到顶开始脱离危险状态
        %(min(data(1,b-8:b+1)) < min(data(1,b-18:b-9))) && (min(data(1,b-18:b-9))<min(data(1,b-28:b-19)))...
        if ((max(data(1,b-18:b+1)) < max(data(1,b-28:b-19))...
            && max(data(1,b-28:b-19))<max(data(1,b-38:b-29)))...
            || (max(data(1,b-8:b+1)) < pressure_vd))... 
            && (max(data(5,b-8:b+1)) > ysphfjdl + ysphfjdlDV)
            % 如果前五分钟内有三次及以上触发红线，则回到中场转速
            if sum(data(73,b-298:b+1)) >= 3
                % 目前转速大于中场转速，则回到中场转速，否则不管
                if upid(8) > zhuansu_mid
                    upid(8) = zhuansu_mid;
                    pidloop(3,8) = upid(8);
                end
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%二次风温控制回路模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%下料量控制模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 下料量控制
if 1==shengliao_junliao_on
    if mod(b,15)==0 && pidloop(10,4)==0
        pidloop(:,4)=pid_calc(pidloop(:,4)');
        pidloop(3,4)=round(pidloop(3,4)*100)/100;%修改：根据现场调节给定精度
        upid(4)=pidloop(3,4);
    end
    %控制振幅
    umax = 0.2;
    if upid(4)<=(data(36,b)-umax)    %%修改：根据现场实际
        upid(4)=data(36,b)-umax;      %忽略
    end
    if upid(4)>=(data(36,b)+umax)
        upid(4)=data(36,b)+umax;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%下料量控制模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%氨水内回路pid模块%%%%%%%%%%%%%%%%%%%%%%%%%
%%氨水积分分离 
if 1==sign_NH3
    if ((pidloop(1,5)>=pidloop(2,5))&&(pidloop(3,5)>=NH3_MAX)) %当设定值大于测量值时，并且阀门已经最大
        pidloop(1,5)= pidloop(2,5);
        pidloop(3,5)=NH3_MAX;
        pidloop(10,6)=1;
    else
        pidloop(10,6)=0;
    end
    if ((pidloop(1,5)<=pidloop(2,5))&&(pidloop(3,5)<=NH3_MIN)) %当设定值小于测量值时，并且阀门已经最小
        pidloop(1,5)= pidloop(2,5);
        pidloop(3,5)=NH3_MIN;
        pidloop(10,6)=1;
    else
        pidloop(10,6)=0;
    end
    %%氨水内回路pid
    if abs(NOX_SP-data(38,b+1))>2
        anshui_wentai=1;
    else
        anshui_wentai=0;
    end

    if abs(data(38,b+1)-NOX_SP)>=7
        pidloop(7,6)=1.4;%
        pidloop(7,5)=0.08;
    end
    if anshui_wentai == 1&&mod(b,8)==0&&pidloop(10,6)==0
        pidloop(:,6)=pid_calc(pidloop(:,6)'); 
        pidloop(3,6)=round(pidloop(3,6)*10)/10;
        pidloop(1,5)=pidloop(3,6);
    end
    if anshui_wentai == 1&&mod(b,8)==0 
        pidloop(:,5)=pid_calc(pidloop(:,5)');
        pidloop(3,5)=round(pidloop(3,5)*100)/100;%修改：根据现场调节给定精度
        upid(5)=pidloop(3,5);
    end
    %控制振幅
    umax = 0.3;
    if(upid(5)>=data(39,b)+umax)
        upid(5) = data(39,b)+umax;
    elseif(upid(5)<=data(39,b)-umax)
        upid(5) = data(39,b)-umax;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%氨水内回路pid模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%分解炉出口温度控制逻辑模块%%%%%%%%%%%%%%%%%%%%%%%%%
if 1==decomposing_furnace_tempr_on
    if b>4
        Up1(1)=data(63,b-2)-workpoint(1);
        Up1(2)=data(46,b)-workpoint(1);
        data(61,b+1)=data(11,b);      %分解炉出口温度            
        if b>13
            data(61,b+1)=sum(data(11,b-9:b+1))/11;     
        end
        P=[0.01,0.01;0.01,0.01];
        gpc_a=temp_fjl_alpha1;  %0.998
        gpc_lmd=temp_fjl_lambda1;  % 4400
        
        %窑电流向上向下饱和时，需程序内部自动提高后者降低分解炉温度设定值
        if 1==ydlUBH && 1==ydlBHFlag      %窑电流向上饱和
            %decomposing_furnace_tempr_1_sp 该值在gui分解炉温度滑动条滑动时更新
            decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp + 1;
            if decomposing_furnace_tempr_1_sp >= gui_fjlT_sp + 2
                decomposing_furnace_tempr_1_sp = gui_fjlT_sp + 2;
            end
            ydlBHFlag = 0; %复位
        end
        if 1==ydlDBH && 1==ydlBHFlag      %窑电流向下饱和
            decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp - 1;
            if decomposing_furnace_tempr_1_sp <= gui_fjlT_sp - 2
                decomposing_furnace_tempr_1_sp = gui_fjlT_sp - 2;
            end
            ydlBHFlag = 0; %复位
        end
        
        data(80,b+1)=decomposing_furnace_tempr_1_sp;
        
        %  分解炉出口温度1偏差过大
        if abs(decomposing_furnace_tempr_1_sp- data(61,b+1))>1.5
            gpc_a=temp_fjl_alpha2;  %0.997
            gpc_lmd=temp_fjl_lambda2;  % 3000
        end

        data(62,b+1)=decomposing_furnace_tempr_1_sp;
        gpc_decomposing_furnace_tempr_1_sp=decomposing_furnace_tempr_1_sp-workpoint(2);              
        yout1=data(61,b-1:b+1)-workpoint(2);

        if b > 30
            %趋势数据
            [mx1,mx_in1] = max(data(11,b-8:b+1)); %10s的数据间隔
            [mx2,mx_in2] = max(data(11,b-18:b-9));
            [mx3,mx_in3] = max(data(11,b-28:b-19));
            [mn1,mn_in1] = min(data(11,b-8:b+1));
            [mn2,mn_in2] = min(data(11,b-18:b-9));
            [mn3,mn_in3] = min(data(11,b-28:b-19));            
            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);

            %温度高于设定值，并且是还保持上升趋势，并且变化率扩大
            if (mn_min>=decomposing_furnace_tempr_1_sp-2) && (mod(b,30)==0)...
                    && (mx1>mx2) && (mx2>mx3) && (mn1>mn2) && (mn2>mn3)  
                delvd = 0;
                if mn_min-decomposing_furnace_tempr_1_sp>=5
                    delvd=0.006;
                elseif mn_min-decomposing_furnace_tempr_1_sp>=3
                    delvd=0.004;
                elseif mn_min-decomposing_furnace_tempr_1_sp>=2
                    delvd=0.002;
                end
                u_decomposing_furnace_tempr = data(13,b+1) - (fjl_vd + delvd);  %温度高，需要减煤
            %温度低于设定值，并且是还保持下降趋势
            elseif (mx_max<=decomposing_furnace_tempr_1_sp+2) && (mod(b,30)==0)...
                    && (mx1<mx2) && (mx2<mx3) && (mn1<mn2) && (mn2<mn3)
                delvd = 0;
                if decomposing_furnace_tempr_1_sp-mx_max>=5
                    delvd=0.006;
                elseif decomposing_furnace_tempr_1_sp-mx_max>=3
                    delvd=0.004;
                elseif decomposing_furnace_tempr_1_sp-mx_max>=2
                    delvd=0.002;
                end
                u_decomposing_furnace_tempr = data(13,b+1) + (fjl_vd + delvd);  %温度低，需要减煤
            else
                %温度处于设定值上下区间，并且是还保持波动
                %控制周期从3s更改到10s，更新A，B值
%                 A = [-0.9769,1];
%                 B = 0.8642;
                if mod(b,3)==0
                    u_decomposing_furnace_tempr=workpoint(1)+gpc_clac(A,B,P,yout1,Up1,gpc_decomposing_furnace_tempr_1_sp,gpc_a,gpc_lmd);                                
                end
            end
            ufjl = 0.02;
            if (u_decomposing_furnace_tempr<=(data(46,b)-ufjl))
                u_decomposing_furnace_tempr=data(46,b)-ufjl;
            end
            if (u_decomposing_furnace_tempr>=(data(46,b)+ufjl))
                u_decomposing_furnace_tempr=data(46,b)+ufjl;
            end
        end
    end
    %三次风温前馈
    % % % % if b > 5
    % % % %     if b > 100
    % % % %         delta_3cf_1 = data(72,b-68) - data(72,b-69);
    % % % %         delta_3cf_2 = data(72,b-69) - data(72,b-70);
    % % % %         delta_3cf_3 = data(72,b-70) - data(72,b-71);
    % % % %     else
    % % % %         delta_3cf_1 = data(72,b+1) - data(72,b);
    % % % %         delta_3cf_2 = data(72,b) - data(72,b-1);
    % % % %         delta_3cf_3 = data(72,b-1) - data(72,b-2);
    % % % %     end
    % % % %     
    % % % %     delta_3cf = delta_3cf_1 + delta_3cf_2 + delta_3cf_3;
    % % % %     if mod(b,5)==0
    % % % % %             u_decomposing_furnace_tempr = u_decomposing_furnace_tempr - delta_3cf * scfqkxs;
    % % % %     end
    % % % % end
    %煤仓仓重前馈
    set(handles.meicang_qiankui,'Visible','off');
    u_decomposing_furnace_tempr_write=u_decomposing_furnace_tempr;
    coaljunhua_sign=0;
    if b>6
        if(sum(data(35,b-4:b+1)>=1.26)==6)
            u_decomposing_furnace_tempr_write=u_decomposing_furnace_tempr-0.05;
            coaljunhua_sign=-1;
            set(handles.meicang_qiankui,'String','煤仓前馈-0.2');
            set(handles.meicang_qiankui,'Visible','on');

            if(sum(data(35,b-4:b+1)>=1.3)==6)
                u_decomposing_furnace_tempr_write=u_decomposing_furnace_tempr-0.08;
                coaljunhua_sign=-2;
                set(handles.meicang_qiankui,'String','煤仓前馈-0.3');
                set(handles.meicang_qiankui,'Visible','on');
            end
        end
    else
        if(data(35,b+1)>=1.26)
            u_decomposing_furnace_tempr_write=u_decomposing_furnace_tempr-0.05;
            coaljunhua_sign=-1;
            set(handles.meicang_qiankui,'String','煤仓前馈-0.2');
            set(handles.meicang_qiankui,'Visible','on');

            if(data(35,b+1)>=1.3)
                u_decomposing_furnace_tempr_write=u_decomposing_furnace_tempr-0.08;
                coaljunhua_sign=-2;
                set(handles.meicang_qiankui,'String','煤仓前馈-0.3');
                set(handles.meicang_qiankui,'Visible','on');
            end
        end
    end
    %生料仓前馈
    if b>11
        if abs(mean(data(28,b-9:b+1))-chongban_flow_sp)<1
            u_write=u_decomposing_furnace_tempr_write;
        else
            shengliao_qiankui=(mean(data(28,b-9:b+1))-chongban_flow_sp)*slqkxs;
            u_write=u_decomposing_furnace_tempr_write+shengliao_qiankui;
        end
    elseif b>2
        if abs(mean(data(28,2:b+1))-chongban_flow_sp)<1
            u_write=u_decomposing_furnace_tempr_write;
        else
            shengliao_qiankui=(mean(data(28,2:b+1))-chongban_flow_sp)*slqkxs;
            u_write=u_decomposing_furnace_tempr_write+shengliao_qiankui;
        end
    end
    %控制振幅
    umax = 0.02;
    if(u_write>data(13,b+1)+umax)
        u_write = data(13,b+1)+umax;
    elseif(u_write<data(13,b+1)-umax)
        u_write = data(13,b+1)-umax;
    end
    if u_write<yaowei_coalMIN
        u_write=yaowei_coalMIN;
    end
    if u_write>yaowei_coalMAX 
        u_write=yaowei_coalMAX;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%分解炉出口温度控制逻辑模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%系统负压高温风机控制模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1==sign_furnace_pressure
    if mod(b,6)==0 
       pidloop(:,7)=pid_calc(pidloop(:,7)');
       pidloop(3,7)=round(pidloop(3,7)*100)/100;%修改：根据现场调节给定精度
       upid(7)=pidloop(3,7);
    end
    %高温分机补偿
    if b>6
        if mod(b,20)==0&&abs(mean(data(9,b-1:b+1))-frequency_pressure_sp)>0.11
            pidloop(3,7)=pidloop(3,7)+(mean(data(9,b-1:b+1))-frequency_pressure_sp)*gaowenfengji_rati;
            upid(7)=pidloop(3,7);
        end
        if data(8,b)~=30&&data(8,b+1)==30
            pidloop(3,7)=pidloop(3,7)+gaowenfengji_compensate;
            upid(7)=pidloop(3,7);
        end
    end
    %控制振幅
    umax = 0.4;
    if(upid(7)>=data(31,b+1)+umax)
        upid(7) = data(31,b+1)+umax;
    elseif(upid(7)<=data(31,b+1)-umax)
        upid(7) = data(31,b+1)-umax;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%系统负压高温风机控制模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%头煤压力头煤喂煤控制模块%%%%%%%%%%%%%%%
if 1==coalklin_on 
    if pidloop(10,2)==0 && mod(b,20)==0
        pidloop(:,2)=pid_calc(pidloop(:,2)');
        pidloop(3,2)=round(pidloop(3,2)*100)/100;
        upid(6) = pidloop(3,2); 
    end
    %控制振幅
    umax = 0.1;
    if upid(6)<=(data(18,b)-umax)
        upid(6)=data(18,b)-umax;
    end
    if upid(6)>=(data(18,b)+umax)
        upid(6)=data(18,b)+umax;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%头煤压力头煤喂煤控制模块结束%%%%%%%%%%%%%%%%%%%%%%

try
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%手动干预控制模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 手动干预控制
%分解炉出口温度控制：喂煤手动干预
if 1==decomposing_furnace_tempr_on && man_in_fjl == true
    man_in_fjl = false;
    u_write = man_weimei;
    u_decomposing_furnace_tempr = man_weimei;
end

%二次风温控制：手动干预篦冷机转速
if 1==ecfw_on && man_in_blj == true
    man_in_blj = false;
    upid(8) = man_zhuansu;
    pidloop(3,8) = upid(8);
end

%窑电流控制: 手动干预头煤喂煤量
% % % if 1==coalklin_on && man_in_ydl == true
% % %     man_in_ydl = false;
% % %     upid(6) = man_toumei;
% % %     pidloop(3,2) = upid(6);
% % % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%手动干预控制模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%输出值保存模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 输出值保存
data(46,b+1)=u_decomposing_furnace_tempr;
data(47,b+1)=upid(8);
data(48,b+1)=upid(6);
data(49,b+1)=upid(4);
data(50,b+1)=u_decomposing_furnace_tempr_write;
data(63,b+1)=u_write;
data(65,b+1)=upid(5);
data(68,b+1)=upid(7);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%输出值保存模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
catch
    disp('这里出问题');
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%无扰切换模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 无扰切换
%二次风温控篦床压力
if 0==ecfw_on
    pidloop(2,8)=pidloop(1,8);
    pidloop(3,8)=data(2,b);
    upid(8) = pidloop(3,8);
    pidloop(4,8)=0;
    pidloop(5,8)=0;
    pidloop(6,8)=0;                   
end

%下料量
if 0==shengliao_junliao_on
    pidloop(1,4)=pidloop(2,4);
    pidloop(3,4)=data(36,b+1);
    upid(4)=data(36,b+1);
    pidloop(4,4)=0;
    pidloop(5,4)=0;
    pidloop(6,4)=0;
end

%氨水控制
if 0==sign_NH3
    pidloop(1,5)=pidloop(2,5);
    pidloop(3,5)=data(39,b);
    upid(5)=data(39,b+1);
    sign_NH3_ctrl=0;
end
if 1==pidloop(10,6) %这里是氨水控制内回路，需单独列出（即使1==sign_NH3，也可能触发）
    pidloop(2,6)=pidloop(1,6);
    pidloop(3,6)=data(64,b+1);
end

%分解炉出口温度
if 0==decomposing_furnace_tempr_on
    Up1=[data(13,b+1),data(13,b+1)];     
    u_decomposing_furnace_tempr=data(13,b+1);
    u_decomposing_furnace_tempr_write=data(13,b+1);
    u_write=data(13,b+1);
end

%系统负压高温风机控制
if 0==sign_furnace_pressure
    pidloop(1,7)=pidloop(2,7);
    pidloop(3,7)=data(31,b);
end

%头煤压力控制头煤喂煤
if 0==coalklin_on
    pidloop(1,2)=pidloop(2,2);
    pidloop(3,2)=data(18,b);
    upid(6)=pidloop(3,2);  
    pidloop(4,2)=0;
    pidloop(5,2)=0;
    pidloop(6,2)=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%无扰切换模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%写控制量模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 写控制量 
%二次风温篦床压力控制
if 1==ecfw_on && abs(upid(8)-data(2,b))>=0.02
    P_write(2,upid(8),blj_freqMAX,blj_freqMIN);
end

%下料量控制
if 1==shengliao_junliao_on && abs(upid(4)-data(36,b))>=0.05
    P_write(36,upid(4),junhua_MAX,junhua_MIN);
end

%氨水控制（这里注意：anshui_wentai 内回路判断标志，而不是sign_NH3作为标志）
if 1==anshui_wentai && abs(upid(5)-data(39,b))>=0.05
    P_write(39,upid(5),NH3_MAX,NH3_MIN);
end

%分解炉出口温度窑尾喂煤量控制
if 1==decomposing_furnace_tempr_on && abs(u_write-data(13,b))>=0.015
    P_write(13,u_write,yaowei_coalMAX,yaowei_coalMIN);
end

%系统负压高温风机控制
if 1==sign_furnace_pressure && abs(upid(7)-data(31,b))>=0.01
    P_write(31,upid(7),gaowenfengji_MAX,gaowenfengji_MIN);
end

%头煤压力窑头喂煤量控制
if 1==coalklin_on&&abs(upid(6)-data(18,b))>=0.04 
    P_write(18,upid(6),yaotou_coalMAX,yaotou_coalMIN);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%写控制量模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%报警模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 报警
if ~(decomposing_furnace_tempr_1_pv_round >= decomposing_furnace_tempr_2_upperlimitS ||decomposing_furnace_tempr_1_pv_round<= decomposing_furnace_tempr_2_lowerlimitS || ...
    snd_chamber_pressure_pv_round>= snd_chamber_pressure_upperlimitS ||snd_chamber_pressure_pv_round<= snd_chamber_pressure_lowerlimitS||wlc_weight_round>=wlc_weight_upperlimitS||...
    wlc_weight_round<=wlc_weight_lowerlimitS||round(10*data(11,b+1))/10<=round(10*data(12,b+1))/10 || NOX_PV >= NOX_upperlimits || NOX_PV <= NOX_lowerlimits)
    alarm_sound_flag = 0;
end
    
set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    
if (decomposing_furnace_tempr_1_pv_round >= decomposing_furnace_tempr_2_upperlimitS||decomposing_furnace_tempr_1_pv_round<= decomposing_furnace_tempr_2_lowerlimitS || ...
    snd_chamber_pressure_pv_round>= snd_chamber_pressure_upperlimitS ||snd_chamber_pressure_pv_round<= snd_chamber_pressure_lowerlimitS||wlc_weight_round>=wlc_weight_upperlimitS||...
    wlc_weight_round<=wlc_weight_lowerlimitS||round(10*data(11,b+1))/10<=round(10*data(12,b+1))/10 || NOX_PV >= NOX_upperlimits || NOX_PV <= NOX_lowerlimits)&& ~alarm_button_clicked

    if(mod(b,2)==1)
       set(handles.alarmbutton,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
       set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end
    
try
    set(pophandles.text12,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
    set(pophandles.text13,'ForegroundColor',[0 0 0]);
    set(pophandles.text14,'ForegroundColor',[0 0 0]);
    set(pophandles.text15,'ForegroundColor',[0 0 0]);
    set(pophandles.text20,'ForegroundColor',[0 0 0]);
    set(pophandles.text21,'ForegroundColor',[0 0 0]);
    set(pophandles.NOX_upperlimits,'ForegroundColor',[0 0 0]);
    set(pophandles.NOX_lowerlimits,'ForegroundColor',[0 0 0]);

catch
%     disp('没有打开报警设置窗口');
end
if (decomposing_furnace_tempr_1_pv_round >= decomposing_furnace_tempr_2_upperlimitS) 
    try
        if(mod(b,2)==1)
            set(pophandles.text12,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text12,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end   
if (decomposing_furnace_tempr_1_pv_round <=decomposing_furnace_tempr_2_lowerlimitS) 
    try
        if(mod(b,2)==1)
            set(pophandles.text13,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text13,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end
    
if (snd_chamber_pressure_pv_round>= snd_chamber_pressure_upperlimitS)
    try
        if(mod(b,2)==1)
            set(pophandles.text14,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text14,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

if (snd_chamber_pressure_pv_round<= snd_chamber_pressure_lowerlimitS)
    try
        if(mod(b,2)==1)
            set(pophandles.text15,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text15,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

if (wlc_weight_round >= wlc_weight_upperlimitS)
    shengliao_junliao_on=0;
    try
        if(mod(b,2)==1)
            set(pophandles.text20,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text20,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

if (wlc_weight_round<= wlc_weight_lowerlimitS)
    shengliao_junliao_on=0;
    try
        if(mod(b,2)==1)
            set(pophandles.text21,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.text21,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

if (round(10*data(11,b+1))/10<=round(10*data(12,b+1))/10)
   try
        set(pophandles.text25,'String','是');
        set(pophandles.text25,'ForegroundColor',[1 0 0]);
   catch
        %disp('没有打开报警设置窗口');
   end
end

%NOX
if (NOX_PV >= NOX_upperlimits) 
    try
        if(mod(b,2)==1)
            set(pophandles.NOX_upperlimits,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.NOX_upperlimits,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end   
if (NOX_PV <=NOX_lowerlimits) 
    try
        if(mod(b,2)==1)
            set(pophandles.NOX_lowerlimits,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.NOX_lowerlimits,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end       

% if alarm_sound_flag
%     load chirp          
%     sound(y,Fs)
% 
% end
 
if alarm_button_clicked
    if alarm_timer == 0
        alarm_timer = 120;
        alarm_button_clicked = 0;
    else
        alarm_timer = alarm_timer - 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%报警模块结束%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 清屏
if mod(b,100)==0                   %每100s清屏
    clc;
end
    
% catch        
% end
%实时画图
% if mod(b,5)==1
%     drawrealtime()
% end
end