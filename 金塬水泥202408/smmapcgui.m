function varargout = apcgui(varargin)
% APCGUI MATLAB code for apcgui.fig
%      APCGUI, by itself, creates a new APCGUI or raises the existing
%      singleton*.
%
%      H = APCGUI returns the handle to a new APCGUI or the handle to
%      the existing singleton*.
%
%      APCGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APCGUI.M with the given input arguments.
%
%      APCGUI('Property','Value',...) creates a new APCGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before apcgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to apcgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help apcgui

% Last Modified by GUIDE v2.5 04-Nov-2021 22:37:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @apcgui_OpeningFcn, ...
                   'gui_OutputFcn',  @apcgui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);

if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before apcgui is made visible.
function apcgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to apcgui (see VARARGIN)
global connect_con first_time_connect_flag A B P gpc_a gpc_lmd yr workpoint  blj_set 
global daobj group  deadzone lastsave  count_pressue  coaljunhua_sign shengliao_zhuanzi_on shengliao_douti_pidai_on_left
global alarmon alarmrow flag_connect_state fjl_set first_time_connect_flag_ontimer 
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on 
global second_plate_pressure_max_pv third_plate_pressure_max_pv upid coalklin_on paramdata cooler_time
global B2 A2 workpoint2 gpc_a2 gpc_lmd2  shengliao_douti_on xintiao_on  fazuFlag weimei_flag blj_big
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global decomposing_furnace_tempr_2_upperMax decomposing_furnace_tempr_2_upperMin decomposing_furnace_tempr_2_lowerMax decomposing_furnace_tempr_2_lowerMin
global sign_bichuang snd_chamber_pressure_upperMax snd_chamber_pressure_upperMin snd_chamber_pressure_lowerMax snd_chamber_pressure_lowerMin alarm_sound_flag alarm_timer alarm_button_clicked
global gpc_shengliao_douti_sp shengliao_douti_liuliang_on wmc_press_on fazu1_max fazu1_min fazu2_max fazu2_min toupai_on
global blj_asc_flag1 blj_asc_flag2 blj_desc_flag1 blj_desc_flag2 blj_asc blj_desc steady_time1 steady_time2 blj_man_flag1 blj_man_flag2
global zhuansu_MAX zhuansu_MIN douti_MAX douti_MIN shengliao_douti_pidai_on_right O2_hanliang
global mill_current_MAX mill_current_MIN zxyStep O2_Cur CO_yuzhi douti_QK blj_pressure_opt_MAX blj_pressure_opt_TAR
global silence_time silence_flag silence_time_setting time_interval interval_counter current_change_flag u_fjl_max
global  blj_max_pressure blj_speed_stop_flag yachuang_mv
global man_blj_speed man_fjl_coal man_in_blj man_blj_time_cnt blj_man_in_flag man_in_fjl man_fjl_time_cnt
global blj_level_one level_one_sp blj_level_two level_two_sp blj_level_three level_three_sp recover_sp recover_flag
global blj_low_time_cnt blj_low_pressure blj_high_speed
global blj_low_pressure_sp blj_high_speed_sp duiliao_speed
%% 配置
paramdata = xml_read('param_set.xml');
mill_current_MAX = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.mill_current_MAX;
mill_current_MIN = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.mill_current_MIN;
zxyStep = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.zxyStep;
u_fjl_max = paramdata.commdata(1).parameter(14).ATTRIBUTE.u_fjl_max;
silence_time_setting = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.silence_time;
time_interval =  paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.time_interval;
blj_pressure_opt_MAX = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.blj_pressure_opt_MAX;
blj_pressure_opt_TAR = paramdata.selfOptimiz(1).parameter(1).ATTRIBUTE.blj_pressure_opt_TAR;
douti_QK = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_QK;
decomposing_furnace_tempr_2_upperMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMax;
decomposing_furnace_tempr_2_upperMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMin;
decomposing_furnace_tempr_2_lowerMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMax;
decomposing_furnace_tempr_2_lowerMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMin;
snd_chamber_pressure_upperMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMax;
snd_chamber_pressure_upperMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMin;
snd_chamber_pressure_lowerMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMax;
snd_chamber_pressure_lowerMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMin;
blj_level_one = paramdata.commdata(1).parameter(15).ATTRIBUTE.blj_level_one;
level_one_sp = paramdata.commdata(1).parameter(16).ATTRIBUTE.level_one_sp ;
blj_level_two = paramdata.commdata(1).parameter(17).ATTRIBUTE.blj_level_two;
level_two_sp = paramdata.commdata(1).parameter(18).ATTRIBUTE.level_two_sp ;
blj_level_three = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj_level_three;
level_three_sp = paramdata.commdata(1).parameter(20).ATTRIBUTE.level_three_sp ;
recover_sp = paramdata.commdata(1).parameter(21).ATTRIBUTE.recover_sp ;
zhuansu_MAX=paramdata.commdata(1).parameter(22).ATTRIBUTE.zhuansu_MAX;
zhuansu_MIN=paramdata.commdata(1).parameter(23).ATTRIBUTE.zhuansu_MIN;
blj_low_pressure_sp = paramdata.commdata(1).parameter(24).ATTRIBUTE.blj_low_pressure_sp;
blj_high_speed_sp = paramdata.commdata(1).parameter(25).ATTRIBUTE.blj_high_speed_sp;
duiliao_speed = paramdata.commdata(1).parameter(26).ATTRIBUTE.duiliao_speed;

