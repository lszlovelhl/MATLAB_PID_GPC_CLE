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

% Last Modified by GUIDE v2.5 23-May-2023 16:04:27

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
global connect_con first_time_connect_flag A B P gpc_a gpc_lmd yr workpoint b fjl_man_timer1 fjl_man_timer2 workpoint2
global daobj group  deadzone lastsave alarm_sound_flag alarm_timer alarm_button_clicked
global alarmon alarmrow flag_connect_state  first_time_connect_flag_ontimer paramdata pre_fjl_weimei_sp
global sign_blj sign_fjl sign_toumei sign_douti fjl_man_plus_on fjl_man_minus_on
global fjl_MAX fjl_MIN zhuansu_MAX zhuansu_MIN douti_MAX douti_MIN toumei_MAX toumei_MIN count1 count2 toupai_MAX toupai_MIN
global fjl_upper_limit blj_lower_limit fjl_lower_limit blj_upper_limit gpc_flag gpc_timer
global xialiao_left_lower_limit xialiao_left_upper_limit xialiao_right_upper_limit xialiao_right_lower_limit count_fjl_man
global sign_blj_pump sign_blj4
global fjl_pmg_gaspress  fjl_pmg_gaspress_flag
global SLcangzhong_MAX  SLcangzhong_MIN
global SLvalveR_sp_MIN SLvalveR_sp_MAX SLcangzhong_sp
global fjlumax tmmin tmmax
global CO_flag douti_on yaotou_on gwfjfy_on rev
global toumei_press_flag bli_pump_flag toupai_min toupai_max fjdl_up fjdl_down bljflag
global avgt avgpress avgspeed midspeed changespeed  xialiao_max xialiao_min weipai_max weipai_min
global wmfy_sp fjl_temp_sp yaotou_sp toupai_speed weipai_speed SLvalveR_sp
global fj11dl0 fj11dl1 fj11dl2 fj11dl3 fj11dl4
global kf11 krm_fjdl fj11dl_sp yaotoufy_sp toumei_sp gwfjfy_sp
global f11dl_asc f11dl_desc f11dl_flat

% % % % % wyxxxxxxxxxx 2022/11/12
global his_file_path his_file_row his_data last_path hisdatadays keycount hitdata_title
%% 配置
paramdata = xml_read('param_set.xml');

%% 初值设定
upid=[210 18 24 3 3 3 3 3];
alarm_sound_flag = 0;
alarm_timer = 300;
alarm_button_clicked = 0;
workpoint=[5.779676,888.521180];
workpoint2=[5.779676,888.521180];
count1 = 0;
count2 = 0;
alarmon=1;
alarmrow=[0 0 0];
flag_connect_state=0;
douti_on=0;
yaotou_on=0;
gwfjfy_on=0;
rev=0;
fjl_man_plus_on = 0;
fjl_man_minus_on = 0;
fjl_man_timer1 = 0;
fjl_man_timer2 = 0;
wmfy_sp=25;
fj11dl_sp=180;
fjl_temp_sp=875;
SLcangzhong_sp=27;
yaotoufy_sp=-35;
toumei_sp=15.5;
gwfjfy_sp=-600;
f11dl_asc=0;
f11dl_desc=0;
f11dl_flat=0;
yaotou_sp=16.5;
toupai_speed=30;
weipai_speed=38;
SLvalveR_sp=80;

bljflag=0;
first_time_connect_flag_ontimer=8;
connect_con=0;%连接状态
first_time_connect_flag=1;%首次连接
pre_fjl_weimei_sp = 0;
count_fjl_man = 0;
daobj=opcda(paramdata.commdata(1).parameter(1).ATTRIBUTE.opcID,paramdata.commdata(1).parameter(1).ATTRIBUTE.opcServerName);
daobj.timeout=200;
% daobj=opcda('192.168.0.1','FL.OPCServer.1');%%%Need_to_be_modified
group = addgroup(daobj);  

deadzone=[1,1,1];
lastsave='none';

