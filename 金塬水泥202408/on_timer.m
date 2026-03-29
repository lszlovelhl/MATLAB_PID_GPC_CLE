function on_timer(obj,event,handles)

global connect_con first_time_connect_flag   u_final itemset first_time_connect_flag_ontimer
global daobj group   lastsave  data b tempdata tempdatavalue  pidloop loopnum upid alarm_sound_flag 
global pophandles alarm_button_clicked alarm_timer  bljblj
global A B workpoint  Up yout A2 B2 workpoint2 Up2 yout2          fjlumax yaotou_on
global flag gpc_a gpc_lmd   toupai_speed third d_tsj
global sign_blj sign_fjl sign_toumei sign_douti sign_fuya blj_press2_sp
global fjl_MAX fjl_MIN zhuansu_MAX zhuansu_MIN toumei_MAX toumei_MIN sizecon paramdata
global fjl_alpha1 fjl_lambda1 fjl_alpha2 fjl_lambda2 
global toumei_p toumei_i toumei_d weimei_man_plus_on weimei_man_minus_on
global blj_p1 blj_i1 blj_d1  fj11dl_sp
global blj_p2 blj_i2 blj_d2 weimei_val pre_fjl_weimei_sp
global blj_p3 blj_i3 blj_d3 fjl_man_minus_timer1 fjl_man_minus_timer2 fjl_man_plus_timer1 fjl_man_plus_timer2
global blj_zhuansu_sp fjl_weimei_sp yaotou_sp  count1 count2
global fjl_upper_limit blj_lower_limit fjl_lower_limit blj_upper_limit gpc_flag gpc_timer tmp_pv shuipao1 shuipao2
global fjl_man_plus_on fjl_man_minus_on count_fjl_man fjl_fuzzy
global xialiao_left_lower_limit xialiao_left_upper_limit xialiao_right_upper_limit xialiao_right_lower_limit delta_tsj
global sign_blj_pump sign_blj4 blj_press_pv_round blj_press1_sp
global blj_pump_p blj_pump_i blj_pump_d flag_delta_I
global blj_pump1_sp
global blj_cd1_calc   yaotou_p yaotou_i yaotou_d   tmmax tmmin
global bli_pump_flag
global fjl_pmg_gaspress_pv 
global fjl_pmg_gaspress_flag
global SLvalveR_sp  toupai_max toupai_min
global SLcangzhong_p SLcangzhong_i SLcangzhong_d SL_alpha1 SL_lambda1 SL_alpha2 SL_lambda2
global SLvalveR_sp_MIN SLvalveR_sp_MAX SLcangzhong_sp shenegliao_cangzhong_calc
global blj4_p blj4_i blj4_d
global blj_cd3_calc yaotoufy_sp
global CO_pv CO_flag COup_flag
global toumei_sp toumei_press_flag toumeiPress_sp toumei_alpha1 toumei_lambda1 toumei_alpha2 toumei_lambda2 toumeiPress_calc
global avgt avgpress avgspeed midspeed changespeed
global douti_p douti_i douti_d xialiao_max xialiao_min  xialiaoliang douti_sp douti_on 
global gwfj_p gwfj_i gwfj_d weipai_max weipai_min gwfjfy_sp gwfjfy_on weipai_speed
global man_in_blj man_blj_speed man_fjl_time_cnt man_in_fjl man_fjl_coal rev   bljflag
global wmfy_sp fjl_temp_sp
global fj11dl0 fj11dl1 fj11dl2 fj11dl3 fj11dl4
global kf11 krm_fjdl

% % % % % wyxxxxxxxxxx 2022/11/12
global keycount hisdatadays hitdata_title

%% 获取Wincc中各变量的值

tic
tempdata = read(group);              % length(tempdata) = 35
[~, b] = size(data);
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end

 tempdata(8).Value=fj11dl_sp;
 tempdatavalue(8) = tempdata(8).Value;
 tempdata(9).Value=fjl_temp_sp;
 tempdatavalue(9) = tempdata(9).Value;
 tempdata(16).Value=SLcangzhong_sp;
 tempdatavalue(16) = tempdata(16).Value;
 tempdata(21).Value=yaotoufy_sp;
 tempdatavalue(21) = tempdata(21).Value;
 tempdata(27).Value=wmfy_sp;
 tempdatavalue(27) = tempdata(27).Value;
 tempdata(31).Value=toumei_sp;
 tempdatavalue(31) = tempdata(31).Value;
 tempdata(41).Value=gwfjfy_sp;
 tempdatavalue(41) = tempdata(41).Value;
 
first_time_connect_flag_ontimer = first_time_connect_flag_ontimer - 1;

if first_time_connect_flag_ontimer<=0
    first_time_connect_flag_ontimer=0;
end    
   
% % % % % wyxxxxxxxxxx 2022/11/12
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



%% 每小时data数据更新


if b >= 3900

    first=0;
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
                               || (licensevalid ~= 087401)%表示license无效
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

%% 读取xml文件
paramdata = xml_read('param_set.xml');
%分解炉
fjl_alpha1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_alpha1;
fjl_lambda1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_lambda1;
fjl_alpha2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2;
fjl_lambda2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2;
fjl_xianfu = paramdata.commdata(1).parameter(22).ATTRIBUTE.fjl_xianfu;
fjl_bcbl = paramdata.commdata(1).parameter(22).ATTRIBUTE.fjl_bcbl;
fjl_temp_sp_up = paramdata.commdata(1).parameter(22).ATTRIBUTE.fjl_temp_sp_up;
fjl_temp_sp_down = paramdata.commdata(1).parameter(22).ATTRIBUTE.fjl_temp_sp_down;