decomposing_furnace_tempr_2_upperlimitS=(decomposing_furnace_tempr_2_upperMax+decomposing_furnace_tempr_2_upperMin)/2;
decomposing_furnace_tempr_2_lowerlimitS=(decomposing_furnace_tempr_2_lowerMax+decomposing_furnace_tempr_2_lowerMin)/2;
snd_chamber_pressure_upperlimitS=9600;
snd_chamber_pressure_lowerlimitS=7400;

fazu1_max = 14.5;
fazu1_min = 0;
fazu2_max = 16;
fazu2_min = 0;
steady_time1 = 30;
steady_time2 = 30;
cooler_time = 0;
blj_man_flag1 = 0;
blj_man_flag2 = 0;
blj_speed_stop_flag = false;
man_in_blj = false;
man_in_fjl = false;
man_blj_time_cnt = 0;
man_fjl_time_cnt = 0;
%% 初值设定
O2_hanliang = [];
O2_Cur = 0;
blj_asc = 0;
blj_desc = 0;
blj_asc_flag1 = 0;
blj_asc_flag2 = 0;
blj_desc_flag1 = 0;
blj_desc_flag2 = 0;
blj_big = 0;
weimei_flag = 0;
fazuFlag = 0;
upid=[12 18 24 3 3 3 3 3];
second_plate_pressure_max_pv=70; 
third_plate_pressure_max_pv=70;
alarm_sound_flag = 0;
alarm_timer = 120;
alarm_button_clicked = 0;
workpoint2=[2.69001,8.98215678];
A2=[-0.6612,1];
B2=-0.03589;
gpc_a2=0.99;
gpc_lmd2=80;
workpoint=[6.93773,867.7332575];
A=[-0.9959,1];
B=0.129;
P=[0.01,0.01;0.01,0.01];
gpc_a=0.99;
gpc_lmd=80;
yr=860;
alarmon=1;
alarmrow=[0 0 0];
flag_connect_state=0;
blj_set=[148,175,90,13,8500,95,10.0];
fjl_set=[871,20];
first_time_connect_flag_ontimer=8;
connect_con=0;%连接状态
first_time_connect_flag=1;%首次连接
count_pressue=0;
shengliao_douti_on=0;
first_cooler_rev_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
decomposing_furnace_tempr_on=0; 
shengliao_douti_pidai_on_left=0;
shengliao_douti_pidai_on_right=0;
coalklin_on=0;
toupai_on = 0;
douti_MAX=240;
douti_MIN=180;
CO_yuzhi=1800;
silence_time = 0;
silence_flag = 0;
interval_counter = 0;
current_change_flag = 0;
recover_flag = 0;
blj_low_time_cnt = 1;
blj_low_pressure = 0;
blj_high_speed = 0;

daobj=opcda(paramdata.commdata(1).parameter(1).ATTRIBUTE.opcID,paramdata.commdata(1).parameter(1).ATTRIBUTE.opcServerName);
% daobj=opcda('192.168.0.1','FL.OPCServer.1');%%%Need_to_be_modified
group = addgroup(daobj);  

deadzone=[1,1,1];
lastsave='none';

%% 设定值初始化 gui_g11_current_sp_slider gui_g11_current_sp_display


% 头煤压力
blj_control4=blj_set(4);
set(handles.gui_klin_head_tempr_sp_display,'String',blj_control4);
set(handles.gui_klin_head_tempr_sp_slider,'Value',blj_control4);
set(handles.gui_klin_head_tempr_sp_slider,'Max',blj_control4+4,'Min',blj_control4-4);
set(handles.gui_klin_head_tempr_sp_slider,'SliderStep',[0.1/8,0.5/8]);
% 篦床压力
blj_control5=blj_set(5);
set(handles.gui_2nd_chamber_pressure_sp_display,'String',1050);
set(handles.gui_2nd_chamber_pressure_sp_slider,'Value',1050);
set(handles.gui_2nd_chamber_pressure_sp_slider,'Max',1200,'Min',1000);
set(handles.gui_2nd_chamber_pressure_sp_slider,'SliderStep',[1/200,10/200]);
% 下料斗提
xialiao_sp=132;
set(handles.shengliao_douti_sp,'String',xialiao_sp);
set(handles.shengliao_douti_sp_slider,'Value',xialiao_sp);
set(handles.shengliao_douti_sp_slider,'Max',xialiao_sp+30,'Min',xialiao_sp-30);
set(handles.shengliao_douti_sp_slider,'SliderStep',[0.1/60,0.5/60]);
% 窑尾给煤上限
set(handles.yaowei_coalMAX,'String',11);
set(handles.yaowei_coalMAX_slider,'Value',11);
set(handles.yaowei_coalMAX_slider,'Max',13,'Min',9);
set(handles.yaowei_coalMAX_slider,'SliderStep',[0.1/4,0.5/4]);

