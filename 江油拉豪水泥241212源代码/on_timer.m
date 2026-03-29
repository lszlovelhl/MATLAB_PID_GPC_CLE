function on_timer(obj,event,handles)

global connect_con first_time_connect_flag   u_final u_blj_speed gpc_a2 blj_big blj_asc blj_desc
global daobj group   lastsave  data b tempdata tempdatavalue  pidloop loopnum upid
global sign_bichuang  itemset  shengliao_douti_pidai_on gpc_lmd2 toupai_sp
global first_cooler_rev_on   decomposing_furnace_tempr_on zsc_sp fazuFlag weimei_flag
global workpoint  Up5 A B P gpc_a gpc_lmd  first_time_connect_flag_ontimer   yaotou_press_sp
global u_decomposing_furnace_tempr   workpoint2 A2 B2 test delta_fjl wm_press_sp paramdata
global coalklinpresp coalklin_on  pophandles  shengliao_douti_on yaowei_coalMAX yaowei_coalMIN
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global alarm_sound_flag alarm_button_clicked alarm_timer    feeding_duct_tempr_2_sp shengliao_douti_sp
global yout1 Up1 gpc_decomposing_furnace_tempr_1_sp decomposing_furnace_tempr_1_sp delta_blj  fazu1_max fazu1_min fazu2_max fazu2_min
global  wmc_press_on gui_klin_head_tempr_sp xintiao_on fjl_lmd2 toupai_on  blj_asc_flag1 blj_asc_flag2 blj_desc_flag1 blj_desc_flag2
global  blj_a1 blj_lmd1 blj_a2  blj_lmd2 tm_p1 tm_i1 tm_d1 douti_p1 douti_i1 douti_d1 fjl_a1 fjl_lmd1 fjl_a2 u_fjl_max
global oil_pressure_threshold2 oil_pressure_threshold1 yachuang_mv zhuansu_MAX zhuansu_MIN
global zhuansu press man_in_blj man_in_fjl man_zhuansu man_weimei man_fjl_time_cnt man_blj_time_cnt blj_stop_sign
global youya_alarm_cnt toumei_MAX toumei_MIN yaodianliu_on yaodianliu_sp toumeiyali_MAX toumeiyali_MIN
global pressure_vd blj_speed_stop_flag man_ydl_toumei man_in_ydl man_ydl_time_cnt
global kypcnt kypcntflag ysfjdl ysfjdlDV zhuansu_mid ydlDBH ydlUBH ydlBHcnt ydlBHFlag gui_fjlT_sp
global ecfw_spcnt ecfw_sp ecfw_cnt_inner_sp wmfy_sp fjl_cle_test
global tidaiwu_x cc_test du_flag qiankui_flag duliao_flag duliao_flag1 tdrl_bc_up tdrl_bc_down tdrl_close_flag tdrl_close_flag1 tdrl_open_flag tdrl_open_flag1
% % % % % wyxxxxxx   2022/11/12
global keycount hisdatadays hitdata_title  duliao_up duliao_down qiankui_flag1 AF blj_rev_time
%%配置文件参数
if 0 == mod(b,31)
    paramdata = xml_read('param_set.xml');
end

p_blj_a1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a1;
p_blj_lmd1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd1;
p_blj_a2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a2;
p_blj_lmd2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd2;
% pressure_vd = paramdata.commdata(1).parameter(4).ATTRIBUTE.pressure_vd;
yachuang_mv = paramdata.commdata(1).parameter(4).ATTRIBUTE.yachuang_mv;
ysfjdl=paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdl;
ysfjdlDV=paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdlDV;
ecfw_sp=paramdata.commdata(1).parameter(4).ATTRIBUTE.ecfw_sp; %二次风温
%%%%%2023/3/30 wyx
gyfpressure_vd = paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd;
gyfpressure_vd2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd2;

p_tm_p1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_p1;
p_tm_i1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_i1;
p_tm_d1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_d1;

p_ydl_p1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_p1;
p_ydl_i1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_i1;
p_ydl_d1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_d1;
ydl_vd = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_vd;
ydl_lbT = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_lbT;
ydl_kzzq = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_kzzq;
kypA = paramdata.commdata(1).parameter(16).ATTRIBUTE.kypA;
ydlBHcntMax = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydlBHcntMax;

p_douti_p1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_p1;
p_douti_i1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_i1;
p_douti_d1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_d1;

p_fjl_a1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a1;
p_fjl_lmd1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd1;
p_fjl_a2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a2;
p_fjl_lmd2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd2;
fjl_vd = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_vd;
tidaiwu_x = paramdata.commdata(1).parameter(7).ATTRIBUTE.tidaiwu_x;
fjl_p = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_p;
tdrl_bc_up = paramdata.commdata(1).parameter(7).ATTRIBUTE.tdrl_bc_up;
tdrl_bc_down = paramdata.commdata(1).parameter(7).ATTRIBUTE.tdrl_bc_down;

p_toupai_p1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_p1;
p_toupai_i1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_i1;
p_toupai_d1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_d1;

zhuansu_mean = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mean;
press_mean = paramdata.commdata(1).parameter(14).ATTRIBUTE.press_mean;
period = paramdata.commdata(1).parameter(14).ATTRIBUTE.period;
zhuansu_step = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_step;
% zhuansu_mid = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mid;
%分解炉cle
fjl_temp_sp_up = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_temp_sp_up;
fjl_temp_sp_down = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_temp_sp_down;
fjl_vd1 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_vd;
fjl_delvd1 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_delvd1;
fjl_delvd2 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_delvd2;
fjl_delvd3 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_delvd3;
fjl_cle_up = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_cle_up;
fjl_cle_down = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_cle_down;
fjl_xianfu = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_xianfu;
%% 获取Wincc中各变量的值

tic
tempdata = read(group);              % length(tempdata) = 35

% % % % % wyxxxxxx   2022/11/12
try
    his_data(tempdata,0,hisdatadays,hitdata_title);                  %报表数据
catch
    disp('保存数据错误');
end
if keycount >= 3601
    keycount = 0;
else
    keycount = keycount + 1;
end

[~, b] = size(data);
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end
first_time_connect_flag_ontimer = first_time_connect_flag_ontimer - 1;

if first_time_connect_flag_ontimer<=0
    first_time_connect_flag_ontimer=0;
end


%%心跳

if xintiao_on == 1
    if mod(b,2) == 0
        write(itemset(37),true)
    else
        write(itemset(37),false)
    end
end


% fazuFlag = 0;
%% 获取设定值
% gui_klin_head_tempr_sp=str2double(get(handles.gui_klin_head_tempr_sp_display,'String'));     %回转窑头煤压力
yaodianliu_sp=str2double(get(handles.text289,'String'));     %回转窑电流
ecfw_sp=str2double(get(handles.ecfw_sp,'String')); %二次风温
% decomposing_furnace_tempr_1_sp=str2double(get(handles.gui_decomposing_furnace_tempr_1_sp_display,'String'));%分解炉温度
shengliao_douti_sp=str2double(get(handles.shengliao_douti_sp,'String')); %斗提电流
yaotou_press_sp = str2double(get(handles.yaotou_press_sp,'String')); %窑头负压

yaowei_coalMAX=str2double(get(handles.yaowei_coalMAX,'String'));
yaowei_coalMIN=str2double(get(handles.yaowei_coalMIN,'String'));

duliao_up = str2double(get(handles.duliao_up,'String'));
duliao_down = str2double(get(handles.duliao_down,'String'));
% decomposing_furnace_tempr_1_sp = gui_fjlT_sp;

% data(78,b+1)=gui_klin_head_tempr_sp; %该值被decomposing_furnace_tempr_1_sp替代使用
% data(80,b+1)=gui_2nd_chamber_pressure_sp;

data(77,b+1)=gui_fjlT_sp; %gui界面设定值
data(79,b+1)=shengliao_douti_sp;
data(91,b+1)=yaotou_press_sp;
data(76,b+1)=ecfw_sp;
data(108,b+1)=yaodianliu_sp;
data(103,b+1)=wmfy_sp;%尾煤风压设定

