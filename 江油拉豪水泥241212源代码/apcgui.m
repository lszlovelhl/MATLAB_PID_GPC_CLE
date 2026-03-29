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

% Last Modified by GUIDE v2.5 31-May-2024 02:00:11

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
global daobj group  deadzone lastsave  count_pressue  coaljunhua_sign shengliao_zhuanzi_on shengliao_douti_pidai_on
global alarmon alarmrow flag_connect_state fjl_set first_time_connect_flag_ontimer 
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on 
global second_plate_pressure_max_pv third_plate_pressure_max_pv upid paramdata
global B2 A2 workpoint2 gpc_a2 gpc_lmd2  shengliao_douti_on xintiao_on  fazuFlag weimei_flag blj_big
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global decomposing_furnace_tempr_2_upperMax decomposing_furnace_tempr_2_upperMin decomposing_furnace_tempr_2_lowerMax decomposing_furnace_tempr_2_lowerMin
global sign_bichuang snd_chamber_pressure_upperMax snd_chamber_pressure_upperMin snd_chamber_pressure_lowerMax snd_chamber_pressure_lowerMin alarm_sound_flag alarm_timer alarm_button_clicked
global gpc_shengliao_douti_sp shengliao_douti_liuliang_on wmc_press_on fazu1_max fazu1_min fazu2_max fazu2_min toupai_on
global blj_asc_flag1 blj_asc_flag2 blj_desc_flag1 blj_desc_flag2 blj_asc blj_desc oil_pressure_threshold2 oil_pressure_threshold1 u_fjl_max yachuang_mv
global zhuansu_MIN zhuansu_MAX wentai_min wentai_max period temp_step zhuansu zxyCnt press
global man_in_blj man_in_fjl man_fjl_time_cnt man_blj_time_cnt youya_alarm_cnt toumei_MAX toumei_MIN
global man_weimei man_zhuansu toumeiyali_MAX toumeiyali_MIN yaodianliu_on pressure_vd blj_speed_stop_flag
global man_ydl_toumei man_in_ydl man_ydl_time_cnt
global kypcnt kypcntflag ysfjdl ysfjdlDV ecfw_sp zhuansu_mid
global ydlDBH ydlUBH ydlBHcnt ydlBHFlag gui_fjlT_sp decomposing_furnace_tempr_1_sp
global ecfw_spcnt ecfw_cnt_inner_sp yaowei_coalMAX yaowei_coalMIN wmfy_sp duliao_up duliao_down
% % % % % wyxxxxxxxxxx 2022/11/12
global his_file_path his_file_row his_data last_path hisdatadays keycount hitdata_title

global cc_test tidaiwu_x du_flag qiankui_flag qiankui_flag1 duliao_flag duliao_flag1 AF_tidai AF blj_rev_time tdrl_open_flag tdrl_open_flag1 tdrl_close_flag tdrl_close_flag1
%[0.831 0.816 0.784] [0.941 0.941 0.941]

% % % % % wyxxxxxx   2022/11/12
hitdata_title = {'日期时间',...
                '二室风机出口压力',...
                '一段篦冷机转速给定值(无扰读取值)',...
                '一段篦冷机转速给定值(程序写入值)',...
                '一段篦冷机转速测量值(篦床速度反馈）',...
                '一室风机出口压力A',...
                '1#阀组供油压力',...
                '2#阀组供油压力',...
                '一室风机出口压力B',...
                '一室风机电流A',...
                '五级下料管出料口温度1',...
                '分解炉出口温度1',...
                '分解炉喂煤量给定值(程序写入值)',...
                '分解炉喂煤量给定值(无扰读取值)',...
                '分解炉喂煤量测量值',...
                '三次风温',...
                '尾煤风压（0711）',...
                '尾煤风压（0710）',...
                '斗提电流1',...
                '喂料量测量值',...
                '喂料量给定值(程序写入值)',...
                '喂料量给定值(无扰读取值)',...
                '头煤压力(窑头一次风煤风风机出口压力）',...
                '窑头温度(二次风温)',...
                '窑尾(烟室)温度',...
                '窑头喂煤量给定值(程序写入值)',...
                '窑头喂煤量给定值(无扰读取值)',...
                '窑头喂煤量测量值',...
                '窑头负压',...
                'AF二期塑料渣称流量反馈值',...
                '回转窑轴电流',...
                '回转窑转速测量值',...
                'AF二期泡沫渣称流量给定值',...
                'AF二期泡沫渣称流量反馈值',...
                'AF二期泡沫渣皮带秤应答',...
                '系统负压（高温风机出口压力）',...
                '残氧(窑尾02)（烟室气体分析O2）',...
                '心跳',...
                '通讯OK',...
                '篦床速度模式选择',...
                '高温风机模式选择',...
                '窑头尾煤模式选择',...
                '分解炉尾煤模式选择',...
                '生料斗提秤模式选择',...
                '一级筒出口气体CO',...
                'C5出口气体CO',...
                '一级筒出口气体O2',...
                'AF二期塑料渣称流量给定值',...
                'AF一期塑料渣称应答',...
                'AF二期塑料渣皮带秤应答',...
                '烟室气体分析CO',...
                '头排风机转速给定值(程序写入值)',...
                '头排风机转速给定值(无扰读取值)',...
                '头排风机转速测量值',...
                '尾排风机转速给定值(程序写入值)',...
                '尾排风机转速给定值(无扰读取值)',...
                '尾排风机转速测量值',...
                '头排风机模式选择',...
                'F1B风机阀门反馈',...
                '篦冷机回路操作员许可',...
                '分解炉回路操作员许可',...
                '塑料渣称流量给定值',...
                '塑料渣称流量反馈值',...
                'F1A风机电流给定',...
                'F1A风机阀门反馈',...
                'F1B风机电流给定'
                };