set(handles.yaowei_coalMIN,'String',6.5);
set(handles.yaowei_coalMIN_slider,'Value',6.5);
set(handles.yaowei_coalMIN_slider,'Max',10,'Min',1);
set(handles.yaowei_coalMIN_slider,'SliderStep',[0.1/9,0.5/9]);
% 分解炉出口温度
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',885);
set(handles.fjl_temp_sp_slider,'Value',885);
set(handles.fjl_temp_sp_slider,'Max',910,'Min',860);
set(handles.fjl_temp_sp_slider,'SliderStep',[1/50,2/50]);
% 窑头温度
% set(handles.yaotou_temp_sp,'String',1020);
% set(handles.yaotou_temp_slider,'Value',1020);
% set(handles.yaotou_temp_slider,'Max',1300,'Min',1000);
% set(handles.yaotou_temp_slider,'SliderStep',[1/300,10/300]);
%窑头负压
set(handles.yaotou_press_sp,'String',-37);
set(handles.yaotou_press_sp_slider,'Value',-37);
set(handles.yaotou_press_sp_slider,'Max',0,'Min',-100);
set(handles.yaotou_press_sp_slider,'SliderStep',[0.5/100,1/100]);
% Choose default command line output for apcgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% newIcon = javax.swing.ImageIcon('EnvieoICON.png');
% figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
% figFrame.setFigureIcon(newIcon); %修改图标
% u = uimenu('label','关于...','position',1);
% uimenu(u,'label','版权信息','callback','about');

% UIWAIT makes apcgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = apcgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connectopc.
function connectopc_Callback(hObject, eventdata, handles)
% hObject    handle to connectopc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_time_connect_flag connect_con daobj group tempdata data  itemset tempmv  auth pidloop loopnum b timer1 timer2 timer3
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on coalklin_on
global shengliao_douti_pidai_on_left gpc_shengliao_douti_sp shengliao_douti_liuliang_on wmc_press_on  xintiao_on toupai_on

global shengliao_douti_pidai_on_right
set(handles.connectopc,'Enable','off')
auth=0;%当其为0时即无法工作
load('key');
usedtime=decodekey(key.usedtime);%这里的key文件主要是起加密作用，主要是给别人使用有时间限制的
validtime=decodekey(key.validtime);
license=decodekey(key.license);




usedtime=usedtime+1;
key.usedtime=encodekey(usedtime);
save('key.mat','key')
if ((validtime-usedtime)>=0)&&(license==20171018)%Need_to_be_modified
    auth=1;
end