%% 每小时data数据更新
if b >= 3900
    datetime = datestr(now,30);
    s = ['save(''data',datetime(1:8),datetime(10:11),'.mat'',''data'');'];
    eval(s);
    lastsave = ['data',datetime(1:8),datetime(10:11),'.mat'];
    data(1 : 6,1) = fix(clock);
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

%% 测量值实时显示
snd_chamber_pressure_pv_round=(round(data(8,b+1)*100))/100;   %一室B篦床压力
yaotou_temp_pv_round=(round(data(23,b+1)*100))/100;   %二次风温
decomposing_furnace_tempr_1_pv_round = round(10*data(11,b+1))/10;  %分解炉温度
%气体
set(handles.yanshi_O2,'String',num2str(round(100*data(36,b+1))/100));
set(handles.yanshi_CO,'String',num2str(round(100*data(50,b+1))/100));
if b < 300
    set(handles.yanshi_O2_lvbo,'String',num2str(round(100*data(36,b+1))/100));
    set(handles.yanshi_CO_lvbo,'String',num2str(round(100*data(50,b+1))/100));
end

if b > 300
    yanshi_O2_lvbo =  sum(data(36,b-298:b+1))/300;
    yanshi_CO_lvbo =  sum(data(50,b-298:b+1))/300;
    set(handles.yanshi_O2_lvbo,'String',num2str(round(100* yanshi_O2_lvbo )/100));
    set(handles.yanshi_CO_lvbo,'String',num2str(round(100* yanshi_CO_lvbo )/100));
end
if b < 60
    wm_div_tm = data(13,b+1) / data(23,b+1);
    set(handles.wm_div_tm,'String',num2str(round(100* wm_div_tm )/100));
end
if b > 60
    wm_lvbo = sum(data(13,b-58:b+1))/60;
    tm_lvbo = sum(data(26,b-58:b+1))/60;
    wm_div_tm =   wm_lvbo / tm_lvbo;
    set(handles.wm_div_tm,'String',num2str(round(100* wm_div_tm )/100));
end

%斗提和高温风机转速
set(handles.OX_pv,'String',num2str(round(10*data(36,b+1))/10));
% set(handles.gui_fan_frequency_pv_display,'String',num2str(round(10*data(34,b+1))/10));
set(handles.system_pressure,'String',num2str(round(data(35,b+1))));
%一段
set(handles.gui_2nd_chamber_pressure_pv_display,'String',num2str(yaotou_temp_pv_round,'%.1f'));
set(handles.gui_1st_cooler_rev_sp_display,'String',num2str(round(100*data(4,b+1))/100));
set(handles.gui_1st_cooler_rev_sp,'String',num2str(data(2,b+1),'%.2f'));
set(handles.gui_1st_cooler_rev_sp2,'String',num2str(data(2,b+1),'%.2f'));
% set(handles.yaotou_temp_pv,'String',num2str(round(10*data(23,b+1))/10));
set(handles.text292,'String',num2str(data(8,b+1),'%.2f'));
set(handles.text296,'String',num2str(data(9,b+1),'%.2f'));
% set(handles.ecfw_sp,'String',[num2str(ecfw_sp),'/',num2str(ecfw_cnt_inner_sp,'%.0f')]);
set(handles.ecfw_sp,'String',num2str(ecfw_sp));
set(handles.youya,'String',num2str(data(6,b+1),'%.2f'));
set(handles.scfw,'String',num2str(data(15,b+1),'%.1f'));

%分解炉
set(handles.gui_decomposing_furnace_tempr_1_pv_display,'String',num2str(data(11,b+1),'%.1f'));
% set(handles.gui_feeding_duct_tempr_2_pv_display,'String',num2str(round(10*data(12,b+1))/10));
set(handles.gui_decomposing_furnace_coal_pv_display,'String',num2str(round(100*data(14,b+1))/100)); %分解炉喂煤
set(handles.gui_decomposing_furnace_coal_sp_display,'String',num2str(round(100*data(12,b+1))/100));
set(handles.gui_decomposing_furnace_coal_sp_display2,'String',num2str(round(100*data(12,b+1))/100));
set(handles.wmc_press_pv,'String',num2str(round(100*data(16,b+1))/100));  %7011风机
set(handles.wmc0_press_pv,'String',num2str(round(100*data(17,b+1))/100));  %7010风机
if AF == 1
    set(handles.tidaiwu_pv,'String',num2str(round(100*data(62,b+1))/100));
    set(handles.tidaiwu_sp,'String',num2str(round(100*data(61,b+1))/100));
elseif AF == 2
    set(handles.tidaiwu_pv,'String',num2str(round(100*data(29,b+1))/100));
    set(handles.tidaiwu_sp,'String',num2str(round(100*data(47,b+1))/100));
elseif AF == 3
    set(handles.tidaiwu_pv,'String',num2str(round(100*data(32,b+1))/100));
    set(handles.tidaiwu_sp,'String',num2str(round(100*data(33,b+1))/100));
end
%回转窑
% set(handles.gui_klin_head_tempr_pv_display,'String',num2str(round(10*data(23,b+1))/10));   %窑头窑尾
% set(handles.gui_klin_end_tempr_pv_display,'String',num2str(round(10*data(24,b+1))/10));
% set(handles.gui_klin_rev_pv_display,'String',num2str(round(100*data(31,b+1))/100));     %回转窑转速
set(handles.text290,'String',num2str(data(30,b+1),'%.2f'));     %窑电流
% set(handles.gui_klin_coal_pv_display,'String',num2str(round(100*data(22,b+1))/100));     %头煤压力
% set(handles.gui_klin_coal_sp_display,'String',num2str(round(100*data(25,b+1))/100));
set(handles.gui_klin_coal_sp_display,'String',num2str(data(26,b+1),'%.2f'));
set(handles.yaotou_press_pv,'String',num2str(round(100*data(28,b+1))/100)); %窑头负压
set(handles.toupai_sp,'String',num2str(round(100*data(52,b+1))/100)); %头排给定

%% 生料
set(handles.shengliao_douti_pv,'String',num2str(round(10*data(18,b+1))/10));     %斗提测量
set(handles.shengliao_pidai_pv,'String',num2str(round(10*data(19,b+1))/10));     %测量
set(handles.shengliao_pidai_sp,'String',num2str(round(10*data(20,b+1))/10));     %给定
%%心跳
set(handles.xintiao_pv,'String',num2str(data(37,b+1)));     %测量
set(handles.lianjie_ok_pv,'String',num2str(data(38,b+1)));   %给定


%% 获取自动控制开关信息
data(66,b+1)=first_cooler_rev_on;
% data(67,b+1)=coalklin_on; %头煤压力控制 更改为 窑电流控制
data(67,b+1)=yaodianliu_on;
data(68,b+1)=decomposing_furnace_tempr_on;
data(69,b+1)=shengliao_douti_pidai_on;
% data(70,b+1) = wmc_press_on;
data(89,b+1) = toupai_on;
% data(109,b+1)=yaodianliu_on;

%%模式选择
if (first_cooler_rev_on == 1) && data(38,b+1) == true
    write(itemset(39),true)
else
    write(itemset(39),false)
