function on_timer(obj,event,handles)
global daobj group   lastsave  data b tempdata tempdatavalue  first data1 paramdata first_time_connect_flag_ontimer
global blj_on fjl_on douti_on toumei_on yaotou_on c1_press_on xintiao_on
global pidloop upid fj11dl0 fj11dl1 fj11dl2 fj11dl3
global A B P gpc_a gpc_lmd workpoint Up1 fjl_temp_sp yout1 u_decomposing_furnace_tempr 
global fj11dl_sp dtdlcntflag dtdlcnt 
global blj_vd zhuansu_MAX zhuansu_MIN temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2 fjl_vd fjl_max fjl_min
global dt_max dt_min blj_delvd ufjl blj_gpc_value
global tm_alpha tm_beta tm_gamma tm_max tm_min tm_alpha1 tm_beta1 tm_gamma1
global yt_alpha yt_beta yt_gamma yt_max yt_min yt_alpha1 yt_beta1 yt_gamma1
global f11dl_asc f11dl_flat f11dl_desc u_blj_speed workpoint2 A2 B2 Up2 yout2
global p_blj_a1 p_blj_lmd1 p_blj_a2 p_blj_lmd2 dtdlcntMax blj_delvd1_up blj_delvd2_up blj_delvd3_up blj_delvd4_up blj_delvd1_down blj_delvd2_down blj_delvd3_down blj_delvd4_down
global workpoint3 A3 B3 Up3 yout3 dtdl_sp u_dtdl_wll 
global man_in_blj man_zhuansu man_in_fjl man_weimei man_in_dtdl man_dtdl man_in_toumei man_toumei man_in_yaotou man_yaotou man_in_gaowen man_gaowen
global keycount hisdatadays hitdata_title  
global wmfy_sp u_final fjl_test itemset loopnum
global douti_jisuan toumei_jisuan c1_jisuan toupai_jisuan pophandles fjl_delvd1 fjl_delvd2 fjl_delvd3 fjl_delvd4
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global fazu1_max fazu1_min fazu2_max fazu2_min alarm_sound_flag alarm_timer alarm_button_clicked
global man_blj_time_cnt man_fjl_time_cnt fjl_cle_test fjl_tishenji manauto modtime zeng zeng1
%%%%%wyx 2023/4/24
global blj_fjdl fjl_wendu douti_wl yaotou_wm gwfj_zs toupai_zs time_j jiou ysphfjdlDV
global tidai_on douti_style fjl_bcbl fjl_cm_test fjltempsp11 fjltempbc blj_up blj_down delta_differenceValue speed_differenceValue blj_limit blj_judge_time blj_chazhi blj_up_moren blj_down_moren
global ecfw_cnt_inner_sp ecfw_sp ecfw_spcnt blj_speed_stop_flag pressure_vd zhuansu_mid yachuang_mv ysphfjdl temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global pressure_vd_low kongchuang_mv
%% 获取OPC中各变量的值 
try
tic
tempdata = read(group);              % length(tempdata) = 35
[~, b] = size(data);        % b=1
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end
    tempdata(38).Value=fj11dl_sp;%%%%%wyx设定值存csv
    tempdatavalue(38) = tempdata(38).Value;%%%%%wyx设定值存csv
    tempdata(39).Value=fjl_temp_sp;
    tempdatavalue(39) = tempdata(39).Value;
    tempdata(40).Value=dtdl_sp;
    tempdatavalue(40) = tempdata(40).Value;


first_time_connect_flag_ontimer = first_time_connect_flag_ontimer - 1;
if first_time_connect_flag_ontimer<=0
   first_time_connect_flag_ontimer=0;
end    
% a = length(itemset);       %此时a=60
data1(1,b+1) = data(10,b+1);
%% 保存csv
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
%% 从xml文件中给变量赋值
if mod(b,10) == 0 %每10s读取一次xml文件
    paramdata = xml_read('param_set.xml');
end

%篦冷机相关参数获取 
p_blj_a1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a1;
p_blj_lmd1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd1;
p_blj_a2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a2;
p_blj_lmd2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd2;
zhuansu_MAX = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_max;
zhuansu_MIN = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_min;
blj_vd = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_vd;
dtdlcntMax = paramdata.commdata(1).parameter(2).ATTRIBUTE.dtdlcntMax;
% blj_delvd1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1;
% blj_delvd2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2;
% blj_delvd3 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3;
% blj_delvd4 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4;
blj_delvd1_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1_up;
blj_delvd2_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2_up;
blj_delvd3_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3_up;
blj_delvd4_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4_up;
blj_delvd1_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1_down;
blj_delvd2_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2_down;
blj_delvd3_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3_down;
blj_delvd4_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4_down;
ufjl = paramdata.commdata(1).parameter(2).ATTRIBUTE.ufjl;
% % % blj_delvd1_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1_down;
% % % blj_delvd2_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2_down;
% % % blj_delvd3_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3_down;
% % % blj_delvd4_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4_down;
DTlevel0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.DTlevel0;
DTlevel1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.DTlevel1;
DTlevel2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.DTlevel2;
DTlevel3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.DTlevel3;
WLlevel0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel0;
WLlevel1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel1;
WLlevel2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel2;
WLlevel3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel3;
fj11dl0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0;
fj11dl1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1;
fj11dl2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2;
fj11dl3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3;
zhuansu_MAX0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MAX0;
zhuansu_MAX1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MAX1;
zhuansu_MAX2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MAX2;
zhuansu_MAX3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MAX3;
zhuansu_MIN0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MIN0;
zhuansu_MIN1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MIN1;
zhuansu_MIN2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MIN2;
zhuansu_MIN3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.zhuansu_MIN3;
pressure_vd_low = paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd_low; 
kongchuang_mv= paramdata.commdata(1).parameter(13).ATTRIBUTE.kongchuang_mv;
%分解炉gpc参数获取 
temp_fjl_alpha1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha1;
temp_fjl_lambda1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda1;
temp_fjl_alpha2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2;
temp_fjl_lambda2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2;
fjl_vd = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_vd;
fjl_max = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_max;
fjl_min = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_min;
fjl_xianfu = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_xianfu;
fjl_delvd1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd1;
fjl_delvd2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd2;
fjl_delvd3 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd3;
fjl_delvd4 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd4;
fjl_a = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_a;
fjl_b = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_b;
fjl_c = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_c;
fjl_douti_P = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_douti_P;
fjl_weimeipress_P = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_weimeipress_P;
fjl_cle_max=paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_cle_max;
fjl_cle_min=paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_cle_min;
blj_cle_max=paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_cle_max;
blj_cle_min =paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_cle_min;

