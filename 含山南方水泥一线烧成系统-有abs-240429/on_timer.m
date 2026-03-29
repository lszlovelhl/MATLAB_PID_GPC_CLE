function on_timer(obj,event,handles)
global daobj group   lastsave  data b tempdata tempdatavalue  first data1 paramdata first_time_connect_flag_ontimer
global blj_on fjl_on douti_on toumei_on gw_fj_press_on
global pidloop upid fj11dl0 fj11dl1 fj11dl2 fj11dl3
global A B P gpc_a gpc_lmd workpoint Up1 fjl_temp_sp yout1 u_decomposing_furnace_tempr
global fj11dl_sp dtdlcntflag dtdlcnt
global blj_vd zhuansu_MAX zhuansu_MIN temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2 fjl_vd fjl_max fjl_min fjl_xianfu fjl_delvd1 fjl_delvd2 fjl_delvd3 fjl_delvd4
global dt_max dt_min
global tm_alpha tm_beta tm_gamma tm_max tm_min tm_alpha1 tm_beta1 tm_gamma1
global u_blj_speed workpoint2 A2 B2 Up2 yout2
global p_blj_a1 p_blj_lmd1 p_blj_a2 p_blj_lmd2 dtdlcntMax blj_delvd1_up blj_delvd2_up blj_delvd3_up blj_delvd4_up blj_delvd1_down blj_delvd2_down blj_delvd3_down blj_delvd4_down
global dtdl_sp
global man_in_blj man_zhuansu man_in_fjl man_weimei man_in_dtdl man_dtdl man_in_toumei man_toumei man_in_gaowen man_gaowen
global keycount hisdatadays hitdata_title
global wmfy_sp u_final fjl_test loopnum
global douti_jisuan toumei_jisuan gw_fj_jisuan pophandles
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global alarm_sound_flag alarm_timer alarm_button_clicked
global man_blj_time_cnt man_fjl_time_cnt fjl_cle_test fjl_tishenji gwfj_alpha gwfj_beta gwfj_gamma gwfj_max gwfj_min
%%%%%wyx 2023/4/24
global blj_fjdl fjl_wendu fjl_wml_fk douti_dl yaotou_wm wpfj_zs toupai_zs
global manaotu Toumei_modTime Weimei_modTime toumei_single_change weimei_single_change itemset
%% 获取OPC中各变量的值
try
    tic
    tempdata = read(group);              % length(tempdata) = 35
    [~, b] = size(data);        % b=1
    for k = 1 : length(tempdata)         % Wincc中的各变量值
        data(k,b + 1) = tempdata(k).Value;
        tempdatavalue(k) = tempdata(k).Value;
    end
    tempdata(37).Value=fj11dl_sp;%%%%%wyx设定值存csv
    tempdatavalue(37) = tempdata(37).Value;%%%%%wyx设定值存csv
    tempdata(38).Value=fjl_temp_sp;
    tempdatavalue(38) = tempdata(38).Value;
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
    
    manaotu=paramdata.commdata(1).parameter(13).ATTRIBUTE.manaotu;
    Toumei_modTime=paramdata.commdata(1).parameter(13).ATTRIBUTE.Toumei_modTime;
    toumei_single_change=paramdata.commdata(1).parameter(13).ATTRIBUTE.toumei_single_change;
    Weimei_modTime=paramdata.commdata(1).parameter(13).ATTRIBUTE.Weimei_modTime;
    weimei_single_change=paramdata.commdata(1).parameter(13).ATTRIBUTE.weimei_single_change;
    
    if manaotu == 1
        %头煤
        if data(56,b+1) > 10 && mod(b, Toumei_modTime) == 0
            write(itemset(56),data(56,b+1)+toumei_single_change);
        %尾煤
        elseif data(57,b+1) > 10 && mod(b, Weimei_modTime) == 0
            write(itemset(57),data(57,b+1)+weimei_single_change);
        end
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
    blj_delvd1_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1_up;
    blj_delvd2_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2_up;
    blj_delvd3_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3_up;
    blj_delvd4_up = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4_up;
    blj_delvd1_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd1_down;
    blj_delvd2_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd2_down;
    blj_delvd3_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd3_down;
    blj_delvd4_down = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_delvd4_down;
    blj_xianfu = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_xianfu;
    blj_cle_max=paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_cle_max;
    blj_cle_min=paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_cle_min;
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
    fjl_cle_max=paramdata.commdata(1).parameter(12).ATTRIBUTE.fjl_cle_max;
    fjl_cle_min=paramdata.commdata(1).parameter(12).ATTRIBUTE.fjl_cle_min;
    fjl_temp=paramdata.commdata(1).parameter(12).ATTRIBUTE.fjl_temp;
    %斗提电流pid参数获取
    dtdl_alpha = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_alpha;
    dtdl_beta = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_beta;
    dt_max = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_max;
    dt_min = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_min;
    %头煤pid参数获取
    tm_alpha = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha;
    tm_beta = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta;
    tm_gamma = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_gamma;
    tm_alpha1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha1;%大偏差参数
    tm_beta1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta1;
    tm_gamma1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_gamma1;
    tm_max = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_max;
    tm_min = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_min;
    %高温风机pid参数获取
    gwfj_alpha = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_alpha;
    gwfj_beta = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_beta;
    gwfj_gamma = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_gamma;
    gwfj_max = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_max;
    gwfj_min = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_min;
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
    data(80,b+1) = data(12,b+1);
    data(77,b+1)=wmfy_sp;%尾煤风压设定
    
    %%%%%wyx 2023/4/24
    blj_fjdl=data(7,b+1);
    fjl_wendu=data(12,b+1);
    fjl_wml_fk = data(14,b+1);
    douti_dl=data(25,b+1);
    yaotou_wm=data(19,b+1);
    wpfj_zs=data(43,b+1);
    toupai_zs=data(47,b+1);
    
    %篦冷机
    set(handles.first_fj_fk,'String',num2str(round(100*data(3,b+1))/100,'%4.2f'));
    set(handles.first_fj_sp,'String',num2str(round(100*data(2,b+1))/100,'%4.2f'));
    set(handles.first_fj_sp2,'String',num2str(round(100*data(2,b+1))/100,'%4.2f'));
    set(handles.first_dl_fk,'String',num2str(round(100*data(7,b+1))/100,'%4.2f'));
    set(handles.first_dl_sp,'String',num2str(round(100*fj11dl_sp)/100,'%4.2f'));
    set(handles.blj_yali,'String',num2str(round(100*data(39,b+1))/100,'%4.2f'));
    %分解炉
    set(handles.fjl_wml_fk,'String',num2str(round(100*data(14,b+1))/100,'%4.2f'));
    set(handles.fjl_wml_sp,'String',num2str(round(100*data(13,b+1))/100,'%4.2f'));
    set(handles.fjl_wml_sp2,'String',num2str(round(100*data(13,b+1))/100,'%4.2f'));
    set(handles.dt_dl_fk,'String',num2str(round(100*data(80,b+1))/100,'%4.2f'));
    set(handles.fjl_temp_fk,'String',num2str(round(100*data(12,b+1))/100,'%4.2f'));
    set(handles.weimei_press_lvbo,'String',num2str(round(100*data(33,b+1))/100,'%4.2f'));
    set(handles.wm_fuhe,'String',num2str(round(100*data(46,b+1))/100,'%4.2f'));
    %斗提电流
    set(handles.dt_wll_fk,'String',num2str(round(100*data(26,b+1))/100,'%4.2f'));
    set(handles.dt_wll_sp,'String',num2str(round(100*data(28,b+1))/100,'%4.2f'));
    set(handles.dt_dl_fk,'String',num2str(round(100*data(25,b+1))/100,'%4.2f'));
    %头煤压力
    set(handles.tm_wml_fk,'String',num2str(round(100*data(19,b+1))/100,'%4.2f'));
    set(handles.tm_wml_sp,'String',num2str(round(100*data(18,b+1))/100,'%4.2f'));
    set(handles.tm_press_fk,'String',num2str(round(100*data(30,b+1))/100,'%4.2f'));
    %高温风机进口压力
    set(handles.wp_fj_fk,'String',num2str(round(100*data(43,b+1))/100,'%4.2f'));
    set(handles.wp_fj_sp,'String',num2str(round(100*data(42,b+1))/100,'%4.2f'));
    set(handles.gw_fj_press_pv,'String',num2str(round(100*data(55,b+1))/100,'%4.2f'));
    %二次风温
    set(handles.ecfw_display,'String',num2str(round(100*data(16,b+1))/100,'%4.2f'));
    %三次风温
    set(handles.scfw_display,'String',num2str(round(100*data(15,b+1))/100,'%4.2f'));
    %回转窑电流
    set(handles.hzy_diplay,'String',num2str(round(100*data(22,b+1))/100,'%4.2f'));
    %窑尾分析CO反馈
    set(handles.yaowei_co,'String',num2str(1000*data(45,b+1),'%4.2f'));
    %窑尾分析O2反馈
    set(handles.yaowei_o2,'String',num2str(round(1000*data(34,b+1))/1000,'%4.2f'));
    %% 获取设定值
    fjl_temp_sp = str2double(get(handles.fjl_temp_sp,'String'));
    dtdl_sp = str2double(get(handles.douti_sp,'String'));
    data(90,b+1) = str2double(get(handles.toumei_sp,'String'));
    data(91,b+1) = str2double(get(handles.gw_fj_press_sp,'String'));
    data(87,b+1) = fj11dl_sp;   %一级风机电流设定值
    data(88,b+1) = fjl_temp_sp; %gui界面设定值
    data(89,b+1) = dtdl_sp;
    %% 记录设定值
    data(65,b+1) = fj11dl_sp;
    data(66,b+1) = fjl_temp_sp;
    data(67,b+1) = dtdl_sp;
    data(68,b+1) = str2double(get(handles.toumei_sp,'String'));
    data(69,b+1) = str2double(get(handles.gw_fj_press_sp,'String'));
    
    %% 获取开关标志位
    data(82,b+1) = blj_on;
    data(83,b+1) = fjl_on;
    data(84,b+1) = douti_on;
    data(85,b+1) = toumei_on;
    data(76,b+1) = gw_fj_press_on;
    %% 记录开关标志位
    data(59,b+1) = blj_on;
    data(60,b+1) = fjl_on;
    data(61,b+1) = douti_on;
    data(62,b+1) = toumei_on;
    data(63,b+1) = gw_fj_press_on;
    
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
    % 5 高温风机进口负压
    if 1 == gw_fj_press_on
        pidloop(10,6) = 0;
    else
        pidloop(10,6) = 1;
    end
    
    %% 实际值滤波
    % F1M1风机电流滤波
    if b>=31
        data(101,b+1)=sum(data(7,b-23:b+1))/25;%F1M1风机电流
    else
        data(101,b+1)=data(7,b+1);
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
    % 斗提电流滤波
    if b>31
        data(102,b+1)=sum(data(25,b-28:b+1))/30;
    else
        data(102,b+1)=data(25,b+1);
    end
    %头煤压力滤波值
    if b>21
        data(103,b+1)=sum(data(30,b-8:b+1))/10; %头煤压力
    else
        data(103,b+1)=data(30,b+1);
    end
    %高温风机进口负压滤波值
    if b>21
        data(105,b+1)=sum(data(55,b-8:b+1))/10; %高温风机进口负压
    else
        data(105,b+1)=data(55,b+1);
    end
    
    
    %% pid 设定值
    pidloop(1,4) = data(90,b+1); %头煤压力设定值
    pidloop(2,6) = data(91,b+1); %尾排风机设定值
    pidloop(1,3) = data(89,b+1); %斗提电流设定值
    
    %% pid 实际值
    pidloop(2,4) = data(103,b+1);%头煤压力检测值
    pidloop(1,6) = data(105,b+1); %尾排风机检测值
    pidloop(2,7) = data(79,b+1);%尾煤压力检测值
    pidloop(2,3) = data(102,b+1); %斗提电流检测值
    %% pid参数整定
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
    %高温风机进口负压参数整定
    pidloop(7,6) = gwfj_alpha;
    pidloop(8,6) = gwfj_beta;
    pidloop(9,6) = gwfj_gamma;
    pidloop(11,6) = gwfj_max;
    pidloop(12,6) = gwfj_min;
    pidloop(13,6)=0.01;
    %% 各段回路控制计算
    %% 计算各段篦冷机控制量
    [~, loopnum]=size(pidloop);
    %% %%%%%%%%%篦冷机回路模块%%%%%%%%%%%%
    if 1 == blj_on
        %判断斗提电流设定值是否刚变化后等待25min才执行换挡逻辑
        if data(89,b+1)~=data(89,b)
            dtdlcntflag = 1; %电流变化
            dtdlcnt = 0; %斗提连续变化时，已最后一次变化开始计算时间
        end
        if 1==dtdlcntflag
            dtdlcnt = dtdlcnt+1;
            if dtdlcnt >= dtdlcntMax  %等待25min
                dtdlcnt = dtdlcntMax;
                dtdlcntflag = 0;
            end
        end
        %分档控制11风机电流设定值、转速上下限
        if (0==dtdlcntflag && 0==dtdlcnt) || (0==dtdlcntflag && dtdlcntMax==dtdlcnt)
            %斗提电流控制关闭，使用喂料量分档
            if 0==douti_on
                if data(28,b+1) >= WLlevel0
                    fj11dl_sp = fj11dl0;
                    %zhuansu_MAX = zhuansu_MAX0;
                    %zhuansu_MIN = zhuansu_MIN0;
                elseif data(28,b+1) >= WLlevel1
                    fj11dl_sp = fj11dl1;
                    %zhuansu_MAX = zhuansu_MAX1;
                    %zhuansu_MIN = zhuansu_MIN1;
                elseif data(28,b+1) >= WLlevel2
                    fj11dl_sp = fj11dl2;
                    %zhuansu_MAX = zhuansu_MAX2;
                    %zhuansu_MIN = zhuansu_MIN2;
                elseif data(28,b+1) >= WLlevel3
                    fj11dl_sp = fj11dl3;
                    %zhuansu_MAX = zhuansu_MAX3;
                    %zhuansu_MIN = zhuansu_MIN3;
                else
                    fj11dl_sp = fj11dl3;
                    %zhuansu_MAX = zhuansu_MAX3;
                    %zhuansu_MIN = zhuansu_MIN3;
                end
            else   %斗提电流控制打开，使用斗提电流设定值分档
                if data(89,b+1) >= DTlevel0
                    fj11dl_sp = fj11dl0;
                    %zhuansu_MAX = zhuansu_MAX0;
                    %zhuansu_MIN = zhuansu_MIN0;
                elseif data(89,b+1) >= DTlevel1
                    fj11dl_sp = fj11dl1;
                    %zhuansu_MAX = zhuansu_MAX1;
                    %zhuansu_MIN = zhuansu_MIN1;
                elseif data(89,b+1) >= DTlevel2
                    fj11dl_sp = fj11dl2;
                    %zhuansu_MAX = zhuansu_MAX2;
                    %zhuansu_MIN = zhuansu_MIN2;
                elseif data(89,b+1) >= DTlevel3
                    fj11dl_sp = fj11dl3;
                    %zhuansu_MAX = zhuansu_MAX3;
                    %zhuansu_MIN = zhuansu_MIN3;
                else
                    fj11dl_sp = fj11dl3;
                    %zhuansu_MAX = zhuansu_MAX3;
                    %zhuansu_MIN = zhuansu_MIN3;
                end
            end
        end
        if b > 16
            % %%%%%%%gpc参数配置
            workpoint2=[3.0391,239.0177];
            %         A2=[-0.9127,1];  %5s
            %         B2=1.793;     %5s
            %         A2=[-0.8331,1];  %10s
            %         B2=3.43;     %10s
            A2=[-0.7603,1];  %15s
            B2=4.924;     %15s
            %         A2=[-0.694,1];  %20s
            %         B2=6.288;     %20s
            %         A2=[-0.5781,1];  %30s
            %         B2=0.668;     %30s
            
            
            Up2(1)=data(2,b-13)-workpoint2(1);
            Up2(2)=data(2,b+1)-workpoint2(1);
            P=[0.01,0.01;0.01,0.01];
            gpc_a2=p_blj_a1;
            gpc_lmd2=p_blj_lmd1;
            if (abs(data(101,b+1) - fj11dl_sp)) > 3.5  %大偏差
                gpc_a2=p_blj_a2;%0.9690;
                gpc_lmd2=p_blj_lmd2;%130;
            end
            yout2=data(101,b-13:7:b+1)-workpoint2(2);
            if mod(b,15)==0
                gpc_fj11dl_sp = fj11dl_sp-workpoint2(2);
                gpc_blj_speed = gpc_clac(A2,B2,P,yout2,Up2,gpc_fj11dl_sp,gpc_a2,gpc_lmd2);
                u_blj_speed = workpoint2(1)+gpc_blj_speed;
            end
            if b > 150
                %趋势数据
                mx1 = max(data(101,b-8:b+1)); %10s的数据间隔
                mx2 = max(data(101,b-18:b-9));
                mx3 = max(data(101,b-28:b-19));
                mn1 = min(data(101,b-8:b+1));
                mn2 = min(data(101,b-18:b-9));
                mn3 = min(data(101,b-28:b-19));
                
                mx11 = max(data(101,b-48:b+1)); %50s的数据间隔
                mx21 = max(data(101,b-98:b-49));
                mx31 = max(data(101,b-148:b-99));
                
                %趋势数据峰谷值
                mx_max = max([mx1,mx2,mx3]);
                mn_min = min([mn1,mn2,mn3]);
                
                %电流高于设定值，并且是还保持上升趋势
                if (mn_min>=fj11dl_sp-blj_cle_min) && (mod(b,23)==0)...
                        && (((mx1>mx2) && (mx2>mx3))||...
                    (mx11>mx21) && (mx21>mx31))
                    delvd = 0;
                    if abs(mn_min-fj11dl_sp)>=7
                        delvd=blj_delvd4_down;
                    elseif abs(mn_min-fj11dl_sp)>=5
                        delvd=blj_delvd3_down;
                    elseif abs(mn_min-fj11dl_sp)>=3
                        delvd=blj_delvd2_down;
                    elseif abs(mn_min-fj11dl_sp)>=1
                        delvd=blj_delvd1_down;
                    end
                    u_blj_speed = data(2,b+1) - (blj_vd + delvd); %电流保持上升趋势，需要减篦速
                %电流低于设定值，并且是还保持下降趋势
                elseif (mx_max<=fj11dl_sp+blj_cle_max) && (mod(b,23)==0)...
                        && (((mx1<mx2) && (mx2<mx3) )||...
                    (mx11<mx21) && (mx21<mx31))
                    delvd = 0;
                    if abs(fj11dl_sp-mx_max)>=7
                        delvd=blj_delvd4_up;
                    elseif abs(fj11dl_sp-mx_max)>=5
                        delvd=blj_delvd3_up;
                    elseif abs(fj11dl_sp-mx_max)>=3
                        delvd=blj_delvd2_up;
                    elseif abs(fj11dl_sp-mx_max)>=1
                        delvd=blj_delvd1_up;
                    end
                    u_blj_speed = data(2,b+1) + (blj_vd + delvd);  %电流保持下降趋势，需要加篦速
                end
            end
            
        end
        %限振幅
        ufjl = blj_xianfu;
        if (u_blj_speed<=(data(2,b)-ufjl))
            u_blj_speed=data(2,b)-ufjl;
        end
        if (u_blj_speed>=(data(2,b)+ufjl))
            u_blj_speed=data(2,b)+ufjl;
        end
        
        data(96,b+1)=u_blj_speed;
    end
    
    
    
    %%%%%%%%%%%篦冷机回路模块结束%%%%%%%%
    
    %% %%%%%%%%%分解炉回路模块%%%%%%%%%%%%
    if 1 == fjl_on
        if data(14,b+1) > 5
            set(handles.fjl_wml_fk,'ForegroundColor',[0 0 0]);%将尾煤量反馈值设置为黑色
        else
            fjl_on = 0;
            set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.fjl_button_off,'BackgroundColor',[1 0 0]);
            set(handles.fjl_wml_fk,'ForegroundColor',[1 0 0]);%将尾煤量反馈值设置为红色
        end
        if b>21 %这个时间的判断注意和控制周期以及Up1(1)=data(12,b-4)-workpoint(1)b-4匹配
            
            %%%%外回路gpc
            
            % % % % % % %wyx
            workpoint=[25.0105,841.1101];
            
            %         A=[-0.9846,1]; %5s
            %         B=0.2301;  %5s
            %        A=[-0.9694,1]; %10s
            %        B=0.4566;  %10s
            %         A=[-0.9545,1]; %15s
            %         B=0.6796;  %15s
            A=[-0.9398,1]; %20s
            B=0.8992;  %20s
            %         A=[-0.9263,1]; %25s
            %         B=1.115;  %25s
            %         A=[-0.9111,1]; %30s
            %         B=1.328;  %30s
            
            
            Up1(1)=data(79,b-18)-workpoint(1);
            Up1(2)=data(79,b+1)-workpoint(1);
            
            P=[0.01,0.01;0.01,0.01];
            gpc_a=temp_fjl_alpha1;
            gpc_lmd=temp_fjl_lambda1;
            
            data(78,b+1)=fjl_temp_sp;
            fjl_temp_sp=fjl_temp_sp-fjl_temp;
            if abs(fjl_temp_sp- data(12,b+1))>3
                gpc_a=temp_fjl_alpha2;
                gpc_lmd=temp_fjl_lambda2;
            end
            yout1=data(12,b-18:9:b+1)-workpoint(2);
            
            if mod(b,20)==0  &&abs(data(79,b-18)-data(79,b+1))<0.6
                gpc_fjl_temp_sp=fjl_temp_sp-workpoint(2);
                wmfy_sp = workpoint(1)+gpc_clac(A,B,P,yout1,Up1,gpc_fjl_temp_sp,gpc_a,gpc_lmd);
                %%%%内回路pid
                pidloop(1,7)=wmfy_sp; %sp
                pidloop(:,7)=pid_calc(pidloop(:,7)');
                pidloop(3,7)=round(pidloop(3,7)*100)/100;
                data(77,b+1)=wmfy_sp;%尾煤风压设定
                if ((pidloop(1,7)>=pidloop(2,7))&&(pidloop(3,7)>=fjl_max)) %当设定值大于测量值时，并且给煤量已经最大
                    pidloop(1,7)= pidloop(2,7);
                    pidloop(3,7)=fjl_max;
                    pidloop(10,7)=1;
                else
                    pidloop(10,7)=0;
                end
                if ((pidloop(1,7)<=pidloop(2,7))&&(pidloop(3,7)<=fjl_min)) %当设定值小于测量值时，并且给煤量已经最小
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
                mx1 = max(data(12,b-3:b+1)); %5s的数据间隔
                mx2 = max(data(12,b-8:b-4));
                mx3 = max(data(12,b-13:b-9));
                mn1 = min(data(12,b-3:b+1));
                mn2 = min(data(12,b-8:b-4));
                mn3 = min(data(12,b-13:b-9));
                
                mx11 = max(data(12,b-28:b+1)); %30s的数据间隔
                mx21 = max(data(12,b-58:b-29));
                mx31 = max(data(12,b-88:b-59));
                
                %趋势数据峰谷值
                mx_max = max([mx1,mx2,mx3]);
                mn_min = min([mn1,mn2,mn3]);
                
                %温度高于设定值，并且是还保持上升趋势
                if (mn_min>=fjl_temp_sp-fjl_cle_min) && (mod(b,23)==0)...
                        && (((mx1>mx2) && (mx2>mx3)) ||...
                        (mx11>mx21) && (mx21>mx31))
                    delvd = 0;
                    if mn_min-fjl_temp_sp>=7
                        delvd=fjl_delvd4;
                    elseif mn_min-fjl_temp_sp>=5
                        delvd=fjl_delvd3;
                    elseif mn_min-fjl_temp_sp>=3
                        delvd=fjl_delvd2;
                    elseif mn_min-fjl_temp_sp>=1
                        delvd=fjl_delvd1;
                    end
                    pidloop(3,7) = data(13,b+1) - (fjl_vd + delvd);  %温度高，需要减煤
                    fjl_cle_test=0- (fjl_vd + delvd);
                    %温度低于设定值，并且是还保持下降趋势
                elseif (mx_max<=fjl_temp_sp+fjl_cle_max) && (mod(b,23)==0)...
                        && (((mx1<mx2) && (mx2<mx3))||...
                        (mx11<mx21) && (mx21<mx31))
                    delvd = 0;
                    if fjl_temp_sp-mx_max>=7
                        delvd=fjl_delvd4;
                    elseif fjl_temp_sp-mx_max>=5
                        delvd=fjl_delvd3;
                    elseif fjl_temp_sp-mx_max>=3
                        delvd=fjl_delvd2;
                    elseif fjl_temp_sp-mx_max>=1
                        delvd=fjl_delvd1;
                    end
                    pidloop(3,7) = data(13,b+1) + (fjl_vd + delvd);  %温度低，需要加煤
                    fjl_cle_test=(fjl_vd + delvd);
                end
                u_decomposing_furnace_tempr=pidloop(3,7);
            end
            
            %斗提电流补偿
            if b > 130
                %delta_wm_press_1 = data(79,b-58) - data(79,b-59);
                %delta_wm_press_2 = data(79,b-59) - data(79,b-60);
                %delta_wm_press_3 = data(79,b-60) - data(79,b-61);
                delta_tsj_1 = data(102,b-110) - data(102,b-111);
                delta_tsj_2 = data(102,b-111) - data(102,b-112);
                delta_tsj_3 = data(102,b-112) - data(102,b-113);
                
            else
                %delta_wm_press_1 = data(33,b+1) - data(33,b);
                %delta_wm_press_2 = data(33,b) - data(33,b-1);
                %delta_wm_press_3 = data(33,b-1) - data(33,b-2);
                delta_tsj_1 = data(25,b + 1) - data(25,b);
                delta_tsj_2 = data(25,b) - data(25,b-1);
                delta_tsj_3 = data(25,b-1) - data(25,b-2);
                
            end
            
            %delta_wm_press = delta_wm_press_1 + delta_wm_press_2 + delta_wm_press_3;
            delta_tsj = delta_tsj_1 + delta_tsj_2 + delta_tsj_3;
            
            %weimeipreses = delta_wm_press * fjl_weimeipress_P;
            tishenji = delta_tsj * fjl_douti_P;
            
            if b>5 && (mod(b,3)==0)
                if (b > 130)
                    %u_decomposing_furnace_tempr = u_decomposing_furnace_tempr - weimeipreses + tishenji;
                    u_decomposing_furnace_tempr = u_decomposing_furnace_tempr + tishenji; %改串级回路后不补偿
                    fjl_tishenji=tishenji;
                end
            end
            
            data(73,b+1) = u_decomposing_furnace_tempr;
            
            %             co补偿
            % % %             if b > 5
            % % %
            % % %                 if u_decomposing_furnace_tempr > data(73,b)
            % % %                     if sum(data(46,b-3:b+1))/5 > 2500
            % % %                         if mod(b,1) == 0
            % % %                             u_decomposing_furnace_tempr = data(73,b) - 0.018;
            % % %                         end
            % % %                     elseif sum(data(46,b-3:b+1))/5 > 2000
            % % %                         if mod(b,1) == 0
            % % %                             u_decomposing_furnace_tempr = data(73,b) - 0.010;
            % % %                         end
            % % %                     elseif sum(data(46,b-3:b+1))/5 > 1530
            % % %                         u_decomposing_furnace_tempr = data(73,b) - 0.007;
            % % %                     end
            % % %                 end
            %                 end
        end
        %控制振幅
        umax = fjl_xianfu;
        if(u_decomposing_furnace_tempr>data(74,b)+umax)
            u_decomposing_furnace_tempr = data(74,b)+umax;
        elseif(u_decomposing_furnace_tempr<data(74,b)-umax)
            u_decomposing_furnace_tempr = data(74,b)-umax;
        end
        u_final=u_decomposing_furnace_tempr;
        pidloop(3,7)=u_final;
        data(74,b+1)=u_final;
        
        %尾煤称跳停保护
        if data(14,b+1) <= 5
            fjl_on = 0;
            man_fjl_time_cnt = 0;
            curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
            timestr=curT(1:10);
            fid=fopen(['EHD\data',timestr,'.txt'],'at');
            fprintf(fid,'%s\n',curT);
            fprintf(fid,'%s\n','分解炉回路关');
            fclose(fid);
            %
            set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.fjl_button_off,'BackgroundColor',[1 0 0]);
            set(handles.fjl_wml_fk,'ForegroundColor',[1 0 0]);%将尾煤量反馈值设置为红色
        else
            fjl_on = 1;
        end
    end
    %%%%%%%%%%%分解炉回路模块结束%%%%%%%%
    
    %% %%%%%%%%%斗提电流回路模块%%%%%%%%%%%%
    if 1==douti_on && b>30
        if mod(b,10)==0
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
        
        
        umax = 0.15;
        if upid(3)<=(data(28,b)-umax)    %%修改：根据现场实际
            upid(3)=data(28,b)-umax;      %忽略
        end
        if upid(3)>=(data(28,b)+umax)    %%修改：根据现场实际
            upid(3)=data(28,b)+umax;      %忽略
        end
        
        
    end
    
    %%%%%%%%%%%斗提电流回路模块结束%%%%%%%%
    
    %% %%%%%%%%%头煤压力回路模块%%%%%%%%%%%%
    if 1==toumei_on && b>30
        if mod(b,10)==0
            if pidloop(10,4)==0
                pidloop(:,4)=pid_calc(pidloop(:,4)');
                pidloop(3,4)=round(pidloop(3,4)*1000)/1000;%修改：根据现场调节给定精度
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
                upid(4)=pidloop(3,4);
            end
        end
        
        toumei_jisuan=upid(4);
        %控制振幅
        umax = 0.1;
        if upid(4)<=(data(18,b)-umax)
            upid(4)=data(18,b)-umax;
        end
        if upid(4)>=(data(18,b)+umax)
            upid(4)=data(18,b)+umax;
        end
        
    end
    %%%%%%%%%%%头煤压力回路模块结束%%%%%%%%
    %% %%%%%%%%%高温风机进口负压回路模块%%%%%%%%%%%%
    if 1==gw_fj_press_on && b>30
        if mod(b,10)==0
            if pidloop(10,6)==0
                pidloop(:,6)=pid_calc(pidloop(:,6)');
                pidloop(3,6)=round(pidloop(3,6)*100)/100;%修改：根据现场调节给定精度
                if ((pidloop(2,6)>=pidloop(1,6))&&(pidloop(3,6)>=gwfj_max)) %当设定值大于测量值时，并且阀门已经最大
                    pidloop(2,6)= pidloop(1,6);
                    pidloop(3,6)=gwfj_max;
                    pidloop(10,6)=1;
                else
                    pidloop(10,6)=0;
                end
                if ((pidloop(2,6)<=pidloop(1,6))&&(pidloop(3,6)<=gwfj_min)) %当设定值小于测量值时，并且阀门已经最小
                    pidloop(2,6)= pidloop(1,6);
                    pidloop(3,6)=gwfj_min;
                    pidloop(10,6)=1;
                else
                    pidloop(10,6)=0;
                end
                upid(6)=pidloop(3,6);
            end
        end
        gw_fj_jisuan=upid(6);
        %控制振幅
        umax = 0.3;
        if upid(6)<=(data(42,b)-umax)
            upid(6)=data(42,b)-umax;
        end
        if upid(6)>=(data(42,b)+umax)
            upid(6)=data(42,b)+umax;
        end
    end
    %%%%%%%%%%%高温风机进口负压回路模块结束%%%%%%%%
    %% 输出值保存
    data(93,b+1) = u_decomposing_furnace_tempr;
    data(94,b+1) = u_blj_speed;
    data(97,b+1)=douti_jisuan; %喂料量计算
    data(98,b+1)=toumei_jisuan; %头煤计算
    data(100,b+1)=gw_fj_jisuan; %高温风机计算
    %% 无扰动切换
    %篦冷机
    if 0==blj_on
        Up2=[data(2,b+1),data(2,b+1)]-workpoint2(1);
        u_blj_speed=data(2,b+1);
    end
    %分解炉
    if 0==fjl_on
        %     Up1=[data(13,b+1),data(13,b+1)]-workpoint(1);
        pidloop(1,7)=pidloop(2,7);
        pidloop(3,7)=data(13,b+1);
        u_decomposing_furnace_tempr=data(13,b+1);
        u_final=u_decomposing_furnace_tempr;
        data(74,b+1)=u_final;
    end
    %斗提电流
    if 0==douti_on
        pidloop(1,3)=pidloop(2,3);
        pidloop(3,3)=data(28,b);
        upid(3) = data(28,b+1);
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
    %高温风机进口负压
    if 0==gw_fj_press_on
        pidloop(2,6)=pidloop(1,6);
        pidloop(3,6)=data(42,b);
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
        u_decomposing_furnace_tempr = man_weimei;
    end
    if man_fjl_time_cnt > 10
        man_fjl_time_cnt = 0;
    end
    if 1==man_in_fjl && 1 == fjl_on
        man_in_fjl = 0;
        man_fjl_time_cnt = 1;
        u_decomposing_furnace_tempr = man_weimei;
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
    %高温风机进口负压
    if 1 == gw_fj_press_on && 1 == man_in_gaowen
        man_in_gaowen = 0;
        upid(6) = man_gaowen;
        pidloop(3,6) = man_gaowen;
    end
    %% 写入值
    %篦冷机转速写入值
    if 1==blj_on&&abs(u_blj_speed-data(2,b+1))>=0.01
        P_write(2,u_blj_speed,zhuansu_MAX,zhuansu_MIN);
    end
    %分解炉喂煤量写入
    if 1==fjl_on&&abs(u_decomposing_furnace_tempr-data(13,b))>=0.02
        try
            P_write(13,u_decomposing_furnace_tempr,fjl_max,fjl_min);
        catch
            disp('error:P_write(13,');
        end
    end
    %斗提电流喂料量写入
    if 1==douti_on&&abs(upid(3)-data(28,b))>=0.01
        P_write(28,upid(3),dt_max,dt_min);
    end
    %头煤压力窑头喂煤量控制
    if 1==toumei_on&&abs(upid(4)-data(18,b))>=0.01
        P_write(18,upid(4),tm_max,tm_min);
    end
    %高温风机进口负压控制量写入
    if 1==gw_fj_press_on&&abs(upid(6)-data(42,b))>=0.01
        P_write(42,upid(6),gwfj_max,gwfj_min);
    end
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
    
    if (data(1,b+1)<= snd_chamber_pressure_lowerlimitS)
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
        set(pophandles.text10,'String',num2str(data(80,b+1),'%.0f'));
        %     set(pophandles.fazu1,'String',num2str(data(87,b + 1)));
        %     set(pophandles.fazu2,'String',num2str(data(88,b + 1)));
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