fjl_CO_level1 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_level1;
fjl_CO_level2 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_level2;
fjl_CO_level3 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_level3;
fjl_CO_P1 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_P1;
fjl_CO_P2 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_P2;
fjl_CO_P3 = paramdata.commdata(1).parameter(33).ATTRIBUTE.fjl_CO_P3;

fjl_MAX = paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MAX;
fjl_MIN = paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MIN;

fjl_vd = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_vd;
fjl_delvd1 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd1;
fjl_delvd2 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd2;
fjl_delvd3 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd3;
fjl_delvd4 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd4;
fjl_delvd5 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd5;
fjl_delvd6 = paramdata.commdata(1).parameter(34).ATTRIBUTE.fjl_delvd6;

%头煤压力
toumei_alpha1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha1;
toumei_lambda1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda1;

toumei_alpha2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha2;
toumei_lambda2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda2;

%篦冷机
blj_p1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_alpha1;
blj_i1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_beta1;
blj_d1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_gamma1;

blj_p2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_alpha2;
blj_i2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_beta2;
blj_d2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_gamma2;

blj_xianfu = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_xianfu;

WLlevel0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel0;
WLlevel1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel1;
WLlevel2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel2;
WLlevel3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.WLlevel3;

fj11dl0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0;
fj11dl1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1;
fj11dl2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2;
fj11dl3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3;
fj11dl4 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl4;

blj_vd = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_vd;

blj_delvd1_up = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd1_up;
blj_delvd2_up = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd2_up;
blj_delvd3_up = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd3_up;
blj_delvd1_down = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd1_down;
blj_delvd2_down = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd2_down;
blj_delvd3_down = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_delvd3_down;


%四室压力控制
blj4_p = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_alpha;
blj4_i = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_beta;
blj4_d = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_gamma;

%生料仓重
SLcangzhong_p = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_alpha;
SLcangzhong_i = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_beta;
SLcangzhong_d = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_gamma;

%窑头
pyaotou_p = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_p;
pyaotou_i = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_i;
pyaotou_d = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_d;

%高温风机
pgwfjfy_p = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p;
pgwfjfy_i = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i;
pgwfjfy_d = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d;
%% 获取设定值
sizecon = 50;
fjl_temp_sp = str2double(get(handles.fjl_temp_sp,'String'));
SLcangzhong_sp = str2double(get(handles.SLcangzhong_sp,'String'));
toumei_sp = str2double(get(handles.toumei_sp,'String'));
yaotoufy_sp=str2double(get(handles.yaotoufy_sp,'String'));
gwfjfy_sp=str2double(get(handles.gwfjfy_sp,'String'));

data(46,b+1)=wmfy_sp;%尾煤风压设定


%% 测量值实时显示

% 篦冷机
set(handles.blj_press1_pv,'String',num2str(data(1,b+1),'%4.2f'));
set(handles.ercfw_pv,'String',num2str(data(26,b+1),'%4.2f'));
set(handles.blj_press2_pv,'String',num2str(data(2,b+1),'%4.2f'));
set(handles.blj_pump1_pv,'String',num2str(data(4,b+1),'%4.2f'));
set(handles.blj_cd1_sp,'String',num2str(data(6,b+1),'%4.2f'));
set(handles.blj_cd2_sp,'String',num2str(data(7,b+1),'%4.2f'));
set(handles.blj_cd3_sp,'String',num2str(data(8,b+1),'%4.2f'));
set(handles.blj_cd4_sp,'String',num2str(data(9,b+1),'%4.2f'));
set(handles.fengji,'String',num2str(data(37,b+1),'%4.2f'));
set(handles.fjdl_sp,'String',num2str(fj11dl_sp,'%4.2f'));

% 分解炉
set(handles.fjl_weimei_pv,'String',num2str(data(13,b+1),'%3.2f'));
set(handles.wuji_pv,'String',num2str(data(11,b+1),'%4.1f'));
set(handles.fjl_tmp,'String',num2str(data(10,b+1),'%4.1f'));
set(handles.fjl_weimei_sp,'String',num2str(data(12,b+1),'%4.2f'));
set(handles.fjl_pmg_gaspress_pv,'String',num2str(data(15,b+1),'%3.2f'));
%CO浓度滤波
CO_pv = data(36,b+1);
% % % if (b>300)
% % %     CO_pv = sum(data(36,b-298:b+1))/300;
% % % end
set(handles.CO_pv,'String',num2str(CO_pv,'%3.1f'));
set(handles.sanci_fw,'String',num2str(data(14,b+1),'%4.1f'));
set(handles.ljxt_temp,'String',num2str(data(42,b+1),'%4.1f'));

% 生料仓重
set(handles.SLcangzhong_pv,'String',num2str(data(20,b+1),'%4.1f'));
set(handles.SLvalveR_pv,'String',num2str(data(23,b+1),'%4.1f'));
set(handles.SLvalveR_sp,'String',num2str(data(25,b+1),'%4.1f'));
% 头煤
set(handles.toumei_pv,'String',num2str(data(35,b+1),'%4.1f'));
set(handles.yaotou_pv,'String',num2str(data(29,b+1),'%3.2f'));
set(handles.yaotou_sp,'String',num2str(data(28,b+1),'%4.2f'));

%窑头负压
yaotoufycl=data(30,b+1);
if(b>30)    %滤波
    yaotoufycl=sum(data(30,b-18:b+1))/20;
end

set(handles.yaotoufy_pv,'String',num2str(yaotoufycl,'%4.1f')); %data
% 1026
set(handles.toupai_speed,'String',num2str(data(38,b+1),'%4.1f')); %data

%斗提
douticl=data(17,b+1);
if(b>30)    %滤波
    douticl=sum(data(17,b-8:b+1))/10;
end
set(handles.douti_pv,'String',num2str(douticl,'%4.2f')); %data
set(handles.sl_pv,'String',num2str(data(19,b+1),'%4.2f')); %data