fjl_CO_level1 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_level1;
fjl_CO_level2 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_level2;
fjl_CO_level3 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_level3;
fjl_CO_P1 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_P1;
fjl_CO_P2 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_P2;
fjl_CO_P3 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_P3;
wmfy_xianfu = paramdata.commdata(1).parameter(14).ATTRIBUTE.wmfy_xianfu;
fjl_CO_jm = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_jm;
fjl_CO_time = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_CO_time;
fjl_jm_YuDu = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_jm_YuDu;
fjl_jm_time1 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_jm_time1;
fjl_jm_time2 = paramdata.commdata(1).parameter(14).ATTRIBUTE.fjl_jm_time2;

%斗提电流pid参数获取 
dtdl_alpha = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_alpha;
dtdl_beta = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_beta;
dtdl_vd = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_vd;
dt_max = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_max;
dt_min = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_min;
dtdl_delvd1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_delvd1;
dtdl_delvd2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_delvd2;
dtdl_delvd3 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_delvd3;
%头煤pid参数获取 
tm_alpha = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha;
tm_beta = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta;
tm_gamma = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_gamma;
tm_alpha1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha1;%大偏差参数
tm_beta1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta1;
tm_gamma1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_gamma1;
tm_max = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_max;
tm_min = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_min;
%窑头pid参数获取 
yt_alpha = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_alpha;
yt_beta = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_beta;
yt_gamma = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_gamma;
yt_alpha1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_alpha1; %大偏差参数
yt_beta1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_beta1;
yt_gamma1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_gamma1;
yt_max = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_max;
yt_min = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_min;
%高温风机pid参数获取 
gwfj_alpha = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_alpha;
gwfj_beta = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_beta;
gwfj_gamma = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_gamma;
gwfj_alpha1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_alpha1; %大偏差参数
gwfj_beta1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_beta1;
gwfj_gamma1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_gamma1;
gwfj_max = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_max;
gwfj_min = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_min;

% 冲煤补偿
fjl_bcbl = paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_bcbl;
fjltempbc=paramdata.commdata(1).parameter(11).ATTRIBUTE.fjltempbc;
%动态控制篦冷机上下限区间
delta_differenceValue= paramdata.commdata(1).parameter(12).ATTRIBUTE.delta_differenceValue; %电流设定值差值
speed_differenceValue=paramdata.commdata(1).parameter(12).ATTRIBUTE.speed_differenceValue;%篦速差值
blj_limit = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_limit;%上下限变化值
blj_judge_time = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_judge_time; %判断区间
blj_chazhi = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_chazhi; %表示上下限差值
blj_up_moren = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_up_moren; %默认上限
blj_down_moren = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_down_moren; %默认下限

%二次风温控制篦速
ecfw_sp =  paramdata.commdata(1).parameter(13).ATTRIBUTE.ecfw_sp; 
pressure_vd = paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd; 
zhuansu_mid = paramdata.commdata(1).parameter(13).ATTRIBUTE.zhuansu_mid; 
ysphfjdl = paramdata.commdata(1).parameter(13).ATTRIBUTE.ysphfjdl; 
yachuang_mv= paramdata.commdata(1).parameter(13).ATTRIBUTE.yachuang_mv; 
temp_blj_alpha1= paramdata.commdata(1).parameter(13).ATTRIBUTE.blj_alpha1; 
temp_blj_beta1= paramdata.commdata(1).parameter(13).ATTRIBUTE.blj_beta1; 
temp_blj_gamma1= paramdata.commdata(1).parameter(13).ATTRIBUTE.blj_gamma1; 
ysphfjdlDV=paramdata.commdata(1).parameter(13).ATTRIBUTE.ysphfjdlDV; 
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
    data1(2,2:3900)=data(87,2:3900);
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

data(80,b+1) = data(11,b+1);
data(77,b+1)=wmfy_sp;%尾煤风压设定


%%%%%wyx 2023/4/24
blj_fjdl=data(5,b+1);
fjl_wendu=data(11,b+1);
if data(28,b+1)>50
    douti_wl=data(29,b+1);
else
    douti_wl=data(36,b+1);
end
yaotou_wm=data(19,b+1); 
gwfj_zs=data(32,b+1); 
toupai_zs=data(49,b+1);

%篦冷机 
set(handles.first_fj_fk,'String',num2str(round(100*data(3,b+1))/100,'%4.2f')); 
set(handles.first_fj_sp,'String',num2str(round(100*data(9,b))/100,'%4.2f')); 
set(handles.first_fj_sp2,'String',num2str(round(100*data(9,b))/100,'%4.2f'));
set(handles.first_dl_fk,'String',num2str(round(100*data(5,b+1))/100,'%4.2f')); 
set(handles.first_dl_sp,'String',num2str(round(100*ecfw_sp)/100,'%4.2f')); 
set(handles.blj_yali,'String',num2str(round(100*data(1,b+1))/100,'%4.1f')); 
%分解炉
set(handles.fjl_wml_fk,'String',num2str(round(100*data(14,b+1))/100,'%4.2f')); 
set(handles.fjl_wml_sp,'String',num2str(round(100*data(13,b+1))/100,'%4.2f')); 
set(handles.fjl_wml_sp2,'String',num2str(round(100*data(13,b+1))/100,'%4.2f')); 
set(handles.fjl_temp_fk,'String',num2str(round(100*data(11,b+1))/100,'%4.2f'));
set(handles.weimei_press_lvbo,'String',num2str(round(100*data(33,b+1))/100,'%4.2f'));
set(handles.wm_fuhe,'String',num2str(round(100*data(47,b+1))/100,'%4.2f'));
%斗提电流
set(handles.dt_wll_fk,'String',num2str(round(100*data(28,b+1))/100,'%4.2f')); 
set(handles.dt_wll_sp,'String',num2str(round(100*data(37,b+1))/100,'%4.2f')); 
set(handles.dt_wll_fk2,'String',num2str(round(100*data(37,b+1))/100,'%4.2f')); 
set(handles.dt_wll_sp2,'String',num2str(round(100*data(36,b+1))/100,'%4.2f')); 
set(handles.dt_dl_fk,'String',num2str(data(25,b+1),'%4.2f')); 