%数据采集
his_file_path = 'EHD\'; %历史数据存储文件路径 'D:\envieohisdata\' EHD=envieohisdata
%his_file_path = 'C:\Users\Administrator\Desktop\2018\Figure';
if ~exist(his_file_path) 
    mkdir(his_file_path);
end 
his_file_row = 1;  %历史数据当前存储文件中记录行数，以便直接追加内容
his_data = {};
last_path = '';
hisdatadays = 30; %存储数据默认天数 30天
keycount = 0;

%% 配置
paramdata = xml_read('param_set.xml');
decomposing_furnace_tempr_2_upperMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMax;
decomposing_furnace_tempr_2_upperMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMin;
decomposing_furnace_tempr_2_lowerMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMax;
decomposing_furnace_tempr_2_lowerMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMin;
snd_chamber_pressure_upperMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMax;
snd_chamber_pressure_upperMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMin;
snd_chamber_pressure_lowerMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMax;
snd_chamber_pressure_lowerMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMin;
ysfjdl=paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdl;
ysfjdlDV=paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdlDV;
ecfw_sp=paramdata.commdata(1).parameter(4).ATTRIBUTE.ecfw_sp; %二次风温
ecfw_cnt_inner_sp = 0; %二次风温内部设定值
yachuang_mv = paramdata.commdata(1).parameter(4).ATTRIBUTE.yachuang_mv;
zhuansu_mid = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mid;
tidaiwu_x = paramdata.commdata(1).parameter(7).ATTRIBUTE.tidaiwu_x;%%%替代物与煤比值：
decomposing_furnace_tempr_2_upperlimitS=(decomposing_furnace_tempr_2_upperMax+decomposing_furnace_tempr_2_upperMin)/2;
decomposing_furnace_tempr_2_lowerlimitS=(decomposing_furnace_tempr_2_lowerMax+decomposing_furnace_tempr_2_lowerMin)/2;
snd_chamber_pressure_upperlimitS=11;
snd_chamber_pressure_lowerlimitS=7;
fazu1_max = 14.5;
fazu1_min = 0;
fazu2_max = 16;
fazu2_min = 0;
cc_test = 0;
oil_pressure_threshold2 = 9.5;
oil_pressure_threshold1 = 14;
pressure_vd = 9.5; 
blj_speed_stop_flag = 0;
u_fjl_max = 200;
zhuansu_MIN = 2;
zhuansu_MAX = 4;
toumei_MAX = 6.5;
toumei_MIN = 4.5;
yaowei_coalMAX = 9;
yaowei_coalMIN = 3;
toumeiyali_MAX = 12;
toumeiyali_MIN = 10;
zxyCnt = 0;
man_in_blj = false;
man_in_fjl = false;
man_fjl_time_cnt = 0;
man_blj_time_cnt = 0;
youya_alarm_cnt = 0;
man_weimei = 8.5;
man_zhuansu = 2.6;
man_ydl_toumei = 5.3;
man_in_ydl = false;
man_ydl_time_cnt = 0;
blj_rev_time = 0;
%% 初值设定
AF_tidai = 1;
AF = 1;
qiankui_flag = 0;
qiankui_flag1 = 0;
duliao_flag = 0;
duliao_flag1 = 0;
tdrl_open_flag = 0;
tdrl_open_flag1 = 0;
tdrl_close_flag = 0;
tdrl_close_flag1 = 0;
du_flag = 0;
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
blj_set=[148,175,90,13,9.0,95,10.0];
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
yaodianliu_on=0;
toupai_on = 0;
zhuansu = [];
press = [];
kypcnt = 0;
kypcntflag = 0;
ydlBHcnt = 0; %判断上下限饱和等待时间
ydlUBH = 0; %上限饱和判断，用作分解炉提温1度
ydlDBH = 0; %下限饱和判断，用作分解炉降温1度
ydlBHFlag = 0;%窑电流饱和标志位
gui_fjlT_sp = 870; %分解炉温度设定值
decomposing_furnace_tempr_1_sp = gui_fjlT_sp;
ecfw_spcnt = -1; %设定值计时，-1表示第一次开启控制按钮
% % % % % wyxxxxxxxxxx 2023/3/31
wmfy_sp=0;

daobj=opcda(paramdata.commdata(1).parameter(1).ATTRIBUTE.opcID,paramdata.commdata(1).parameter(1).ATTRIBUTE.opcServerName);
% daobj=opcda('192.168.0.1','FL.OPCServer.1');%%%Need_to_be_modified
daobj.Timeout = 60;
group = addgroup(daobj);  

deadzone=[1,1,1];
lastsave='none';

%% 设定值初始化 gui_g11_current_sp_slider gui_g11_current_sp_display

% 
% % 头煤压力
% set(handles.gui_klin_head_tempr_sp_display,'String',12);
% set(handles.gui_klin_head_tempr_sp_slider,'Value',12);
% set(handles.gui_klin_head_tempr_sp_slider,'Max',16,'Min',8);
% set(handles.gui_klin_head_tempr_sp_slider,'SliderStep',[0.01/8,0.05/8]);

% 窑电流
set(handles.text289,'String',350);
set(handles.slider53,'Value',350);
set(handles.slider53,'Max',550,'Min',250);
set(handles.slider53,'SliderStep',[1/300,5/300]);