%篦冷机
kf11(1) = data(37,b+1);
kf11 = kalman_Filter(kf11);
kf11(1) =kf11(3);
kf11 = kalman_Filter(kf11);
data(64,b+1) = kf11(3); %2611卡尔曼电流滤波
krm_fjdl= kf11(3);

%高温风机 1204
gwfjcl=data(39,b+1);
if(b>30)    %滤波
    gwfjcl=sum(data(39,b-18:b+1))/20;
end
set(handles.gwfjfy_pv,'String',num2str(gwfjcl,'%4.2f')); %data
set(handles.weipai_speed,'String',num2str(data(40,b+1),'%4.2f')); %data


%% 控制器信号打开,获取自动控制开关信息
% 篦冷机
% if(sign_blj==1)
%     pidloop(10,1)=1;%自动为1
%     data(sizecon+1,b+1) = blj_press1_sp;
% else
%     pidloop(10,1)=0;%自动为1
% end

% 分解炉
if(sign_fjl==1)
    data(sizecon+3,b+1) = fjl_temp_sp;   
end

% 头煤压力
if(sign_toumei==1)
% % %     pidloop(10,4)=1;%自动为1
    data(sizecon+7,b+1) = toumei_sp;
% % % else
% % %     pidloop(10,4)=0;%自动为1
end

% 生料仓重
if(sign_douti==1)
    pidloop(10,5)=1;%自动为1
    data(45,b+1) = SLcangzhong_sp;
else
    pidloop(10,5)=0;%自动为1
end

% 窑头负压
if(yaotou_on==1)
    pidloop(10,7)=1;%自动为1
    data(71,b+1) = yaotoufy_sp;
else
    pidloop(10,7)=0;%自动为1
end

% 高温风机
if(gwfjfy_on==1)
    pidloop(10,10)=1;%自动为1
    data(90,b+1) = gwfjfy_sp;
else
    pidloop(10,10)=0;%自动为1
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%篦冷机模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 篦冷机GPC+CLE回路
if(b>30)    %滤波
    pidloop(1,1)=sum(data(26,b-28:b+1))/30; %二次风温滤波
end
data(65,b+1)=data(37,b+1);
if b>40
    data(65,b+1)=sum(data(37,b-28:b+1))/30; %风机电流滤波
    data(80,b+1)=sum(data(17,b-28:b+1))/30; %斗提电流滤波
    data(81,b+1)=sum(data(14,b-28:b+1))/30; %三次风温滤波
end
set(handles.fengji,'String',num2str(data(65,b+1),'%4.2f'));
if 1==sign_blj 
    %分档控制11风机电流设定值、转速上下限
    %使用喂料量分档
    if data(19,b+1) >= WLlevel0 
        fj11dl_sp = fj11dl0;
    elseif data(19,b+1) >= WLlevel1 
        fj11dl_sp = fj11dl1;
    elseif data(19,b+1) >= WLlevel2 
        fj11dl_sp = fj11dl2;
    elseif data(19,b+1) >= WLlevel3 
        fj11dl_sp = fj11dl3;
    elseif data(19,b+1) < WLlevel3
        fj11dl_sp = fj11dl4;
    else
        fj11dl_sp = fj11dl3;
    end

    if b>31 %这是时间要和gpc控制周期数据计算时间匹配Up2(1)=data(3,b-5)-workpoint2(1)
        workpoint2=[21.8026,174.1094];%-0.9959 -3.8411 8.8627 8401.4
        %A2=[-0.9923,1];
        %B2=-1.922;
        %A2=[-0.9965,1]; %5s
        %B2=0.02546;      %5s
%         A2=[-0.993,1]; %10s
%         B2=0.05084;      %10s
%       A2=[-0.9896,1]; %15s
%       B2=0.07613;      %15s
        %A2=[-0.9861,1]; %20s
        %B2=0.1013;      %20s
        A2=[-0.9792,1]; %30s
        B2=0.1515;      %30s

        Up2(1)=data(6,b-29)-workpoint2(1);
        Up2(2)=data(6,b+1)-workpoint2(1);

        P=[0.01,0.01;0.01,0.01];
        gpc_a2=blj_p2;%0.9725
        gpc_lmd2=blj_i2;%130; 

        if (abs(data(65,b+1) - fj11dl_sp)) > 5  %大偏差
            gpc_a2=blj_p1;%0.9690;
            gpc_lmd2=blj_i1;%130;
        end
        yout2=data(65,b-29:15:b+1)-workpoint2(2);
        if mod(b,30)==0 
            gpc_fj11dl_sp = fj11dl_sp-workpoint2(2);
            blj_cd1_calc = workpoint2(1)+gpc_clac(A2,B2,P,yout2,Up2,gpc_fj11dl_sp,gpc_a2,gpc_lmd2);
        end
        data(69,b+1) = blj_cd1_calc;
        
            %限振幅
        ublj = blj_xianfu;
        if (blj_cd1_calc<=(data(6,b)-ublj))
            blj_cd1_calc=data(6,b)-ublj;
        end
        if (blj_cd1_calc>=(data(6,b)+ublj))
            blj_cd1_calc=data(6,b)+ublj;
        end
        
%*************************CLE Start*************************
        if b > 50
            %趋势数据
            mx1= max(data(65,b-8:b+1)); %10s的数据间隔
            mx2 = max(data(65,b-18:b-9));
            mx3 = max(data(65,b-28:b-19));
            mn1 = min(data(65,b-8:b+1));
            mn2 = min(data(65,b-18:b-9));
            mn3 = min(data(65,b-28:b-19));

%             bljmx1 = mx1;
%             bljmx2 = mx2;
%             bljmx3 = mx3;
%             bljmn1 = mn1;
%             bljmn2 = mn2;
%             bljmn3 = mn3;