%头煤压力
set(handles.tm_wml_fk,'String',num2str(round(100*data(18,b+1))/100,'%4.2f')); 
set(handles.tm_wml_sp,'String',num2str(round(100*data(19,b+1))/100,'%4.2f')); 
set(handles.tm_press_fk,'String',num2str(round(100*data(30,b+1))/100,'%4.2f')); 
%c1出口压力
set(handles.gw_fj_fk,'String',num2str(round(100*data(32,b+1))/100,'%4.2f')); 
set(handles.gw_fj_sp,'String',num2str(round(100*data(31,b+1))/100,'%4.2f')); 
set(handles.c1_press_pv,'String',num2str(round(100*data(27,b+1))/100,'%4.2f')); 
%窑头负压
set(handles.yaotou_press_pv,'String',num2str(round(100*data(20,b+1))/100,'%4.2f')); 
set(handles.toupai_zhuansu_pv,'String',num2str(round(100*data(49,b+1))/100,'%4.2f')); 
% set(handles.toupai_zhuansu_sp,'String',num2str(round(100*data(45,b+1))/100,'%4.2f'));
%二次风温
set(handles.ecfw_display,'String',num2str(round(100*data(16,b+1))/100,'%4.2f')); 
%三次风温
set(handles.scfw_display,'String',num2str(round(100*data(15,b+1))/100,'%4.2f')); 
%回转窑电流
set(handles.hzy_diplay,'String',num2str(round(100*data(22,b+1))/100,'%4.2f')); 
%窑尾分析CO反馈
set(handles.yaowei_co,'String',num2str(round(100*data(46,b+1))/100,'%4.2f')); 
%窑尾分析O2反馈
set(handles.yaowei_o2,'String',num2str(round(1000*data(34,b+1))/1000,'%4.2f')); 
%% 获取设定值
fjltempsp11 = str2double(get(handles.fjl_temp_sp,'String'));
fjl_temp_sp = fjltempsp11 - fjltempbc;
dtdl_sp = str2double(get(handles.douti_sp,'String'));
data(90,b+1) = str2double(get(handles.toumei_sp,'String'));
data(91,b+1) = str2double(get(handles.c1_press_sp,'String'));
data(92,b+1) = str2double(get(handles.yaotou_press_sp,'String'));
data(87,b+1) = fj11dl_sp;   %一级风机电流设定值
data(88,b+1) = fjl_temp_sp; %gui界面设定值
data(89,b+1) = dtdl_sp;
%% 记录设定值
data(65,b+1) = fj11dl_sp;
data(66,b+1) = fjl_temp_sp;
data(67,b+1) = dtdl_sp;
data(68,b+1) = str2double(get(handles.toumei_sp,'String'));
data(69,b+1) = str2double(get(handles.c1_press_sp,'String'));
data(70,b+1) = str2double(get(handles.yaotou_press_sp,'String'));

%% 获取开关标志位 
data(82,b+1) = blj_on;
data(83,b+1) = fjl_on;
data(84,b+1) = douti_on;
data(85,b+1) = toumei_on;
data(86,b+1) = yaotou_on;
data(76,b+1) = c1_press_on;
%% 记录开关标志位
data(59,b+1) = blj_on;
data(60,b+1) = fjl_on;
data(61,b+1) = douti_on;
data(62,b+1) = toumei_on;
data(63,b+1) = c1_press_on;
data(64,b+1) = yaotou_on;


%% 回路控制模式判断

%篦冷机
if blj_on == 1 &&  data(51,b+1) == true
     write(itemset(52),true)
else
    write(itemset(52),false)
    data(2,b+1) = data(9,b+1);
end

%分解炉
if fjl_on == 1 &&  data(51,b+1) == true
     write(itemset(55),true)
else
    write(itemset(55),false)
    data(13,b+1) = data(10,b+1);
end
if data(51,b+1) == false
    
    blj_on=0;
    fjl_on=0;
    douti_on=0;
    toumei_on=0;
    yaotou_on=0;
    c1_press_on=0;
    ecfw_spcnt = -1; %停止控制器时，将该值复位
    blj_speed_stop_flag = false;
    man_in_blj=0;
    man_in_fjl=0;
    man_in_dtdl=0;
    man_in_toumei=0;
    man_in_yaotou=0;
    man_in_gaowen=0;
    
    man_blj_time_cnt = 0;
    man_fjl_time_cnt = 0;
    
    % % % % % %wyx 2023/6/27 新增回路开关记录txt
    % % % % % curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    % % % % % timestr=curT(1:10);
    % % % % % fid=fopen(['LOG\data',timestr,'.txt'],'at');
    % % % % % fprintf(fid,'%s\n',curT);
    % % % % % fprintf(fid,'%s\n','所有回路关闭');
    % % % % % fclose(fid);
    %
    
    set(handles.blj_button_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.pushbutton_douti_right,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.douti_button_on,'BackgroundColor',[0.941 0.941 0.941]);
    % set(handles.douti_button_off,'BackgroundColor',[1 0 0]);
    
    set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.toumei_button_on,'BackgroundColor',[0.941 0.941 0.941]);
    % set(handles.toumei_button_off,'BackgroundColor',[1 0 0]);
    
    set(handles.c1_press_button_on,'BackgroundColor',[0.941 0.941 0.941]);
    % set(handles.c1_press_button_off,'BackgroundColor',[1 0 0]);
    set(handles.yaotou_button_on,'BackgroundColor',[0.94 0.94 0.94]);
    % set(handles.yaotou_button_off,'BackgroundColor',[1 0 0]);
    
end


%% 开关启动判断
% 1 篦冷机 采用gpc
% 2 分解炉 采用gpc+pid
if 1 == fjl_on
    pidloop(10,7) = 0;
else
    pidloop(10,7) = 1;
end
% 3 斗提电流 
if 1 == douti_on
    pidloop(10,3) = 0;
else
    pidloop(10,3) = 1;
end
% 4 头煤
if 1 == toumei_on
    pidloop(10,4) = 0;
else
    pidloop(10,4) = 1;
end
% 5 窑头负压
if 1 == yaotou_on
    pidloop(10,5) = 0;
else
    pidloop(10,5) = 1;
end
% 6 高温风机 c1出口负压
if 1 == c1_press_on
    pidloop(10,6) = 0;
else
    pidloop(10,6) = 1;
end

%% 实际值滤波

% f11风机电流滤波
% if b>=50    
%     data(101,b+1)=sum(data(7,b-33:b+1))/35;%11风机电流 35
% else
%     data(101,b+1)=data(7,b+1);
% end
dl_lvbo_time = 20;
if b > dl_lvbo_time
    data(101,b+1) = mean([data(101,b-dl_lvbo_time+2:b),data(5,b+1)]);
elseif b>2
    data(101,b+1)=mean([data(101,2:b),data(5,b+1)]);   
else
    data(101,b+1)=data(5,b+1);
end

% 分解炉温度滤波
if b>13
    data(81,b+1)=sum(data(80,b-8:b+1))/10;    
else
    data(81,b+1) = data(80,b+1);
end
%尾煤风压滤波值
if b>21
    data(79,b+1)=sum(data(33,b-8:b+1))/10; %尾煤风压
else
    data(79,b+1)=data(33,b+1);
end
% 斗提电流滤波值
% dtdl_lvbo_time = 60;
% 斗提电流滤波
if b>61
    data(102,b+1)=sum(data(25,b-48:b+1))/50;%%30
