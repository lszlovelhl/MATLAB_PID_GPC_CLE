function on_timer(obj,event,handles)

global connect_con first_time_connect_flag   u_final itemset first_time_connect_flag_ontimer
global daobj group   lastsave  data b tempdata tempdatavalue  pidloop loopnum upid alarm_sound_flag 
global pophandles alarm_button_clicked alarm_timer  bljblj
global A B workpoint  Up yout A2 B2 workpoint2 Up2 yout2          fjlumax yaotou_on
global flag gpc_a gpc_lmd   toupai_speed third d_tsj
global sign_blj sign_fjl sign_toumei sign_douti sign_fuya blj_press2_sp
global fjl_MAX fjl_MIN zhuansu_MAX zhuansu_MIN  toumei_MAX toumei_MIN sizecon 
global fjl_alpha1 fjl_lambda1 fjl_alpha2 fjl_lambda2 
global toumei_p toumei_i toumei_d weimei_man_plus_on weimei_man_minus_on
global blj_p1 blj_i1 blj_d1
global blj_p2 blj_i2 blj_d2 weimei_val pre_fjl_weimei_sp
global blj_p3 blj_i3 blj_d3 fjl_man_minus_timer1 fjl_man_minus_timer2 fjl_man_plus_timer1 fjl_man_plus_timer2
global blj_zhuansu_sp fjl_weimei_sp yaotou_sp  count1 count2
global fjl_upper_limit blj_lower_limit fjl_lower_limit blj_upper_limit gpc_flag gpc_timer tmp_pv shuipao1 shuipao2
global fjl_man_plus_on fjl_man_minus_on count_fjl_man fjl_fuzzy
global xialiao_left_lower_limit xialiao_left_upper_limit xialiao_right_upper_limit xialiao_right_lower_limit delta_tsj
global sign_blj_pump sign_blj4 blj_press_pv_round blj_press1_sp
global blj_pump_p blj_pump_i blj_pump_d flag_delta_I
global blj_pump1_sp
global blj_cd1_calc   yaotou_p yaotou_i yaotou_d
global bli_pump_flag
global fjl_pmg_gaspress_pv fjl_pmg_gaspress_sp
global sign_fjl_pmg_gaspress fjl_pmg_gaspress_flag
global SLvalveR_sp  toupai_max toupai_min
global SLcangzhong_p SLcangzhong_i SLcangzhong_d
global SLvalveR_sp_MIN SLvalveR_sp_MAX
global blj4_p blj4_i blj4_d
global ZHUANSU4_MAX ZHUANSU4_MIN
global blj_cd3_calc yaotoufy_sp
global CO_pv CO_sp sign_CO  CO_flag
global toumei_sp toumei_press_flag
global avgt avgpress avgspeed midspeed changespeed
global fjdl_up fjdl_down
global douti_p douti_i douti_d xialiao_max xialiao_min  xialiaoliang douti_sp douti_on 
global gwfj_p gwfj_i gwfj_d weipai_max weipai_min gwfjfy_sp gwfjfy_on weipai_speed xhfjfy_sp
global man_in_blj man_blj_speed man_fjl_time_cnt man_in_fjl man_fjl_coal rev

%% 获取Wincc中各变量的值

tic
tempdata = read(group);              % length(tempdata) = 35
[~, b] = size(data);
for k = 1 : length(tempdata)         % Wincc中的各变量值
    data(k,b + 1) = tempdata(k).Value;
    tempdatavalue(k) = tempdata(k).Value;
end
first_time_connect_flag_ontimer = first_time_connect_flag_ontimer - 1;

if first_time_connect_flag_ontimer<=0
    first_time_connect_flag_ontimer=0;
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

%头煤压力
toumei_p = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha;
toumei_i = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_beta;
toumei_d = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_gamma;

%篦冷机
blj_p1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_alpha1;
blj_i1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_beta1;
blj_d1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_gamma1;

blj_p2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_alpha2;
blj_i2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_beta2;
blj_d2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_gamma2;

blj_p3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.blj_alpha3;
blj_i3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.blj_beta3;
blj_d3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.blj_gamma3;

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

% toupai_max = paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_max;
% toupai_min = paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_min;
%下料
pdouti_p = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_p;
pdouti_i = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_i;
pdouti_d = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_d;

%高温风机 循环风机
pgwfjfy_p = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p;
pgwfjfy_i = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i;
pgwfjfy_d = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d;
pxhfjfy_p = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_p;
pxhfjfy_i = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_i;
pxhfjfy_d = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_d;
%% 获取设定值
sizecon = 50;
blj_press1_sp = str2double(get(handles.blj_press1_sp,'String'));
blj_pump1_sp = str2double(get(handles.blj_pump1_sp,'String'));
blj_press4_sp = str2double(get(handles.blj_press4_sp,'String'));
fjl_temp_sp = str2double(get(handles.fjl_temp_sp,'String'));
SLcangzhong_sp = str2double(get(handles.SLcangzhong_sp,'String'));
toumei_sp = str2double(get(handles.toumei_sp,'String'));
fjl_pmg_gaspress_sp = str2double(get(handles.fjl_pmg_gaspress_sp,'String'));
CO_sp = str2double(get(handles.CO_sp,'String'));
yaotoufy_sp=str2double(get(handles.yaotoufy_sp,'String'));
douti_sp=str2double(get(handles.douti_sp,'String'));
gwfjfy_sp=str2double(get(handles.gwfjfy_sp,'String'));
xhfjfy_sp=str2double(get(handles.xhfjfy_sp,'String'));