%             mx12 = max(data(110,b-48:b+1)); %50s的数据间隔
%             mx22 = max(data(110,b-98:b-49));
%             mx32 = max(data(110,b-148:b-99));
%             mn12 = min(data(110,b-48:b+1));
%             mn22 = min(data(110,b-98:b-49));
%             mn32 = min(data(110,b-148:b-99));  

            %趋势数据峰谷值
            mx_max = max([mx1,mx2,mx3]);
            mn_min = min([mn1,mn2,mn3]);
            
%             %趋势判断
%             if ((mx1>mx2) && (mx2>mx3)) % || ((mx12>mx22) && (mx22>mx32))
%                 f11dl_asc = 1;  %趋势上升
%                 f11dl_desc = 0;
%                 f11dl_flat = 0;
%             elseif ((mx1<mx2) && (mx2<mx3)) % || (mx12<mx22) && (mx22<mx32))
%                 f11dl_asc = 0;
%                 f11dl_desc = 1; %趋势下降
%                 f11dl_flat = 0;
%             else
%                 f11dl_flat = 1; %趋势平坦
%             end
            
            %电流保持上升趋势，需要减篦速
            if (mn_min >= fj11dl_sp-8) && (mod(b,24)==0) && (mx1>mx2) && (mx2>mx3)
%                 ...&& ((f11dl_asc==1)||((f11dl_desc==1)&&(f11dl_flat==1))) %选9秒错开10秒周期的GPC，每90秒会冲突一次GPC，影响不大
                delvd = 0;
                if mn_min-fj11dl_sp>=6
                    delvd=blj_delvd1_down; 
                elseif mn_min-fj11dl_sp>=4
                    delvd=blj_delvd2_down; 
                elseif mn_min-fj11dl_sp>=2
                    delvd=blj_delvd3_down;
                end
                blj_cd1_calc = data(6,b) - (blj_vd + delvd); %电流保持上升趋势，需要减篦速 
            %电流保持下降趋势，需要加篦速
            elseif (mx_max <= fj11dl_sp+9) && (mod(b,24)==0) && (mx1<mx2) && (mx2<mx3)
%                 ...&& ((f11dl_desc==1)||((f11dl_asc==1)&&(f11dl_flat==1)))
                delvd = 0;
                if fj11dl_sp-mx_max>=6
                    delvd=blj_delvd1_up;
                elseif fj11dl_sp-mx_max>=4
                    delvd=blj_delvd2_up;
                elseif fj11dl_sp-mx_max>=2
                    delvd=blj_delvd3_up;
                end
                blj_cd1_calc = data(6,b) + (blj_vd + delvd);  %电流保持下降趋势，需要加篦速
            end
        end
        %*****************CLE End******************
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%篦冷机模块END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 篦冷机无扰切换
if 0==sign_blj 
    Up2=[data(6,b+1),data(6,b+1)]-workpoint2(1);
    blj_cd1_calc=data(6,b+1);
    
end

data(68,b+1)=blj_cd1_calc;
if data(68,b+1) > zhuansu_MAX
    data(68,b+1)=zhuansu_MAX;
end
if data(68,b+1) < zhuansu_MIN
    data(68,b+1)=zhuansu_MIN;
end
     
   
%% 头煤压力控制

if(b>50)    %滤波
    data(58,b+1)=sum(data(35,b-28:b+1))/30; %生料仓重滤波
end
if 1 == sign_toumei
    if b>11 %这是时间要和gpc控制周期数据计算时间匹配Up2(1)=data(3,b-5)-workpoint2(1)
        workpoint2=[3.2448,13.9344];%-0.9959 -3.8411 8.8627 8401.4
        %A2=[-0.9926,1];
        %B2=-0.0157;
%         A2=[-0.9635,1]; %5s
%         B2=0.07735;      %5s
        A2=[-0.9284,1]; %10s
        B2=0.1519;      %10s
    %     A2=[-0.8946,1]; %15s
    %     B2=0.2237;      %15s
    %     A2=[-0.862,1]; %20s
    %     B2=0.2929;      %20s
    %     A2=[-0.8003,1]; %30s
    %     B2=0.4238;      %30s

        Up2(1)=data(28,b-9)-workpoint2(1);
        Up2(2)=data(28,b+1)-workpoint2(1);

        P=[0.01,0.01;0.01,0.01];
        gpc_a2=toumei_alpha2;%
        gpc_lmd2=toumei_lambda2;%; 

        if (abs(data(58,b+1) - toumei_sp)) > 1.5  %大偏差
            gpc_a2=toumei_alpha1;%;
            gpc_lmd2=toumei_lambda1;%;
        end
        yout2=data(58,b-9:5:b+1)-workpoint2(2);
        if mod(b,10)==0 
            gpc_toumeiPress_sp = toumei_sp-workpoint2(2);
            toumeiPress_calc = workpoint2(1)+gpc_clac(A2,B2,P,yout2,Up2,gpc_toumeiPress_sp,gpc_a2,gpc_lmd2);
        end
        data(75,b+1) = toumeiPress_calc;
    end

    %限振幅
    utoumei = 0.065;
    if (toumeiPress_calc<=(data(28,b)-utoumei))
        toumeiPress_calc=data(28,b)-utoumei;
    end
    if (toumeiPress_calc>=(data(28,b)+utoumei))
        toumeiPress_calc=data(28,b)+utoumei;
    end
end

%头煤压力控制无扰切换
if 0==sign_toumei
    Up2=[data(28,b+1),data(28,b+1)]-workpoint2(1);
    toumeiPress_calc=data(28,b+1);
end

data(74,b+1)=toumeiPress_calc;
if data(74,b+1) > toumei_MAX
    data(74,b+1)=toumei_MAX;
end
if data(74,b+1) < toumei_MIN
    data(74,b+1)=toumei_MIN;
end