%kalman filter inti
kf11=[0,0,0,0,1,1];
krm_fjdl=0;
%GPC标志位
gpc_flag = false;
gpc_timer = 0;
fjl_pmg_gaspress_flag =0;
CO_flag =0;
toumei_press_flag =0;
bli_pump_flag = 0;
%标志位置0
sign_blj = 0;
sign_fjl = 0;
sign_toumei = 0;
sign_douti = 0;
sign_blj_pump = 0;
sign_blj4 = 0;
%写入值范围初始化
zhuansu_MAX = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MAX;
zhuansu_MIN = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MIN;
fjl_MAX = paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MAX;
fjl_MIN = paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MIN;
toumei_MAX = paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MAX;
toumei_MIN = paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MIN;
SLvalveR_sp_MAX  = paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MAX;
SLvalveR_sp_MIN = paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MIN;
toupai_max = paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_max;
toupai_min = paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_min;
fjlumax= paramdata.commdata(1).parameter(22).ATTRIBUTE.fjlumax;
avgt = paramdata.commdata(1).parameter(25).ATTRIBUTE.avgt;
changespeed = paramdata.commdata(1).parameter(25).ATTRIBUTE.changespeed;
avgpress = paramdata.commdata(1).parameter(25).ATTRIBUTE.avgpress;
avgspeed = paramdata.commdata(1).parameter(25).ATTRIBUTE.avgspeed;
midspeed = paramdata.commdata(1).parameter(25).ATTRIBUTE.midspeed;
xialiao_max = paramdata.commdata(1).parameter(27).ATTRIBUTE.xialiao_max;
xialiao_min = paramdata.commdata(1).parameter(27).ATTRIBUTE.xialiao_min;
fjdl_up = paramdata.commdata(1).parameter(28).ATTRIBUTE.fjdl_up;
fjdl_down = paramdata.commdata(1).parameter(28).ATTRIBUTE.fjdl_down;
weipai_max=paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_max;
weipai_min=paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_min;
toupai_MAX = 40;
toupai_MIN = 25;
fj11dl0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0;
fj11dl1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1;
fj11dl2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2;
fj11dl3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3;
fj11dl4 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl4;
% 报警初始化
xialiao_left_upper_limit = 910;
xialiao_left_lower_limit = 870;
xialiao_right_upper_limit = -20;
xialiao_right_lower_limit = -100;
blj_upper_limit = 185;
blj_lower_limit = 160;
tmmax=16;
tmmin=12;
%% 配置
%% 设定值初始化 gui_g11_current_sp_slider gui_g11_current_sp_display
%分解炉
set(handles.fjl_temp_sp,'String',875);
set(handles.fjl_temp_sp_slider,'Value',875);
set(handles.fjl_temp_sp_slider,'Max',900,'Min',800);
set(handles.fjl_temp_sp_slider,'SliderStep',[1/100,5/100]);

set(handles.fjl_MAX,'String',fjl_MAX);
set(handles.fjl_MAX_slider,'Value',fjl_MAX);
set(handles.fjl_MAX_slider,'Max',15,'Min',3);
set(handles.fjl_MAX_slider,'SliderStep',[0.1/12,0.5/12]);

set(handles.fjl_MIN,'String',fjl_MIN);
set(handles.fjl_MIN_slider,'Value',fjl_MIN);
set(handles.fjl_MIN_slider,'Max',9,'Min',0);
set(handles.fjl_MIN_slider,'SliderStep',[0.1/9,0.5/9]);