else
    data(102,b+1)=data(25,b+1);
end
% % % % % if b > dtdl_lvbo_time
% % % % %     data(102,b+1) = mean([data(102,b-dl_lvbo_time+2:b),data(25,b+1)]);
% % % % % elseif b>2
% % % % %     data(102,b+1)=mean([data(102,2:b),data(25,b+1)]);   
% % % % % else
% % % % %     data(102,b+1)=data(25,b+1);
% % % % % end
%头煤压力滤波值
if b>31
    data(103,b+1)=sum(data(30,b-18:b+1))/20; %头煤压力
else
    data(103,b+1)=data(30,b+1);
end
%窑头负压滤波值
if b>50
    data(104,b+1)=sum(data(20,b-43:b+1))/45; %窑头负压
else
    data(104,b+1)=data(20,b+1);
end
%高温风机入口负压滤波值
if b>41
    data(105,b+1)=sum(data(57,b-33:b+1))/35; %c1出口负压
else
    data(105,b+1)=data(57,b+1);
end


%% pid 设定值
pidloop(1,4) = data(90,b+1); %头煤压力设定值
pidloop(2,5) = data(92,b+1); %窑头负压 反特性
pidloop(1,6) = data(91,b+1); %高温风机设定值
pidloop(1,3) = data(89,b+1); %斗提电流设定值
pidloop(2,8) = ecfw_sp; %二次风温反特性
%% pid 实际值
pidloop(2,4) = data(103,b+1);%头煤压力检测值
pidloop(1,5) = data(104,b+1);%窑头压力检测值
pidloop(2,6) = data(105,b+1); %高温风机检测值
pidloop(2,7) = data(79,b+1);%尾煤压力检测值
pidloop(2,3) = data(102,b+1); %斗提电流检测值
pidloop(1,8) = data(16,b+1); %二次风温检测值
if b>=13
    pidloop(1,8)=sum(data(16,b-9:b+1))/11; %二次风温
end
%% pid参数整定
%二次风温参数整定
pidloop(7,8)=temp_blj_alpha1;%0.021;%kuc     1.3
pidloop(8,8)=temp_blj_beta1;%50;%k   20
pidloop(9,8)=temp_blj_gamma1;%0;%kec  0.01
pidloop(11,8)=zhuansu_MAX;
pidloop(12,8)=zhuansu_MIN;
pidloop(13,8)=0.01;% 30
%分解炉参数整定
pidloop(7,7) = fjl_a;
pidloop(8,7) = fjl_b;
pidloop(9,7) = fjl_c;
pidloop(11,7) = fjl_max;
pidloop(12,7) = fjl_min;
pidloop(13,7)=0.01;
%斗提电流参数整定
pidloop(7,3) = dtdl_alpha; %kp
pidloop(8,3) = dtdl_beta;  %ki
pidloop(9,3) = 0;          %kd
pidloop(11,3) = dt_max;
pidloop(12,3) = dt_min;
pidloop(13,3)=0.01;
%头煤压力参数整定
pidloop(7,4) = tm_alpha;
pidloop(8,4) = tm_beta;
pidloop(9,4) = tm_gamma;
pidloop(11,4) = tm_max;
pidloop(12,4) = tm_min;
pidloop(13,4)=0.01;
%窑头负压参数整定
pidloop(7,5) = yt_alpha;
pidloop(8,5) = yt_beta;
pidloop(9,5) = yt_gamma;
pidloop(11,5) = yt_max;
pidloop(12,5) = yt_min;
pidloop(13,5)=0.01;
%c1出口负压参数整定
pidloop(7,6) = gwfj_alpha;
pidloop(8,6) = gwfj_beta;
pidloop(9,6) = gwfj_gamma;
pidloop(11,6) = gwfj_max;
pidloop(12,6) = gwfj_min;
pidloop(13,6)=0.01;
%% 各段回路控制计算


%%心跳

if xintiao_on == 1
    if mod(b,2) == 0
        write(itemset(50),true)
    else
        write(itemset(50),false) 
    end
end
%% 计算各段篦冷机控制量
[~, loopnum]=size(pidloop);
%% %%%%%%%%%篦冷机回路模块%%%%%%%%%%%%
if 1 == blj_on    
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
        if ((pidloop(1,8)>=pidloop(2,8))&&(pidloop(3,8)>=zhuansu_MAX))  %当测量值大于设定值时，并且阀门已经最大，反特性
            pidloop(2,8)= pidloop(1,8);
            pidloop(3,8)=zhuansu_MAX;
        end

        if ((pidloop(1,8)<=pidloop(2,8))&&(pidloop(3,8)<=zhuansu_MIN)) %当测量值小于设定值时，并且阀门已经最小，反特性
            pidloop(2,8)= pidloop(1,8);
            pidloop(3,8)=zhuansu_MIN;
        end
    end
    %%判断是否触发红线
    if b > 40
        if (max(data(1,b-31:b+1)) > pressure_vd)...
                ||(max(data(5,b-31:b+1)) <= ysphfjdl) %一室平衡风机电流过小于61A表示不透风
            blj_speed_stop_flag = true;
        end
    end
    