%% 窑头负压控制
pidloop(2,7)=yaotoufy_sp;   %正负未知    1026
pidloop(1,7)=data(30,b+1);  %data未知
if(b>30)    %滤波
    pidloop(1,7)=sum(data(30,b-18:b+1))/20;
end
data(72,b+1)=pidloop(1,7);

pidloop(7,7)=pyaotou_p;%kuc    
pidloop(8,7)=pyaotou_i;%ke
pidloop(9,7)=pyaotou_d;%kec

pidloop(11,7)=toupai_max; %修改：根据现场调节上限
pidloop(12,7)=toupai_min;
pidloop(13,7)=0.05;%0.3

if yaotou_on == 0
   toupai_speed = data(38,b+1);  %data
end

if mod(b,10)==0
    if pidloop(10,7)==1
        pidloop(:,7)=pid_calc(pidloop(:,7)');
        pidloop(3,7)=round(pidloop(3,7)*100)/100;%修改：根据现场调节给定精度
        toupai_speed=round(pidloop(3,7)*100)/100; 
    end
end

%抗饱和
if ((pidloop(2,7)>=pidloop(1,7))&&(pidloop(3,7)>=toupai_max)) %当设定值大于测量值时，并且阀门已经最大
   pidloop(2,7)= pidloop(1,7);
   pidloop(3,7)=toupai_max;
   pidloop(10,7)=1;
else
   pidloop(10,7)=0;
end
if ((pidloop(2,7)<=pidloop(1,7))&&(pidloop(3,7)<=toupai_min)) %当设定值小于测量值时，并且阀门已经最小
   pidloop(2,7)= pidloop(1,7);
   pidloop(3,7)=toupai_min;
   pidloop(10,7)=1;
else
   pidloop(10,7)=0;
end

data(48,b+1)=toupai_speed;

% 无扰切换
if pidloop(10,7)==0
    pidloop(2,7)=pidloop(1,7);
    pidloop(3,7)=data(38,b);    %data
    pidloop(4,7)=0;
    pidloop(5,7)=0;
    pidloop(6,7)=0;
end


%% 高温风机控制1204
pidloop(2,10)=gwfjfy_sp;   %正负未知    1026
pidloop(1,10)=data(39,b+1);  %data未知
if(b>30)    %滤波
    pidloop(1,10)=sum(data(39,b-18:b+1))/20;
end
data(92,b+1)=pidloop(1,10);

pidloop(7,10)=pgwfjfy_p;%kuc    
pidloop(8,10)=pgwfjfy_i;%ke
pidloop(9,10)=pgwfjfy_d;%kec

pidloop(11,10)=weipai_max; %修改：根据现场调节上限
pidloop(12,10)=weipai_min;
pidloop(13,10)=0.05;%0.3

if pidloop(10,10)==0
   weipai_speed = data(40,b+1);  %data
end

if mod(b,15)==0
    if pidloop(10,10)==1
        pidloop(:,10)=pid_calc(pidloop(:,10)');
        pidloop(3,10)=round(pidloop(3,10)*100)/100;%修改：根据现场调节给定精度
        weipai_speed=round(pidloop(3,10)*100)/100; 
    end
end

%抗饱和
if ((pidloop(2,10)>=pidloop(1,10))&&(pidloop(3,10)>=weipai_max)) %当设定值大于测量值时，并且阀门已经最大
   pidloop(2,10)= pidloop(1,10);
   pidloop(3,10)=weipai_max;
   pidloop(10,10)=1;
else
   pidloop(10,10)=0;
end
if ((pidloop(2,10)<=pidloop(1,10))&&(pidloop(3,10)<=weipai_min)) %当设定值小于测量值时，并且阀门已经最小
   pidloop(2,10)= pidloop(1,10);
   pidloop(3,10)=weipai_min;
   pidloop(10,10)=1;
else
   pidloop(10,10)=0;
end

data(49,b+1)=weipai_speed;

% 无扰切换
if pidloop(10,10)==0
    pidloop(2,10)=pidloop(1,10);
    pidloop(3,10)=data(40,b);    %data
    pidloop(4,10)=0;
    pidloop(5,10)=0;
    pidloop(6,10)=0;
end


%% 生料仓重控制

pidloop(1,5)=SLcangzhong_sp;   
pidloop(2,5)=data(20,b+1);
if(b>20)    %滤波
    pidloop(2,5)=sum(data(20,b-8:b+1))/10;
end
data(sizecon+6,b+1)=pidloop(2,5);

pidloop(7,5)=SLcangzhong_p;%kuc    
pidloop(8,5)=SLcangzhong_i;%ke
pidloop(9,5)=SLcangzhong_d;%kec

pidloop(11,5)=SLvalveR_sp_MAX; %修改：根据现场调节上限
pidloop(12,5)=SLvalveR_sp_MIN;
pidloop(13,5)=0.05;%0.3
 
% 喂料转子秤-斗提电流PID计算
if sign_douti == 0
   SLvalveR_sp = data(25,b+1);
end

if mod(b,12)==0
    if pidloop(10,5)==1
        pidloop(:,5)=pid_calc(pidloop(:,5)');
        pidloop(3,5)=round(pidloop(3,5)*100)/100;%修改：根据现场调节给定精度
        SLvalveR_sp=round(pidloop(3,5)*100)/100; 
    end
end

%抗饱和
if ((pidloop(1,5)>=pidloop(2,5))&&(pidloop(3,5)>=SLvalveR_sp_MAX)) %当设定值大于测量值时，并且阀门已经最大
   pidloop(1,5)= pidloop(2,5);
   pidloop(3,5)=SLvalveR_sp_MAX;
   pidloop(10,5)=1;
else
   pidloop(10,5)=0;
end
if ((pidloop(1,5)<=pidloop(2,5))&&(pidloop(3,5)<=SLvalveR_sp_MIN)) %当设定值小于测量值时，并且阀门已经最小
   pidloop(1,5)= pidloop(2,5);
   pidloop(3,5)=SLvalveR_sp_MIN;
   pidloop(10,5)=1;
else
   pidloop(10,5)=0;
end

data(45,b+1)=SLvalveR_sp;

% 无扰切换
if pidloop(10,5)==0
    pidloop(1,5)=pidloop(2,5);
    pidloop(3,5)=data(25,b);
    pidloop(4,5)=0;
    pidloop(5,5)=0;
    pidloop(6,5)=0;
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%分解炉模块%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 分解炉GPC主程序
if b>21
    data(63,b+1)=sum(data(15,b-8:b+1))/10; %尾煤风压滤波值
else
    data(63,b+1)=data(15,b+1); %尾煤风压
end

if (b > 25)
    data(54,b+1) = sum(data(10,b-8:b+1))/10; %分解炉出口温度滤波
else
    data(54,b+1) = data(10,b+1); %分解炉出口温度
end

pidloop(2,6)=data(63,b+1); %pv

pidloop(7,6)=paramdata.commdata(1).parameter(32).ATTRIBUTE.fjl_p;
pidloop(8,6)=paramdata.commdata(1).parameter(32).ATTRIBUTE.fjl_i;
pidloop(9,6)=paramdata.commdata(1).parameter(32).ATTRIBUTE.fjl_d;
pidloop(11,6)=fjl_MAX; %上限
pidloop(12,6)=fjl_MIN;  %下限
pidloop(13,6)=0.02;

if 1==sign_fjl
    if b > 50
        if b>16 %这个时间的判断注意和控制周期以及Up1(1)=data(12,b-4)-workpoint(1)b-4匹配
    %% 外回路gpc
    % % % % % % %wyx         workpoint=[9.435,878.8581];%[9.3773,882.7332575];
            workpoint=[30.776,879.1895];

    %         A=[-1.007,1]; %10s
    %         B=0.4454;  %10s
            A=[-1.011,1]; %15s
            B=0.6693;  %15s
    %             A=[-1.014,1]; %20s
    %             B=0.8939;  %20s
    %         A=[-1.018,1]; %25s
    %         B=1.119;  %25s
%             A=[-1.021,1]; %30s
%             B=1.346;  %30s

            Up1(1)=data(63,b-13)-workpoint(1);
            Up1(2)=data(63,b+1)-workpoint(1);

            P=[0.01,0.01;0.01,0.01];

            gpc_a=fjl_alpha1;
            gpc_lmd=fjl_lambda1; 

            data(53,b+1)=fjl_temp_sp;
            
            %内部调高设定值
            fjl_temp_sp = fjl_temp_sp + fjl_temp_sp_up;
            %内部调低设定值
            fjl_temp_sp = fjl_temp_sp - fjl_temp_sp_down;
            
             %大偏差
            if abs(fjl_temp_sp- data(10,b+1))>3
                gpc_a=fjl_alpha2;
                gpc_lmd=fjl_lambda2;
            end

            yout1=data(10,b-13:7:b+1)-workpoint(2);

            if mod(b,15)==0
                gpc_fjl_temp_sp=fjl_temp_sp-workpoint(2);
                wmfy_sp = workpoint(1)+gpc_clac(A,B,P,yout1,Up1,gpc_fjl_temp_sp,gpc_a,gpc_lmd);
            %% 内回路pid
                pidloop(1,6)=wmfy_sp; %sp
                pidloop(:,6)=pid_calc(pidloop(:,6)');
                pidloop(3,6)=round(pidloop(3,6)*100)/100;

        %抗饱和
                if ((pidloop(1,6)>=pidloop(2,6))&&(pidloop(3,6)>=fjl_MAX)) %当设定值大于测量值时，并且阀门已经最大
                    pidloop(1,6)= pidloop(2,6);
                    pidloop(3,6)=fjl_MAX;
                    pidloop(10,6)=1;
                else
                    pidloop(10,6)=0;
                end
                if ((pidloop(1,6)<=pidloop(2,6))&&(pidloop(3,6)<=fjl_MIN)) %当设定值小于测量值时，并且阀门已经最小
                    pidloop(1,6)= pidloop(2,6);
                    pidloop(3,6)=fjl_MIN;
                    pidloop(10,6)=1;
                else
                    pidloop(10,6)=0;
                end
                fjl_weimei_sp=pidloop(3,6);
                u_final =pidloop(3,6);
            end
            
% % %             if abs(data(15,b+1)-wmfy_sp)>1
% % %                 fjl_xianfu=1;
% % %             end
            
            data(67,b+1)=pidloop(3,6);
        end
    
% % %         if b > 110
% % %     %         delta_wm_press_1 = data(85,b-58) - data(85,b-59);
% % %     %         delta_wm_press_2 = data(85,b-59) - data(85,b-60);
% % %     %         delta_wm_press_3 = data(85,b-60) - data(85,b-61);
% % %             delta_tsj_1 = data(80,b-70) - data(80,b-72);
% % %             delta_tsj_2 = data(80,b-72) - data(80,b-74);
% % %             delta_tsj_3 = data(80,b-74) - data(80,b-76);
% % %         else
% % %     %         delta_wm_press_1 = data(15,b+1) - data(15,b);
% % %     %         delta_wm_press_2 = data(15,b) - data(15,b-1);
% % %     %         delta_wm_press_3 = data(15,b-1) - data(15,b-2);
% % %             delta_tsj_1 = data(17,b+1) - data(17,b-1);
% % %             delta_tsj_2 = data(17,b-1) - data(17,b-3);
% % %             delta_tsj_3 = data(17,b-3) - data(17,b-5);
% % %         end
% % %         delta_tsj = delta_tsj_1 + delta_tsj_2 + delta_tsj_3;
% % %     
% % %         tishenji = delta_tsj * fjl_douti_P;
% % %         if b>7 && (mod(b,19)==0)
% % %             if (b > 110)
% % %                 u_final = fjl_weimei_sp+tishenji; %改串级回路后不补偿
% % %                 data(67,b+1)=fjl_weimei_sp+tishenji;
% % %             else
% % %                 u_final = fjl_weimei_sp;
% % %             end
% % %         end
    
%尾煤冲煤补偿

% % %         wm_pressmx = max(data(15,b-31:b-28));
% % %         wm_pressmn = min(data(15,b-31:b-28));
        
        if abs(data(15,b-31)-data(15,b-28))>1.2
                delta_wm_press_1 = data(15,b-28) - data(15,b-29);
                delta_wm_press_2 = data(15,b-29) - data(15,b-30);
                delta_wm_press_3 = data(15,b-30) - data(15,b-31);

                delta_wm = delta_wm_press_1 + delta_wm_press_2 + delta_wm_press_3;

                if mod(b,3)==0
                    u_final = fjl_weimei_sp-delta_wm*fjl_bcbl;
                end
        end
    

    
        %控制振幅

        umax = fjl_xianfu;
        if(u_final>data(12,b)+umax)
            u_final = data(12,b)+umax;
        elseif(u_final<data(12,b)-umax)
            u_final = data(12,b)-umax;
        end
        data(67,b+1)=u_final;
        
        %趋势数据
        mx1 = max(data(54,b-8:b+1)); %10s的数据间隔
        mx2 = max(data(54,b-18:b-9));
        mx3 = max(data(54,b-28:b-19));
        mn1 = min(data(54,b-8:b+1));
        mn2 = min(data(54,b-18:b-9));
        mn3 = min(data(54,b-28:b-19));

        %趋势数据峰谷值
        mx_max = max([mx1,mx2,mx3]);
        mn_min = min([mn1,mn2,mn3]);

        %温度高于设定值，并且是还保持上升趋势
        if (mn_min>=fjl_temp_sp-15) && (mod(b,23)==0) && ((mx1>mx2) && (mx2>mx3))
    % % %             ||...(mx11>mx21) && (mx21>mx31))
            delvd = 0;
            if mn_min-fjl_temp_sp>=7
                delvd=fjl_delvd1;
            elseif mn_min-fjl_temp_sp>=5
                delvd=fjl_delvd2;
            elseif mn_min-fjl_temp_sp>=3
                delvd=fjl_delvd3;
            end
            u_final = data(12,b+1) - (fjl_vd + delvd);  %温度高，需要减煤
        %温度低于设定值，并且是还保持下降趋势
        elseif (mx_max<=fjl_temp_sp+15) && (mod(b,23)==0) && ((mx1<mx2) && (mx2<mx3))
    % % %             ||...(mx11<mx21) && (mx21<mx31))
            delvd = 0;
            if fjl_temp_sp-mx_max>=7
                delvd=fjl_delvd4;
            elseif fjl_temp_sp-mx_max>=5
                delvd=fjl_delvd5;
            elseif fjl_temp_sp-mx_max>=3
                delvd=fjl_delvd6;
            end
            u_final = data(12,b+1) + (fjl_vd + delvd);  %温度低，需要加煤
        end
        
        %CO飙升处理  滤波300s
        if b > 50
            if data(10,b+1) > fjl_temp_sp - 25
                if u_final > data(12,b)
                    if data(36,b+1) > fjl_CO_level1
                        if mod(b,5) == 0
                            u_final = data(12,b) - fjl_CO_P1;
                            pidloop(3,6) = data(12,b) - fjl_CO_P1;
                        end
                    elseif data(36,b+1) > fjl_CO_level2
                        if mod(b,5) == 0
                            u_final = data(12,b) - fjl_CO_P2;
                            pidloop(3,6) = data(12,b) - fjl_CO_P2;
                        end
                    elseif data(36,b+1) > fjl_CO_level3
                        if mod(b,5) == 0
                            u_final = data(12,b) - fjl_CO_P3;
                            pidloop(3,6) = data(12,b) - fjl_CO_P3;
                        end
                    end
                end
            end
        end
    end
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%分解炉模块End%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 清屏
if mod(b,100)==0                   %每100s清屏
    clc;
end

%% 11-04 手动干预 篦冷机 采用直接修改upid(1)并赋值给pidloop(3,1)的方法
if man_in_blj == true
    man_in_blj = false;
    blj_cd1_calc = man_blj_speed;
    pidloop(3,1) = man_blj_speed;
end

%% 11-04 手动干预 分解炉 修改设定值后关闭自动停滞3秒 重开
if man_in_fjl == true 
    man_in_fjl = false;
    man_fjl_time_cnt = 1;
    pidloop(3,6) = man_fjl_coal;
    P_write(12,man_fjl_coal,fjl_MAX,fjl_MIN);
    sign_fjl = 0;
end

if man_fjl_time_cnt ~= 0
    man_fjl_time_cnt = man_fjl_time_cnt + 1;
end

if man_fjl_time_cnt > 18
    man_fjl_time_cnt = 0;
    sign_fjl = 1;
end   

%% 无扰切换
%分解炉出口温度
if 0==sign_fjl 
    pidloop(1,6)=pidloop(2,6);
    pidloop(3,6)=data(12,b+1);
    fjl_weimei_sp=data(12,b+1);
    u_final = data(12,b+1);
end

%% 写控制量 
%篦冷机
if sign_blj == 1
    if abs(blj_cd1_calc-data(6,b))>=0.01
        P_write(6,blj_cd1_calc,zhuansu_MAX,zhuansu_MIN);
        P_write(7,blj_cd1_calc,zhuansu_MAX,zhuansu_MIN);
    end
end
%分解炉
if sign_fjl == 1
    try
        P_write(12,u_final,fjl_MAX,fjl_MIN);
    catch
        disp('error:P_write(12,');
    end
end


%% 生料仓重空仓，满仓
% % % if b>30
% % %     if(sum(data(20,b-8:b+1))/10<20) && mod(b,30)==0
% % %         SLvalveR_sp=data(25,b)+0.3;
% % %         pidloop(3,5)=SLvalveR_sp;
% % %     end
% % %     if(sum(data(20,b-8:b+1))/10>35) && mod(b,30)==0
% % %         SLvalveR_sp=data(25,b)-0.4;
% % %         pidloop(3,5)=SLvalveR_sp;
% % %     end
% % % end
%% 
%生料仓重
if sign_douti == 1
    if abs(SLvalveR_sp-data(25,b))>=0.01
        P_write(25,SLvalveR_sp,SLvalveR_sp_MAX,SLvalveR_sp_MIN);
    end
end

%头煤压力
if sign_toumei == 1
    if abs(toumeiPress_calc-data(28,b))>=0.01
        P_write(28,toumeiPress_calc,toumei_MAX,toumei_MIN);
    end
end

%窑头负压
if yaotou_on == 1                %1026
    if abs(toupai_speed-data(38,b))>=0.01
        P_write(38,toupai_speed,toupai_max,toupai_min);  %data
    end
end

% if douti_on == 1                %1026
%     if abs(xialiaoliang-data(19,b))>=0.01
% % % % % %         P_write(19,xialiaoliang,xialiao_max,xialiao_min);  %data
%     end
% end
%1204

%高温风机
if gwfjfy_on == 1       
    if abs(weipai_speed-data(40,b))>=0.01
        P_write(40,weipai_speed,weipai_max,weipai_min);  %data
    end
end
%% 报警设置

try
    set(pophandles.blj_now,'String',num2str(data(65,b+1),'%4.0f'));
    set(pophandles.xialiao_left_now,'String',num2str(data(10,b+1),'%4.1f'));
    set(pophandles.xialiao_right_now,'String',num2str(data(72,b+1),'%4.1f'));
    set(pophandles.tmnow,'String',num2str(data(35,b+1),'%4.1f'));
catch
end

try
if ~(data(65,b+1) >= blj_upper_limit || data(65,b+1) <= blj_lower_limit || ...
        data(10,b+1) >= xialiao_left_upper_limit || data(10,b+1) <= xialiao_left_lower_limit ||...
        data(72,b+1) >= xialiao_right_upper_limit || data(72,b+1) <= xialiao_right_lower_limit||...
        data(35,b+1) >= tmmax || data(35,b+1) <= tmmin)
    set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    alarm_sound_flag = 0;
end

if (data(65,b+1) >= blj_upper_limit || data(65,b+1) <= blj_lower_limit || ...
        data(10,b+1) >= xialiao_left_upper_limit || data(10,b+1) <= xialiao_left_lower_limit ||...
        data(72,b+1) >= xialiao_right_upper_limit || data(72,b+1) <= xialiao_right_lower_limit||...
         data(35,b+1) >= tmmax || data(35,b+1) <= tmmin)
    try
        if(mod(b,2)==1)
            set(handles.alarmbutton,'BackgroundColor',[1 0 0]);%将报警设置按钮背景为红色
        else
            set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
        end
        alarm_sound_flag = 1;
    catch
        %     disp('没有打开报警设置窗口');
    end
end
catch
end
try
    set(pophandles.blj_upper_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
    set(pophandles.blj_lower_limit,'ForegroundColor',[0 0 0]);
    set(pophandles.xialiao_left_upper_limit,'ForegroundColor',[0 0 0]);
    set(pophandles.xialiao_left_lower_limit,'ForegroundColor',[0 0 0]);
    set(pophandles.xialiao_right_upper_limit,'ForegroundColor',[0 0 0]);
    set(pophandles.xialiao_right_lower_limit,'ForegroundColor',[0 0 0]);
    set(pophandles.tmmax,'ForegroundColor',[0 0 0]);
    set(pophandles.tmmin,'ForegroundColor',[0 0 0]);
catch
%     disp('没有打开报警设置窗口');
end
% 篦冷机报警
if (data(65,b+1) >= blj_upper_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.blj_upper_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.blj_upper_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

if (data(65,b+1) <= blj_lower_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.blj_lower_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.blj_lower_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end
% 分解炉报警
if (data(10,b+1) >= xialiao_left_upper_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.xialiao_left_upper_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.xialiao_left_upper_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

if (data(10,b+1) <= xialiao_left_lower_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.xialiao_left_lower_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.xialiao_left_lower_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

%

if (data(35,b+1) >= tmmax)
    try
        if(mod(b,2)==1)
            set(pophandles.tmmax,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.tmmax,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

if (data(35,b+1) <= tmmin)
    try
        if(mod(b,2)==1)
            set(pophandles.tmmin,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.tmmin,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

% 分解炉报警
if (data(30,b+1) >= xialiao_right_upper_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.xialiao_right_upper_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.xialiao_right_upper_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

if (data(30,b+1) <= xialiao_right_lower_limit)
    try
        if(mod(b,2)==1)
            set(pophandles.xialiao_right_lower_limit,'ForegroundColor',[1 0 0]);%将当前上行温度为红色
        else
            set(pophandles.xialiao_right_lower_limit,'ForegroundColor',[0 0 0]);%将当前上行温度为黑色
        end
    catch
            %disp('没有打开报警设置窗口');
    end
end

try
    if alarm_sound_flag && ~alarm_button_clicked
        load sounds
        sound(y,Fs)
    end
end

if alarm_button_clicked
    if alarm_timer == 0
        alarm_timer = 300;
        alarm_button_clicked = 0;
    else
        alarm_timer = alarm_timer - 1;
    end
end
end