% 篦床压力
% blj_control5=blj_set(5);
% set(handles.ecfw_sp,'String',blj_control5);
% set(handles.gui_2nd_chamber_pressure_sp_slider,'Value',blj_control5);
% set(handles.gui_2nd_chamber_pressure_sp_slider,'Max',blj_control5+3,'Min',blj_control5-3);
% set(handles.gui_2nd_chamber_pressure_sp_slider,'SliderStep',[0.1/6,0.2/6]);
% % % % % set(handles.ecfw_sp,'String',ecfw_sp);
% % % % % set(handles.gui_2nd_chamber_pressure_sp_slider,'Value',ecfw_sp);
% % % % % set(handles.gui_2nd_chamber_pressure_sp_slider,'Max',1300,'Min',1150);
% % % % % set(handles.gui_2nd_chamber_pressure_sp_slider,'SliderStep',[1/150,5/150]);
% 下料斗提
xialiao_sp=100;
set(handles.shengliao_douti_sp,'String',xialiao_sp);
set(handles.shengliao_douti_sp_slider,'Value',xialiao_sp);
set(handles.shengliao_douti_sp_slider,'Max',xialiao_sp+15,'Min',xialiao_sp-15);
set(handles.shengliao_douti_sp_slider,'SliderStep',[0.1/30,0.5/30]);
% 窑尾给煤上限
set(handles.yaowei_coalMAX,'String',yaowei_coalMAX );
set(handles.yaowei_coalMAX_slider,'Value',yaowei_coalMAX);
set(handles.yaowei_coalMAX_slider,'Max',11,'Min',5);
set(handles.yaowei_coalMAX_slider,'SliderStep',[0.05/6,0.1/6]);

set(handles.yaowei_coalMIN,'String',yaowei_coalMIN);
set(handles.yaowei_coalMIN_slider,'Value',yaowei_coalMIN);
set(handles.yaowei_coalMIN_slider,'Max',9,'Min',2);
set(handles.yaowei_coalMIN_slider,'SliderStep',[0.05/7,0.1/7]);
% 替代燃料堵设定值
set(handles.duliao_up,'String',6.5 );
set(handles.duliao_up_slider,'Value',6.5);
set(handles.duliao_up_slider,'Max',11,'Min',3);
set(handles.duliao_up_slider,'SliderStep',[0.05/8,0.1/8]);

set(handles.duliao_down,'String',5.6 );
set(handles.duliao_down_slider,'Value',5.6);
set(handles.duliao_down_slider,'Max',11,'Min',3);
set(handles.duliao_down_slider,'SliderStep',[0.05/8,0.1/8]);
% 分解炉出口温度
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',gui_fjlT_sp);
set(handles.fjl_temp_sp_slider,'Value',gui_fjlT_sp);
set(handles.fjl_temp_sp_slider,'Max',885,'Min',835);
set(handles.fjl_temp_sp_slider,'SliderStep',[1/50,2/50]);

set(handles.tidaiwu_x,'String',tidaiwu_x);
set(handles.tidaiwu_x_slider,'Value',tidaiwu_x);
set(handles.tidaiwu_x_slider,'Max',1.5,'Min',0);
set(handles.tidaiwu_x_slider,'SliderStep',[1/150,1/15]);
% 分解炉喂煤增速
set(handles.text270,'String',200);
set(handles.slider42,'Value',200);
set(handles.slider42,'Max',1000,'Min',100);
set(handles.slider42,'SliderStep',[10/900,20/900]);

% 油压
set(handles.pressure_vd,'String',pressure_vd);
set(handles.oil_pressure_threshold2_slider,'Value',pressure_vd);
set(handles.oil_pressure_threshold2_slider,'Max',15,'Min',0);
set(handles.oil_pressure_threshold2_slider,'SliderStep',[0.1/15,0.5/15]);


set(handles.yachuang_mv,'String',yachuang_mv);
set(handles.yachuang_mv_slider,'Value',yachuang_mv);
set(handles.yachuang_mv_slider,'Max',0.4,'Min',0);
set(handles.yachuang_mv_slider,'SliderStep',[0.01/0.4,0.02/0.4]);
% 转速上下限
set(handles.zhuansu_MAX,'String',4.0);
set(handles.zhuansu_MAX_slider,'Value',4.0);
set(handles.zhuansu_MAX_slider,'Max',6,'Min',2);
set(handles.zhuansu_MAX_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.zhuansu_MIN,'String',2.0);
set(handles.zhuansu_MIN_slider,'Value',2.0);
set(handles.zhuansu_MIN_slider,'Max',4,'Min',0);
set(handles.zhuansu_MIN_slider,'SliderStep',[0.05/4,0.1/4]);

% 二次风温设定
set(handles.ecfw_sp,'String',ecfw_sp);
set(handles.ecfw_sp_slider,'Value',ecfw_sp);
set(handles.ecfw_sp_slider,'Max',1240,'Min',1000);
set(handles.ecfw_sp_slider,'SliderStep',[0.1/24,1/24]);

% 窑头给煤上下限
set(handles.toumei_MAX,'String',toumei_MAX);
set(handles.toumei_MAX_slider,'Value',toumei_MAX);
set(handles.toumei_MAX_slider,'Max',8,'Min',4);
set(handles.toumei_MAX_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.toumei_MIN,'String',toumei_MIN);
set(handles.toumei_MIN_slider,'Value',toumei_MIN);
set(handles.toumei_MIN_slider,'Max',6,'Min',3);
set(handles.toumei_MIN_slider,'SliderStep',[0.05/3,0.1/3]);
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
%初始替代燃料af
set(handles.AF1,'BackgroundColor',[0 1 0]);
set(handles.AF2,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.AF3,'BackgroundColor',[0.831 0.816 0.784]);    