%头煤
set(handles.toumei_sp,'String',15.5);
set(handles.toumei_sp_slider,'Value',15.5);
set(handles.toumei_sp_slider,'Max',30,'Min',10);
set(handles.toumei_sp_slider,'SliderStep',[0.1/20,0.5/20]);
%生料仓重
set(handles.SLcangzhong_sp,'String',27);
set(handles.sl_sp_slider,'Value',27);
set(handles.sl_sp_slider,'Max',40,'Min',0);
set(handles.sl_sp_slider,'SliderStep',[1/40,2/40]);
%窑头负压
set(handles.yaotoufy_sp,'String',-35);
set(handles.yaotou_sp_slider,'Value',-35);
set(handles.yaotou_sp_slider,'Max',-20,'Min',-120);
set(handles.yaotou_sp_slider,'SliderStep',[1/100,5/100]);
%高温风机负压
set(handles.gwfjfy_sp,'String',-600);
set(handles.gwfjfy_slider,'Value',-600);
set(handles.gwfjfy_slider,'Max',-100,'Min',-1200);
set(handles.gwfjfy_slider,'SliderStep',[1/1100,10/1100]);
% Choose default command line output for apcgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% % % % % wyxxxxxxxxxx 2022/11/12
hitdata_title = {'日期时间',...
               '一室篦床压力',...
                '二室篦床压力',...
                '四室篦床压力',...
                '篦冷机1#泵出口压力',...
                '篦冷机2#泵出口压力',...
                '1#传动给定值',...
                '2#传动给定值',...
                '3#传动给定值(2611风机电流设定值)',...
                '4#传动给定值(分解炉温度设定值)',...
                '分解炉出口温度',...
                '五级下料管出料口温度',...
                '分解炉喂煤量给定值',...
                '分解炉喂煤量测量值  fhl_weimei_pv',...
                '三次风温',...
                '分解炉喷煤管气体压力',...
                '三次风负压(生料仓重设定值)',...
                '斗提电流',...
                '喂料转子秤反馈  weiliao_pv',...
                '喂料转子秤设定  weiliao_sp',...
                '生料仓重',...
                '转子秤负荷率(窑头负压设定值)',...
                '电动流量阀左反馈',...
                '电动流量阀右反馈',...
                '电动流量阀左给定',...
                '电动流量阀右给定',...
                '窑头温度(二次风温)',...
                '窑尾烟室温度(尾煤风压设定值)',...
                '窑头转子秤设定  yaotou_sp',...
                '窑头转子秤测量  yaotou_pv',...
                '窑头罩负压',...
                '窑尾烟室负压(头煤压力设定值)',...
                '回转窑主传电流反馈',...
                '回转窑转速测量值',...
                '回转窑转速给定值',...
                '窑头喷煤风管气体压力',...
                'CO浓度反馈值',...
                '2611风机电流',...
                '头排风机',...
                '高温风机出口压力',...
                '尾排风机',...
                '2609风机电流(高温风机出口负压设定值)',...
                '焚烧炉出口烟气至窑尾分解炉烟温'
                }; %#ok<*NASGU>


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
paramdata = xml_read('param_set.xml');
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
global first_time_connect_flag connect_con daobj group tempdata data  itemset tempmv  auth pidloop loopnum b 


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
if (now - license<=7) && (now - license>=-7)&&licensevalid ==087400%-7表示防止现场电脑时间和生成key用的电脑时间不对应，所以扩大范围。有效期为7天
    licensevalid = 087401;
    usedtime1 = usedtime;
    bak.usedtime=encodekey(usedtime1);
    key.licensevalid = encodekey(licensevalid);%使license有效
end
save('key.mat','key');
save('bak.mat','bak');

if ((validtime-usedtime)>=0)&&(licensevalid==087401)%Need_to_be_modified
%     auth=1;

    if usedtime1 ~= usedtime     %%防止授权激活后，拷贝key出去，再次使用
        msgbox('授权有效期到期，请更新授权！');
    else
        auth=1;
    end
else

    msgbox('授权有效期到期，请更新授权！');
end