if auth==1
    if strcmp(daobj.Status,'disconnected')%这里即是判断是否处于连接状态，如果没有处于连接状态的做法
        if first_time_connect_flag==1%当没有处于连接状态时，一定要让这个变量处于0，才能连接。
            first_time_connect_flag=0;
            tempmv=[];
            b=0;
            %% connect to opcserver,init data 进行连接
            connect_con=0;
            first_cooler_rev_on=0;
            second_cooler_rev_on=0;
            third_cooler_rev_on=0;
            decomposing_furnace_tempr_on =0;
            coalklin_on=0; 
            shengliao_douti_pidai_on_left = 0;
            shengliao_douti_pidai_on_right = 0;
            shengliao_douti_liuliang_on = 0;
            wmc_press_on = 0;
            xintiao_on = 0;
            toupai_on = 0;
            timer1=0;
            timer2=0;
            timer3=0;
            set(handles.disconnectopc,'BackgroundColor',[1 0 0]);
            set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
            %set(handles.yaotou_temp_open,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            
            set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
%             set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            
            
            % set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);

            set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.toupai_open,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.toupai_close,'BackgroundColor',[0.941 0.941 0.941]);
            
  

           connect(daobj);
            itemset=additem(group, {'KO2!S327S04_327FA14YP10_AP',...
'KO2!S327S05_327DR04SC10_AP',...
'KO2!T327S05_327DR04SC10_AP',...
'KO2!S327S05_327DR04YS10_AP',...
'KO2!S327S04_327FA11YP10_AP',...
'KO2!S327S05_327DR04YP10_AP',...
'KO2!S327S05_327DR04YP20_AP',...
'KO2!S327S05_327CC02YP11_AP',...%KO2!S327S04_327FA27YP10_AP
'KO2!S327S04_327FA27YI10_AP',...
'KI2!S323S04_323CYA5YT20_AP',...
'KI2!S323S04_323CA04YT10_AP',...
'FP2!T624S09_624WF04FC10_AP',...
'FP2!S624S09_624WF04FC10_AP',...
'FP2!S624S09_624WF04YF10_AP',...
'KO2!S326S08_326DT27YT10_AP',...
'FP2!S624S09_624VV31YP10_AP',...
'KI2!S322S02_322WF46EC10_ST1',...%空变量，补位备用 FP2!S624S07_624PS08YT10_AP
'KI2!S322S02_322BE55YI10_AP',...
'KI2!T322S02_322WF00_YF',...
'KI2!T322S02_322WF00_FC',...
'KI2!S322S02_322WF00_FC',...
'FP2!S624S08_624VV33YP10_AP',...
'KO2!S326S08_326BD30YT10_AP',...
'KO2!S326S08_326BD31YT10_AP',...
'FP2!T624S08_624WF19FC10_AP',...
'FP2!S624S08_624WF19FC10_AP',...
'FP2!S624S08_624WF19YF10_AP',...
'KO2!S326S08_326BD30YP10_AP',...
'KO2!S326S08_326BD31YP10_AP',...
'KI2!T322S02_322WF46FC10_AP',...%KO2!S326S08_326DR05YI10_AP
'KI2!S322S02_322WF46FC10_AP',...%KO2!S326S08_326DR05YS10_AP
'KI2!S322S02_322WF46YF10_AP',...%KI2!T323S04_323FA20SC10_AP
'KI2!S322S02_322WF47FC10_AP',...%KI2!S323S04_323FA20SC10_AP
'KI2!S322S02_322WF47YF10_AP',...%KI2!S323S04_323FA20YS10_AP
'KI2!S322S02_322WF47EC10_ST1',...%KI2!S323S04_323FA20YP20_AP
'KI2!T322S02_322WF47FC10_AP',...%KI2!S321S09_326BD31AG40_AP
'KI2!T323S04_COMMU_XT',...
'KI2!T323S04_COMMU_OK',...
'KO2!S327S05_327DR04EC10_AM',...
'KI2!S323S04_323FA20MT10_AM',...
'FP2!S624S08_624WF19EC10_AM',...
'FP2!S624S09_624WF04EC10_AM',...
'KI2!S322S02_322WF00_AM',...
'KI2!S321S09_323CYA1AG10_AP',...
'KI2!S321S09_323CA04AG10_AP',...
'KI2!S321S09_323CYA1AG30_AP',...
'KI2!S321S09_323CA04AG40_AP',...
'KI2!S321S09_326BD31AG20_AP',...
'KI2!S321S09_326BD31AG30_AP',...
'KI2!S321S09_326BD31AG10_AP',...
'KO2!T328S03_328FA27SC10_AP',...
'KO2!S328S03_328FA27SC10_AP',...
'KO2!S328S03_328FA27YS10_AP',...
'KI2!T324S08_324FA10SC10_AP',...
'KI2!S324S08_324FA10SC10_AP',...
'KI2!S324S08_324FA10YS10_AP',...
'KO2!S328S03_328FA27MT10_AM',...
'KI2!S324S08_324FA10MT10_AM',...
'KI2!T323S04_REQUEST_LUCIE',...
'KI2!S321S09_326BD31AG40_AP',});
            connect(daobj);

            tempdata=read(group);
            data=zeros(length(tempdata)+60,1);%初始化data  Need_to_be_modified
            data(1:6,1)=fix(clock);% fix是化小数为整数，方法是舍去小数部分，clock是6x1的向量，其元素是日期（年月日时分秒），且第一列的元素全为日期，向量可以拓展，即列数可以增加。除第一列外，每列元素均为84+12个PID的值
           %% prepare pidloop and pid parameter
            loopnum=1;%风机电流	头煤压力 篦冷机压力 斗提电流(转子) 斗提电流(皮带) 
            pidloop=[0 0 0 0 0 0 0 0 0 0 0 0 0 ;%sp
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%pv
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%mv
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e0
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e1
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e2
                      0.001 0.001 0.0029 0.0066 0.0061 0.0061 0.9 0.92 0.70 0.82 0.82 0.35 4 ;%kp  Need_to_be_modified
                   
                      88 90 90 75 75 50 75 65 95 55 70 110 30 ;%ti  Need_to_be_modified
                      
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%td  
                      1 1 1 1 1 1 1 1 1 1 1 1 1 ;%man_on
                      100 100 100 100 100 100 100 100 100 100 100 100 65 ;%upperlimit  Need_to_be_modified
                      2  7  6   10   7   16  6  6  5  6  5  5 20 ;%lowerlimit  Need_to_be_modified
                      1 1 1 1 1 1 1 1 1 1 1 1 0 ;%deadzone  Need_to_be_modified
                      ];
        else
            delete(itemset);
            connect(daobj);
            itemset=additem(group, {'KO2!S327S04_327FA14YP10_AP',...
'KO2!S327S05_327DR04SC10_AP',...
'KO2!T327S05_327DR04SC10_AP',...
'KO2!S327S05_327DR04YS10_AP',...
'KO2!S327S04_327FA11YP10_AP',...
'KO2!S327S05_327DR04YP10_AP',...
'KO2!S327S05_327DR04YP20_AP',...
'KO2!S327S05_327CC02YP11_AP',...%KO2!S327S04_327FA27YP10_AP
'KO2!S327S04_327FA27YI10_AP',...
'KI2!S323S04_323CYA5YT20_AP',...
'KI2!S323S04_323CA04YT10_AP',...
'FP2!T624S09_624WF04FC10_AP',...
'FP2!S624S09_624WF04FC10_AP',...
'FP2!S624S09_624WF04YF10_AP',...
'KO2!S326S08_326DT27YT10_AP',...
'FP2!S624S09_624VV31YP10_AP',...
'KI2!S322S02_322WF46EC10_ST1',...%空变量，补位备用 FP2!S624S07_624PS08YT10_AP
'KI2!S322S02_322BE55YI10_AP',...
'KI2!T322S02_322WF00_YF',...
'KI2!T322S02_322WF00_FC',...
'KI2!S322S02_322WF00_FC',...
'FP2!S624S08_624VV33YP10_AP',...
'KO2!S326S08_326BD30YT10_AP',...
'KO2!S326S08_326BD31YT10_AP',...
'FP2!T624S08_624WF19FC10_AP',...
'FP2!S624S08_624WF19FC10_AP',...
'FP2!S624S08_624WF19YF10_AP',...
'KO2!S326S08_326BD30YP10_AP',...
'KO2!S326S08_326BD31YP10_AP',...
'KI2!T322S02_322WF46FC10_AP',...%KO2!S326S08_326DR05YI10_AP
'KI2!S322S02_322WF46FC10_AP',...%KO2!S326S08_326DR05YS10_AP
'KI2!S322S02_322WF46YF10_AP',...%KI2!T323S04_323FA20SC10_AP
'KI2!S322S02_322WF47FC10_AP',...%KI2!S323S04_323FA20SC10_AP
'KI2!S322S02_322WF47YF10_AP',...%KI2!S323S04_323FA20YS10_AP
'KI2!S322S02_322WF47EC10_ST1',...%KI2!S323S04_323FA20YP20_AP
'KI2!T322S02_322WF47FC10_AP',...%KI2!S321S09_326BD31AG40_AP
'KI2!T323S04_COMMU_XT',...
'KI2!T323S04_COMMU_OK',...
'KO2!S327S05_327DR04EC10_AM',...
'KI2!S323S04_323FA20MT10_AM',...
'FP2!S624S08_624WF19EC10_AM',...
'FP2!S624S09_624WF04EC10_AM',...
'KI2!S322S02_322WF00_AM',...
'KI2!S321S09_323CYA1AG10_AP',...
'KI2!S321S09_323CA04AG10_AP',...
'KI2!S321S09_323CYA1AG30_AP',...
'KI2!S321S09_323CA04AG40_AP',...
'KI2!S321S09_326BD31AG20_AP',...
'KI2!S321S09_326BD31AG30_AP',...
'KI2!S321S09_326BD31AG10_AP',...
'KO2!T328S03_328FA27SC10_AP',...
'KO2!S328S03_328FA27SC10_AP',...
'KO2!S328S03_328FA27YS10_AP',...
'KI2!T324S08_324FA10SC10_AP',...
'KI2!S324S08_324FA10SC10_AP',...
'KI2!S324S08_324FA10YS10_AP',...
'KO2!S328S03_328FA27MT10_AM',...
'KI2!S324S08_324FA10MT10_AM',...
'KI2!T323S04_REQUEST_LUCIE',...
'KI2!S321S09_326BD31AG40_AP',});
            connect(daobj);
        end
        t_iohandle = timer('Name','apctimer','TimerFcn', {@on_timer, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器
        start(t_iohandle);%启动定时器
       

        set(handles.connect_state,'String','已连接');
        set(handles.disconnectopc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.connectopc,'BackgroundColor',[0 1 0]);
    else
        msgbox('已经连接','错误')
    end
else
    auth=0;
    close(handles.figure1);%关闭figure
end
set(handles.connectopc,'Enable','on')






% --- Executes on button press in disconnectopc.
function disconnectopc_Callback(hObject, eventdata, handles)
% hObject    handle to disconnectopc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  temper_down_flag temper_up_flag connect_con daobj pidloop apc_on temp_on  first_cooler_rev_on data tempdata toupai_on
global decomposing_furnace_tempr_on coalklin_on second_cooler_rev_on third_cooler_rev_on xintiao_on shengliao_douti_pidai_on_left
if ~isempty(timerfind)
    stop(timerfind)
    delete(timerfind)
end
if strcmp(daobj.Status,'connected')
    disconnect(daobj)
    datetime = datestr(now,30);
    s = ['save(''data',datetime(1:8),datetime(10:13),'.mat'',''data'');'];
    eval(s);
    lastsave = ['data',datetime(1:8),datetime(10:13),'.mat'];
end
set(handles.connect_state,'ForegroundColor',[0 0 0]); 
set(handles.connect_state,'String','已断开');
set(handles.connectopc,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.disconnectopc,'BackgroundColor',[1 0 0]);

set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
%set(handles.yaotou_temp_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_open_left,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.xintiao_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.xintiao_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toupai_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toupai_close,'BackgroundColor',[0.941 0.941 0.941]);
apc_on=0;
connect_con=0;
temp_on=0;
first_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
coalklin_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
xintiao_on = 0;
shengliao_douti_pidai_on_left = 0;
toupai_on = 0;
temper_down_flag=0;
temper_up_flag=0;
data=zeros(length(tempdata)+50,1);



% --- Executes on selection change in listbox1.


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gui_decomposing_furnace_tempr_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decomposing_furnace_tempr_on paramdata
decomposing_furnace_tempr_on =0;

% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
paramdata = xml_read('param_set.xml');
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on slider movement.

function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_g11_current_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_g11_current_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in gui_1st_cooler_on_button.
function gui_1st_cooler_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on
first_cooler_rev_on=1;

set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);



% --- Executes on button press in gui_1st_cooler_off_button.
function gui_1st_cooler_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on paramdata zxyCnt stop_zxyCnt stop_zxyFlag recover_flag blj_speed_stop_flag
global blj_low_time_cnt blj_low_pressure blj_high_speed
first_cooler_rev_on=0;
zxyCnt = 0; %启动自寻优计时器清零
stop_zxyCnt = 0; %停止自寻优计时器清零
stop_zxyFlag = 0; %停止自寻优触发条件复位
recover_flag = false;
blj_speed_stop_flag = false;
blj_low_time_cnt = 1;
blj_low_pressure = 0;
blj_high_speed = 0;


set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
%set(handles.yaotou_temp_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
paramdata = xml_read('param_set.xml');


% --- Executes on slider movement.

% --- Executes during object creation, after setting all properties.

% --- Executes on button press in pushbutton13.


% --- Executes on slider movement.

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global daobj auth
auth=1;%%%%Need_to_be_modified
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if auth==1
    button2=questdlg('确定退出？','退出程序','Yes','No','Yes');
    if strcmp(button2,'Yes')
        %%%%%%%%Need_to_be_modified
        if ~isempty(timerfind)
            stop(timerfind)
            delete(timerfind)
        end
        if strcmp(daobj.Status,'connected')
            disconnect(daobj)
        end
     %%%%%%%%%%Need_to_be_modified
        delete(hObject);
    end;
else
    delete(hObject);
end
% Hint: delete(hObject) closes the figure


% --- Executes during object creation, after setting all properties.
function gui_decomposing_furnace_tempr_2_sp_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_2_sp_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_feeding_duct_tempr_2_pv_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_feeding_duct_tempr_2_pv_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_2nd_chamber_pressure_pv_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_pv_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_furnace_pressure_pv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_furnace_pressure_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_g11_current_sp_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function OX_pv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OX_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.



% --- Executes on button press in gui_auto_off.
function gui_auto_off_Callback(hObject, eventdata, handles)
% hObject    handle to gui_auto_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temper_down_flag temper_up_flag first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on coalklin_on wmc_press_on shengliao_douti_pidai_on_left
first_cooler_rev_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
coalklin_on=0;
wmc_press_on = 0;
shengliao_douti_pidai_on_left=0;
temper_down_flag=0;
temper_up_flag=0;

% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);




set(handles.shengliao_pidai_open_left,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.941 0.941 0.941]);

% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[1 0 0]);


set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on slider movement.



% --- Executes on button press in alarmbutton.
function alarmbutton_Callback(hObject, eventdata, handles)
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS pophandles
global alarm_sound_flag alarm_button_clicked fazu1_max fazu1_min fazu2_max fazu2_min
% open('alarmset.fig');

% run('alarmset');
set(0,'CurrentFigure',alarmset);
pophandles = guihandles;

set(pophandles.text12,'String',decomposing_furnace_tempr_2_upperlimitS);
set(pophandles.slider1,'Value',decomposing_furnace_tempr_2_upperlimitS);
set(pophandles.text13,'String',decomposing_furnace_tempr_2_lowerlimitS);
set(pophandles.slider2,'Value',decomposing_furnace_tempr_2_lowerlimitS);
set(pophandles.text14,'String',snd_chamber_pressure_upperlimitS);
set(pophandles.slider4,'Value',snd_chamber_pressure_upperlimitS);
set(pophandles.text15,'String',snd_chamber_pressure_lowerlimitS);
set(pophandles.slider5,'Value',snd_chamber_pressure_lowerlimitS);

set(pophandles.fazu1_max,'String',fazu1_max);
set(pophandles.fazu1_maxSlider,'Value',fazu1_max);
set(pophandles.fazu1_min,'String',fazu1_min);
set(pophandles.fazu1_minSlider,'Value',fazu1_min);