% Choose default command line output for apcgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

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
global first_time_connect_flag connect_con daobj group tempdata data  itemset tempmv  auth pidloop loopnum b 
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on
global shengliao_douti_pidai_on gpc_shengliao_douti_sp shengliao_douti_liuliang_on wmc_press_on  xintiao_on toupai_on


set(handles.connectopc,'Enable','off')
auth=0;%当其为0时即无法工作
load('key');
usedtime=decodekey(key.usedtime);%这里的key文件主要是起加密作用，主要是给别人使用有时间限制的
validtime=decodekey(key.validtime);
license=decodekey(key.license);
usedtime=usedtime+1;
key.usedtime=encodekey(usedtime);
licensevalid=decodekey(key.licensevalid);
load('bak');  %%防止授权激活后，拷贝key出去，再次使用
usedtime1=decodekey(bak.usedtime);
usedtime1=usedtime1+1;
bak.usedtime=encodekey(usedtime1);
if (now - license<=7) && (now - license>=-7)&&licensevalid==110110110110 %-7表示防止现场电脑时间和生成key用的电脑时间不对应，所以扩大范围。有效期为7天
    licensevalid = 101011010100;
    usedtime1 = usedtime;
    bak.usedtime=encodekey(usedtime1);
    key.licensevalid = encodekey(licensevalid);%使license有效
end
save('key.mat','key');
save('bak.mat','bak');

%不使用软件usedtime虽不计时，但也不可以超过有效期2倍时间,并且天数不会小于使用时间
if (now - license <= (validtime/24)*2) && (now - license >= usedtime/24-1) %天数，单位：天
    if ((validtime-usedtime)>=0)&&(licensevalid==101011010100)%Need_to_be_modified
    %     auth=1;
        if usedtime1 ~= usedtime     %%防止授权激活后，拷贝key出去，再次使用
            msgbox('授权有效期到期，请更新授权！');
        else
            auth=1;
        end
    else
        msgbox('授权有效期到期，请更新授权！');
    end
else
    licensevalid = 110110110110; %使license无效
    key.licensevalid = encodekey(licensevalid);
    save('key.mat','key');
    msgbox('授权有效期到期，请更新授权！');
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
            shengliao_douti_pidai_on = 0;
            shengliao_douti_liuliang_on = 0;
            wmc_press_on = 0;
            xintiao_on = 0;
            toupai_on = 0;
            set(handles.disconnectopc,'BackgroundColor',[1 0 0]);
            set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
            set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
            %set(handles.yaotou_temp_open,'BackgroundColor',[0.831 0.816 0.784]);
            set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
            
            set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
%             set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
            set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);
            % set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
%             set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
            
            
            % set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.831 0.816 0.784]);
            % set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);

%             set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.831 0.816 0.784]);
            set(handles.toupai_open,'BackgroundColor',[0.831 0.816 0.784]);
            set(handles.toupai_close,'BackgroundColor',[0.831 0.816 0.784]);
            
  