if auth==1
    if strcmp(daobj.Status,'disconnected')%这里即是判断是否处于连接状态，如果没有处于连接状态的做法
        if first_time_connect_flag==1%当没有处于连接状态时，一定要让这个变量处于0，才能连接。
            first_time_connect_flag=0;
            tempmv=[];
            b=0;
            connect(daobj);
            itemset=additem(group, {'Server0.Group4.PT_501A',...
                'Server0.Group4.PT_501B',...
                'Server0.Group4.PT_501D',...
                'Server0.Group4.PT_881',...
                'Server0.Group4.PT_882',...
                'Server0.Group4.M2603_7CO',...
                'Server0.Group4.M2603_8CO',...
                'Server0.Group4.M2603_9CO',...
                'Server0.Group4.M2603_10CO',...
                'Server0.Group4.TT_426',...
                'Server0.Group4.TT_424',...
                'Server0.Group4.AC2713_AO',...
                'Server0.Group4.AC2713_AI',...
                'Server0.Group4.TT_427',...
                'Server0.Group4.PT_595',...
                'Server0.Group4.PT_413',...
                'Server0.Group4.M2401_1I',...
                'Server0.Group4.AS2402_FK',...
                'Server0.Group4.AS2402_GD',...
                'Server0.Group4.WT_444',...
                'Server0.Group4.AS2402_FH',...
                'Server0.Group4.ZIK441_ZT',...
                'Server0.Group4.ZIK442_ZT',...
                'Server0.Group4.ZIK441_CO',...
                'Server0.Group4.ZIK442_CO',...
                'Server0.Group4.TT_505',...
                'Server0.Group4.TT_439',...
                'Server0.Group4.AC2712_AO',...
                'Server0.Group4.AC2712_AI',...
                'Server0.Group4.PT_504',...
                'Server0.Group4.PT_438',...
                'Server0.Group4.AC2501_I',...
                'Server0.Group4.AC2501_ZT1',...
                'Server0.Group4.AC2501_CO1',...
                'Server0.Group4.PT_594',...
                'Server0.Group4.PT_453',...
                'Server0.Group4.M2611_I',...
                'Server0.Group4.M2622_CO',...
                'Server0.Group4.PT_1234',...
                'Server0.Group4.M2220_CO',...
                'Server0.Group4.M2609_I',...
                'Server0.Group4.TT_27'
                });
            connect(daobj);

            tempdata=read(group);
            data=zeros(length(tempdata)+50,1);%初始化data  Need_to_be_modified
            data(1:6,1)=fix(clock);% fix是化小数为整数，方法是舍去小数部分，clock是6x1的向量，其元素是日期（年月日时分秒），且第一列的元素全为日期，向量可以拓展，即列数可以增加。除第一列外，每列元素均为84+12个PID的值
           %% prepare pidloop and pid parameter
            loopnum=1;%稳压仓
            pidloop=[ 0 0 0 0 0 0 0 0 0 0 0 0 0 ;%sp
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%pv
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%mv
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e0
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e1
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e2
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%kp  Need_to_be_modified
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%ti  Need_to_be_modified
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%td  
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%手动为0 自动为1
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%upperlimit  Need_to_be_modified
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%lowerlimit  Need_to_be_modified
                      0 0 0 0 0 0 0 0 0 0 0 0 0 ;%deadzone  Need_to_be_modified
                      ];
        else
            delete(itemset);
            connect(daobj);
            itemset=additem(group, {'Server0.Group4.PT_501A',...
                'Server0.Group4.PT_501B',...
                'Server0.Group4.PT_501D',...
                'Server0.Group4.PT_881',...
                'Server0.Group4.PT_882',...
                'Server0.Group4.M2603_7CO',...
                'Server0.Group4.M2603_8CO',...
                'Server0.Group4.M2603_9CO',...
                'Server0.Group4.M2603_10CO',...
                'Server0.Group4.TT_426',...
                'Server0.Group4.TT_424',...
                'Server0.Group4.AC2713_AO',...
                'Server0.Group4.AC2713_AI',...
                'Server0.Group4.TT_427',...
                'Server0.Group4.PT_595',...
                'Server0.Group4.PT_413',...
                'Server0.Group4.M2401_1I',...
                'Server0.Group4.AS2402_FK',...
                'Server0.Group4.AS2402_GD',...
                'Server0.Group4.WT_444',...
                'Server0.Group4.AS2402_FH',...
                'Server0.Group4.ZIK441_ZT',...
                'Server0.Group4.ZIK442_ZT',...
                'Server0.Group4.ZIK441_CO',...
                'Server0.Group4.ZIK442_CO',...
                'Server0.Group4.TT_505',...
                'Server0.Group4.TT_439',...
                'Server0.Group4.AC2712_AO',...
                'Server0.Group4.AC2712_AI',...
                'Server0.Group4.PT_504',...
                'Server0.Group4.PT_438',...
                'Server0.Group4.AC2501_I',...
                'Server0.Group4.AC2501_ZT1',...
                'Server0.Group4.AC2501_CO1',...
                'Server0.Group4.PT_594',...
                'Server0.Group4.PT_453',...
                'Server0.Group4.M2611_I',...
                'Server0.Group4.M2622_CO',...
                'Server0.Group4.PT_1234',...
                'Server0.Group4.M2220_CO',...
                'Server0.Group4.M2609_I',...
                'Server0.Group4.TT_27'
                });

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
global  connect_con daobj pidloop apc_on data tempdata itemset
global sign_blj sign_fjl sign_toumei sign_douti sign_blj_pump sign_blj4
global   yaotou_on douti_on gwfjfy_on rev bljflag

% % % % % wyxxxxxxxxxx 2022/11/12
global  hisdatadays hitdata_title
try