%% 测量值实时显示

% 篦冷机
set(handles.blj_press1_pv,'String',num2str(data(1,b+1),'%4.2f'));
set(handles.ercfw_pv,'String',num2str(data(26,b+1),'%4.2f'));
set(handles.blj_press4_pv,'String',num2str(data(3,b+1),'%4.2f'));
set(handles.blj_pump1_pv,'String',num2str(data(4,b+1),'%4.2f'));
set(handles.blj_cd1_sp,'String',num2str(data(6,b+1),'%4.2f'));
set(handles.blj_cd2_sp,'String',num2str(data(7,b+1),'%4.2f'));
set(handles.blj_cd3_sp,'String',num2str(data(8,b+1),'%4.2f'));
set(handles.blj_cd4_sp,'String',num2str(data(9,b+1),'%4.2f'));
set(handles.fengji,'String',num2str(data(41,b+1),'%4.2f'));
% 分解炉
set(handles.fjl_weimei_pv,'String',num2str(data(13,b+1),'%3.2f'));
set(handles.wuji_pv,'String',num2str(data(11,b+1),'%4.1f'));
set(handles.fjl_tmp,'String',num2str(data(10,b+1),'%4.1f'));
set(handles.fjl_weimei_sp,'String',num2str(data(12,b+1),'%4.2f'));
set(handles.fjl_pmg_gaspress_pv,'String',num2str(data(15,b+1),'%3.2f'));
set(handles.CO_pv,'String',num2str(data(36,b+1),'%3.1f'));
% 斗提
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

%高温风机 1204
gwfjcl=data(39,b+1);
if(b>30)    %滤波
    gwfjcl=sum(data(39,b-18:b+1))/20;
end
set(handles.gwfjfy_pv,'String',num2str(gwfjcl,'%4.2f')); %data
set(handles.weipai_speed,'String',num2str(data(40,b+1),'%4.2f')); %data
%循环风机   %点表有误
% xhfjcl=data(40,b+1);
% if(b>30)    %滤波
%     xhfjcl=sum(data(40,b-18:b+1))/20;
% end
% set(handles.xhfjfy_pv,'String',num2str(xhfjcl,'%4.2f')); %data
%% 控制器信号打开,获取自动控制开关信息
% 篦冷机
if(sign_blj==1)
    pidloop(10,1)=1;%自动为1
    data(sizecon+1,b+1) = blj_press1_sp;
else
    pidloop(10,1)=0;%自动为1
end
% if(sign_blj_pump==1)
%     pidloop(10,2)=1;%自动为1
%     data(sizecon+9,b+1) = blj_pump1_sp;
% % else
%     pidloop(10,2)=0;%自动为1
% end
% % 
if(sign_blj4==1)
    pidloop(10,3)=1;%自动为1
    data(sizecon+11,b+1) = blj_press4_sp;
else
    pidloop(10,3)=0;%自动为1
end
%分解炉
if(sign_fjl==1)
    data(sizecon+3,b+1) = fjl_temp_sp;   
end

%头煤压力
if(sign_toumei==1)
    pidloop(10,4)=1;%自动为1
    data(sizecon+7,b+1) = toumei_sp;
else
    pidloop(10,4)=0;%自动为1
end

% 斗提
if(sign_douti==1)
    pidloop(10,5)=1;%自动为1
    data(sizecon+5,b+1) = SLcangzhong_sp;
else
    pidloop(10,5)=0;%自动为1
end

%窑头负压
if(yaotou_on==1)
    pidloop(10,7)=1;%自动为1
    data(71,b+1) = yaotoufy_sp;
else
    pidloop(10,7)=0;%自动为1
end
%斗提
if(douti_on==1)
    pidloop(10,9)=1;%自动为1
    data(85,b+1) = yaotoufy_sp;
else
    pidloop(10,9)=0;%自动为1
end
%高温风机
if(gwfjfy_on==1)
    pidloop(10,10)=1;%自动为1
    data(90,b+1) = gwfjfy_sp;
else
    pidloop(10,10)=0;%自动为1
end
%循环风机
if(gwfjfy_on==2)
    pidloop(10,11)=1;%自动为1
    data(91,b+1) = gwfjfy_sp;
else
    pidloop(10,11)=0;%自动为1
end

%% 篦冷机控制

pidloop(2,1)=blj_press1_sp;   %反特性
pidloop(1,1)=data(26,b+1);
if(b>30)    %滤波
    pidloop(1,1)=sum(data(26,b-28:b+1))/30;
end
data(65,b+1)=data(41,b+1);
if b>40
    data(65,b+1)=sum(data(41,b-28:b+1))/30;
    data(80,b+1)=sum(data(17,b-28:b+1))/30;
    data(81,b+1)=sum(data(14,b-28:b+1))/30;
end
set(handles.fengji,'String',num2str(data(65,b+1),'%4.2f'));
    

data(sizecon+2,b+1)=pidloop(1,1);
set(handles.ercfw_pv,'String',num2str(data(sizecon+2,b+1),'%4.2f'));
if (abs(pidloop(2,1)-pidloop(1,1)) > 60)
    pidloop(7,1)=blj_p1;%kuc     大偏差系数
    pidloop(8,1)=blj_i1;%ke
    pidloop(9,1)=blj_d1;%kec