%            connect(daobj);
            itemset=additem(group, {'Channel1.Device1.AI.C377FA09MT_PI',...
                'Channel1.Device1.MAN.C0719DPAO_MAN_OUT',...
                'Channel1.Device1.MAN.C0719DPAO_MAN_IN',...
                'Channel1.Device1.REALM.C0719DPAI_05',...
                'Channel1.Device1.AI.C377FA07MT_PI',...
                'Channel1.Device1.REALM.C0719DPAI_03',...
                'Channel1.Device1.REALM.C0719DPAI_04',...
                'Channel1.Device1.AI.C377FA08MT_PI',...
                'Channel1.Device1.AI.C377FA07MT_CI',...
                'Channel1.Device1.AI.A373CYA5YP12_TI',...
                'Channel1.Device1.AI.A373CYA6YT13_TI',...
                'Channel1.Device1.MAN.CFT303_MAN_IN',...
                'Channel1.Device1.MAN.CFT303_MAN_OUT',...
                'Channel1.Device1.AS.CFT303_ZI_real',...
                'Channel1.Device1.AI.A373CYA8YP15_TI',...
                'Channel1.Device1.AI.E644PF27MT10_PI',...
                'Channel1.Device1.AI.E644PF26MT10_PI',...
                'Channel1.Device1.AI.A312BE51MT_CI',...
                'Channel1.Device1.AI.A312WF36MT10_FI',...
                'Channel1.Device1.MAN.A312WF36EC_MAN_IN',...
                'Channel1.Device1.MAN.A312WF36EC_MAN_OUT',...
                'Channel1.Device1.AI.C644FE32YP10_PI',...
                'Channel1.Device1.AI.CTT307_TI',...
                'Channel1.Device1.AI.A373CYA7YP14_TI',...
                'Channel1.Device1.MAN.CFT302_MAN2_IN',...
                'Channel1.Device1.MAN.CFT302_MAN2_OUT',...
                'Channel1.Device1.AI.CFT302_ZI',...
                'Channel1.Device1.AI.CPT307_PI',...
                'Channel1.Device1.AI.A380WF07AC10_FI',...
                'Channel1.Device1.AI.C376KI02MT_CI',...
                'Channel1.Device1.AI.C376KI02MT_SI',...
                'Channel1.Device1.MAN.A380WF08_MAN_OUT',...
                'Channel1.Device1.AI.A380WF08AC10_FI',...
                'Channel1.Device1.DI.A380WF08AC10_RN',...
                'Channel1.Device1.AI.A373FA19YP12_PI',...
                'Channel1.Device1.AI.A373CYA1AG8_O2',...
                'Channel1.Device1.DM.XINTIAO',...
                'Channel1.Device1.DS.TONGXUN_OK',...
                'Channel1.Device1.DM.BISU_MODE_SEL',...
                'Channel1.Device1.DM.GAOWEN_AM_SEL',...
                'Channel1.Device1.DM.TOUMEI_AM_SEL',...
                'Channel1.Device1.DM.WEIMEI_AM_SEL',...
                'Channel1.Device1.DM.CHENG_AM_SEL',...
                'Channel1.Device1.AI.A373CYA1AG10_CO',...
                'Channel1.Device1.AI.A373CYA1AG9_CO',...
                'Channel1.Device1.AI.A373CYA1AG10_O2',...
                'Channel1.Device1.MAN.A380WF07_MAN_OUT',...
                'Channel1.Device1.DI.A373AF09WF10_RN',...
                'Channel1.Device1.DI.A380WF07AC10_RN',...
                'Channel1.Device1.AI.A373CYA1AG8_CO',...
                'Channel1.Device1.MAN.C378FA02_MAN_IN',...
                'Channel1.Device1.MAN.C378FA02_MAN_OUT',...
                'Channel1.Device1.AI.CSC380_SI',...
                'Channel1.Device1.MAN.B374FA06BP_MAN_IN',...
                'Channel1.Device1.MAN.B374FA06BP_MAN_OUT',...
                'Channel1.Device1.AI.B374FA06BP_SI',...
                'Channel1.Device1.DM.TOUPAI_MODE_SEL',...
                'Channel1.Device1.AI.C377FA08YZ_ZI',...
                'Channel1.Device1.DS.BISU_MODE_SEL1',...
                'Channel1.Device1.DS.WEIMEI_MODE_SEL1',...
                'Channel1.Device1.MAN.A373AF09WF10_MAN_OUT',...
                'Channel1.Device1.AI.A373AF09WF10_FI',...
                'Channel1.Device1.AS.C377FA07YZ_PID_SP',...
                'Channel1.Device1.AI.C377FA07YZ_ZI',...
                'Channel1.Device1.AS.C377FA08YZ_PID_SP'

});
            connect(daobj);

            tempdata=read(group);
            data=zeros(length(tempdata)+50,1);%初始化data  Need_to_be_modified
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
            itemset=additem(group, {'Channel1.Device1.AI.C377FA09MT_PI',...
                        'Channel1.Device1.MAN.C0719DPAO_MAN_OUT',...
                        'Channel1.Device1.MAN.C0719DPAO_MAN_IN',...
                        'Channel1.Device1.REALM.C0719DPAI_05',...
                        'Channel1.Device1.AI.C377FA07MT_PI',...
                        'Channel1.Device1.REALM.C0719DPAI_03',...
                        'Channel1.Device1.REALM.C0719DPAI_04',...
                        'Channel1.Device1.AI.C377FA08MT_PI',...
                        'Channel1.Device1.AI.C377FA07MT_CI',...
                        'Channel1.Device1.AI.A373CYA5YP12_TI',...
                        'Channel1.Device1.AI.A373CYA6YT13_TI',...
                        'Channel1.Device1.MAN.CFT303_MAN_IN',...
                        'Channel1.Device1.MAN.CFT303_MAN_OUT',...
                        'Channel1.Device1.AS.CFT303_ZI_real',...
                        'Channel1.Device1.AI.A373CYA8YP15_TI',...
                        'Channel1.Device1.AI.E644PF27MT10_PI',...
                        'Channel1.Device1.AI.E644PF26MT10_PI',...
                        'Channel1.Device1.AI.A312BE51MT_CI',...
                        'Channel1.Device1.AI.A312WF36MT10_FI',...
                        'Channel1.Device1.MAN.A312WF36EC_MAN_IN',...
                        'Channel1.Device1.MAN.A312WF36EC_MAN_OUT',...
                        'Channel1.Device1.AI.C644FE32YP10_PI',...
                        'Channel1.Device1.AI.CTT307_TI',...
                        'Channel1.Device1.AI.A373CYA7YP14_TI',...
                        'Channel1.Device1.MAN.CFT302_MAN2_IN',...
                        'Channel1.Device1.MAN.CFT302_MAN2_OUT',...
                        'Channel1.Device1.AI.CFT302_ZI',...
                        'Channel1.Device1.AI.CPT307_PI',...
                        'Channel1.Device1.AI.A380WF07AC10_FI',...
                        'Channel1.Device1.AI.C376KI02MT_CI',...
                        'Channel1.Device1.AI.C376KI02MT_SI',...
                        'Channel1.Device1.MAN.A380WF08_MAN_OUT',...
                        'Channel1.Device1.AI.A380WF08AC10_FI',...
                        'Channel1.Device1.DI.A380WF08AC10_RN',...
                        'Channel1.Device1.AI.A373FA19YP12_PI',...
                        'Channel1.Device1.AI.A373CYA1AG8_O2',...
                        'Channel1.Device1.DM.XINTIAO',...
                        'Channel1.Device1.DS.TONGXUN_OK',...
                        'Channel1.Device1.DM.BISU_MODE_SEL',...
                        'Channel1.Device1.DM.GAOWEN_AM_SEL',...
                        'Channel1.Device1.DM.TOUMEI_AM_SEL',...
                        'Channel1.Device1.DM.WEIMEI_AM_SEL',...
                        'Channel1.Device1.DM.CHENG_AM_SEL',...
                        'Channel1.Device1.AI.A373CYA1AG10_CO',...
                        'Channel1.Device1.AI.A373CYA1AG9_CO',...
                        'Channel1.Device1.AI.A373CYA1AG10_O2'...
                        'Channel1.Device1.MAN.A380WF07_MAN_OUT'...
                        'Channel1.Device1.DI.A373AF09WF10_RN'...
                        'Channel1.Device1.DI.A380WF07AC10_RN',...
                        'Channel1.Device1.AI.A373CYA1AG8_CO',...
                        'Channel1.Device1.MAN.C378FA02_MAN_IN',...
                        'Channel1.Device1.MAN.C378FA02_MAN_OUT',...
                        'Channel1.Device1.AI.CSC380_SI',...
                        'Channel1.Device1.MAN.B374FA06BP_MAN_IN',...
                        'Channel1.Device1.MAN.B374FA06BP_MAN_OUT',...
                        'Channel1.Device1.AI.B374FA06BP_SI',...
                        'Channel1.Device1.DM.TOUPAI_MODE_SEL',...
                        'Channel1.Device1.AI.C377FA08YZ_ZI',...
                        'Channel1.Device1.DS.BISU_MODE_SEL1',...
                        'Channel1.Device1.DS.WEIMEI_MODE_SEL1',...
                        'Channel1.Device1.MAN.A373AF09WF10_MAN_OUT',...
                        'Channel1.Device1.AI.A373AF09WF10_FI',...
                        'Channel1.Device1.AS.C377FA07YZ_PID_SP',...
                        'Channel1.Device1.AI.C377FA07YZ_ZI',...
                        'Channel1.Device1.AS.C377FA08YZ_PID_SP'



});
            connect(daobj);
        end
        t_iohandle = timer('Name','apctimer','TimerFcn', {@on_timer, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器
        start(t_iohandle);%启动定时器
       

        set(handles.connect_state,'String','已连接');
        set(handles.disconnectopc,'BackgroundColor',[0.831 0.816 0.784]);
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
global connect_con daobj pidloop apc_on temp_on  first_cooler_rev_on data tempdata toupai_on zxyCnt zhuansu press
global decomposing_furnace_tempr_on second_cooler_rev_on third_cooler_rev_on xintiao_on shengliao_douti_pidai_on
global ecfw_spcnt

% % % % % wyxxxxxx   2022/11/12
global  hisdatadays hitdata_title
try

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
set(handles.connectopc,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.disconnectopc,'BackgroundColor',[1 0 0]);

set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
%set(handles.yaotou_temp_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);

set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.shengliao_pidai_open,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.xintiao_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.xintiao_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.toupai_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.toupai_close,'BackgroundColor',[0.831 0.816 0.784]);
apc_on=0;
connect_con=0;
temp_on=0;
first_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
xintiao_on = 0;
shengliao_douti_pidai_on = 0;
toupai_on = 0;
zxyCnt = 0;
zhuansu = [];
press = [];
data=zeros(length(tempdata)+50,1);
ecfw_spcnt = -1; %停止控制器时，将该值复位
% % % % % wyxxxxxx   2022/11/12
his_data(tempdata,1,hisdatadays,hitdata_title); %1表示断开中控时，保存当前内存中历史数据
connect_con=0;
data=zeros(length(tempdata)+50,1);
catch
end


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
global decomposing_furnace_tempr_on paramdata man_fjl_time_cnt man_in_fjl
decomposing_furnace_tempr_on =0;
man_fjl_time_cnt = 0;
man_in_fjl = false;
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
paramdata = xml_read('param_set.xml');
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

set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);