sign_blj = 0;
sign_fjl = 0;
bljflag=0;
sign_toumei = 0;
gwfjfy_on=0;
sign_douti = 0;
sign_blj_pump = 0;
sign_blj4 = 0;
rev=0;
yaotou_on=0;
douti_on=0;

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

% % % % % wyxxxxxxxxxx 2022/11/12
his_data(tempdata,1,hisdatadays,hitdata_title); %1表示断开中控时，保存当前内存中历史数据
connect_con=0;
data=zeros(length(tempdata)+50,1);
catch
end

set(handles.blj_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.blj_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.fjl_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.fjl_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toumei_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toumei_off,'BackgroundColor',[0.941 0.941 0.941]);


set(handles.sl_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.sl_down,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yaotou_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yaotou_down,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gwfjfy_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gwfjfy_down,'BackgroundColor',[0.941 0.941 0.941]);
data=zeros(length(tempdata)+50,1);

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



% --- Executes on button press in gui_auto_off.
function gui_auto_off_Callback(hObject, eventdata, handles)
% hObject    handle to gui_auto_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_blj sign_fjl sign_toumei sign_douti sign_blj_pump sign_blj4
global  bljflag
global   yaotou_on  gwfjfy_on rev
sign_blj = 0; 
sign_fjl = 0;
yaotou_on=0;
rev=0;
gwfjfy_on = 0;
sign_toumei = 0;
sign_douti = 0;
sign_blj_pump = 0;
bljflag=0;
sign_blj4 = 0;
set(handles.blj_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.blj_off,'BackgroundColor',[1 0 0]);

set(handles.fjl_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.fjl_off,'BackgroundColor',[1 0 0]);

set(handles.sl_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.sl_down,'BackgroundColor',[1 0 0]);

set(handles.gwfjfy_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gwfjfy_down,'BackgroundColor',[1 0 0]);

set(handles.toumei_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toumei_off,'BackgroundColor',[1 0 0]);

set(handles.yaotou_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yaotou_down,'BackgroundColor',[1 0 0]);


% --- Executes on button press in alarmbutton.
function alarmbutton_Callback(hObject, eventdata, handles)
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS pophandles
global alarm_sound_flag alarm_button_clicked b data
% open('alarmset.fig');

% run('alarmset');
set(0,'CurrentFigure',alarmset);
pophandles = guihandles;




set(pophandles.figure1, 'WindowStyle', 'modal');
alarm_sound_flag = 0;
alarm_button_clicked = 1;
set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);
        
% hObject    handle to alarmbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',about);



% --------------------------------------------------------------------
function adjust_Callback(hObject, eventdata, handles)
% hObject    handle to adjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',adjust);


% --- Executes on button press in blj_on.
function blj_on_Callback(hObject, eventdata, handles)
% hObject    handle to blj_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_blj sign_blj_pump
sign_blj = 1;
sign_blj_pump = 0;
set(handles.blj_on,'BackgroundColor',[0 1 0]);
% set(handles.blj_pump_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.blj_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in blj_off.
function blj_off_Callback(hObject, eventdata, handles)
% hObject    handle to blj_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_blj
sign_blj = 0;
% sign_blj_pump = 0;
set(handles.blj_on,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.blj_pump_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.blj_off,'BackgroundColor',[1 0 0]);


% --- Executes on slider movement.
function fjl_temp_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_temp_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.fjl_temp_sp,'String',num2str(a));