set(pophandles.fazu2_max,'String',fazu2_max);
set(pophandles.fazu2_maxSlider,'Value',fazu2_max);
set(pophandles.fazu2_min,'String',fazu2_min);
set(pophandles.fazu2_minSlider,'Value',fazu2_min);



set(pophandles.figure1, 'WindowStyle', 'modal');
alarm_sound_flag = 0;
alarm_button_clicked = 1;
set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);
        
% hObject    handle to alarmbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --- Executes on slider movement.
function gui_klin_head_tempr_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_tempr_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a*10)/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_klin_head_tempr_sp_display,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_klin_head_tempr_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_tempr_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_klin_tempr_off_button.
function gui_klin_tempr_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
global coalklin_on paramdata
coalklin_on=0;
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]); 
paramdata = xml_read('param_set.xml');
%handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_klin_tempr_on_button.
function gui_klin_tempr_on_button_Callback(hObject, eventdata, handles)
global coalklin_on
coalklin_on=1;
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0 1 0]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
% hObject    handle to gui_klin_tempr_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)







% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1



% --- Executes on button press in shengliao_douti_open.

% --- Executes on button press in shengliao_douti_close.


% --- Executes on button press in gui_3rd_cooler_on_button.
function gui_3rd_cooler_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_3rd_cooler_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global third_cooler_rev_on
third_cooler_rev_on=1;
% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0 1 0]);
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gui_3rd_cooler_off_button.
function gui_3rd_cooler_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_3rd_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global third_cooler_rev_on paramdata
third_cooler_rev_on=0;
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[1 0 0]);
% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
paramdata = xml_read('param_set.xml');
% --- Executes on slider movement.
function gui_feeding_duct_tempr_2_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_feeding_duct_tempr_2_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
% set(handles.gui_feeding_duct_tempr_2_sp_display,'String',num2str(slide_value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_feeding_duct_tempr_2_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_feeding_duct_tempr_2_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_1st_cooler_on_button_bed.
function gui_1st_cooler_on_button_bed_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_on_button_bed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on
first_cooler_rev_on=2;
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0 1 0]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on slider movement.
function gui_2nd_chamber_pressure_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_2nd_chamber_pressure_sp_display,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_2nd_chamber_pressure_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_feeding_duct_tempr_2_on_button.
function gui_feeding_duct_tempr_2_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_feeding_duct_tempr_2_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decomposing_furnace_tempr_on 
decomposing_furnace_tempr_on =2;
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0 1 0]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on slider movement.
function gui_decomposing_furnace_tempr_1_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gui_decomposing_furnace_tempr_1_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_decomposing_furnace_tempr_1_on_button.
function gui_decomposing_furnace_tempr_1_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decomposing_furnace_tempr_on 
decomposing_furnace_tempr_on =3;
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0 1 0]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in gui_decomposing_furnace_tempr_off_button.