% --- Executes on button press in gui_1st_cooler_off_button.
function gui_1st_cooler_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on paramdata zhuansu zxyCnt press man_in_blj man_blj_time_cnt ecfw_spcnt
first_cooler_rev_on=0;
zxyCnt = 0;
zhuansu = [];
press = [];
man_in_blj = false;
man_blj_time_cnt = 0;
ecfw_spcnt = -1; %停止控制器时，将该值复位
set(handles.gui_2nd_chamber_pressure_sp_slider,'Enable','on');
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
%set(handles.yaotou_temp_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
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
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on 
global wmc_press_on shengliao_douti_pidai_on zxyCnt zhuansu press ecfw_spcnt
zhuansu = []; 
press = [];
first_cooler_rev_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
wmc_press_on = 0;
shengliao_douti_pidai_on=0;
zxyCnt = 0;
ecfw_spcnt = -1; %停止控制器时，将该值复位

% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);



set(handles.shengliao_pidai_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.831 0.816 0.784]);

% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[1 0 0]);


set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.831 0.816 0.784]);
% set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);

set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);


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
set(handles.alarmbutton,'BackgroundColor',[0.831 0.816 0.784]);
        
% hObject    handle to alarmbutton (see GCBO)
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
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);

% --- Executes on button press in gui_3rd_cooler_off_button.
function gui_3rd_cooler_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_3rd_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global third_cooler_rev_on paramdata
third_cooler_rev_on=0;
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[1 0 0]);
% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.831 0.816 0.784]);
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
global first_cooler_rev_on data b
if 0 == data(59,b+1) 
    msgbox('未授权，本回路无法投运！');
else
    first_cooler_rev_on=1;
    set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0 1 0]);
    set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);
    set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);
end


% --- Executes on slider movement.
function gui_2nd_chamber_pressure_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.ecfw_sp,'String',num2str(slide_value));
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
global decomposing_furnace_tempr_on man_fjl_time_cnt
global decomposing_furnace_tempr_1_sp ydlBHcnt ydlBHFlag gui_fjlT_sp data b
if 0 == data(60,b+1) 
    msgbox('未授权，本回路无法投运！');