% --- Executes during object creation, after setting all properties.
function fjl_temp_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_temp_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in fjl_on.
function fjl_on_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_fjl
sign_fjl = 1;
set(handles.fjl_on,'BackgroundColor',[0 1 0]);
set(handles.fjl_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in fjl_off.
function fjl_off_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_fjl
sign_fjl = 0;
set(handles.fjl_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.fjl_off,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function sl_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to sl_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.SLcangzhong_sp,'String',num2str(a));

% --- Executes during object creation, after setting all properties.
function sl_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sl_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in sl_open.
function sl_open_Callback(hObject, eventdata, handles)
% hObject    handle to sl_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_douti
sign_douti = 1;
set(handles.sl_open,'BackgroundColor',[0 1 0]);
set(handles.sl_down,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in sl_down.
function sl_down_Callback(hObject, eventdata, handles)
% hObject    handle to sl_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_douti
sign_douti = 0;
set(handles.sl_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.sl_down,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function toumei_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.toumei_sp,'String',num2str(a));

% --- Executes during object creation, after setting all properties.
function toumei_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in toumei_on.
function toumei_on_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_toumei
sign_toumei = 1;
set(handles.toumei_on,'BackgroundColor',[0 1 0]);
set(handles.toumei_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in toumei_off.
function toumei_off_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_toumei
sign_toumei = 0;
set(handles.toumei_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toumei_off,'BackgroundColor',[1 0 0]);

function param_setting_Callback(hObject, eventdata, handles)
% hObject    handle to param_setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramhandles
global fjl_MAX fjl_MIN zhuansu_MAX zhuansu_MIN douti_MAX douti_MIN
set(0,'CurrentFigure',param_setting);
paramhandles = guihandles;


zhuansu_MAX=str2double(get(paramhandles.zhuansu_MAX,'String'));
zhuansu_MIN=str2double(get(paramhandles.zhuansu_MIN,'String'));
douti_MAX=str2double(get(paramhandles.SLvalveR_sp_MAX,'String'));
douti_MIN=str2double(get(paramhandles.SLvalveR_sp_MIN,'String'));


% --- Executes on button press in blj_figure.
function blj_figure_Callback(hObject, eventdata, handles)
% hObject    handle to blj_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in fjl_figure.
function fjl_figure_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shengliao_figure.
function shengliao_figure_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(45,2:c),t,data(56,2:c));     %生料仓重
% set(p1(1),'ylim',[90,100],'ytick',[90:1:100]);
% set(p1(2),'ylim',[90,100],'ytick',[90:1:100]);

% --- Executes on button press in toumei_figure.
function toumei_figure_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon b
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(75,2:c),t,data(58,2:c));     %头煤压力
% set(p1(1),'ylim',[(data(sizecon+7,b+1)-1),(data(sizecon+7,b+1)+1)],'ytick',[(data(sizecon+7,b+1)-1):0.2:(data(sizecon+7,b+1)+1)]);
% set(p1(2),'ylim',[(data(sizecon+7,b+1)-1),(data(sizecon+7,b+1)+1)],'ytick',[(data(sizecon+7,b+1)-1):0.2:(data(sizecon+7,b+1)+1)]);


% --- Executes on button press in fjl_man_plus.
function fjl_man_plus_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_man_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weimei_man_plus_on count_fjl_man weimei_man_minus_on
weimei_man_minus_on = 0;
if (weimei_man_plus_on < 6)
    weimei_man_plus_on = weimei_man_plus_on + 1;
end
count_fjl_man = 30;
% --- Executes on button press in fjl_man_minus.
function fjl_man_minus_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_man_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weimei_man_minus_on count_fjl_man weimei_man_plus_on
weimei_man_plus_on = 0;
if (weimei_man_minus_on < 6)
    weimei_man_minus_on = weimei_man_minus_on + 1;
end
count_fjl_man = 30;


% --- Executes on slider movement.
function blj_press1_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_press1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.blj_press1_sp,'String',num2str(a));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_press1_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_press1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaotou_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.yaotoufy_sp,'String',num2str(a));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in yaotou_open.
function yaotou_open_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaotou_on
yaotou_on = 1;
set(handles.yaotou_open,'BackgroundColor',[0 1 0]);
set(handles.yaotou_down,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in yaotou_down.
function yaotou_down_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaotou_on
yaotou_on = 0;
set(handles.yaotou_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yaotou_down,'BackgroundColor',[1 0 0]);


% --- Executes during object creation, after setting all properties.
function douti_on_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function douti_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.douti_sp,'String',num2str(a));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function douti_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function gwfjfy_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfjfy_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a/50)*50;%将滑块的值赋给value
set(hObject,'Value',a);%不用管
set(handles.gwfjfy_sp,'String',num2str(a));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfjfy_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfjfy_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gwfjfy_open.
function gwfjfy_open_Callback(hObject, eventdata, handles)
% hObject    handle to gwfjfy_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfjfy_on
gwfjfy_on = 1;
set(handles.gwfjfy_open,'BackgroundColor',[0 1 0]);
set(handles.gwfjfy_down,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gwfjfy_down.
function gwfjfy_down_Callback(hObject, eventdata, handles)
% hObject    handle to gwfjfy_down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfjfy_on
gwfjfy_on = 0;
set(handles.gwfjfy_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gwfjfy_down,'BackgroundColor',[1 0 0]);


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


% --- Executes on button press in man_mei_pushbutton.
function man_mei_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to man_mei_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_fjl_coal man_fjl_time_cnt man_in_fjl
man_fjl_coal = str2double(get(handles.man_fjl_coal,'String'));
man_in_fjl = true;
man_fjl_time_cnt = 0;


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


% --- Executes on button press in man_speed_pushbutton.
function man_speed_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to man_speed_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_blj_speed man_blj_time_cnt man_in_blj
man_blj_speed = str2double(get(handles.man_blj_speed,'String'));
man_in_blj = true;
man_blj_time_cnt = 0;


% --- Executes during object creation, after setting all properties.


% --- Executes on slider movement.
function fjl_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_MAX paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fjl_MAX,'String',num2str(slide_value));
fjl_MAX=str2double(get(handles.fjl_MAX,'String'));
paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MAX=fjl_MAX;
xml_write('param_set.xml',paramdata);