elseif (abs(pidloop(2,1)-pidloop(1,1)) > 30)
    pidloop(7,1)=blj_p2;%kuc    小偏差系数
    pidloop(8,1)=blj_i2;%ke
    pidloop(9,1)=blj_d2;%kec
else
    pidloop(7,1)=blj_p3;%kuc    稳态系数
    pidloop(8,1)=blj_i3;%ke
    pidloop(9,1)=blj_d3;%kec
end

    
pidloop(11,1)=zhuansu_MAX; %修改：根据现场调节上限
pidloop(12,1)=zhuansu_MIN;
pidloop(13,1)=0.01;%0.3



% 篦冷机转速-篦冷机压力PID计算
if sign_blj == 0
    blj_cd1_calc = data(6,b+1);   %手动控制
end

if sign_blj == 1 && bli_pump_flag == 0
  if mod(b,5)==0
    if pidloop(10,1)==1
        pidloop(:,1)=pid_calc(pidloop(:,1)');
        pidloop(3,1)=round(pidloop(3,1)*1000)/1000;%修改：根据现场调节给定精度
        blj_cd1_calc= pidloop(3,1); 


     
    end
  end
end
bljblj=blj_cd1_calc;
data(70,b+1)=bljblj;


%判断风机电流状态
delta_I = 0;
flag_delta_I = 0;
if b>100 && sign_blj == 1
        if mean(data(41,b-18:b+1)) - mean(data(41,b-38:b-19)) > 0 && ...
                        mean(data(41,b-38:b-19)) - mean(data(41,b-58:b-39)) > 0 && ...
                        mean(data(41,b-58:b-39)) - mean(data(41,b-78:b-59)) > 0
            flag_delta_I = 1;  %连续上升
        elseif mean(data(41,b-18:b+1)) - mean(data(41,b-38:b-19)) < 0 && ...
                        mean(data(41,b-38:b-19)) - mean(data(41,b-58:b-39)) < 0 && ...
                        mean(data(41,b-58:b-39)) - mean(data(41,b-78:b-59)) < 0
            flag_delta_I = 2;  %连续下降
        else
            flag_delta_I = 0;
        end
        
        if data(65,b+1)<avgpress&&...
                mean(data(41,b-18:b+1)) - mean(data(41,b-38:b-19)) > 0 && ...
                        mean(data(41,b-38:b-19)) - mean(data(41,b-58:b-39)) > 0 && ...
                        mean(data(41,b-58:b-39)) - mean(data(41,b-78:b-59)) > 0
                    rev=1;
        end
        
        if rev==1
            if mean(data(41,b-18:b+1)) - mean(data(41,b-38:b-19)) < 0 && ...
                        mean(data(41,b-38:b-19)) - mean(data(41,b-58:b-39)) < 0 && ...
                        mean(data(41,b-58:b-39)) - mean(data(41,b-78:b-59)) < 0
                    rev=0;
            end
        end
        


        if mod(b,5)==0
            if data(65,b+1)>=fjdl_up+6  %&&flag_delta_I==1
                %                  ff_flag = 280;
                if blj_cd1_calc>zhuansu_MIN
                    blj_cd1_calc = data(68,b)-0.5;
                else
                     blj_cd1_calc = zhuansu_MIN;
                 end
            elseif data(65,b+1)>fjdl_up+3%&&flag_delta_I==1
%                  ff_flag = 275;
                 blj_cd1_calc = zhuansu_MIN+0.5;
            elseif data(65,b+1)>fjdl_up%%&&flag_delta_I==1&&(blj_cd1_calc>(zhuansu_MIN+2))
%                  ff_flag = 270;
               if blj_cd1_calc >zhuansu_MIN+1
                 if flag_delta_I==1
                     blj_cd1_calc = zhuansu_MIN+0.5;
                 elseif flag_delta_I==2
                     blj_cd1_calc = zhuansu_MIN+1;
                 else
                     blj_cd1_calc = zhuansu_MIN+0.7;
                 end
               end
            %代表固定板料较多，推速向上调
            elseif data(65,b+1)<avgpress %&&flag_delta_I==2
                 if blj_cd1_calc<zhuansu_MAX
                     blj_cd1_calc = data(68,b)+0.5;
                 else
                     blj_cd1_calc = zhuansu_MAX;
                 end
            elseif data(65,b+1)<(avgpress+fjdl_down)/2%&&flag_delta_I==2
                if flag_delta_I==1
                     blj_cd1_calc = avgspeed-0.5;
                elseif flag_delta_I==2
                     blj_cd1_calc = avgspeed+0.5;
                else
                     blj_cd1_calc = avgspeed;
                end
                
            elseif data(65,b+1)<fjdl_down%%&&flag_delta_I==2&&(blj_cd1_calc<(zhuansu_MAX-2))
%                  ff_flag = -270;
                 if flag_delta_I==1
                     blj_cd1_calc = changespeed-1.5;
                 elseif flag_delta_I==2
                     blj_cd1_calc = changespeed+0.5;
                 else
                         blj_cd1_calc = changespeed;
                 end
            %都不满足 保持GPC控制量
            else
                 %ff_flag = 0;
                 blj_cd1_calc = bljblj;
            end
        end
        pidloop(3,1)=blj_cd1_calc;
end
  

% 
% %% 如果平均转速大于设定转速且平均压力小于设定压力 风机电流比较高
% if b>300
%     t_avgspeed=sum(data(6,b-avgt+2,b+1))/avgt;
%     t_avgpress=sum(data(1,b-avgt+2,b+1))/avgt;
%     t_avgi=sum(data(1,b-avgt+2,b+1)/avgt;
%     if t_avgspeed>avgspeed && t_avgpress<avgpress && t_avgi>132
%         blj_cd1_calc=changespeed;
%         pidloop(3,1)= blj_cd1_calc;
%     end
% end
%%

% 无扰切换
if pidloop(10,1)==0
    pidloop(2,1)=pidloop(1,1);
    pidloop(3,1)=data(6,b);
    pidloop(4,1)=0;
    pidloop(5,1)=0;
    pidloop(6,1)=0;
end

data(68,b+1)=blj_cd1_calc;
if data(68,b+1) > zhuansu_MAX
    data(68,b+1)=zhuansu_MAX;
end
if data(68,b+1) < zhuansu_MIN
    data(68,b+1)=zhuansu_MIN;
end

%% 1#泵压力控制
% pidloop(2,2)=blj_pump1_sp;  
% pidloop(1,2)=data(4,b+1);
% if(b>20)    %滤波
%     pidloop(1,2)=sum(data(4,b-18:b+1))/20;
% end
% data(sizecon+10,b+1)=pidloop(1,2);
% 
% pidloop(7,2)=blj_pump_p;%kuc    
% pidloop(8,2)=blj_pump_i;%ke
% pidloop(9,2)=blj_pump_d;%kec
% 
% 
%     
% pidloop(11,2)=toumei_MAX; %修改：根据现场调节上限
% pidloop(12,2)=toumei_MIN;
% pidloop(13,2)=0.01;%0.3
%  
% if sign_blj_pump == 0 && sign_blj == 0
%     blj_cd1_calc = data(6,b+1);
% end

% if sign_blj_pump == 1
%   if mod(b,5)==0
%     if pidloop(10,2)==1
%         pidloop(:,2)=pid_calc(pidloop(:,2)');
%         pidloop(3,2)=round(pidloop(3,2)*100)/100;%修改：根据现场调节给定精度
%         blj_cd1_calc=round(pidloop(3,2)*100)/100; 
%     end
%   end
% end

% 无扰切换
% if pidloop(10,2)==0
%     pidloop(1,2)=pidloop(2,2);
%     pidloop(3,2)=data(6,b);
%     pidloop(4,2)=0;
%     pidloop(5,2)=0;
%     pidloop(6,2)=0;
% end
% if(b>10)    %滤波
%     data(sizecon+10,b+1)=sum(data(4,b-8:b+1))/10;
% end
if b > 70
    if max(data(4,b-8:b+1)) > blj_pump1_sp ...
            && max(data(4,b-18:b-9)) > blj_pump1_sp ...
            && max(data(4,b-28:b-19)) > blj_pump1_sp && (sign_blj_pump == 1) 
        if mod(b,5) == 0
             blj_cd1_calc =  blj_cd1_calc + 0.5;
        end
        bli_pump_flag=1;
    else
         bli_pump_flag=0;
    end
    
    
    
%     if  (sum((data(4,b-3:b+1) > blj_pump1_sp)) == 2) && (sign_blj_pump == 1) 
%         if mod(b,5) == 0
%              blj_cd1_calc =  blj_cd1_calc + 0.5;
%              P_write(6,blj_cd1_calc,zhuansu_MAX,zhuansu_MIN);
%              P_write(7,blj_cd1_calc+1,zhuansu_MAX,zhuansu_MIN);
%              bli_pump_flag=1;
%         end
%     else
%          bli_pump_flag=0;
%     end
end
     
    


%% 四室压力控制
pidloop(2,3)=blj_press4_sp;  
pidloop(1,3)=data(3,b+1);
if(b>20)    %滤波
    pidloop(1,3)=sum(data(3,b-18:b+1))/20;
end
data(sizecon+12,b+1)=pidloop(1,3);

pidloop(7,3)=blj4_p;%kuc    
pidloop(8,3)=blj4_i;%ke
pidloop(9,3)=blj4_d;%kec


    
pidloop(11,3)=ZHUANSU4_MAX; %修改：根据现场调节上限
pidloop(12,3)=ZHUANSU4_MIN;
pidloop(13,3)=0.01;%0.3
 

% 窑头喂煤-头煤压力PID计算
if sign_blj4 == 0
    blj_cd3_calc = data(8,b+1); 
end



if sign_blj4 == 1
    if mod(b,3)==0
        if pidloop(10,3)==1
            pidloop(:,3)=pid_calc(pidloop(:,3)');
            pidloop(3,3)=round(pidloop(3,3)*100)/100;%修改：根据现场调节给定精度
            blj_cd3_calc=round(pidloop(3,3)*100)/100; 

        end
    end
end

% 无扰切换
if pidloop(10,3)==0
    pidloop(1,3)=pidloop(2,3);
    pidloop(3,3)=data(8,b);
    pidloop(4,3)=0;
    pidloop(5,3)=0;
    pidloop(6,3)=0;
end



%% 头煤压力控制
pidloop(1,4)=toumei_sp;  
pidloop(2,4)=data(35,b+1);
if(b>35)    %滤波
    pidloop(2,4)=sum(data(35,b-18:b+1))/20;
end
set(handles.toumei_pv,'String',num2str(pidloop(2,4),'%4.1f'));
data(sizecon+8,b+1)=pidloop(2,4);

pidloop(7,4)=toumei_p;%kuc    
pidloop(8,4)=toumei_i;%ke
pidloop(9,4)=toumei_d;%kec


    
pidloop(11,4)=toumei_MAX; %修改：根据现场调节上限
pidloop(12,4)=toumei_MIN;
pidloop(13,4)=0.01;%0.3
 
% 窑头喂煤-头煤压力PID计算
if sign_toumei == 0
    yaotou_sp = data(28,b+1);
end

if mod(b,10)==0
    if pidloop(10,4)==1
       pidloop(:,4)=pid_calc(pidloop(:,4)');
       pidloop(3,4)=round(pidloop(3,4)*100)/100;%修改：根据现场调节给定精度
       yaotou_sp=round(pidloop(3,4)*100)/100; 

    end
end

% 无扰切换
if pidloop(10,4)==0
    pidloop(1,4)=pidloop(2,4);
    pidloop(3,4)=data(28,b);
    pidloop(4,4)=0;
    pidloop(5,4)=0;
    pidloop(6,4)=0;
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

% 无扰切换
if pidloop(10,7)==0
    pidloop(2,7)=pidloop(1,7);
    pidloop(3,7)=data(38,b);    %data
    pidloop(4,7)=0;
    pidloop(5,7)=0;
    pidloop(6,7)=0;
end

%% 下料

pidloop(1,9)=douti_sp;  
pidloop(2,9)=data(17,b+1);  
if(b>30)    %滤波
    pidloop(2,9)=sum(data(17,b-8:b+1))/10;
end
data(83,b+1)=pidloop(2,9);

pidloop(7,9)=pdouti_p;%kuc    
pidloop(8,9)=pdouti_i;%ke
pidloop(9,9)=pdouti_d;%kec

pidloop(11,9)=xialiao_max; %修改：根据现场调节上限
pidloop(12,9)=xialiao_min;
pidloop(13,9)=0.05;%0.3

if douti_on == 0
   xialiaoliang = data(19,b+1);  %data
end

if mod(b,3)==0
    if pidloop(10,9)==1
        pidloop(:,9)=pid_calc(pidloop(:,9)');
        pidloop(3,9)=round(pidloop(3,9)*100)/100;%修改：根据现场调节给定精度
        xialiaoliang=round(pidloop(3,9)*100)/100; 

    end
end

% 无扰切换
if pidloop(10,9)==0
    pidloop(1,9)=pidloop(2,9);
    pidloop(3,9)=data(19,b);    %data
    pidloop(4,9)=0;
    pidloop(5,9)=0;
    pidloop(6,9)=0;
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

if mod(b,10)==0
    if pidloop(10,10)==1
        pidloop(:,10)=pid_calc(pidloop(:,10)');
        pidloop(3,10)=round(pidloop(3,10)*100)/100;%修改：根据现场调节给定精度
        weipai_speed=round(pidloop(3,10)*100)/100; 

    end
end

% 无扰切换
if pidloop(10,10)==0
    pidloop(2,10)=pidloop(1,10);
    pidloop(3,10)=data(40,b);    %data
    pidloop(4,10)=0;
    pidloop(5,10)=0;
    pidloop(6,10)=0;
end
%% 循环风机控制1204
% pidloop(2,11)=xhfjfy_sp;   %正负未知    1026
% pidloop(1,11)=data(321,b+1);  %data未知
% if(b>30)    %滤波
%     pidloop(1,11)=sum(data(321,b-18:b+1))/20;
% end
% data(321,b+1)=pidloop(1,11);
% 
% pidloop(7,11)=pxhfjfy_p;%kuc    
% pidloop(8,11)=pxhfjfy_i;%ke
% pidloop(9,11)=pxhfjfy_d;%kec
% 
% pidloop(11,11)=weipai_max; %修改：根据现场调节上限
% pidloop(12,11)=weipai_min;
% pidloop(13,11)=0.05;%0.3
% 
% if pidloop(10,11)==0
%    weipai_speed = data(38,b+1);  %data
% end
% 
% if mod(b,11)==0
%     if pidloop(10,11)==1
%         pidloop(:,11)=pid_calc(pidloop(:,11)');
%         pidloop(3,11)=round(pidloop(3,11)*100)/100;%修改：根据现场调节给定精度
%         weipai_speed=round(pidloop(3,11)*100)/100; 
% 
%     end
% end
% 
% % 无扰切换
% if pidloop(10,11)==0
%     pidloop(2,11)=pidloop(1,11);
%     pidloop(3,11)=data(321,b);    %data
%     pidloop(4,11)=0;
%     pidloop(5,11)=0;
%     pidloop(6,11)=0;
% end
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

% 无扰切换
if pidloop(10,5)==0
    pidloop(1,5)=pidloop(2,5);
    pidloop(3,5)=data(25,b);
    pidloop(4,5)=0;
    pidloop(5,5)=0;
    pidloop(6,5)=0;
end




%% 分解炉GPC主程序

% % workpoint = [11.3,837.98];
A = [ -0.9452,1];
B = 3.103;%3.92
workpoint = [11.3,837.98];
% A = [ -0.9888,1];
% B = 0.6347;%3.92

if b > 4
    
%    if(b>150)
%         %提升机电流周期是106s
%         delta_tsj_1 = data(66,b)-data(66,b-106);
%         delta_tsj_2 = data(66,b-1)-data(66,b-107);
%         delta_tsj_3 = data(66,b-2)-data(66,b-108);
% 
% 
%         %前馈，如果当前提升机电流比90s前高1.2，则每秒增加0.003，防止温度下降太快
%     else
%         delta_tsj_1 = data(66,b+1)-data(66,b);
%         delta_tsj_2 = data(66,b)-data(66,b-1);
%         delta_tsj_3 = data(66,b-1)-data(66,b-2);
%     end
% 
%     delta_tsj = (delta_tsj_1+delta_tsj_2+delta_tsj_3)/3;
% 
%     if(mod(b,5)==0)
% %         u_final = fjl_weimei_sp + 0.018*delta_tsj;
%         
% 
%     end
    
    Up1(1) = data(12,b-3) - workpoint(1);
    Up1(2) = data(12,b+1) - workpoint(1);
    if b > 13
        data(sizecon+4,b+1) = sum(data(10,b-9:b+1))/11;
    end
    P=[0.01,0.01;0.01,0.01];
    gpc_a=fjl_alpha1;
    gpc_lmd=fjl_lambda1; 
    if abs(fjl_temp_sp- data(sizecon+4,b+1))>8   %大偏差参数
        gpc_a=fjl_alpha2;
        gpc_lmd=fjl_lambda2; 
    end
    gpc_fjl_temp_sp = fjl_temp_sp - workpoint(2);
    yout = data(sizecon+4,b-1:b+1)-workpoint(2); 
    
    if sign_fjl == 1 &&  fjl_pmg_gaspress_flag == 0  && CO_flag == 0 && toumei_press_flag == 0
        if b>10
            if mod(b,5)==0
                fjl_weimei_sp = workpoint(1)+gpc_clac(A,B,P,yout,Up1,gpc_fjl_temp_sp,gpc_a,gpc_lmd);
                u_final = fjl_weimei_sp;
            end
        end
    end
end


    
% if b>=20 && (abs(data(sizecon+4,b)-data(sizecon+4,b+1))<0.1);
%     %如果分解炉温度和前一秒几乎相等，则令gpc标志位为true，窑尾喂煤暂时不动
%     gpc_flag = true;
%     fjl_weimei_sp = data(13,b);
% else
%     %如果分解炉温度开始变化，则标志位置false
%     gpc_flag = false;
% end
% if gpc_flag == true;
%     %标志位为true时，gpc_timer每秒加一
%     gpc_timer = gpc_timer+1;
%     %当gpc_timer到10，也就是5分钟仍未变化，则令窑尾喂煤加0.02，timer重新计时
%     if gpc_timer == 300
%         if data(sizecon+4,b+1) < fjl_temp2_sp
%             fjl_weimei_sp = data(13,b)+0.02;
%         elseif data(sizecon+4,b+1) > fjl_temp2_sp
%             fjl_weimei_sp = data(13,b)-0.02;
%         end
%         gpc_timer = 0;
%     end
% else
%     gpc_timer = 0;
% end

if(sign_fjl==0)
    fjl_weimei_sp = data(12,b+1);
    u_final = fjl_weimei_sp;

end

     



% %% 分解炉模糊控制
% if (b > 20)
%     fjl_diff = data(38,b+1) - data(38,b);
% end
% if (b > 20 && sign_fjl == 2)
%     if (mod(b,20)==1)
%         fjl_fuzzy = FuzzyCompute1(fjl_temp_sp, data(38,b+1), fjl_diff, data(13, b+1),0);
%     end
% end
% if(sign_fjl==0 || sign_fjl==1)
%     fjl_fuzzy = data(13,b+1);
% 
% end
%% 五级下料管GPC主程序
% workpoint2 = [7.8281,853.8823];
% 
% A2 = [-0.9873, 1];%10s
% B2 = 0.5;%1.162
% 
% if b > 4
%     Up2(1) = data(13,b-4) - workpoint2(1);
%     Up2(2) = data(13,b) - workpoint2(1);
%     data(sizecon+10,b+1) = data(12,b);
%     if b > 13
%         data(sizecon+10,b+1) = sum(data(12,b-9:b+1))/11;
%     end
%     if b>=20 && (abs(data(sizecon+10,b)-data(sizecon+10,b+1))>5);
%         data(sizecon+10,b+1) = data(sizecon+10,b);
%     end
%     
%     P=[0.01,0.01;0.01,0.01];
%     gpc_a=fjl_alpha1;
%     gpc_lmd=fjl_lambda1; 
%     if abs(fjl_temp_sp- data(sizecon+10,b+1))>2.5
%         gpc_a=fjl_alpha2;
%         gpc_lmd=fjl_lambda2;
%     end
%     gpc_fjl_temp_sp = fjl_temp_sp - workpoint2(2);
%     yout2 = data(sizecon+10,b-1:b+1)-workpoint2(2); 
%     if sign_fjl == 1
%         if b>10
%             if mod(b,8)==0
%                 fjl_weimei_sp = workpoint2(1)+gpc_clac(A2,B2,P,yout2,Up2,gpc_fjl_temp_sp,gpc_a,gpc_lmd);
% %                 if b>=20 && (abs(data(sizecon+10,b)-data(sizecon+10,b+1))<0.04);
% %                     fjl_weimei_sp = data(13,b);
% %                 end
%             end
%         end
%     end
% end
% 
% 
% 
% if(sign_fjl==0)
%     fjl_weimei_sp = data(13,b+1);
%     data(42,b+1) = data(13,b+1);
% 
% end
% 
% set(handles.fjl_weimei_sp,'String',data(13,b+1));



%% 清屏
if mod(b,100)==0                   %每100s清屏
    clc;
end
    

% %% 分解炉喂煤半自动控制
% if (count_fjl_man == 0)
%     weimei_man_plus_on = 0;
%     weimei_man_minus_on = 0;
%     pre_fjl_weimei_sp = fjl_weimei_sp;
% end
% 
% if (sign_fjl == 1)
%     if (count_fjl_man == 30)
%         pre_fjl_weimei_sp = fjl_weimei_sp;
%     end
%     if (count_fjl_man > 0 && weimei_man_plus_on > 0)
%         u_final = pre_fjl_weimei_sp + 0.05 * weimei_man_plus_on;
%         count_fjl_man = count_fjl_man - 1;
%     end
%     
%     if (count_fjl_man > 0 && weimei_man_minus_on > 0)
%         u_final = pre_fjl_weimei_sp - 0.05 * weimei_man_minus_on;
%         count_fjl_man = count_fjl_man - 1;
%     end
%     
% else 
%     count_fjl_man = 0;
%     weimei_man_plus_on = 0;
%     weimei_man_minus_on = 0;
%     pre_fjl_weimei_sp = fjl_weimei_sp;
% end
% 
% 
%% 11-04 手动干预 篦冷机 采用直接修改upid(1)并赋值给pidloop(3,1)的方法
if man_in_blj == true
    man_in_blj = false;
    blj_cd1_calc = man_blj_speed;
    pidloop(3,1) = man_blj_speed;
end


%% 11-04 手动干预 分解炉 修改设定值后关闭自动停滞3秒 重开
if man_in_fjl == true&&sign_fjl == 1
    man_in_fjl = false;
    man_fjl_time_cnt = 1;
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

%% 写控制量 
if sign_blj == 1
    if abs(blj_cd1_calc-data(6,b))>=0.01
        P_write(6,blj_cd1_calc,zhuansu_MAX,zhuansu_MIN);
        P_write(7,blj_cd1_calc+1,zhuansu_MAX,zhuansu_MIN);
    end
end



if sign_blj4 == 1
    if abs(blj_cd3_calc-data(8,b))>=0.01
        P_write(8,blj_cd3_calc,ZHUANSU4_MAX,ZHUANSU4_MIN);
        P_write(9,blj_cd3_calc+1.5,ZHUANSU4_MAX,ZHUANSU4_MIN);
    end
end

if (sign_fjl == 1)
    if abs(u_final-data(13,b+1))>=0.001
        if (u_final-data(12,b+1) > fjlumax)  &&  (fjl_pmg_gaspress_flag == 0)  && (CO_flag == 0)  && (toumei_press_flag == 0)          %振幅控制量
            u_final = data(12,b+1)+fjlumax;
        end
        if (u_final-data(12,b+1) < -fjlumax) && (fjl_pmg_gaspress_flag == 0)  &&  (CO_flag == 0)  && (toumei_press_flag == 0)
            u_final = data(12,b+1)-fjlumax;
        end
        
        %         if (u_final-data(12,b+1) > 0.1)  &&  (fjl_pmg_gaspress_flag == 0)  && (CO_flag == 0)  && (toumei_press_flag == 0)          %振幅控制量
        %             u_final = data(12,b+1)+0.1;
        %         end
        %         if (u_final-data(12,b+1) < -0.05) && (fjl_pmg_gaspress_flag == 0)  &&  (CO_flag == 0)  && (toumei_press_flag == 0)
        %             u_final = data(12,b+1)-0.05;
        %         end
        if b>30
            if b > 110
                third_1 = data(81,b-58) - data(81,b-59);
                third_2 = data(81,b-59) - data(81,b-60);
                third_3 = data(81,b-60) - data(81,b-61);
                delta_tsj_1 = data(80,b-100) - data(80,b-101);
                delta_tsj_2 = data(80,b-101) - data(80,b-102);
                delta_tsj_3 = data(80,b-102) - data(80,b-103);
            else
                third_1 = data(14,b+1) - data(14,b);
                third_2 = data(14,b) - data(14,b-1);
                third_3 = data(14,b-1) - data(14,b-2);
                delta_tsj_1 = data(17,b + 1) - data(17,b);
                delta_tsj_2 = data(17,b) - data(17,b-1);
                delta_tsj_3 = data(17,b-1) - data(17,b-2);
            end
            third = third_1 + third_2 + third_3;
            d_tsj = delta_tsj_1 + delta_tsj_2 + delta_tsj_3;
            if mod(b,5)==0
                u_final = u_final- third * 0.001 +d_tsj * 0.008;
            end
        end
        if b > 5
            if ( sum((data(15,b-1:b+1) > fjl_pmg_gaspress_sp)) >= 2) && (sign_fjl_pmg_gaspress == 1)
                if mod(b,15)==0
                    u_final = u_final-0.25;
                    P_write(12,u_final,fjl_MAX,fjl_MIN);
                    fjl_pmg_gaspress_flag=1;          %尾煤冲煤的对冲补偿
                end
            else
                fjl_pmg_gaspress_flag=0;
            end
        end
        
        
        %          if b > 5
        %             if ( sum((data(36,b-1:b+1) > CO_sp)) >= 2) && sign_CO == 1
        %                 if mod(b,15)==0
        %                     u_final = u_final-0.38;
        %                     P_write(12,u_final,fjl_MAX,fjl_MIN);
        %                     CO_flag=1;          %CO浓度过高的对冲补偿
        %                 end
        %             else
        %                  CO_flag=0;
        %             end
        %          end
        %
        
        
        %         if b > 20
        %             if ( sum((data(sizecon+8,b-9:b+1) > (toumei_sp+1))) >= 10)
        %                 if mod(b,20)==0
        %                     u_final = u_final-0.0294*(data(sizecon+8,b+1)-toumei_sp);
        %                     P_write(12,u_final,fjl_MAX,fjl_MIN);
        %                     toumei_press_flag = 1;                                  %头煤冲煤的对冲补偿
        %                 end
        %             else
        %                 toumei_press_flag = 0;
        %             end
        %         end
        %
        
        
        
        
        if (b > 300) && (fjl_pmg_gaspress_flag == 0)  &&  (CO_flag == 0) && (toumei_press_flag == 0) &&(data(10,b-5)<fjl_temp_sp+25)
            u(1) = data(10,b-5)-data(10,b-3);         %温度快速下降的补偿
            u(2) = data(10,b-3)-data(10,b-1);
            u(3) = data(10,b-1)-data(10,b+1);
            if (u(1)>0) && (u(2)>0) && (u(3)>0) && (mod(b,15)==0)
                u_final = data(12,b)+0.05;
            end
        end
        
        % CO问题                        不太懂
        if b > 5 && data(10,b+1)>855 && sign_CO == 1
            if u_final >= data(67,b)
                if sum(data(36,b-3:b+1))/5 > 4000
%                     if mod(b,3) == 0
                        u_final = data(67,b) - 0.018;
%                     end
                elseif sum(data(36,b-3:b+1))/5 > 3000
%                     if mod(b,3) == 0
                        u_final = data(67,b) - 0.012;
%                     end
                elseif sum(data(36,b-3:b+1))/5 > 2500
                    if mod(b,3)==0
                        u_final = data(67,b) - 0.006;
                    end
                end
            end
        end
        
        P_write(12,u_final,fjl_MAX,fjl_MIN);
    end
end
data(67,b+1)=u_final;

%% 生料仓重空仓，满仓
if b>30
    if(sum(data(20,b-8:b+1))/10<20)
        SLvalveR_sp=data(25,b)+0.3;
        pidloop(3,5)=SLvalveR_sp;
    end
    if(sum(data(20,b-8:b+1))/10>35)
        SLvalveR_sp=data(25,b)-0.4;
        pidloop(3,5)=SLvalveR_sp;
    end
end
%% 
if sign_douti == 1
    if abs(SLvalveR_sp-data(25,b))>=0.01
        P_write(25,SLvalveR_sp,SLvalveR_sp_MAX,SLvalveR_sp_MIN);
%         P_write(24,SLvalveR_sp,SLvalveR_sp_MAX,SLvalveR_sp_MIN);
    end
end
if sign_toumei == 1
    if abs(yaotou_sp-data(28,b))>=0.01
        P_write(28,yaotou_sp,toumei_MAX,toumei_MIN);
    end
end

if yaotou_on == 1                %1026
    if abs(toupai_speed-data(38,b))>=0.01
        P_write(38,toupai_speed,toupai_max,toupai_min);  %data
    end
end

if douti_on == 1                %1026
    if abs(xialiaoliang-data(19,b))>=0.01
        P_write(19,xialiaoliang,xialiao_max,xialiao_min);  %data
    end
end
%1204
if gwfjfy_on == 1 ||    gwfjfy_on == 2          
    if abs(weipai_speed-data(40,b))>=0.01
        P_write(40,weipai_speed,weipai_max,weipai_min);  %data
    end
end
%% 报警设置

try
    set(pophandles.blj_now,'String',num2str(data(1,b+1),'%4.0f'));
    set(pophandles.xialiao_left_now,'String',num2str(data(39,b+1),'%4.1f'));
    set(pophandles.xialiao_right_now,'String',num2str(data(12,b+1),'%4.1f'));
catch
end

try
if ~(blj_press_pv_round >= blj_upper_limit || blj_press_pv_round <= blj_lower_limit || ...
        data(39,b+1) >= xialiao_left_upper_limit || data(39,b+1) <= xialiao_left_lower_limit ||...
        data(12,b+1) >= xialiao_right_upper_limit || data(12,b+1) <= xialiao_right_lower_limit)
    set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);%将报警设置按钮背景为灰色
    alarm_sound_flag = 0;
end

if (blj_press_pv_round >= blj_upper_limit || blj_press_pv_round <= blj_lower_limit || ...
        data(39,b+1) >= xialiao_left_upper_limit || data(39,b+1) <= xialiao_left_lower_limit ||...
        data(12,b+1) >= xialiao_right_upper_limit || data(12,b+1) <= xialiao_right_lower_limit)
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
catch
%     disp('没有打开报警设置窗口');
end
% 篦冷机报警
if (blj_press_pv_round >= blj_upper_limit)
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

if (blj_press_pv_round <= blj_lower_limit)
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
if (data(39,b+1) >= xialiao_left_upper_limit)
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

if (data(39,b+1) <= xialiao_left_lower_limit)
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

% 分解炉报警
if (data(12,b+1) >= xialiao_right_upper_limit)
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

if (data(12,b+1) <= xialiao_right_lower_limit)
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
        load chirp
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