else
    decomposing_furnace_tempr_on = 1;
    man_fjl_time_cnt = 0;
    set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0 1 0]);

    set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.831 0.816 0.784]);
    % set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.831 0.816 0.784]);
    set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);
    decomposing_furnace_tempr_1_sp = gui_fjlT_sp; %将gui界面温度实时更新给内部温度值
    ydlBHcnt = 0; %窑电流饱和计时器复位
    ydlBHFlag = 0;%窑电流饱和标志位复位
end

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
slide_value=a;%将滑块的值赋给value
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
slide_value=a;%将滑块的值赋给value
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
global gui_fjlT_sp decomposing_furnace_tempr_1_sp ydlBHcnt ydlBHFlag
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',num2str(slide_value));

%如果手动调节分解炉温度滑动条后，先将窑电流饱和逻辑复位然后继续判断
gui_fjlT_sp = slide_value;
decomposing_furnace_tempr_1_sp = gui_fjlT_sp; %将gui界面温度实时更新给内部温度值
ydlBHcnt = 0; %窑电流饱和计时器复位
ydlBHFlag = 0;%窑电流饱和标志位复位

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


% --- Executes on button press in shengliao_pidai_open.
function shengliao_pidai_open_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_douti_on shengliao_douti_pidai_on
shengliao_douti_on=0;
shengliao_douti_pidai_on = 1;
set(handles.shengliao_pidai_open,'BackgroundColor',[0 1 0]);
set(handles.shengliao_pidai_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);

% --- Executes on button press in shengliao_pidai_close.
function shengliao_pidai_close_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_douti_on shengliao_zhuanzi_on shengliao_douti_pidai_on
shengliao_douti_pidai_on=0;
set(handles.shengliao_pidai_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.shengliao_pidai_open,'BackgroundColor',[0.831 0.816 0.784]);


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
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.831 0.816 0.784]);

set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);


% --- Executes on button press in xintiao_close.
function xintiao_close_Callback(hObject, eventdata, handles)
% hObject    handle to xintiao_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xintiao_on
xintiao_on = 0;

set(handles.xintiao_open,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.xintiao_close,'BackgroundColor',[0.831 0.816 0.784]);

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
set(handles.xintiao_close,'BackgroundColor',[0.831 0.816 0.784]);


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


% --- Executes on button press in shengliao_pidai_open.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_pidai_open (see GCBO)
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
set(handles.toupai_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.toupai_open,'BackgroundColor',[0.831 0.816 0.784]);

% --- Executes on button press in toupai_open.
function toupai_open_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_on
toupai_on = 1;
set(handles.toupai_open,'BackgroundColor',[0 1 0]);
set(handles.toupai_close,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);


% --- Executes on slider movement.
function slider42_Callback(hObject, eventdata, handles)
% hObject    handle to slider42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global u_fjl_max
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
u_fjl_max = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.text270,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function oil_pressure_threshold2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to oil_pressure_threshold2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pressure_vd
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
pressure_vd = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.pressure_vd,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function oil_pressure_threshold2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oil_pressure_threshold2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function yachuang_mv_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yachuang_mv_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global yachuang_mv
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
yachuang_mv = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.yachuang_mv,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function yachuang_mv_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yachuang_mv_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zhuansu_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_MAX
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
zhuansu_MAX = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.zhuansu_MAX,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function zhuansu_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zhuansu_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_MIN
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
zhuansu_MIN = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.zhuansu_MIN,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function zhuansu_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(21,2:c),t,data(84,2:c));  

% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(2,2:c),t,data(23,2:c));%二次风温
% figure;
% p1 = plotyy(t,data(2,2:c),t,data(8,2:c));%一室风机压力
figure;
p1 = plotyy(t,data(105,2:c),t,data(9,2:c));%风机电流
figure;
p1 = plotyy(t,data(105,2:c),t,data(6,2:c));%供油阀压力

% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure(3);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(15,2:c),t,data(11,2:c));
% legend('三次风温','分解炉温度');
axis(hAx(1),[-inf,inf,920,1020]);
axis(hAx(2),[-inf,inf,820,920]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'三次风温');  % 为X轴加标签 ;
ylabel(hAx(2),'分解炉温度');  % 为X轴加标签 