%     if b>180
%          %压力趋势下降
%         if max(data(1,b-21:b+1)) < max(data(1,b-44:b-22))...
%                 && max(data(1,b-67:b-45))<max(data(1,b-89:b-67))...
%                 && max(data(1,b-21:b+1)) < pressure_vd_low + 0.3...
%                 && (mod(b,30) == 0)
%             if u_blj_speed > zhuansu_MAX
%                 u_blj_speed = zhuansu_MAX - kongchuang_mv;
%             else
%                 u_blj_speed = u_blj_speed - kongchuang_mv;
%             end
%             
%             if u_blj_speed <= zhuansu_MIN
%                 u_blj_speed = zhuansu_MIN;
%             end
%             pidloop(3,8) = u_blj_speed;
%         end
%         %压力趋势上涨
%         if max(data(1,b-21:b+1)) > max(data(1,b-44:b-22))...
%                 && max(data(1,b-67:b-45))>max(data(1,b-89:b-67))...
%                 && max(data(1,b-21:b+1)) > pressure_vd - 0.25
%             blj_speed_stop_flag = true;
%         end
%        
%     end

    %触发红线则data(73,b+1)置1 
    if (blj_speed_stop_flag == true) && (mod(b,70) == 0) %30
        if u_blj_speed < zhuansu_MIN
            u_blj_speed = zhuansu_MIN + yachuang_mv;
        else
            u_blj_speed = u_blj_speed + yachuang_mv;
        end

        data(106,b+1) = 1;
        if u_blj_speed >= zhuansu_MAX
            u_blj_speed = zhuansu_MAX;
        end
        pidloop(3,8) = u_blj_speed;
        blj_speed_stop_flag = false; %复位
    end

    %%二次风温控制回路
    if mod(b,60)==0 %10
        pidloop(:,8)=pid_calc(pidloop(:,8)');
        if blj_speed_stop_flag == false
           pidloop(3,8)=round(pidloop(3,8)*1000)/1000;%修改：根据现场调节给定精度
           u_blj_speed=round(pidloop(3,8)*1000)/1000;
           umax = 0.02;
           if (u_blj_speed<data(9,b+1)-umax)
               u_blj_speed=data(9,b+1)-umax;
           end
           if (u_blj_speed>data(9,b+1)+umax)
               u_blj_speed=data(9,b+1)+umax;
           end
           
        else
           pidloop(3,8) = u_blj_speed;
        end
    end
    %篦冷机转速振幅,防止回中场时被限制，所以去掉振幅
%     umax = 1;
%     if (u_blj_speed<data(2,b+1)-umax)
%         u_blj_speed=data(2,b+1)-umax;
%     end
%     if (u_blj_speed>data(2,b+1)+umax)
%         u_blj_speed=data(2,b+1)+umax;
%     end
    %篦冷机转速返回中场速度，这部分不可再控制振幅之前
    if b > 300
        % 如果趋势已经发生转折，则判断为趋势到顶开始脱离危险状态
        %(min(data(1,b-8:b+1)) < min(data(1,b-18:b-9))) && (min(data(1,b-18:b-9))<min(data(1,b-28:b-19)))...
        if ((max(data(1,b-31:b+1)) < max(data(1,b-64:b-32))...
            && max(data(1,b-97:b-65))<max(data(1,b-129:b-97)))...
            || (max(data(1,b-21:b+1)) < pressure_vd))... 
            && (max(data(5,b-21:b+1)) > ysphfjdl + ysphfjdlDV)
            % 如果前五分钟内有五次及以上触发红线并且篦床压力恢复到预警值附近，则回到中场转速
            if sum(data(106,b-298:b+1)) >= 2 && max(data(1,b-111:b+1))< pressure_vd  %%
                % 目前转速大于中场转速，则回到中场转速，否则不管
                if u_blj_speed > zhuansu_mid
%                     chazhi=max(data(96,b-111:b+1))-zhuansu_mid;
%                     if chazhi<0.14
                        u_blj_speed = zhuansu_mid;
%                     else
%                         u_blj_speed = zhuansu_mid+0.05;
%                     end
                    pidloop(3,8) = u_blj_speed;
                end
            end
        end
    end
    data(96,b+1) = u_blj_speed;
    pidloop(3,8) = u_blj_speed;
end

%%%%%%%%%%%篦冷机回路模块结束%%%%%%%%

%% %%%%%%%%%分解炉回路模块%%%%%%%%%%%%
if 1 == fjl_on
    if b>21 %这个时间的判断注意和控制周期以及Up1(1)=data(12,b-4)-workpoint(1)b-4匹配
        
        %%%%外回路gpc
        
        % % % % % % %wyx
        workpoint=[37.6877,901.3187];
        
        %         A=[-0.996,1]; %5s
        %         B=0.7109;  %5s
        %        A=[-0.992,1]; %10s
        %        B=1.419;  %10s
        A=[-0.9881,1]; %15s
        B=2.124;  %15s
        %         A=[-0.9841,1]; %20s
        %         B=2.826;  %20s
        %         A=[-0.9802,1]; %25s
        %         B=3.526;  %25s
        
        
        Up1(1)=data(79,b-13)-workpoint(1);
        Up1(2)=data(79,b+1)-workpoint(1);
        
        
        P=[0.01,0.01;0.01,0.01];
        gpc_a=temp_fjl_alpha1;
        gpc_lmd=temp_fjl_lambda1;
        
        if abs(fjl_temp_sp- data(11,b+1))>3.5
            gpc_a=temp_fjl_alpha2;
            gpc_lmd=temp_fjl_lambda2;
        end
        
        yout1=data(11,b-13:7:b+1)-workpoint(2);
        
        
        if mod(b,15)==0  &&abs(data(79,b-13)-data(79,b+1))<1
            gpc_fjl_temp_sp=fjl_temp_sp-workpoint(2);
            wmfy_sp = workpoint(1)+gpc_clac(A,B,P,yout1,Up1,gpc_fjl_temp_sp,gpc_a,gpc_lmd);
            %尾煤压力限幅
%             if(wmfy_sp>pidloop(1,7)+wmfy_xianfu)
%                 wmfy_sp =pidloop(1,7)+wmfy_xianfu;
%             elseif(wmfy_sp<pidloop(1,7)-wmfy_xianfu)
%                 wmfy_sp = pidloop(1,7)-wmfy_xianfu;
%             end
            
            %%%%内回路pid
            pidloop(1,7)=wmfy_sp; %sp
            pidloop(:,7)=pid_calc(pidloop(:,7)');
            pidloop(3,7)=round(pidloop(3,7)*100)/100;
            data(77,b+1)=wmfy_sp;%尾煤风压设定
            
            
            if ((pidloop(1,7)>=pidloop(2,7))&&(pidloop(3,7)>=fjl_max)) %当设定值大于测量值时，并且阀门已经最大
                pidloop(1,7)= pidloop(2,7);
                pidloop(3,7)=fjl_max;
                pidloop(10,7)=1;
            else
                pidloop(10,7)=0;
            end
            if ((pidloop(1,7)<=pidloop(2,7))&&(pidloop(3,7)<=fjl_min)) %当设定值小于测量值时，并且阀门已经最小
                pidloop(1,7)= pidloop(2,7);
                pidloop(3,7)=fjl_min;
                pidloop(10,7)=1;
            else
                pidloop(10,7)=0;
            end
            fjl_test=pidloop(3,7)-u_decomposing_furnace_tempr;
            u_decomposing_furnace_tempr=pidloop(3,7);
        end
        if b > 150
            %趋势数据
            mx1 = max(data(11,b-8:b+1)); %10s的数据间隔
            mx2 = max(data(11,b-18:b-9));
            mx3 = max(data(11,b-28:b-19));
            mn1 = min(data(11,b-8:b+1));
            mn2 = min(data(11,b-18:b-9));
            mn3 = min(data(11,b-28:b-19));
            
            mx11 = max(data(11,b-38:b+1)); %40s的数据间隔
            mx21 = max(data(11,b-78:b-39));
            mx31 = max(data(11,b-118:b-79));
            
            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);
            
            %温度高于设定值，并且是还保持上升趋势
            if (mn_min>=fjl_temp_sp-fjl_cle_min) && (mod(b,23)==0)...
                    && (((mx1>mx2) && (mx2>mx3)) ||...
                    (mx11>mx21) && (mx21>mx31))
                fjl_delvd = 0;
                if  mn_min-fjl_temp_sp>=13
                    fjl_delvd=fjl_delvd4;
                elseif mn_min-fjl_temp_sp>=7
                    fjl_delvd=fjl_delvd3;
                elseif mn_min-fjl_temp_sp>=4
                    fjl_delvd=fjl_delvd2;
                elseif abs(mn_min-fjl_temp_sp)>=1
                    fjl_delvd=fjl_delvd1;
                end
                pidloop(3,7) = data(13,b+1) - (fjl_vd + fjl_delvd);  %温度高，需要减煤
                fjl_cle_test=0- (fjl_vd + fjl_delvd);
                %温度低于设定值，并且是还保持下降趋势
            elseif (mx_max<=fjl_temp_sp+fjl_cle_max) && (mod(b,23)==0)...
                    && (((mx1<mx2) && (mx2<mx3))||...
                    (mx11<mx21) && (mx21<mx31))
                fjl_delvd = 0;
                if  fjl_temp_sp-mx_max>=13
                    fjl_delvd=fjl_delvd4;
                elseif fjl_temp_sp-mx_max>=7
                    fjl_delvd=fjl_delvd3;
                elseif fjl_temp_sp-mx_max>=4
                    fjl_delvd=fjl_delvd2;
                elseif abs(fjl_temp_sp-mx_max)>=1
                    fjl_delvd=fjl_delvd1;
                end
                pidloop(3,7) = data(13,b+1) + fjl_vd + fjl_delvd;  %温度低，需要加煤
                fjl_cle_test=fjl_vd + fjl_delvd;
            end
            
            u_decomposing_furnace_tempr=pidloop(3,7);
        end
        
        %斗提电流补偿
                if b > 120
                    delta_tsj_1 = data(102,b-68) - data(102,b-70);
                    delta_tsj_2 = data(102,b-70) - data(102,b-72);
                    delta_tsj_3 = data(102,b-72) - data(102,b-74);
                else
                    delta_tsj_1 = data(25,b + 1) - data(25,b);
                    delta_tsj_2 = data(25,b) - data(25,b-1);
                    delta_tsj_3 = data(25,b-1) - data(25,b-2);
                end
                delta_tsj = delta_tsj_1 + delta_tsj_2 + delta_tsj_3;
                tishenji = delta_tsj * fjl_douti_P;
        
                if b>5 && (mod(b,6)==0)
                    if (b > 130)
                        u_final = u_decomposing_furnace_tempr + tishenji; %改串级回路后不补偿
                        fjl_tishenji=tishenji;
                    else
                        u_final = u_decomposing_furnace_tempr;
                    end
        
                end
                
        data(73,b+1) = u_final;
        % % % % %
        % % % % %         co补偿
        % % % % %         if b > 5
        % % % % %
        % % % % %             if u_decomposing_furnace_tempr > data(73,b)
        % % % % %                 if sum(data(46,b-3:b+1))/5 > 2500
        % % % % %                     if mod(b,1) == 0
        % % % % %                         u_decomposing_furnace_tempr = data(73,b) - 0.018;
        % % % % %                     end
        % % % % %                 elseif sum(data(46,b-3:b+1))/5 > 2000
        % % % % %                     if mod(b,1) == 0
        % % % % %                         u_decomposing_furnace_tempr = data(73,b) - 0.010;
        % % % % %                     end
        % % % % %                 elseif sum(data(46,b-3:b+1))/5 > 1530
        % % % % %                     u_decomposing_furnace_tempr = data(73,b) - 0.007;
        % % % % %                 end
        % % % % %             end
        % % % % %
        % % % % %         end
        
    end
    
    %CO飙升处理
    if b > 25 && data(11,b+1) > 860% && (data(46,b+1) - data(46,b) > 0.003 && data(46,b) -data(46,b-1) > 0.003)
%         if max(data(46,b-1:b+1)) > max(data(46,b-4:b-1))...
%                 && max(data(46,b-4:b-1))>max(data(46,b-7:b-4))...
%                 && max(data(46,b-1:b+1)) >2000 ...
%                 && (mod(b,5) == 0)
%             
%         end
%         if max(data(46,b-1:b+1)) < max(data(46,b-4:b-1))...
%                 && max(data(46,b-4:b-1))<max(data(46,b-7:b-4))...
%                 && max(data(46,b-1:b+1)) >2000 ...
%                 && (mod(b,5) == 0)
%             
%         end
               
        if u_decomposing_furnace_tempr > data(10,b)
            if sum(data(46,b-3:b+1))/5 > fjl_CO_level1
                if mod(b,fjl_CO_time) == 0
                    u_final = data(73,b) - fjl_CO_P1;
                    u_decomposing_furnace_tempr = data(10,b) - fjl_CO_P1;
                end
            elseif sum(data(46,b-3:b+1))/5 > fjl_CO_level2
                if mod(b,fjl_CO_time) == 0
                    u_final = data(73,b) - fjl_CO_P2;
                     u_decomposing_furnace_tempr = data(10,b) - fjl_CO_P2;
                end
            elseif sum(data(46,b-3:b+1))/5 > fjl_CO_level3
                if mod(b,fjl_CO_time) == 0
                    u_final = data(73,b) - fjl_CO_P3;
                    u_decomposing_furnace_tempr = data(10,b) - fjl_CO_P3;
                end
            end
        end
    end
    
    %控制振幅
    umax = fjl_xianfu;
    if(u_decomposing_furnace_tempr>data(10,b)+umax)
        u_decomposing_furnace_tempr = data(10,b)+umax;
    elseif(u_decomposing_furnace_tempr<data(10,b)-umax)
        u_decomposing_furnace_tempr = data(10,b)-umax;
    end
    u_final=u_decomposing_furnace_tempr;
    data(74,b+1)=u_final;
    pidloop(3,7)=u_final;
    
    %co恢复后加煤
    fjl_CO_jm_signal = fjl_CO_level3 - fjl_jm_YuDu;
    if b>120
        if min(data(46,b-fjl_jm_time1:b-fjl_jm_time2))>fjl_CO_jm_signal && max(data(46,b-(fjl_jm_time2-1):b+1))<fjl_CO_jm_signal && data(11,b+1)
            u_final = data(10,b) + fjl_CO_jm;
        end
    end
    
%     if b > 30 &&  abs(data(79,b-13)-data(79,b+1))>0.3
%         
%             fjl_cm_test = abs(data(79,b-13)-data(79,b+1));
%             
%             delta_wm_press_1 = data(79,b+1) - data(79,b-4);
%             delta_wm_press_2 = data(79,b-4) - data(79,b-9);
%             delta_wm_press_3 = data(79,b-9) - data(79,b-13);
% 
%             delta_wm = delta_wm_press_1 + delta_wm_press_2 + delta_wm_press_3;
% 
%             if mod(b,3)==0
%                 u_decomposing_furnace_tempr = u_decomposing_furnace_tempr-delta_wm*fjl_bcbl;
% %                 pidloop(1,7) = pidloop(2,7);
%             end
%     end
  
end

%%%%%%%%%%%分解炉回路模块结束%%%%%%%%

%% %%%%%%%%%斗提电流回路模块%%%%%%%%%%%%
if 1==douti_on && b>30
    
    if mod(b,20)==0   %%10
        if douti_style==0
            pidloop(3,3)=data(29,b);
            upid(3) = data(29,b);
        else
            pidloop(3,3)=data(36,b);
            upid(3) = data(36,b);
        end
        if pidloop(10,3)==0
            pidloop(:,3)=pid_calc(pidloop(:,3)');
            pidloop(3,3)=round(pidloop(3,3)*1000)/1000;%修改：根据现场调节给定精度
            if ((pidloop(1,3)>=pidloop(2,3))&&(pidloop(3,3)>=dt_max)) %当设定值大于测量值时，并且阀门已经最大
                pidloop(1,3)= pidloop(2,3);
                pidloop(3,3)=dt_max;
                pidloop(10,3)=1;
            else
                pidloop(10,3)=0;
            end
            if ((pidloop(1,3)<=pidloop(2,3))&&(pidloop(3,3)<=dt_min)) %当设定值小于测量值时，并且阀门已经最小
                pidloop(1,3)= pidloop(2,3);
                pidloop(3,3)=dt_min;
                pidloop(10,3)=1;
            else
                pidloop(10,3)=0;
            end
            
            upid(3)=pidloop(3,3);
        end
    end
        douti_jisuan=upid(3);
    

    umax = 0.2;
    if upid(3)<=(data(29,b)-umax)    %%修改：根据现场实际
        upid(3)=data(29,b)-umax;      %忽略
    end
    if upid(3)>=(data(29,b)+umax)    %%修改：根据现场实际
        upid(3)=data(29,b)+umax;      %忽略
    end

    
end

%%%%%%%%%%%斗提电流回路模块结束%%%%%%%%

%% %%%%%%%%%头煤压力回路模块%%%%%%%%%%%%
if 1==toumei_on && b>30
    if pidloop(10,4)==0 && mod(b,20)==0
        pidloop(:,4)=pid_calc(pidloop(:,4)');
        pidloop(3,4)=round(pidloop(3,4)*100)/100;
        if ((pidloop(1,4)>=pidloop(2,4))&&(pidloop(3,4)>=tm_max)) %当设定值大于测量值时，并且阀门已经最大
            pidloop(1,4)= pidloop(2,4);
            pidloop(3,4)=tm_max;
            pidloop(10,4)=1;
        else
            pidloop(10,4)=0;
        end
        if ((pidloop(1,4)<=pidloop(2,4))&&(pidloop(3,4)<=tm_min)) %当设定值小于测量值时，并且阀门已经最小
            pidloop(1,4)= pidloop(2,4);
            pidloop(3,4)=tm_min;
            pidloop(10,4)=1;
        else
            pidloop(10,4)=0;
        end
        upid(4) = pidloop(3,4); 
    end
        toumei_jisuan=upid(4);
    %控制振幅
    umax = 0.1;%0.1
    if upid(4)<=(data(18,b)-umax)
        upid(4)=data(18,b)-umax;
    end
    if upid(4)>=(data(18,b)+umax)
        upid(4)=data(18,b)+umax;
    end

end
%%%%%%%%%%%头煤压力回路模块结束%%%%%%%%

%% %%%%%%%%%窑头负压回路模块%%%%%%%%%%%%
if 1==yaotou_on && b>30
    if pidloop(10,5)==0 && mod(b,10)==0
        pidloop(:,5)=pid_calc(pidloop(:,5)');
        pidloop(3,5)=round(pidloop(3,5)*100)/100;
        upid(5) = pidloop(3,5); 
    end
        toupai_jisuan=upid(5);
    %控制振幅
    umax = 0.1;
    if upid(5)<=(data(45,b)-umax)
        upid(5)=data(45,b)-umax;
    end
    if upid(5)>=(data(45,b)+umax)
        upid(5)=data(45,b)+umax;
    end

end
%%%%%%%%%%%窑头负压回路模块结束%%%%%%%%
%% %%%%%%%%%c1出口负压回路模块%%%%%%%%%%%%
if 1==c1_press_on && b>30
    if pidloop(10,6)==0 && mod(b,20)==0
        pidloop(:,6)=pid_calc(pidloop(:,6)');
        pidloop(3,6)=round(pidloop(3,6)*100)/100;
        upid(6) = pidloop(3,6); 
    end
        c1_jisuan=upid(6);
    %控制振幅
    umax = 0.3;
    if upid(6)<=(data(31,b)-umax)
        upid(6)=data(31,b)-umax;
    end
    if upid(6)>=(data(31,b)+umax)
        upid(6)=data(31,b)+umax;
    end

end
%%%%%%%%%%%c1出口负压回路模块结束%%%%%%%%
%% 输出值保存
data(93,b+1) = u_final;
data(97,b+1)=douti_jisuan; %喂料量计算
data(98,b+1)=toumei_jisuan; %头煤计算
data(99,b+1)=toupai_jisuan;  %头排风机计算
data(100,b+1)=c1_jisuan; %高温风机计算
%% 无扰动切换
%篦冷机
if 0==blj_on
    Up2=[data(2,b+1),data(2,b+1)]-workpoint2(1);
    pidloop(2,8)=pidloop(1,8);
    u_blj_speed=data(9,b+1);
    pidloop(3,8)= u_blj_speed;
    pidloop(4,8)=0;
    pidloop(5,8)=0;
    pidloop(6,8)=0;         
end
%分解炉
if 0==fjl_on 
%     Up1=[data(13,b+1),data(13,b+1)]-workpoint(1);
    pidloop(1,7)=pidloop(2,7);
    pidloop(3,7)=data(10,b+1);
    u_decomposing_furnace_tempr=data(10,b+1);
    u_final=u_decomposing_furnace_tempr;
    data(74,b+1)=u_final;
end
%斗提电流
if 0==douti_on
    pidloop(1,3)=pidloop(2,3);
    if douti_style==0
        pidloop(3,3)=data(29,b);
        upid(3) = data(29,b+1);
    else
        pidloop(3,3)=data(36,b);
        upid(3) = data(36,b+1);
    end
end
%头煤压力
if 0==toumei_on
    pidloop(1,4)=pidloop(2,4);
    pidloop(3,4)=data(18,b);
    upid(4)=pidloop(3,4);  
    pidloop(4,4)=0;
    pidloop(5,4)=0;
    pidloop(6,4)=0;
end
%窑头负压
if 0==yaotou_on
    pidloop(2,5)=pidloop(1,5);
    pidloop(3,5)=data(45,b);
    upid(5)=pidloop(3,5);  
    pidloop(4,5)=0;
    pidloop(5,5)=0;
    pidloop(6,5)=0;
end
%c1出口负压
if 0==c1_press_on
    pidloop(1,6)=pidloop(2,6);
    pidloop(3,6)=data(31,b);
    upid(6)=pidloop(3,6);  
    pidloop(4,6)=0;
    pidloop(5,6)=0;
    pidloop(6,6)=0;
end
%% 手动干预模块
%篦冷机
if man_blj_time_cnt ~= 0
    man_blj_time_cnt = man_blj_time_cnt + 1;
    u_blj_speed = man_zhuansu;
end
if man_blj_time_cnt > 10
    man_blj_time_cnt = 0;
end
if 1 == man_in_blj && 1 == blj_on
    man_in_blj = 0;
    man_blj_time_cnt = 1;
    u_blj_speed = man_zhuansu;
end



%分解炉
if man_fjl_time_cnt ~= 0
    man_fjl_time_cnt = man_fjl_time_cnt + 1;
    u_final = man_weimei;
end
if man_fjl_time_cnt > 10
    man_fjl_time_cnt = 0;
end
if 1==man_in_fjl && 1 == fjl_on
    man_in_fjl = 0;
    man_fjl_time_cnt = 1;
    u_final = man_weimei;
    pidloop(3,7)= man_weimei;
end
%斗提电流
if 1==douti_on && 1==man_in_dtdl
    man_in_dtdl = 0;
    upid(3) = man_dtdl;
end
%头煤压力
if 1==toumei_on && 1==man_in_toumei
    man_in_toumei = 0;
    upid(4) = man_toumei;
    pidloop(3,4) = man_toumei;
end
%窑头负压
if 1 == yaotou_on && 1 == man_in_yaotou
    man_in_yaotou = 0;
    upid(5) = man_yaotou;
    pidloop(3,5) = man_yaotou;
end
%c1出口负压
if 1 == c1_press_on && 1 == man_in_gaowen
    man_in_gaowen = 0;
    upid(6) = man_gaowen;
    pidloop(3,6) = man_gaowen;
end
%% 写入值
%篦冷机转速写入值
if 1==blj_on&&abs(u_blj_speed-data(2,b+1))>=0.005 %之前0.02
    P_write(2,u_blj_speed,zhuansu_MAX,zhuansu_MIN);
end
%分解炉喂煤量写入
if 1==fjl_on&&abs(u_final-data(13,b))>=0.002 
    try
        P_write(13,u_final,fjl_max,fjl_min);
    catch
        disp('error:P_write(13,');
    end
end
%斗提电流喂料量写入
if 1==douti_on&&abs(upid(3)-data(29,b))>=0.01%%0.01
    if douti_style==0
%        P_write(29,upid(3),dt_max,dt_min);
    else
%         P_write(36,upid(3),dt_max,dt_min);
    end
end
% %头煤压力窑头喂煤量控制
% if 1==toumei_on&&abs(upid(4)-data(18,b))>=0.005 
%     P_write(18,upid(4),tm_max,tm_min);
% end
% % % % % %窑头负压控制量写入
% % % % % if 1==yaotou_on&&abs(upid(5)-data(45,b))>=0.01 
% % % % %     P_write(45,upid(5),yt_max,yt_min);
% % % % % end
% % % % % %c1出口负压控制量写入
% % % % % if 1==c1_press_on&&abs(upid(6)-data(31,b))>=0.01 
% % % % %     P_write(31,upid(6),gwfj_max,gwfj_min);
% % % % % end
%% 报警模块 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ~(data(80,b+1) >= decomposing_furnace_tempr_2_upperlimitS ||data(80,b+1)<= decomposing_furnace_tempr_2_lowerlimitS || ...
        data(1,b+1)>= snd_chamber_pressure_upperlimitS ||data(1,b+1)<= snd_chamber_pressure_lowerlimitS )
    alarm_sound_flag = 0;
end
  
set(handles.alarmbutton,'BackgroundColor',[0.831 0.816 0.784]);%将报警设置按钮背景为灰色
    
if (data(80,b+1) >= decomposing_furnace_tempr_2_upperlimitS||data(80,b+1)<= decomposing_furnace_tempr_2_lowerlimitS || ...
        data(1,b+1)>= snd_chamber_pressure_upperlimitS ||data(1,b+1)<= snd_chamber_pressure_lowerlimitS)&& ~alarm_button_clicked
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

if (data(80,b+1) >= decomposing_furnace_tempr_2_upperlimitS)
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

if (data(80,b+1) <=decomposing_furnace_tempr_2_lowerlimitS)
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

if (data(1,b+1)>= snd_chamber_pressure_upperlimitS)
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

if (data(1,b+1)< snd_chamber_pressure_lowerlimitS)
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

% % % % % if (data(87,b + 1) > fazu1_max)
% % % % %     try
% % % % %         if(mod(b,2)==1)
% % % % %             set(pophandles.fazu1_max,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
% % % % %         else
% % % % %             set(pophandles.fazu1_max,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
% % % % %         end
% % % % %     catch
% % % % %         %disp('没有打开报警设置窗口');
% % % % %     end
% % % % % end
% % % % % 
% % % % % if (data(88,b + 1) > fazu2_max)
% % % % %     try
% % % % %         if(mod(b,2)==1)
% % % % %             set(pophandles.fazu2_max,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
% % % % %         else
% % % % %             set(pophandles.fazu2_max,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
% % % % %         end
% % % % %     catch
% % % % %         %disp('没有打开报警设置窗口');
% % % % %     end
% % % % % end

if alarm_sound_flag
%     load chirp
%     sound(y,Fs)
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
    set(pophandles.text11,'String',num2str(data(1,b+1),'%.1f'));
    set(pophandles.text10,'String',num2str(data(80,b+1),'%.1f'));
    set(pophandles.fazu1,'String',num2str(data(38,b+1),'%.1f'));
    set(pophandles.fazu2,'String',num2str(data(4,b+1),'%.1f'));
catch
%     disp('没有打开报警设置窗口');
end
catch lasterror
       tete = lasterror.message;
       fiderror = fopen('logFile.txt','a+');
       fprintf(fiderror,'%s\n',tete);
       for e=1:length(lasterror.stack)
           fprintf(fiderror,'%s at %i\n',lasterror.stack(e).name, lasterror.stack(e).line);
       end
       fclose(fiderror);
end