% --- Executes on slider movement.
function shengliao_douti_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.shengliao_douti_sp,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function shengliao_douti_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shengliao_douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function chongban_flow_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shengliao_douti_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function yaowei_coalMAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaowei_coalMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaowei_coalMAX,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaowei_coalMAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaowei_coalMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaowei_coalMIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaowei_coalMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaowei_coalMIN,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaowei_coalMIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaowei_coalMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function fjl_temp_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_temp_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_temp_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_temp_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',about);


% --- Executes on button press in shengliao_pidai_open_left.
function shengliao_pidai_open_left_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_open_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_douti_on shengliao_douti_pidai_on_left shengliao_douti_pidai_on_right
shengliao_douti_on=0;
shengliao_douti_pidai_on_left = 1;
shengliao_douti_pidai_on_right = 0;
set(handles.shengliao_pidai_open_left,'BackgroundColor',[0 1 0]);
set(handles.shengliao_pidai_open_right,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in shengliao_pidai_close.
function shengliao_pidai_close_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_douti_on shengliao_zhuanzi_on shengliao_douti_pidai_on_left shengliao_douti_pidai_on_right
shengliao_douti_pidai_on_left=0;
shengliao_douti_pidai_on_right = 0;
set(handles.shengliao_pidai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_open_left,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_open_right,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in wmc_press_open.
function wmc_press_open_Callback(hObject, eventdata, handles)
% hObject    handle to wmc_press_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wmc_press_on 
wmc_press_on  =1;


% --- Executes on button press in wmc_press_close.
function wmc_press_close_Callback(hObject, eventdata, handles)
% hObject    handle to wmc_press_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wmc_press_on 
wmc_press_on  = 0;

% --- Executes on slider movement.
function wmc_press_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to wmc_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value


% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.wmc_press_sp,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function wmc_press_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wmc_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.


% --- Executes during object creation, after setting all properties.


% --- Executes on slider movement.
function yaotou_temp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_temp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.yaotou_temp_sp,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_temp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_temp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in yaotou_temp_open.
function yaotou_temp_open_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_temp_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on
first_cooler_rev_on=1;
set(handles.yaotou_temp_open,'BackgroundColor',[0 1 0]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in xintiao_close.
function xintiao_close_Callback(hObject, eventdata, handles)
% hObject    handle to xintiao_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xintiao_on
xintiao_on = 0;

set(handles.xintiao_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.xintiao_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in xintiao_open.
function xintiao_open_Callback(hObject, eventdata, handles)
% hObject    handle to xintiao_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xintiao_on
xintiao_on = 1;
set(handles.xintiao_open,'BackgroundColor',[0 1 0]);
set(handles.xintiao_close,'BackgroundColor',[0.941 0.941 0.941]);


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',adjust);


% --- Executes on slider movement.
function slider39_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shengliao_douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in shengliao_pidai_open_left.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_open_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shengliao_pidai_close.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function yaotou_press_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaotou_press_sp,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_press_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in toupai_close.
function toupai_close_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_on
toupai_on=0;
set(handles.toupai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toupai_open,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in toupai_open.
function toupai_open_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_on
toupai_on = 1;
set(handles.toupai_open,'BackgroundColor',[0 1 0]);
set(handles.toupai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global temper_up_flag 
% temper_up_flag = 1;
% set(handles.pushbutton54,'BackgroundColor',[0 1 0]);
% set(handles.pushbutton55,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global temper_up_flag 
% temper_up_flag = 0;
% set(handles.pushbutton55,'BackgroundColor',[0 1 0]);
% set(handles.pushbutton54,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global temper_down_flag 
% temper_down_flag = 1;
% set(handles.pushbutton56,'BackgroundColor',[0 1 0]);
% set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global temper_down_flag 
% temper_down_flag = 0;
% set(handles.pushbutton57,'BackgroundColor',[0 1 0]);
% set(handles.pushbutton56,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in param_setting.
function param_setting_Callback(hObject, eventdata, handles)
% hObject    handle to param_setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramhandles
global zhuansu_MAX zhuansu_MIN douti_MAX douti_MIN  CO_yuzhi
set(0,'CurrentFigure',param_setting);
paramhandles = guihandles;

zhuansu_MAX=str2double(get(paramhandles.zhuansu_MAX,'String'));
zhuansu_MIN=str2double(get(paramhandles.zhuansu_MIN,'String'));
douti_MAX=str2double(get(paramhandles.douti_MAX,'String'));
douti_MIN=str2double(get(paramhandles.douti_MIN,'String'));
CO_yuzhi=str2double(get(paramhandles.CO_yuzhi,'String'));


% --- Executes on button press in shengliao_pidai_open_right.
function shengliao_pidai_open_right_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_open_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_douti_on shengliao_douti_pidai_on_right shengliao_douti_pidai_on_left
shengliao_douti_on=0;
shengliao_douti_pidai_on_right = 1;
shengliao_douti_pidai_on_left = 0;
set(handles.shengliao_pidai_open_right,'BackgroundColor',[0 1 0]);
set(handles.shengliao_pidai_open_left,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data b
[~,c]=size(data);
t=2:c;
figure;
p1=plotyy(t,data(9,2:c),t,data(80,2:c));%一室风机电流
set(p1(1),'ylim',[(data(80,b+1)-15),(data(80,b+1)+15)],'ytick',[(data(80,b+1)-15):5:(data(80,b+1)+15)]);
set(p1(2),'ylim',[(data(80,b+1)-15),(data(80,b+1)+15)],'ytick',[(data(80,b+1)-15):5:(data(80,b+1)+15)]);
% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data b
[~,c]=size(data);
t=2:c;
figure;
p1=plotyy(t,data(18,2:c),t,data(79,2:c));%斗提电流
set(p1(1),'ylim',[(data(79,b+1)-10),(data(79,b+1)+10)],'ytick',[(data(79,b+1)-10):2:(data(79,b+1)+10)]);
set(p1(2),'ylim',[(data(79,b+1)-10),(data(79,b+1)+10)],'ytick',[(data(79,b+1)-10):2:(data(79,b+1)+10)]);


% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data b
[~,c]=size(data);
t=2:c;
figure;
p1=plotyy(t,data(11,2:c),t,data(77,2:c));%分解炉温度
set(p1(1),'ylim',[(data(77,b+1)-20),(data(77,b+1)+20)],'ytick',[(data(77,b+1)-20):5:(data(77,b+1)+20)]);
set(p1(2),'ylim',[(data(77,b+1)-20),(data(77,b+1)+20)],'ytick',[(data(77,b+1)-20):5:(data(77,b+1)+20)]);


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[~,c]=size(data);
t=2:c;
figure;
p1=plot(t,data(8,2:c));%一室篦下压力


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  data b zxyCnt stop_zxyCnt stop_zxyFlag a rukuEcur O2_hanliang first_cooler_rev_on
global sign_mill_current  good_mill_current_sp  init last_mill_current first
a=get(hObject,'Value');%获取checkbox1当前状态
% disp(a);
if first_cooler_rev_on == 0
    button2=questdlg('请先打开电流控制','电流寻优','Yes','No','Yes');
    set(hObject,'ForegroundColor','k');
    set(handles.checkbox2,'Value',0);
    set(handles.gui_2nd_chamber_pressure_sp_slider,'Enable','on');
    zxyCnt = 0; %启动自寻优计时器清零
    stop_zxyCnt = 0; %停止自寻优计时器清零
    stop_zxyFlag = 0; %停止自寻优触发条件复位
else
    if a
        set(hObject,'ForegroundColor',[0.2 0.8 0.4]);
        set(handles.gui_2nd_chamber_pressure_sp_slider,'Enable','off');
    %启动电流自寻优记录当前时刻的入库电流和磨机电流作为前一次值
        first=1;
        init=1;
    else
        set(handles.checkbox2,'Value',0);
        set(hObject,'ForegroundColor','k');
        set(handles.gui_2nd_chamber_pressure_sp_slider,'Enable','on');
        zxyCnt = 0; %启动自寻优计时器清零
        stop_zxyCnt = 0; %停止自寻优计时器清零
        stop_zxyFlag = 0; %停止自寻优触发条件复位
        last_mill_current = 148;
        init = 0;
        lastE=[];
        curE=[];
    end
end


% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes during object creation, after setting all properties.
function gui_1st_cooler_rev_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_rev_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in draw.
function draw_Callback(hObject, eventdata, handles)
% hObject    handle to draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data 
[~,c]=size(data);
xx=2:c;
yy1 = data(3,2:c);
yy2 = data(23,2:c);
figure;
[AX, ~, ~] = plotyy(xx,yy1,xx,yy2,@plot);
set(get(AX(1),'ylabel'),'string', '一段篦速设定值','fontsize',12);
set(get(AX(2),'ylabel'),'string', '二次风温滤波测量值','fontsize',12);
set(AX(1),'ylim',[min(yy1)-0.05,max(yy1)+0.05]);
set(AX(2),'ylim',[min(yy2)-10,max(yy2)+10]);
xlabel('时间/s','fontsize',12);



function blj_zhuansu_Callback(hObject, eventdata, handles)
% hObject    handle to blj_zhuansu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blj_zhuansu as text
%        str2double(get(hObject,'String')) returns contents of blj_zhuansu as a double


function man_blj_speed_Callback(hObject, eventdata, handles)
% hObject    handle to man_blj_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of man_blj_speed as text
%        str2double(get(hObject,'String')) returns contents of man_blj_speed as a double


% --- Executes during object creation, after setting all properties.
function man_blj_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to man_blj_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_blj_speed man_blj_time_cnt man_in_blj
man_blj_speed = str2double(get(handles.man_blj_speed,'String'));
man_in_blj = true;
man_blj_time_cnt = 0;


% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_fjl_coal man_fjl_time_cnt man_in_fjl
man_fjl_coal = str2double(get(handles.man_fjl_coal,'String'));
man_in_fjl = true;
man_fjl_time_cnt = 0;


function man_fjl_coal_Callback(hObject, eventdata, handles)
% hObject    handle to man_fjl_coal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of man_fjl_coal as text
%        str2double(get(hObject,'String')) returns contents of man_fjl_coal as a double


% --- Executes during object creation, after setting all properties.
function man_fjl_coal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to man_fjl_coal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