subplot(3,1,2);
[hAx,hLine1,hLine2] = plotyy(t,data(13,2:c),t,data(17,2:c));
% legend('尾煤量','尾煤风压');
axis manual;
axis(hAx(1),[-inf,inf,2,14]);
axis(hAx(2),[-inf,inf,22,34]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压');  % 为X轴加标签

subplot(3,1,3);
[hAx,hLine1,hLine2] =plotyy(t,data(13,2:c),t,data(11,2:c));
% legend('尾煤量','分解炉出口温度');
axis(hAx(1),[-inf,inf,3,8]);
axis(hAx(2),[-inf,inf,820,920]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量');  % 为X轴加标签
ylabel(hAx(2),'分解炉出口温度');  % 为X轴加标签 

figure(2);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(103,2:c),t,data(11,2:c));
% legend('尾煤风压sp','分解炉温度');
axis(hAx(1),[-inf,inf,22,34]);
axis(hAx(2),[-inf,inf,840,880]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤风压sp');  % 为X轴加标签 ;
ylabel(hAx(2),'分解炉出口温度');

subplot(3,1,2);
plot(t,data(17,2:c),t,data(103,2:c));
% legend('尾煤风压pv','尾煤风压sp');
axis([-inf,inf,22,32]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel('尾煤风压pv');  % 为X轴加标签 ;


subplot(3,1,3);
[hAx,hLine1,hLine2] = plotyy(t,data(73,2:c),t,data(103,2:c));
% legend('尾煤量sp','尾煤风压sp');
axis(hAx(1),[-inf,inf,3,8]);
axis(hAx(2),[-inf,inf,22,34]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量sp');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压sp');  % 为X轴加标签 ;
% figure;
% p1 = plotyy(t,data(13,2:c),t,data(15,2:c));%三次风温

% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
% p1 = plotyy(t,data(26,2:c),t,data(82,2:c));  
p1 = plotyy(t,data(26,2:c),t,data(111,2:c)); %窑电流滤波值
figure;
p2 = plotyy(t,data(26,2:c),t,data(82,2:c));  %头煤压力滤波值

% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(52,2:c),t,data(28,2:c));  


% --- Executes on button press in zhuansu_input.
function zhuansu_input_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',zhuansu_man);


% --- Executes on button press in weimei_input.
function weimei_input_Callback(hObject, eventdata, handles)
% hObject    handle to weimei_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',weimei_man);


% --- Executes during object creation, after setting all properties.
function gui_decomposing_furnace_tempr_off_button_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function toumei_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global toumei_MAX
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
toumei_MAX = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.toumei_MAX,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function toumei_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global toumei_MIN
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
toumei_MIN = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.toumei_MIN,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function toumei_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider53_Callback(hObject, eventdata, handles)
% hObject    handle to slider53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a*10)/10;%将滑块的值赋给value
slide_value=round(a*100)/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.text289,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaodianliu_on paramdata man_ydl_time_cnt man_in_ydl
yaodianliu_on=0;
man_ydl_time_cnt = 0;
man_in_ydl = false;
set(handles.pushbutton62,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.pushbutton61,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]); 
paramdata = xml_read('param_set.xml');

% --- Executes on button press in pushbutton63
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaodianliu_on
yaodianliu_on=1;
set(handles.pushbutton62,'BackgroundColor',[0 1 0]);
set(handles.pushbutton61,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.gui_auto_off,'BackgroundColor',[0.831 0.816 0.784]);


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',ydl_weimei_man);


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_in_fjl man_weimei
man_weimei = str2double(get(handles.gui_decomposing_furnace_coal_sp_display,'String'));
man_weimei = man_weimei + 0.1;
man_in_fjl = 1;


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_in_fjl man_weimei
man_weimei = str2double(get(handles.gui_decomposing_furnace_coal_sp_display,'String'));
man_weimei = man_weimei - 0.1;
man_in_fjl = 1;


% --- Executes on slider movement.
function ecfw_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to ecfw_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ecfw_sp paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
ecfw_sp = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.ecfw_sp,'String',num2str(slide_value));
paramdata.commdata(1).parameter(4).ATTRIBUTE.ecfw_sp=ecfw_sp;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ecfw_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ecfw_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_zhuansu man_in_blj
man_zhuansu = str2double(get(handles.gui_1st_cooler_rev_sp,'String'));
man_zhuansu = man_zhuansu + 0.1;
man_in_blj = 1;


% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_zhuansu man_in_blj
man_zhuansu = str2double(get(handles.gui_1st_cooler_rev_sp,'String'));
man_zhuansu = man_zhuansu - 0.1;
man_in_blj = 1;


% --- Executes on slider movement.
function tidaiwu_x_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tidaiwu_x_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tidaiwu_x paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
tidaiwu_x = slide_value;
set(hObject,'Value',slide_value);%不用管
set(handles.tidaiwu_x,'String',num2str(slide_value));
paramdata.commdata(1).parameter(7).ATTRIBUTE.tidaiwu_x=tidaiwu_x;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tidaiwu_x_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tidaiwu_x_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function duliao_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to duliao_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global paramdata duliao_up
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.duliao_up,'String',num2str(slide_value));
% paramdata.commdata(1).parameter(7).ATTRIBUTE.duliao_up=duliao_up;
% % xml_write('param_set.xml',paramdata);
% wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
% xml_write('param_set.xml',paramdata,'paramdata',wPref);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function duliao_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duliao_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function duliao_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to duliao_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global paramdata duliao_down
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.duliao_down,'String',num2str(slide_value));
% paramdata.commdata(1).parameter(7).ATTRIBUTE.duliao_down=duliao_down;
% xml_write('param_set.xml',paramdata);
% wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
% xml_write('param_set.xml',paramdata,'paramdata',wPref);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function duliao_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duliao_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AF1.
function AF1_Callback(hObject, eventdata, handles)
% hObject    handle to AF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AF
AF = 1;
set(handles.AF1,'BackgroundColor',[0 1 0]);
set(handles.AF2,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.AF3,'BackgroundColor',[0.831 0.816 0.784]);  

% --- Executes on button press in AF2.
function AF2_Callback(hObject, eventdata, handles)
% hObject    handle to AF2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AF
AF = 2;
set(handles.AF2,'BackgroundColor',[0 1 0]);
set(handles.AF1,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.AF3,'BackgroundColor',[0.831 0.816 0.784]);  

% --- Executes on button press in AF3.
function AF3_Callback(hObject, eventdata, handles)
% hObject    handle to AF3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AF
AF = 3;
set(handles.AF3,'BackgroundColor',[0 1 0]);
set(handles.AF2,'BackgroundColor',[0.831 0.816 0.784]);
set(handles.AF1,'BackgroundColor',[0.831 0.816 0.784]);  


% --- Executes during object creation, after setting all properties.
function AF1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AF1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(47,2:c),t,data(117,2:c));
figure;
p1 = plotyy(t,data(61,2:c),t,data(62,2:c));