% --- Executes during object creation, after setting all properties.
function fjl_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_MIN paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fjl_MIN,'String',num2str(slide_value));
fjl_MIN=str2double(get(handles.fjl_MIN,'String'));
paramdata.commdata(1).parameter(15).ATTRIBUTE.fjl_MIN=fjl_MIN;
xml_write('param_set.xml',paramdata);

% --- Executes during object creation, after setting all properties.
function fjl_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure(3);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(14,2:c),t,data(10,2:c));
% legend('三次风温','分解炉温度');
axis(hAx(1),[-inf,inf,870,1050]);
axis(hAx(2),[-inf,inf,860,890]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'三次风温');  % 为X轴加标签 ;
ylabel(hAx(2),'分解炉温度');  % 为X轴加标签 

subplot(3,1,2);
[hAx,hLine1,hLine2] = plotyy(t,data(12,2:c),t,data(15,2:c));
% legend('尾煤量','尾煤风压');
axis manual;
axis(hAx(1),[-inf,inf,7,12]);
axis(hAx(2),[-inf,inf,27,34]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压');  % 为X轴加标签

subplot(3,1,3);
[hAx,hLine1,hLine2] =plotyy(t,data(12,2:c),t,data(10,2:c));
% legend('尾煤量','分解炉出口温度');
axis(hAx(1),[-inf,inf,7.5,11.5]);
axis(hAx(2),[-inf,inf,860,890]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量');  % 为X轴加标签
ylabel(hAx(2),'分解炉出口温度');  % 为X轴加标签 

figure(2);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(46,2:c),t,data(10,2:c));
% legend('尾煤风压sp','分解炉温度');
axis(hAx(1),[-inf,inf,27,34]);
axis(hAx(2),[-inf,inf,860,890]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤风压sp');  % 为X轴加标签 ;
ylabel(hAx(2),'分解炉出口温度');

subplot(3,1,2);
plot(t,data(15,2:c),t,data(46,2:c));
% legend('尾煤风压pv','尾煤风压sp');
axis([-inf,inf,27,34]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel('尾煤风压pv');  % 为X轴加标签 ;


subplot(3,1,3);
[hAx,hLine1,hLine2] = plotyy(t,data(67,2:c),t,data(46,2:c));
% legend('尾煤量sp','尾煤风压sp');
axis(hAx(1),[-inf,inf,7.5,11.5]);
axis(hAx(2),[-inf,inf,27,34]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量sp');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压sp');  % 为X轴加标签 ;

% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data b sizecon
[~,c]=size(data);
t=2:c;
figure;
p2 = plotyy(t,data(69,2:c),t,data(1,2:c));     %篦冷机
figure;
p1 = plotyy(t,data(69,2:c),t,data(26,2:c));%2609卡尔曼电流滤波
figure;
p3 = plotyy(t,data(69,2:c),t,data(65,2:c));%均值电流滤波

% --- Executes during object creation, after setting all properties.
function fjdl_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjdl_sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in GW_fj_figure.
function GW_fj_figure_Callback(hObject, eventdata, handles)
% hObject    handle to GW_fj_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(39,2:c),t,data(49,2:c));     %高温风机

% --- Executes on button press in YT_fy_figure.
function YT_fy_figure_Callback(hObject, eventdata, handles)
% hObject    handle to YT_fy_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(48,2:c),t,data(30,2:c));     %窑头负压