end
%篦冷机回路DCS权限关闭
% if data(39,b+1) == false
%     first_cooler_rev_on=0;
%     zxyCnt = 0;
%     zhuansu = [];
%     press = [];
%     man_in_blj = false;
%     man_blj_time_cnt = 0;
%     ecfw_spcnt = -1; %停止控制器时，将该值复位
%     set(handles.gui_2nd_chamber_pressure_sp_slider,'Enable','on');
%     set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
%     %set(handles.yaotou_temp_open,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
% end

if yaodianliu_on == 1 && data(38,b+1) == true
    write(itemset(41),true)
else
    write(itemset(41),false)
end
%窑电流回路DCS权限关闭
% if data(41,b+1) == false
%     yaodianliu_on=0;
%     man_ydl_time_cnt = 0;
%     man_in_ydl = false;
%     set(handles.pushbutton62,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.pushbutton61,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);
% end

if decomposing_furnace_tempr_on == 1 && data(38,b+1) == true
    write(itemset(42),true)
else
    write(itemset(42),false)
end
%分解炉出口温度回路DCS权限关闭
% if data(42,b+1) == false
%     decomposing_furnace_tempr_on =0;
%     man_fjl_time_cnt = 0;
%     man_in_fjl = false;
%     % set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
% end

if shengliao_douti_pidai_on == 1 && data(38,b+1) == true
    write(itemset(43),true)
else
    write(itemset(43),false)
end
%斗提电流控制回路DCS权限关闭
% if data(43,b+1) == false
%     shengliao_douti_pidai_on=0;
%     set(handles.shengliao_pidai_close,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.shengliao_pidai_open,'BackgroundColor',[0.831 0.816 0.784]);
% end

if toupai_on == 1 && data(38,b+1) == true
    write(itemset(57),true)
else
    write(itemset(57),false)
end
%窑头负压回路DCS权限关闭
% if data(51,b+1) == false
%     toupai_on=0;
%     set(handles.toupai_close,'BackgroundColor',[0.831 0.816 0.784]);
%     set(handles.toupai_open,'BackgroundColor',[0.831 0.816 0.784]);
% end

if 1==first_cooler_rev_on
    pidloop(10,1)=0;
else
    pidloop(10,1)=1;
end

if 1==yaodianliu_on
    pidloop(10,6)=0;
else
    pidloop(10,6)=1;
end

if shengliao_douti_pidai_on==1
    pidloop(10,4)=0;
else
    pidloop(10,4)=1;
end

if toupai_on==1
    pidloop(10,5)=0;
else
    pidloop(10,5)=1;
end
% disp('111');
%% 参数设置
% 设定值
pidloop(2,1)=ecfw_sp;  %二次风温，反特性
pidloop(1,4)=shengliao_douti_sp; %斗提电流
pidloop(2,5) = yaotou_press_sp; %窑头负压，反特性
pidloop(1,6)=yaodianliu_sp;    %窑电流
%测量值
pidloop(1,1)=data(23,b+1);
pidloop(2,4)=data(18,b+1);
pidloop(1,5)=data(28,b+1);
pidloop(2,6)=data(30,b+1);

% % % % % data(85,b+1)=data(17,b+1);
data(87,b+1)=data(6,b+1);
data(88,b+1)=data(7,b+1);

if b>=31
    pidloop(1,1)=sum(data(23,b-3:b+1))/5;
    pidloop(2,4)=sum(data(18,b-28:b+1))/30;
    pidloop(1,5)=sum(data(28,b-7:b+1))/9;
    pidloop(2,6)=sum(data(30,b-28:b+1))/30;
    
    % % % % %     data(85,b+1)=sum(data(17,b-3:b+1))/5;
end
if b > 61
    pidloop(2,2)=sum(data(22,b-58:b+1))/60;
    pidloop(2,6)=sum(data(30,b-58:b+1))/60;
end
if b > 181
    pidloop(2,2)=sum(data(22,b-178:b+1))/180;
    pidloop(2,6)=sum(data(30,b-178:b+1))/180;
end
if b >= (ydl_lbT+1)
    data(99,b+1) = sum(data(8,b-(ydl_lbT-2):b+1))/ydl_lbT;
    pidloop(2,2)=sum(data(22,b-(ydl_lbT-2):b+1))/ydl_lbT;
    pidloop(2,6)=sum(data(30,b-(ydl_lbT-2):b+1))/ydl_lbT;
else
    data(99,b + 1) = data(8,b+1);
end

if b > 5
    data(97,b+1) = (data(99,b+1) - data(99,b)) * 1000;%一次导
    data(98,b+1) = data(97,b+1) - data(97,b);%二次导
else
    data(97,b + 1) = data(99,b + 1);
    data(98,b + 1) = data(97,b + 1);
end

%二次风温篦冷机参数
pidloop(7,1)=p_blj_a1;%kuc    应增大
pidloop(8,1)=p_blj_lmd1;%ke
pidloop(9,1)=0;%kec
pidloop(11,1)=zhuansu_MAX;
pidloop(12,1)=zhuansu_MIN;
pidloop(13,1)=0.001;%0.3

%窑电流参数
pidloop(7,6)= p_ydl_p1;                      %0.014;kuc    应增大
pidloop(8,6)= p_ydl_i1;                            %20;k
pidloop(9,6)= p_ydl_d1;                       %0;kec
pidloop(11,6)=toumei_MAX;
pidloop(12,6)=toumei_MIN;
pidloop(13,6)=0.005;

%生料斗提
pidloop(7,4)= p_douti_p1;                         %0.035;kuc    应增大
pidloop(8,4)= p_douti_i1;                         %20;ke
pidloop(9,4)= p_douti_d1;                         %0;kec
pidloop(11,4)=176; %修改：根据现场调节上限
pidloop(12,4)=164;
pidloop(13,4)=0.0005;%0.3

%窑头负压
pidloop(7,5)= p_toupai_p1;                         %0.035;kuc    应增大
pidloop(8,5)= p_toupai_i1;                         %20;ke
pidloop(9,5)= p_toupai_d1;                         %0;kec
pidloop(11,5)=800;
pidloop(12,5)=150;
pidloop(13,5)=0.001;%0.3
%%%%%2023/3/30 wyx
%分解炉温度
if b>11
    data(85,b+1)=sum(data(17,b-8:b+1))/10; %尾煤风压
else
    data(85,b+1)=data(17,b+1);
end
%替代燃料检测值
if b> 30
    data(117,b+1) = sum(data(29,b-8:b+1))/10;
else
    data(117,b+1) = data(29,b+1);
end
pidloop(2,7)=data(85,b+1); %pv
pidloop(7,7)=fjl_p; %p 0.024
pidloop(8,7)=0.05; %i
pidloop(9,7)=0.01; %d
pidloop(11,7)=12; %上限
pidloop(12,7)=0;  %下限
pidloop(13,7)=0.01;


data(81,b+1)=pidloop(1,1);
data(82,b+1)=pidloop(2,2);
% data(83,b+1)=pidloop(1,3); %篦下压力2
data(84,b+1)=pidloop(2,4);
data(92,b+1)=pidloop(1,5);
data(111,b+1)=pidloop(2,6); %窑电流

%% 计算各段篦冷机控制量
[~, loopnum]=size(pidloop);

%% 二次风温篦冷机控制
% data(59,b+1) = 1;
%该回路未授权，本回路无法投运
if 0 == data(59,b+1)
    first_cooler_rev_on=0;
    zhuansu = [];
    press = [];
    man_in_blj = false;
    man_blj_time_cnt = 0;
    ecfw_spcnt = -1; %停止控制器时，将该值复位
    set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
    %     if(mod(b,2)==1)
    %         set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
    %     else
    set(handles.gui_1st_cooler_off_button,'BackgroundColor',[1 1 0]);
    %     end
end

if 1==first_cooler_rev_on
    %控制开关启动时，设定值与实际值差值缓慢缩小过程,防止差值过大调节幅度太大
    if -1 == ecfw_spcnt %-1表示打开控制时第一次触发且只使用一次
        if ecfw_sp - pidloop(1,1) > 30
            ecfw_cnt_inner_sp = pidloop(1,1) + 30; %二次风温反特性，1,3是测量值
        else
            ecfw_cnt_inner_sp = ecfw_sp; %二次风温内部设定值
        end
        ecfw_spcnt = 0; %排除掉-1，只是第一次使用一次
    else
        if ecfw_cnt_inner_sp < ecfw_sp
            ecfw_spcnt = ecfw_spcnt + 1;
            if ecfw_spcnt >= 300 %每5min，ecfw_cnt_inner_sp+30
                if ecfw_cnt_inner_sp < pidloop(1,1)
                    ecfw_cnt_inner_sp = pidloop(1,1) + 30;
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
    pidloop(2,1) = ecfw_cnt_inner_sp; %反特性 控制量由篦压变为二次风温
    
    %篦冷机转速积分饱和
    if pidloop(10,1)==0
        if ((pidloop(1,1)>=pidloop(2,1))&&(pidloop(3,1)>=zhuansu_MAX)) %当测量值大于设定值时，并且阀门已经最大，反特性
            pidloop(2,1)= pidloop(1,1);
            pidloop(3,1)=zhuansu_MAX;
        end
        if ((pidloop(1,1)<=pidloop(2,1))&&(pidloop(3,1)<=zhuansu_MIN)) %当测量值小于设定值时，并且阀门已经最小，反特性
            pidloop(2,1)= pidloop(1,1);
            pidloop(3,1)=zhuansu_MIN;
        end
    end
    %%%%%2023/3/30 wyx
    if b > 31
        if (max(data(6,b-13:b+1)) > gyfpressure_vd... %1#阀组供油压力
                &&(max(data(6,b-28:b-14)) > gyfpressure_vd))...%1#阀组供油压力连续两个周期超过上限
                ||(max(data(7,b-13:b+1)) > gyfpressure_vd2... %2#阀组供油压力
                &&(max(data(7,b-28:b-14)) > gyfpressure_vd2))...%2#阀组供油压力连续两个周期超过上限
                ||sum(data(8,b-8:b+1))/10 > pressure_vd
            blj_speed_stop_flag = true;
        end
    end
    
    % 触发红线则data(102,b+1)置1
    if (blj_speed_stop_flag == true) && (mod(b,40) == 0) && blj_rev_time == 0
        if upid(1) < zhuansu_MIN
            upid(1) = zhuansu_MIN + yachuang_mv;
        else
            upid(1) = upid(1) + yachuang_mv;
        end
        
        data(102,b+1) = 1;
        if upid(1) >= zhuansu_MAX
            upid(1) = zhuansu_MAX;
        end
        pidloop(3,1) = upid(1);
        blj_speed_stop_flag = false; %复位
    end
    if mod(b,20)==0 && pidloop(10,1)==0 && blj_rev_time == 0
        pidloop(:,1)=pid_calc(pidloop(:,1)');
        if blj_speed_stop_flag == false
            pidloop(3,1)=round(pidloop(3,1)*100)/100;
            upid(1)=round(pidloop(3,1)*100)/100;
        else
            pidloop(3,1) = upid(1);
        end
    end
    %篦冷机转速返回中场速度，这部分不可在控制振幅之前
    if b > 300
        if  (max(data(6,b-13:b+1)) < gyfpressure_vd)...
                && (max(data(6,b-28:b-14)) < gyfpressure_vd)...
                && (max(data(6,b-43:b-29)) < gyfpressure_vd)...
                &&(max(data(6,b-13:b+1)) < gyfpressure_vd2)...
                && (max(data(6,b-28:b-14)) < gyfpressure_vd2)...
                && (max(data(6,b-43:b-29)) < gyfpressure_vd2)...
                && (sum(data(8,b-8:b+1))/10 < pressure_vd)
            
            % 目前转速大于中场转速，则回到中场转速，否则不管
            blj_rev_time = 1;
            %             if upid(1) > zhuansu_mid
            %                 upid(1) = zhuansu_mid;
            %                 pidloop(3,1) = upid(1);
            %             end
        end
    end
    %每10s下降0.2 回到中场转速
    speed = 0.2;
    if upid(1) > (zhuansu_mid+speed) &&  blj_rev_time == 1
        if mod(b,20)==0
            upid(1) = upid(1) - speed;
            pidloop(3,1) = upid(1);
        end
    else
        blj_rev_time = 0;
    end
    data(105,b+1)=upid(1);
    data(120,b+1)=blj_rev_time;
end

%% 斗提电流控制
if mod(b,15)==0
    if pidloop(10,4)==0
        pidloop(:,4)=pid_calc(pidloop(:,4)');
        pidloop(3,4)=round(pidloop(3,4)*1000)/1000;%修改：根据现场调节给定精度
        upid(4)=pidloop(3,4);
    end
end
umax = 0.13;
if upid(4)<=(data(20,b+1)-umax)    %%修改：根据现场实际
    upid(4)=data(20,b+1)-umax;      %忽略
end
if upid(4)>=(data(20,b+1)+umax)    %%修改：根据现场实际
    upid(4)=data(20,b+1)+umax;      %忽略
end

%% 窑头负压控制
if mod(b,1)==0
    if pidloop(10,5)==0
        pidloop(:,5)=pid_calc(pidloop(:,5)');
        pidloop(3,5)=round(pidloop(3,5)*1000)/1000;%修改：根据现场调节给定精度
        upid(5)=pidloop(3,5);
    end
end
umax = 10;
if upid(5)<=(data(51,b+1)-umax)
    upid(5)=data(51,b+1)-umax;
end
if upid(5)>=(data(51,b+1)+umax)
    upid(5)=data(51,b+1)+umax;
end

%% 窑电流控制回路
if 1==yaodianliu_on && b > 30
    %头煤积分分离
    ydlUBH = 0; %上限饱和判断，用作分解炉提温1度
    ydlDBH = 0; %下限饱和判断，用作分解炉降温1度
    if pidloop(10,6)==0
        if ((pidloop(1,6)>=pidloop(2,6))&&(pidloop(3,6)>=toumei_MAX)) %当设定值大于测量值时，并且阀门已经最大
            pidloop(1,6)= pidloop(2,6);
            pidloop(3,6)=toumei_MAX;
            ydlUBH = 1; %向上饱和，分解炉提温1度
        end
        
        if ((pidloop(1,6)<=pidloop(2,6))&&(pidloop(3,6)<=toumei_MIN)) %当设定值小于测量值时，并且阀门已经最小
            pidloop(1,6)= pidloop(2,6);
            pidloop(3,6)=toumei_MIN;
            ydlDBH = 1; %向下饱和，分解炉降温1度
        end
    end
    
    %触发上下限饱和时，对分解炉温度设定值提高或降低1度温度，本逻辑要在积分饱和判断之后
    if 1==ydlUBH || 1==ydlDBH
        ydlBHcnt = ydlBHcnt+1;
        if ydlBHcnt >= ydlBHcntMax %触发饱和后，等待10min，然后对分解炉温度操作
            ydlBHcnt = 0;
            ydlBHFlag = 1;
        end
    else
        ydlBHcnt = 0;  %条件破坏（饱和解除）时，随时复位重新计时
    end
    
    %垮窑皮处理
    if b > 120 && 0==kypcntflag
        ydl1 = mean(data(30,b-58:b+1));
        ydl2 = mean(data(30,b-118:b-59));
        ydldelt = ydl1-ydl2;
        if ydldelt > kypA  %1分钟差值超过20A则表示垮窑皮
            kypcntflag = 1;
        end
    end
    %如果垮窑皮则保持30min静默状态
    if 1==kypcntflag
        kypcnt = kypcnt+1;
        if kypcnt >= 1800 %静默30min
            kypcnt = 0;
            kypcntflag = 0;
        end
    else
        [mx1,mx_in1] = max(data(111,b-8:b+1)); %间隔10s
        [mx2,mx_in2] = max(data(111,b-18:b-9));
        [mx3,mx_in3] = max(data(111,b-28:b-19));
        [mn1,mn_in1] = min(data(111,b-8:b+1));
        [mn2,mn_in2] = min(data(111,b-18:b-9));
        [mn3,mn_in3] = min(data(111,b-28:b-19));
        
        mx_max = max([mx1,mx2,mx3]);
        mn_min = min([mn1,mn2,mn3]);
        
        %窑电流高于设定值，并且是还保持上升趋势
        if (mn_min>=yaodianliu_sp) && (mod(b,60)==0)...
                && (mx1>mx2) && (mx2>mx3) && (mn1>mn2) && (mn2>mn3)
            delvd = 0;
            if mn_min-yaodianliu_sp>=8
                delvd=0.008;
            elseif mn_min-yaodianliu_sp>=5
                delvd=0.006;
            elseif mn_min-yaodianliu_sp>=3
                delvd=0.004;
            end
            pidloop(3,6) = data(25,b+1) - (ydl_vd+delvd);  %窑电流高，需要减煤
            upid(6)=pidloop(3,6);
            %窑电流低于设定值，并且是还保持下降趋势
        elseif (mx_max<=yaodianliu_sp) && (mod(b,60)==0)...
                && (mx1<mx2) && (mx2<mx3) && (mn1<mn2) && (mn2<mn3)
            delvd = 0;
            if yaodianliu_sp-mx_max>=8
                delvd=0.008;
            elseif yaodianliu_sp-mx_max>=5
                delvd=0.006;
            elseif yaodianliu_sp-mx_max>=3
                delvd=0.004;
            end
            pidloop(3,6) = data(25,b+1) + (ydl_vd+delvd);  %窑电流低，需要加煤
            upid(6)=pidloop(3,6);
        else
            %窑电流处于设定值上下区间，并且是还保持波动
            if mod(b,ydl_kzzq)==0  %300
                pidloop(:,6)=pid_calc(pidloop(:,6)');
                pidloop(3,6)=round(pidloop(3,6)*100)/100;%修改：根据现场调节给定精度
                upid(6)=pidloop(3,6);
            end
        end
        %         umax = 0.02;
        %         if (pidloop(3,6)<=(data(25,b+1)-umax))   %%控制振幅
        %             pidloop(3,6) = data(25,b+1)-umax;
        %             upid(6)=pidloop(3,6);
        %         end
        %         if (pidloop(3,6)>=(data(25,b+1)+umax))
        %             pidloop(3,6) = data(25,b+1)+umax;
        %             upid(6)=pidloop(3,6);
        %         end
    end
    umax = 0.05;
    if upid(6)<=(data(25,b)-umax)
        upid(6)=data(25,b)-umax;
    end
    if upid(6)>=(data(25,b)+umax)
        upid(6)=data(25,b)+umax;
    end
end
% disp('111222');
%% 分解炉出口温度主程序
% data(60,b+1) = 1;
%该回路未授权，无法投运
if 0 == data(60,b+1)
    decomposing_furnace_tempr_on =0;
    man_fjl_time_cnt = 0;
    man_in_fjl = false;
    set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
    %     if(mod(b,2)==1)
    %         set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
    %     else
    set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[1 1 0]);
    %     end
end



if 1==decomposing_furnace_tempr_on
    %%%%%2023/3/30 wyx
    
    %%%%外回路gpc,尾煤风压控分解炉温度
    if b>11 %这个时间的判断注意和控制周期以及Up1(1)=data(12,b-4)-workpoint(1)b-4匹配
        workpoint=[27.3734,870.0415];
        A=[-0.9881,1]; %10s
        B=0.8514;  %10s
        %         A=[-0.9822,1]; %15s
        %         B=1.273;  %15s
        %         A=[-0.9763,1]; %20s
        %         B=1.693;  %20s
        
        Up1(1)=data(85,b-8)-workpoint(1);
        Up1(2)=data(85,b+1)-workpoint(1);
        P=[0.01,0.01;0.01,0.01];
        gpc_a=p_fjl_a1;%0.9895
        gpc_lmd=p_fjl_lmd1; %3250
        
        %窑电流向上向下饱和时，需程序内部自动提高或者降低分解炉温度设定值
        if 1==ydlUBH && 1==ydlBHFlag      %窑电流向上饱和
            %decomposing_furnace_tempr_1_sp 该值在gui分解炉温度滑动条滑动时更新
            decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp + 1;
            if decomposing_furnace_tempr_1_sp >= gui_fjlT_sp + 2
                decomposing_furnace_tempr_1_sp = gui_fjlT_sp + 2;
            end
            ydlBHFlag = 0;
        end
        if 1==ydlDBH && 1==ydlBHFlag      %窑电流向下饱和
            decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp - 1;
            if decomposing_furnace_tempr_1_sp <= gui_fjlT_sp - 2
                decomposing_furnace_tempr_1_sp = gui_fjlT_sp - 2;
            end
            ydlBHFlag = 0;
        end
        data(78,b+1)=decomposing_furnace_tempr_1_sp;
        decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp + fjl_temp_sp_up;
        decomposing_furnace_tempr_1_sp = decomposing_furnace_tempr_1_sp - fjl_temp_sp_down;
        
        %分解炉出口温度1偏差过大
        if abs(decomposing_furnace_tempr_1_sp - data(11,b+1))>2.0  %大偏差
            gpc_a=p_fjl_a2;%0.9885
            gpc_lmd=p_fjl_lmd2;%3250
        end
        
        
        
        %温度处于设定值上下区间，并且是还保持波动
        if mod(b,10)==0 &&abs(data(85,b-8)-data(85,b+1))<0.7
            yout1=data(11,b-9:5:b+1)-workpoint(2);
            gpc_decomposing_furnace_tempr_1_sp=decomposing_furnace_tempr_1_sp-workpoint(2);
            wmfy_sp = workpoint(1)+gpc_clac(A,B,P,yout1,Up1,gpc_decomposing_furnace_tempr_1_sp,gpc_a,gpc_lmd);
            %%%%内回路pid
            pidloop(1,7)=wmfy_sp; %sp
            if qiankui_flag>=1
                disp('触发替代燃料变化前馈，停止一次gpc');
                pidloop(1,7) = pidloop(2,7);
                qiankui_flag = 0;
            end
            %             if tdrl_open_flag>=1
            %                 disp('触发替代燃料开启前馈，停止一次gpc');
            %                 pidloop(1,7) = pidloop(2,7);
            %                 tdrl_open_flag = 0;
            %             end
            %             if tdrl_close_flag>=1
            %                 disp('触发替代燃料关闭前馈，停止一次gpc');
            %                 pidloop(1,7) = pidloop(2,7);
            %                 tdrl_close_flag = 0;
            %             end
            if duliao_flag>=1
                disp('触发堵料前馈，停止一次gpc');
                pidloop(1,7) = pidloop(2,7);
                duliao_flag = 0;
            end
            pidloop(:,7)=pid_calc(pidloop(:,7)');
            pidloop(3,7)=round(pidloop(3,7)*100)/100;
            u_final=pidloop(3,7);
            
            if ((pidloop(1,7)>=pidloop(2,7))&&(pidloop(3,7)>=yaowei_coalMAX)) %当设定值大于测量值时，并且阀门已经最大
                pidloop(1,7)= pidloop(2,7);
                pidloop(3,7)=yaowei_coalMAX;
                pidloop(10,7)=1;
            else
                pidloop(10,7)=0;
            end
            if ((pidloop(1,7)<=pidloop(2,7))&&(pidloop(3,7)<=yaowei_coalMIN)) %当设定值小于测量值时，并且阀门已经最小
                pidloop(1,7)= pidloop(2,7);
                pidloop(3,7)=yaowei_coalMIN;
                pidloop(10,7)=1;
            else
                pidloop(10,7)=0;
            end
            u_decomposing_furnace_tempr=pidloop(3,7);
            
        end
        if b > 100
            %趋势数据
            mx1 = max(data(11,b-8:b+1)); %10s的数据间隔
            mx2 = max(data(11,b-18:b-9));
            mx3 = max(data(11,b-28:b-19));
            mn1 = min(data(11,b-8:b+1));
            mn2 = min(data(11,b-18:b-9));
            mn3 = min(data(11,b-28:b-19));
            
            mx11 = max(data(11,b-28:b+1)); %30s的数据间隔
            mx21 = max(data(11,b-58:b-29));
            mx31 = max(data(11,b-88:b-59));
            
            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);
            
            %温度高于设定值，并且是还保持上升趋势
            if (mn_min>=decomposing_furnace_tempr_1_sp-fjl_cle_down) && (mod(b,13)==0)...
                    && ((mx1>mx2) && (mx2>mx3))
                % % %                     ||...
                % % %                         (mx11>mx21) && (mx21>mx31))
                delvd = 0;
                if abs(mn_min-decomposing_furnace_tempr_1_sp)>=5
                    delvd=fjl_delvd1;
                elseif abs(mn_min-decomposing_furnace_tempr_1_sp)>=3
                    delvd=fjl_delvd2;
                elseif abs(mn_min-decomposing_furnace_tempr_1_sp)>=1
                    delvd=fjl_delvd3;
                end
                if qiankui_flag1 == 0 && duliao_flag1 == 0 && tdrl_open_flag1 == 0 && tdrl_close_flag1 == 0
                    pidloop(3,7) = data(12,b+1) - (fjl_vd1 + delvd);  %温度高，需要减煤
                elseif qiankui_flag1 == 1
                    pidloop(3,7) = data(12,b+1);
                    disp('触发替代燃料变化前馈，停止一次上升趋势cle');
                    qiankui_flag1 = 0;
                    %                 elseif tdrl_open_flag1 == 1
                    %                     pidloop(3,7) = data(12,b+1);
                    %                     disp('触发替代燃料开启前馈，停止一次上升趋势cle');
                    %                     tdrl_open_flag1 = 0;
                    %                 elseif tdrl_close_flag1 == 1
                    %                     pidloop(3,7) = data(12,b+1);
                    %                     disp('触发替代燃料关闭前馈，停止一次上升趋势cle');
                    %                     tdrl_close_flag1 = 0;
                elseif duliao_flag1 == 1
                    pidloop(3,7) = data(12,b+1);
                    disp('触发堵料前馈，停止一次上升趋势cle');
                    duliao_flag1 = 0;
                end
                fjl_cle_test=0- (fjl_vd1 + delvd);
                %温度低于设定值，并且是还保持下降趋势
            elseif (mx_max<=decomposing_furnace_tempr_1_sp+fjl_cle_up) && (mod(b,13)==0)...
                    && ((mx1<mx2) && (mx2<mx3))
                % % %                     ||...
                % % %                         (mx11<mx21) && (mx21<mx31))
                delvd = 0;
                if abs(decomposing_furnace_tempr_1_sp-mx_max)>=5
                    delvd=fjl_delvd1+0.006;
                elseif abs(decomposing_furnace_tempr_1_sp-mx_max)>=3
                    delvd=fjl_delvd2+0.004;
                elseif abs(decomposing_furnace_tempr_1_sp-mx_max)>=1
                    delvd=fjl_delvd3+0.002;
                end
                
                if qiankui_flag1 == 0 && duliao_flag1 == 0 && tdrl_open_flag1 == 0 && tdrl_close_flag1 == 0
                    pidloop(3,7) = data(12,b+1) + (fjl_vd1 + delvd);  %温度低，需要加煤
                elseif qiankui_flag1 == 1
                    pidloop(3,7) = data(12,b+1);
                    disp('触发替代燃料变化前馈，停止一次下降趋势cle');
                    qiankui_flag1 = 0;
                    %                 elseif tdrl_open_flag1 == 1
                    %                     pidloop(3,7) = data(12,b+1);
                    %                     disp('触发替代燃料开启前馈，停止一次下降趋势cle');
                    %                     tdrl_open_flag1 = 0;
                    %                 elseif tdrl_close_flag1 == 1
                    %                     pidloop(3,7) = data(12,b+1);
                    %                     disp('触发替代燃料关闭前馈，停止一次下降趋势cle');
                    %                     tdrl_close_flag1 = 0;
                elseif duliao_flag1 == 1
                    pidloop(3,7) = data(12,b+1);
                    disp('触发堵料前馈，停止一次下降趋势cle');
                    duliao_flag1 = 0;
                end
                fjl_cle_test=fjl_vd1 + delvd;
            end
            
            u_decomposing_furnace_tempr=pidloop(3,7);
        end
        
        
        
        % % % % %             umax = 0.02;
        % % % % %             if (u_decomposing_furnace_tempr<=(data(72,b)-umax))
        % % % % %                 u_decomposing_furnace_tempr=data(72,b)-umax;
        % % % % %             end
        % % % % %             if (u_decomposing_furnace_tempr>=(data(72,b)+umax))
        % % % % %                 u_decomposing_furnace_tempr=data(72,b)+umax;
        % % % % %             end
        
        
    end
    
    if b > 110
        delta_wm_press_1 = data(85,b-58) - data(85,b-59);
        delta_wm_press_2 = data(85,b-59) - data(85,b-60);
        delta_wm_press_3 = data(85,b-60) - data(85,b-61);
        delta_tsj_1 = data(84,b-100) - data(84,b-101);
        delta_tsj_2 = data(84,b-101) - data(84,b-102);
        delta_tsj_3 = data(84,b-102) - data(84,b-103);
        delta_AF2_1 = data(117,b) - data(117,b+1);
        delta_AF2_2 = data(117,b-1) - data(117,b);
        delta_AF2_3 = data(117,b-2) - data(117,b-1);
    else
        delta_wm_press_1 = data(17,b+1) - data(17,b);
        delta_wm_press_2 = data(17,b) - data(17,b-1);
        delta_wm_press_3 = data(17,b-1) - data(17,b-2);
        delta_tsj_1 = data(18,b+1) - data(18,b);
        delta_tsj_2 = data(18,b) - data(18,b-1);
        delta_tsj_3 = data(18,b-1) - data(18,b-2);
        delta_AF2_1 = data(117,b) - data(117,b+1);
        delta_AF2_2 = data(117,b-1) - data(117,b);
        delta_AF2_3 = data(117,b-2) - data(117,b-1);
    end
    
    delta_wm_press = delta_wm_press_1 + delta_wm_press_2 + delta_wm_press_3;
    delta_tsj = delta_tsj_1 + delta_tsj_2 + delta_tsj_3;
    delta_AF2 = delta_AF2_1+delta_AF2_2+delta_AF2_3;
    delta_fjl = data(77,b+1) - data(11,b+1);
    delta_fjl_1 = data(11,b+1) - data(11,b);
    delta_fjl_2 = data(11,b) - data(11,b-1);
    delta_fjl_3 = data(11,b-1) - data(11,b-2);
    
    
    
    if(data(86,b+1) == 0 && mod(b,3) == 0)
        if (b > 110)
            u_final = u_decomposing_furnace_tempr; %%+delta_tsj * 0.084; %%% - delta_wm_press * 0.088
        else
            u_final = u_decomposing_furnace_tempr;
        end
    end
    if data(47,b+1) > 1.5 && b > 5
        if (abs(data(47,b+1)-data(29,b+1))>0.4 || abs(data(47,b+1)-data(29,b-2))>0.4) && mod(b,3) == 0
            u_final = u_decomposing_furnace_tempr+delta_AF2*tidaiwu_x;
%             fjl_xianfu = 0.3;
        end
    end
    
    data(73,b+1)=u_final;
    
    %CO问题
    if b > 5 && (data(46,b+1) - data(46,b) > 0.003 && data(46,b) -data(46,b-1) > 0.003)
        data(86,b+1) = 1;
        if u_final > data(73,b)
            if sum(data(44,b-3:b+1))/5 > 2500
                if mod(b,1) == 0
                    u_final = data(73,b) - 0.018;
                    u_decomposing_furnace_tempr = data(72,b) - 0.018;
                end
            elseif sum(data(44,b-3:b+1))/5 > 2000
                if mod(b,1) == 0
                    u_final = data(73,b) - 0.010;
                    u_decomposing_furnace_tempr = data(72,b) - 0.010;
                end
            elseif sum(data(44,b-3:b+1))/5 > 1530
                u_final = data(73,b) - 0.007;
                u_decomposing_furnace_tempr = data(72,b) - 0.007;
            end
        end
    else
        data(86,b+1) = 0;
    end
    %控制振幅
    if b > 10 && qiankui_flag == 0 && qiankui_flag1 == 0 && duliao_flag == 0
        umax = fjl_xianfu;
        if(u_final>data(72,b)+umax)
            u_final = data(72,b)+umax;
        elseif(u_final<data(72,b)-umax)
            u_final = data(72,b)-umax;
        end
        pidloop(3,7) = u_final;
    end
    
    %%%%%2023/3/30 wyx
    %%%%%替代燃料转化成煤
    
    %替代燃料关闭
    if b > 10
        %替代燃料关闭后补偿缺失的煤
        if ((data(48,b) == 1 && data(48,b+1) == 0) || (sum(data(48,b-1:b+1))== 0 && sum(data(48,b-4:b-2))==3)|| (sum(data(48,b-2:b+1))== 0 && sum(data(48,b-6:b-3))==4)) &&...
                AF == 1
        end
        if ((data(49,b) == 1 && data(49,b+1) == 0) || (sum(data(49,b-1:b+1))== 0 && sum(data(49,b-4:b-2))==3)|| (sum(data(49,b-2:b+1))== 0 && sum(data(49,b-6:b-3))==4)) &&...
                AF == 2
        end
        if ((data(34,b) == 1 && data(34,b+1) == 0) || (sum(data(34,b-1:b+1))== 0 && sum(data(34,b-4:b-2))==3)|| (sum(data(34,b-2:b+1))== 0 && sum(data(34,b-6:b-3))==4)) &&...
                AF == 3
        end
        %         if u_final >= duliao_up
        %             u_final = duliao_up;
        %         else
        %             if tdrl_close_flag == 1 && tdrl_close_flag1 == 1
        %                 u_final = u_final + tdrl_bc_up;
        %             end
        %         end
        %         tdrl_close_flag = 1;
        %         tdrl_close_flag1 = 1;
        %         data(119,b+1) = 1;
        %         if abs(data(77,b+1) - data(11,b+1)) < 5
        %             tdrl_close_flag = 0;
        %             tdrl_close_flag1 = 0;
        %         end
        %替代燃料开启
    elseif b >10 && (((data(48,b) == 0 && data(48,b+1) == 1) || (sum(data(48,b-1:b+1))== 3 && sum(data(48,b-4:b-2))==0)|| (sum(data(48,b-2:b+1))== 4 && sum(data(48,b-6:b-3))==0)) ||...
            ((data(49,b) == 0 && data(49,b+1) == 1) || (sum(data(49,b-1:b+1))== 3 && sum(data(49,b-4:b-2))==0)|| (sum(data(49,b-2:b+1))== 4 && sum(data(49,b-6:b-3))==0)) ||...
            ((data(34,b) == 0 && data(34,b+1) == 1) || (sum(data(34,b-1:b+1))== 3 && sum(data(34,b-4:b-2))==0)|| (sum(data(34,b-2:b+1))== 4 && sum(data(34,b-6:b-3))==0)))
        %替代燃料开启，适量降低用煤量防止温度飙升
        %         if u_final <= duliao_down
        %             u_final =  duliao_down;
        %         else
        %             u_final = u_final - tdrl_bc_down;
        %         end
        %         tdrl_open_flag = 1;
        %         tdrl_open_flag1 = 1;
        %         data(119,b+1) = -1;
        %         if abs(data(77,b+1) - data(11,b+1)) < 5
        %             tdrl_open_flag = 0;
        %             tdrl_open_flag1 = 0;
        %         end
    end
    
    %替代燃料变化的时候，加减煤
    if b>30
        if AF == 1 && (data(48,b-1) == 1 && data(48,b) == 1 && data(48,b+1) == 1)
            if data(61,b+1) > 0.3
                cc_test=(data(61,b)-data(61,b+1))*tidaiwu_x;
            end
        elseif AF == 2 && (data(49,b-1) == 1 && data(49,b) == 1 && data(49,b+1) == 1)
            if data(47,b+1) > 0.3
                cc_test=(data(47,b)-data(47,b+1))*tidaiwu_x;
            end
        elseif AF == 3 && (data(34,b-1) == 1 && data(34,b) == 1 && data(34,b+1) == 1)
            if data(32,b+1) > 0.3
                cc_test=(data(32,b)-data(32,b+1))*tidaiwu_x;
            end
        end
        u_final = u_final+cc_test;
        data(118,b+1) = cc_test;
        if cc_test ~= 0
            qiankui_flag = 1;
            qiankui_flag1 = 1;
        end
    end
    %堵料特殊处理
    if b>40
        if (data(48,b-1)== 1 && data(48,b)== 1 && data(48,b+1)== 1) && AF == 1
            if data(61,b+1) > 0.5
                if (data(61,b+1) - (data(61,b+1) - data(62,b+1))) < 0.5
                    duliao_flag = 1;
                    duliao_flag1 = 1;
                else
                    duliao_flag = 0;
                    duliao_flag1 = 0;
                end
            end
        elseif (data(49,b-1)== 1 && data(49,b)== 1 && data(49,b+1)== 1) && AF == 2
            if data(47,b+1) > 0.5
                if (data(47,b+1) - (data(47,b+1) - data(29,b+1))) < 0.5
                    duliao_flag = 1;
                    duliao_flag1 = 1;
                else
                    duliao_flag = 0;
                    duliao_flag1 = 0;
                end
            end
        elseif (data(34,b-1)== 1 && data(34,b)== 1 && data(34,b+1)== 1) && AF == 3
            if data(32,b+1) > 0.5
                if (data(32,b+1) - (data(32,b+1) - data(33,b+1))) < 0.5
                    duliao_flag = 1;
                    duliao_flag1 = 1;
                else
                    duliao_flag = 0;
                    duliao_flag1 = 0;
                end
            end
        end
        if duliao_flag == 1 && duliao_flag1 == 1
            u_final = data(12,b+1) + (data(12,b+1) - (data(12,b+1) * tidaiwu_x));
            if u_final > duliao_up
                u_final = duliao_up;
            end
        end
    end
    
    if qiankui_flag == 1 && qiankui_flag1 == 1 || duliao_flag == 1 && duliao_flag1 == 1 %|| tdrl_open_flag == 1 && tdrl_open_flag1 == 1 || tdrl_close_flag ==1 && tdrl_close_flag1 == 1
        pidloop(3,7)=u_final;
        u_decomposing_furnace_tempr=u_final;
        data(73,b+1)=u_final;
        P_write(12,u_final,yaowei_coalMAX,yaowei_coalMIN)
    end
    
    %替代燃料堵得时候，加煤
    %1. 检测到温度低于设定值8度且保持下降趋势，大幅度加煤
    %2. 在等2min做判断
    %     if b > 150 && mod(b,5) == 0 && du_flag == 0
    %         mx1 = max(data(11,b-8:b+1)); %5s的数据间隔
    %         mx2 = max(data(11,b-18:b-9));
    %         mx3 = max(data(11,b-28:b-19));
    %
    %         if ((mx1<mx2) && (mx2<mx3)) && ...
    %            (decomposing_furnace_tempr_1_sp - data(11,b+1))>= 8
    %
    % %             u_final = 7.8;
    % %             pidloop(3,7)=u_final;
    % %             u_decomposing_furnace_tempr=u_final;
    % %             du_flag = 1;
    %         end
    %     end
    %     if du_flag ~= 0
    %         du_flag = du_flag + 1;
    %     end
    %     if du_flag >= 120
    %         du_flag = 0;
    %     end
end

%% 无扰切换
%二次风温篦冷机控制
if pidloop(10,1)==1 && data(39,b+1) == false
    pidloop(1,1)=pidloop(2,1);
    pidloop(3,1)=data(2,b+1);
    pidloop(4,1)=0;
    pidloop(5,1)=0;
    pidloop(6,1)=0;
    upid(1)=data(2,b+1);
    write(itemset(3),data(2,b+1));
end
%斗提电流
if pidloop(10,4)==1 && data(43,b+1) == false
    pidloop(1,4)=pidloop(2,4);
    pidloop(3,4)=data(21,b+1);
    upid(4)=data(21,b+1);
    write(itemset(20),data(21,b+1));
    pidloop(4,4)=0;
    pidloop(5,4)=0;
    pidloop(6,4)=0;
end
%分解炉温度控制
if 0==decomposing_furnace_tempr_on && data(42,b+1) == false
    % % % % %     Up1=[data(13,b+1),data(13,b+1)]-workpoint(1);
    pidloop(1,7)=pidloop(2,7);
    pidloop(3,7)=data(13,b+1);
    u_decomposing_furnace_tempr=data(13,b+1);
    u_final = data(13,b+1);
    write(itemset(12),data(13,b+1));
end
%窑头负压控制
if pidloop(10,5)==1 && data(57,b+1) == false
    pidloop(2,5)=pidloop(1,5);
    pidloop(3,5)=data(52,b+1);
    upid(5)=data(52,b+1);
    write(itemset(51),data(52,b+1));
    pidloop(4,5)=0;
    pidloop(5,5)=0;
    pidloop(6,5)=0;
end
%窑电流控制
if pidloop(10,6)==1 && data(41,b+1) == false
    pidloop(1,6)=pidloop(2,6);
    pidloop(3,6)=data(26,b);
    upid(6) = data(26,b+1);
    write(itemset(25),data(26,b+1))
    pidloop(4,6)=0;
    pidloop(5,6)=0;
    pidloop(6,6)=0;
end


%% 输出值保存
data(71,b+1)=upid(1); %二次风温篦冷机
data(72,b+1)=u_decomposing_furnace_tempr; %分解炉温度1
% data(72,b+1)=data(13,b+1); %分解炉温度1
data(74,b+1)=upid(6);%窑电流，头煤给定值
data(75,b+1)=upid(4); %斗提电流
data(90,b+1)=upid(5); %窑头负压，头排风机转速
% data(110,b+1)=upid(6); %窑电流

%% 手动干预
%篦冷机转速手动干预
if man_in_blj == 1
    man_in_blj = 0;
    upid(1) = man_zhuansu;
    pidloop(3,1) = upid(1);
end

% 分解炉喂煤手动干预
fjl_stop_sign = false;
if man_in_fjl == 1
    man_in_fjl = 0;
    man_fjl_time_cnt = 1;
    
    decomposing_furnace_tempr_on = 0;
end
if man_fjl_time_cnt ~= 0
    man_fjl_time_cnt = man_fjl_time_cnt + 1;
    fjl_stop_sign = true;
    P_write(12,man_weimei,yaowei_coalMAX,yaowei_coalMIN);
    data(73,b+1)=man_weimei;
end
if man_fjl_time_cnt > 15
    man_fjl_time_cnt = 0;
    decomposing_furnace_tempr_on = 1;
end
%窑电流手动干预
if man_in_ydl == 1
    man_in_ydl = 0;
    upid(6) = man_ydl_toumei;
    pidloop(3,6) = upid(6);
end


%% 写控制量
%二次风温篦冷机控制
if 0==pidloop(10,1) && data(39,b+1) == true
    if abs(upid(1)-data(3,b))>=0.001
        P_write(3,upid(1),zhuansu_MAX,zhuansu_MIN)
    end
end
%分解炉温度控制
if 1==decomposing_furnace_tempr_on && fjl_stop_sign == false && data(42,b+1) == true
    if abs(u_final-data(12,b))>=0.01
        P_write(12,u_final,yaowei_coalMAX,yaowei_coalMIN)
    end
end
%斗提电流控制
if 0==pidloop(10,4) && data(43,b+1) == true
    if abs(upid(4)-data(20,b))>=0.001
        %         P_write(20,upid(4),176,164)
    end
end
%窑头负压头排风机控制
if 0==pidloop(10,5) && data(57,b+1) == true
    if abs(upid(5)-data(51,b))>=0.002
        %         P_write(51,upid(5),800,150)
    end
end
%窑电流控制
if 0==pidloop(10,6) && data(41,b+1) == true
    if abs(upid(6)-data(25,b))>=0.005
        %         P_write(25,upid(6),toumei_MAX,toumei_MIN)
    end
end


%% 报警模块
% if b > 3 && data(12,b+1) >= yaowei_coalMAX && data(12,b) >= yaowei_coalMAX
%     if(mod(b,2)==1)
%         set(handles.yaowei_coalMAX,'BackgroundColor',[1 0 0]);%将上限按钮背景为红色
%     else
%         set(handles.yaowei_coalMAX,'BackgroundColor',[0.831 0.816 0.784]);%将上限按钮背景为灰色
%     end
%     weimei_flag = 1;
% else
%     set(handles.yaowei_coalMAX,'BackgroundColor',[0.831 0.816 0.784]);%将上限按钮背景为灰色
%     weimei_flag = 0;
% end
% if b > 3 && data(12,b+1) <= yaowei_coalMIN && data(12,b) <= yaowei_coalMIN
%     if(mod(b,2)==1)
%         set(handles.yaowei_coalMIN,'BackgroundColor',[1 0 0]);%将下限按钮背景为红色
%     else
%         set(handles.yaowei_coalMIN,'BackgroundColor',[0.831 0.816 0.784]);%将下限按钮背景为灰色
%     end
%     weimei_flag = 1;
% else
%     set(handles.yaowei_coalMIN,'BackgroundColor',[0.831 0.816 0.784]);%将下限按钮背景为灰色
%     weimei_flag = 0;
% end

if ~(decomposing_furnace_tempr_1_pv_round >= decomposing_furnace_tempr_2_upperlimitS ||decomposing_furnace_tempr_1_pv_round<= decomposing_furnace_tempr_2_lowerlimitS || ...
        snd_chamber_pressure_pv_round>= snd_chamber_pressure_upperlimitS ||snd_chamber_pressure_pv_round<= snd_chamber_pressure_lowerlimitS || data(87,b + 1) > fazu1_max || ...
        data(88,b + 1) > fazu2_max) && weimei_flag == 0
    alarm_sound_flag = 0;
end

set(handles.alarmbutton,'BackgroundColor',[0.831 0.816 0.784]);%将报警设置按钮背景为灰色

if (decomposing_furnace_tempr_1_pv_round >= decomposing_furnace_tempr_2_upperlimitS||decomposing_furnace_tempr_1_pv_round<= decomposing_furnace_tempr_2_lowerlimitS || ...
        snd_chamber_pressure_pv_round>= snd_chamber_pressure_upperlimitS ||snd_chamber_pressure_pv_round<= snd_chamber_pressure_lowerlimitS || ...
        data(87,b+1) > fazu1_max || data(88,b + 1) > fazu2_max || weimei_flag == 1)&& ~alarm_button_clicked
    if(mod(b,2)==1)
        set(handles.alarmbutton,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
    else
        set(handles.alarmbutton,'BackgroundColor',[0.831 0.816 0.784]);%将报警设置按钮背景为灰色
    end
    alarm_sound_flag = 1;
end

try
    set(pophandles.text12,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
    set(pophandles.text13,'ForegroundColor',[0 0 0]);
    set(pophandles.text14,'ForegroundColor',[0 0 0]);
    set(pophandles.text15,'ForegroundColor',[0 0 0]);
    set(pophandles.fazu1_max,'ForegroundColor',[0 0 0]);
    set(pophandles.fazu1_min,'ForegroundColor',[0 0 0]);
    set(pophandles.fazu2_max,'ForegroundColor',[0 0 0]);
    set(pophandles.fazu2_min,'ForegroundColor',[0 0 0]);
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

if (data(87,b + 1) > fazu1_max)
    try
        if(mod(b,2)==1)
            set(pophandles.fazu1_max,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.fazu1_max,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

if (data(88,b + 1) > fazu2_max)
    try
        if(mod(b,2)==1)
            set(pophandles.fazu2_max,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.fazu2_max,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
        %disp('没有打开报警设置窗口');
    end
end

try
    if alarm_sound_flag
        load chirp
        sound(y,Fs)
    end
catch
    disp('报警声音异常');
end

if alarm_button_clicked
    if alarm_timer == 0
        alarm_timer = 120;
        alarm_button_clicked = 0;
    else
        alarm_timer = alarm_timer - 1;
    end
end

%报警实时
try
    % identifier:1、2、3、4分别表示21#、22#、23#、24#号炉和UpTemPv值1、2、3、4对应
    set(pophandles.text11,'String',num2str(snd_chamber_pressure_pv_round));
    set(pophandles.text10,'String',num2str(decomposing_furnace_tempr_1_pv_round));
    set(pophandles.fazu1,'String',num2str(data(87,b + 1)));
    set(pophandles.fazu2,'String',num2str(data(88,b + 1)));
catch
    %     disp('没有打开报警设置窗口');
end

%% 清屏
if mod(b,100)==0                   %每100s清屏
    clc;
end

end
