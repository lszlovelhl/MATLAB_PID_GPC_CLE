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

% Last Modified by GUIDE v2.5 13-Aug-2022 17:15:06

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
global daobj group  deadzone lastsave  count_pressue  coaljunhua_sign gaowenfengji_rati
global alarmon alarmrow flag_connect_state fjl_set first_time_connect_flag_ontimer 
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on 
global second_plate_pressure_max_pv third_plate_pressure_max_pv upid coalklin_on paramdata
global B2 A2 workpoint2 gpc_a2 gpc_lmd2  shengliao_junliao_on wei_toucaol_rati gaowenfengji_compensate
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global decomposing_furnace_tempr_2_upperMax decomposing_furnace_tempr_2_upperMin decomposing_furnace_tempr_2_lowerMax decomposing_furnace_tempr_2_lowerMin wlc_weight_upperlimitS wlc_weight_lowerlimitS
global sign_bichuang snd_chamber_pressure_upperMax snd_chamber_pressure_upperMin snd_chamber_pressure_lowerMax snd_chamber_pressure_lowerMin alarm_sound_flag alarm_timer alarm_button_clicked 
global blj_freqMAX blj_freqMIN yaotou_coalMAX yaotou_coalMIN yaowei_coalMAX yaowei_coalMIN NH3_MAX NH3_MIN
global sign_NH3 NOX_upperlimits NOX_lowerlimits workpoint3 A3 B3 NH3_limit NOX_limit sign_NH3_ctrl
global first data1 junhua_MAX junhua_MIN  sign_furnace_pressure gaowenfengji_MAX gaowenfengji_MIN
global B4 A4 workpoint4 gpc_a4 gpc_lmd4 ecfw_on
global blj_level_one level_one_sp blj_level_two level_two_sp blj_level_three level_three_sp recover_sp recover_flag
global blj_low_pressure_sp slqkxs scfqkxs
global blj_low_time_cnt blj_low_pressure blj_high_speed blj_speed_stop_flag
global temp_blj_alpha1 temp_blj_beta1 man_in_fjl
global temp_blj_alpha2 temp_blj_beta2  blj_mode  man_in_blj fjl_mode
global ydl_mode pressure_vd yachuang_mv zhuansu_mid man_in_ydl ysphfjdl
global u_write u_decomposing_furnace_tempr_write u_decomposing_furnace_tempr
global kypcnt kypcntflag ecfw_sp
global ydlDBH ydlUBH ydlBHcnt ydlBHFlag gui_fjlT_sp decomposing_furnace_tempr_1_sp
global ecfw_spcnt ecfw_cnt_inner_sp
%% 配置
paramdata = xml_read('param_set.xml');
blj_level_one = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_level_one;
level_one_sp = paramdata.commdata(1).parameter(12).ATTRIBUTE.level_one_sp ;
blj_level_two = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_level_two;
level_two_sp = paramdata.commdata(1).parameter(12).ATTRIBUTE.level_two_sp ;
blj_level_three = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_level_three;
level_three_sp = paramdata.commdata(1).parameter(12).ATTRIBUTE.level_three_sp ;
recover_sp = paramdata.commdata(1).parameter(12).ATTRIBUTE.recover_sp ;
blj_low_pressure_sp = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_low_pressure_sp;

decomposing_furnace_tempr_2_upperMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMax;
decomposing_furnace_tempr_2_upperMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_upperMin;
decomposing_furnace_tempr_2_lowerMax=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMax;
decomposing_furnace_tempr_2_lowerMin=paramdata.commdata(1).parameter(2).ATTRIBUTE.decomposing_furnace_tempr_2_lowerMin;
snd_chamber_pressure_upperMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMax;
snd_chamber_pressure_upperMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_upperMin;
snd_chamber_pressure_lowerMax=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMax;
snd_chamber_pressure_lowerMin=paramdata.commdata(1).parameter(3).ATTRIBUTE.snd_chamber_pressure_lowerMin;

blj_freqMAX=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.uplimit;
blj_freqMIN=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.downlimit;
pressure_vd=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.pressure_vd;
ysphfjdl=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ysphfjdl;
yachuang_mv=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.yachuang_mv;
zhuansu_mid=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.zhuansu_mid;
ecfw_sp=paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ecfwsp;
ecfw_cnt_inner_sp = 0; %二次风温内部设定值

yaotou_coalMAX=paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.uplimit;
yaotou_coalMIN=paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.downlimit;

yaowei_coalMAX=paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.uplimit;
yaowei_coalMIN=paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.downlimit;
slqkxs = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.slqkxs;
scfqkxs = paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.scfqkxs;

NH3_MAX = paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.uplimit;
NH3_MIN=paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.downlimit;

junhua_MAX = paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.uplimit;
junhua_MIN=paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.downlimit;
gaowenfengji_MAX = paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.uplimit;
gaowenfengji_MIN=paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.downlimit;
gaowenfengji_compensate=paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.compensate;   
gaowenfengji_rati=paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.rati; 

temp_blj_alpha1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1;   % 大偏差
temp_blj_beta1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1;
temp_blj_alpha2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2;   % 小偏差
temp_blj_beta2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2;

decomposing_furnace_tempr_2_upperlimitS=(decomposing_furnace_tempr_2_upperMax+decomposing_furnace_tempr_2_upperMin)/2;
decomposing_furnace_tempr_2_lowerlimitS=(decomposing_furnace_tempr_2_lowerMax+decomposing_furnace_tempr_2_lowerMin)/2;
snd_chamber_pressure_upperlimitS=8;
snd_chamber_pressure_lowerlimitS=5.5;
wlc_weight_upperlimitS=70;
wlc_weight_lowerlimitS=40;
NOX_upperlimits = 75;
NOX_lowerlimits = 15;

%% 初值设定
upid=[12 18 24 10 10 10 10 20];
u_write=5.4;
u_decomposing_furnace_tempr_write=5.4;
u_decomposing_furnace_tempr=5.4;
man_in_fjl = false;
fjl_mode = false;
ydl_mode = false;
blj_speed_stop_flag = false;
recover_flag = 0;
blj_low_time_cnt = 1;
blj_low_pressure = 0;
blj_high_speed = 0;
second_plate_pressure_max_pv=70; 
third_plate_pressure_max_pv=70;
alarm_sound_flag = 0;
alarm_timer = 120;
alarm_button_clicked = 0;
B2=[0.1729];
A2=[-0.9994,1];
workpoint2=[8.5549,861.7647];
gpc_a2=0.99;
gpc_lmd2=80;
A=[-0.9931,1];
B=[0.2614];
P=[0.01,0.01;0.01,0.01];
gpc_a=0.99;
gpc_lmd=80;
yr=860;
workpoint=[8.5549,873.5283];
alarmon=1;
alarmrow=[0 0 0];
flag_connect_state=0;
blj_set=[66,175,90,15.8,6.8,163,9.2];
fjl_set=[873,860];
wei_toucaol_rati=0;
first_time_connect_flag_ontimer=8;
connect_con=0;%连接状态
first_time_connect_flag=1;%首次连接
count_pressue=0;
shengliao_junliao_on=0;
coaljunhua_sign=0;
sign_furnace_pressure=0;
ecfw_on = 0;
blj_mode  = false;
man_in_blj = false;
man_in_ydl = false;
% yachuang_mv = 1;
% pressure_vd = 7.8;
% zhuansu_mid = 23;
%篦冷机 gpc
B4=[-0.0013];% -0.0023
A4=[-0.9830,1];
workpoint4=[25.3974,7.5095]; %[27.3974,7.3095]
gpc_a4=temp_blj_alpha1;
gpc_lmd4=temp_blj_beta1;

first=1;
data1=[];
%A=[-0.9772 1];%%%Need_to_be_modified
%B=1.3402;%%%Need_to_be_modified
%P=[0.01,0.01;0.01,0.01];
%gpc_a=0.1;
%gpc_lmd=5; 
%yr=[0,0,0];
%workpoint=[0.2922,8.7751];
first_cooler_rev_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
decomposing_furnace_tempr_on=0; 
coalklin_on=0; 
%upid_old=[0,0,0];

deadzone=[1,1,1];
sign_bichuang=0;
sign_NH3=0;
sign_NH3_ctrl=0;

NH3_limit=490;
NOX_limit=28;
lastsave='none';

kypcnt=0;
kypcntflag=0;

ydlBHcnt = 0; %判断上下限饱和等待时间
ydlUBH = 0; %上限饱和判断，用作分解炉提温1度
ydlDBH = 0; %下限饱和判断，用作分解炉降温1度
ydlBHFlag = 0;%窑电流饱和标志位
gui_fjlT_sp = 870; %分解炉温度设定值
decomposing_furnace_tempr_1_sp = gui_fjlT_sp;
ecfw_spcnt = -1; %设定值计时，-1表示第一次开启控制按钮

daobj=opcda(paramdata.commdata(1).parameter(1).ATTRIBUTE.opcID,paramdata.commdata(1).parameter(1).ATTRIBUTE.opcServerName);

% daobj=opcda('192.168.0.1','FL.OPCServer.1');%%%Need_to_be_modified
group = addgroup(daobj); 

%% 设定值初始化
% 头煤压力
 blj_control4=blj_set(4);
 set(handles.gui_klin_head_tempr_sp_display,'String',blj_control4);
 set(handles.gui_klin_head_tempr_sp_slider,'Value',blj_control4);
 set(handles.gui_klin_head_tempr_sp_slider,'Max',30,'Min',0);
 set(handles.gui_klin_head_tempr_sp_slider,'SliderStep',[0.1/30,0.5/30]);

%  高温风机
set(handles.frequency_pressure_sp,'String',-8.2);
set(handles.frequency_pressure_sp_slider,'Value',-8.2);
set(handles.frequency_pressure_sp_slider,'Max',-6,'Min',-10);
set(handles.frequency_pressure_sp_slider,'SliderStep',[0.1/4,0.5/4]);

% 下料量
xialiao_sp=blj_set(6);
set(handles.chongban_flow_sp,'String',xialiao_sp);
set(handles.chongban_flow_sp_slider,'Value',xialiao_sp);
set(handles.chongban_flow_sp_slider,'Max',190,'Min',110);
set(handles.chongban_flow_sp_slider,'SliderStep',[1/80,5/80]);

% 分解炉出口温度
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',gui_fjlT_sp);
set(handles.gui_decomposing_furnace_tempr_1_sp_slider,'Value',gui_fjlT_sp);
set(handles.gui_decomposing_furnace_tempr_1_sp_slider,'Max',gui_fjlT_sp+30,'Min',gui_fjlT_sp-50);
set(handles.gui_decomposing_furnace_tempr_1_sp_slider,'SliderStep',[1/80,10/80]);

%氨水
set(handles.NOX_SP,'String',71);
set(handles.NOX_SP_Slider,'Value',70); 
set(handles.NOX_SP_Slider,'Max',80,'Min',20);
set(handles.NOX_SP_Slider,'SliderStep',[0.1/60,1/60]);

% % % %二次风温
% % % set(handles.ecfw_sp,'String',1200);
% % % set(handles.ecfw_sp_slider,'Value',1200); 
% % % set(handles.ecfw_sp_slider,'Max',1250,'Min',1100);
% % % set(handles.ecfw_sp_slider,'SliderStep',[1/150,5/150]);

% Choose default command line output for apcgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
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
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on coalklin_on ecfw_on 
global first  
first=1;

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
            %additem初始化参数  Need_to_be_modified
            %connect to opcserver,init data 进行连接
            connect_con=0;
            first_cooler_rev_on=0;
            second_cooler_rev_on=0;
            third_cooler_rev_on=0;
            decomposing_furnace_tempr_on =0;
            coalklin_on=0;       
            ecfw_on = 0;
            set(handles.disconnectopc,'BackgroundColor',[1 0 0]);

            set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.shengliao_junhua_open,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.shengliao_junhua_close,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
            % set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
            set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.94 0.94 0.94]);
            
            connect(daobj);
            itemset=additem(group, {  'OS_Server_M::PT518/PT518.Value',...
            'OS_Server_M::2606M1VSD/2606M1VSD-G.ManSP',...
            'OS_Server_M::2606M1VSD/2606M1VSD-K.Value',...
            'OS_Server_M::PT519/PT519.Value',...
            'OS_Server_M::2608M/2608M-C.Value',...
            'OS_Server_M::2611VSD/2611M-C.Value',...
            'OS_Server_M::2612VSD/2612MRQD-C.Value',...
            'OS_Server_M::2109M1/2109MVSD-G.ManSP',...
            'OS_Server_M::PT421/PT421.Percent',...
            'OS_Server_M::2420AC/NH3-K.Percent',...
            'OS_Server_M::TT401/TT401.Value',...
            'OS_Server_M::TT418/TT418.Value',...
            'OS_Server_M::2712AC/2712AC-G.ManSP',...
            'OS_Server_M::2712AC/2712AC-K.Value',...
            'OS_Server_M::TT407/TT407.Value',...
            'OS_Server_M::TT511/TT511.Value',...
            'OS_Server_M::TT404/TT404.Value',...
            'OS_Server_M::2713AC/2713AC-G.ManSP',...
            'OS_Server_M::2713AC/2713AC-K2.Value',...
            'OS_Server_M::PdT513/PdT513.Value',...
            'OS_Server_M::PT403/PT403.Value',...
            'OS_Server_M::2501AD/2501AD-C.Value',...
            'OS_Server_M::2501AD/2501AD-K.Value',...
            'OS_Server_M::2501AD/2501AD-G.ManSP',...
            'OS_Server_M::2401M1/2401M1-C.Value',...
            'OS_Server_M::ZT370/ZT370-K.Value',...
            'OS_Server_M::ZT370/ZT370-G.ManSP',...
            'OS_Server_M::2340AC/2340-K.Value',...
            'OS_Server_M::2340AC/2340-G.ManSP',...
            'OS_Server_M::PT632/PT632.Value',...
            'OS_Server_M::2410M1/2410MVSD-G.ManSP',...
            'OS_Server_M::2410M1/2410MVSD-K.Value',...
            'OS_Server_M::PT382/PT382.Value',...
            'OS_Server_M::YWHB/ywhb-o2.Value',...
            'OS_Server_M::2712AT/WT2712-K.Value',...
            'OS_Server_M::WT367/PID.SV',...
            'OS_Server_M::WT367/WT367.Value',...
            'OS_Server_M::YWHB/YWHB-NO2.Value',...
            'OS_Server_M::2420AC/S1PU-HN3-G.ManSP',...
            'OS_Server_M::2420AC/S1MDUFNH3_PV.Value'
            });
            connect(daobj);
            tempdata=read(group);

            data=zeros(length(tempdata)+50,1);%初始化data  Need_to_be_modified
            data(1:6,1)=fix(clock);% fix是化小数为整数，方法是舍去小数部分，clock是6x1的向量，其元素是日期（年月日时分秒），且第一列的元素全为日期，向量可以拓展，即列数可以增加。除第一列外，每列元素均为84+12个PID的值
            %% prepare pidloop and pid parameter
            loopnum=1;% 一加煤气 二加煤气 均热煤气 一加空气 二加空气 均热空气 一加空烟 二加空烟 均热空烟 一加煤烟 二加煤烟 均热煤烟 空气总管压力

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
            itemset=additem(group, {   'OS_Server_M::PT518/PT518.Value',...
            'OS_Server_M::2606M1VSD/2606M1VSD-G.ManSP',...
            'OS_Server_M::2606M1VSD/2606M1VSD-K.Value',...
            'OS_Server_M::PT519/PT519.Value',...
            'OS_Server_M::2608M/2608M-C.Value',...
            'OS_Server_M::2611VSD/2611M-C.Value',...
            'OS_Server_M::2612VSD/2612MRQD-C.Value',...
            'OS_Server_M::2109M1/2109MVSD-G.ManSP',...
            'OS_Server_M::PT421/PT421.Percent',...
            'OS_Server_M::2420AC/NH3-K.Percent',...
            'OS_Server_M::TT401/TT401.Value',...
            'OS_Server_M::TT418/TT418.Value',...
            'OS_Server_M::2712AC/2712AC-G.ManSP',...
            'OS_Server_M::2712AC/2712AC-K.Value',...
            'OS_Server_M::TT407/TT407.Value',...
            'OS_Server_M::TT511/TT511.Value',...
            'OS_Server_M::TT404/TT404.Value',...
            'OS_Server_M::2713AC/2713AC-G.ManSP',...
            'OS_Server_M::2713AC/2713AC-K2.Value',...
            'OS_Server_M::PdT513/PdT513.Value',...
            'OS_Server_M::PT403/PT403.Value',...
            'OS_Server_M::2501AD/2501AD-C.Value',...
            'OS_Server_M::2501AD/2501AD-K.Value',...
            'OS_Server_M::2501AD/2501AD-G.ManSP',...
            'OS_Server_M::2401M1/2401M1-C.Value',...
            'OS_Server_M::ZT370/ZT370-K.Value',...
            'OS_Server_M::ZT370/ZT370-G.ManSP',...
            'OS_Server_M::2340AC/2340-K.Value',...
            'OS_Server_M::2340AC/2340-G.ManSP',...
            'OS_Server_M::PT632/PT632.Value',...
            'OS_Server_M::2410M1/2410MVSD-G.ManSP',...
            'OS_Server_M::2410M1/2410MVSD-K.Value',...
            'OS_Server_M::PT382/PT382.Value',...
            'OS_Server_M::YWHB/ywhb-o2.Value',...
            'OS_Server_M::2712AT/WT2712-K.Value',...
            'OS_Server_M::WT367/PID.SV',...
            'OS_Server_M::WT367/WT367.Value',...
            'OS_Server_M::YWHB/YWHB-NO2.Value',...
            'OS_Server_M::2420AC/S1PU-HN3-G.ManSP',...
            'OS_Server_M::2420AC/S1MDUFNH3_PV.Value'
            });
            connect(daobj);
        end
        t_iohandle = timer('Name','apctimer','TimerFcn', {@on_timer, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器 
        start(t_iohandle);%启动定时器
        set(handles.connect_state,'String','已连接');
        set(handles.disconnectopc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.connectopc,'BackgroundColor',[0 1 0]);
    else
        msgbox('已经连接','错误');
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
global  connect_con daobj pidloop apc_on temp_on  first_cooler_rev_on data tempdata 
global decomposing_furnace_tempr_on coalklin_on second_cooler_rev_on third_cooler_rev_on sign_NH3 
global data1 sign_furnace_pressure shengliao_junliao_on ecfw_on man_in_blj recover_flag blj_speed_stop_flag
global man_in_ydl man_in_fjl ecfw_spcnt
data1=[]; 

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
% set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_junhua_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_junhua_close,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.NOX_ctrl_on,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.NOX_ctrl_off,'BackgroundColor',[0.94 0.94 0.94]);

set(handles.NOX_ctrl_on,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.NOX_ctrl_off,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.frequency_pressure_open,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.frequency_pressure_close,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.ecfw_open,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.ecfw_close,'BackgroundColor',[0.94 0.94 0.94]);
apc_on=0;
connect_con=0;
temp_on=0;
first_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
coalklin_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
sign_NH3 = 0;
sign_furnace_pressure=0;
shengliao_junliao_on = 0;
ecfw_on = 0;
man_in_blj = false;
man_in_ydl = false;
man_in_fjl = false;
recover_flag = false;
blj_speed_stop_flag = false;
data=zeros(length(tempdata)+50,1);
ecfw_spcnt = -1; %停止控制器时，将该值复位

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gui_decomposing_furnace_tempr_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decomposing_furnace_tempr_on paramdata man_in_fjl
decomposing_furnace_tempr_on =0;
man_in_fjl = false;
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[1 0 0]);
% paramdata = xml_read('param_set.xml');
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_decomposing_furnace_coal_floor_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_coal_floor_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a*2)/2;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_decomposing_furnace_coal_floor_sp_display,'String',num2str(slide_value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_decomposing_furnace_coal_floor_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_coal_floor_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


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
formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_g11_current_sp_display,'String',num2str(slide_value,formatSpec));

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


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_1st_cooler_on_button.
function gui_1st_cooler_on_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on
first_cooler_rev_on=1;
set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0 1 0]);
% set(handles.gui_1st_cooler_off_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);



% --- Executes on button press in gui_1st_cooler_off_button.
function gui_1st_cooler_off_button_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on paramdata
first_cooler_rev_on=0;
set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_1st_cooler_off_button,'BackgroundColor',[1 0 0]);
paramdata = xml_read('param_set.xml');


% --- Executes on slider movement.
function pressure_floor_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_2_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a/100)*100;%将滑块的值赋给value
set(hObject,'Value',a);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.pressure_floor,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function pressure_floor_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressure_floor_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function gui_decomposing_furnace_tempr_2_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_2_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_decomposing_furnace_tempr_2_sp_display,'String',num2str(slide_value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_decomposing_furnace_tempr_2_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_2_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


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
function NOX_pv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NOX_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function valve_floor_slider_Callback(hObject, eventdata, handles)

% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a*10)/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.valve_floor,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function valve_floor_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to valve_floor_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_auto_off.
function gui_auto_off_Callback(hObject, eventdata, handles)
% hObject    handle to gui_auto_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first_cooler_rev_on second_cooler_rev_on third_cooler_rev_on decomposing_furnace_tempr_on coalklin_on sign_NH3
global sign_furnace_pressure shengliao_junliao_on man_in_blj man_in_ydl man_in_fjl ecfw_spcnt
sign_furnace_pressure=0;
first_cooler_rev_on=0;
second_cooler_rev_on=0;
third_cooler_rev_on=0;
decomposing_furnace_tempr_on=0;
coalklin_on=0;
sign_NH3 = 0;
shengliao_junliao_on = 0;
man_in_blj = false;
man_in_ydl = false;
man_in_fjl = false;
ecfw_spcnt = -1; %停止控制器时，将该值复位

% set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_1st_cooler_off_button,'BackgroundColor',[1 0 0]);

set(handles.shengliao_junhua_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.shengliao_junhua_close,'BackgroundColor',[1 0 0]);
set(handles.frequency_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.frequency_pressure_close,'BackgroundColor',[1 0 0]);
% set(handles.gui_3rd_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_3rd_cooler_off_button,'BackgroundColor',[1 0 0]);


% set(handles.gui_1st_cooler_on_button_bed,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[1 0 0]);
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[1 0 0]);

set(handles.NOX_ctrl_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.NOX_ctrl_off,'BackgroundColor',[1 0 0]);
set(handles.ecfw_open,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.ecfw_close,'BackgroundColor',[1 0 0]);

set(handles.gui_auto_off,'BackgroundColor',[1 0 0]);


% --- Executes on slider movement.
function gui_feed_sp_top_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_feed_sp_top_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a*2)/2;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_feed_sp_top,'String',num2str(slide_value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_feed_sp_top_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_feed_sp_top_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in alarmbutton.
function alarmbutton_Callback(hObject, eventdata, handles)
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS pophandles
global alarm_sound_flag alarm_button_clicked wlc_weight_upperlimitS wlc_weight_lowerlimitS
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
set(pophandles.text20,'String',wlc_weight_upperlimitS);
set(pophandles.slider6,'Value',wlc_weight_upperlimitS);
set(pophandles.text21,'String',wlc_weight_lowerlimitS);
set(pophandles.slider7,'Value',wlc_weight_lowerlimitS);



set(pophandles.figure1, 'WindowStyle', 'modal');
alarm_sound_flag = 0;
alarm_button_clicked = 1;
set(handles.alarmbutton,'BackgroundColor',[0.941 0.941 0.941]);
        
% hObject    handle to alarmbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_klin_coal_floor_sp_display_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_coal_floor_sp_display_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_klin_coal_floor_sp_display_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_klin_coal_floor_sp_display_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_klin_head_tempr_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_tempr_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a*10)/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_klin_head_tempr_sp_display,'String',num2str(slide_value,formatSpec));
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
global coalklin_on
coalklin_on=0;
set(handles.gui_klin_tempr_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_klin_tempr_off_button,'BackgroundColor',[1 0 0]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]); 
% paramdata = xml_read('param_set.xml');
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


% --- Executes on slider movement.
function chongban_flow_slider_Callback(hObject, eventdata, handles)
% hObject    handle to chongban_flow_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
%将滑块的值赋给value
set(hObject,'Value',a);%不用管
slide_value=(round(a*10))/10;%将滑块的值赋给value
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.chongban_flow_sp,'String',num2str(slide_value));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function chongban_flow_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chongban_flow_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_3rd_plate_pressure_max_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_3rd_plate_pressure_max_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
%将滑块的值赋给value
slide_value=round(a);%将滑块的值赋给value
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
% set(handles.gui_3rd_plate_pressure_max_sp_display,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_3rd_plate_pressure_max_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_3rd_plate_pressure_max_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider24_Callback(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gui_fan_frequency_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_fan_frequency_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gui_fan_frequency_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_fan_frequency_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on slider movement.
function slider27_Callback(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in shengliao_junhua_open.
function shengliao_junhua_open_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_junhua_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_junliao_on
shengliao_junliao_on=1;
set(handles.shengliao_junhua_open,'BackgroundColor',[0 1 0]);
set(handles.shengliao_junhua_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in shengliao_junhua_close.
function shengliao_junhua_close_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_junhua_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global shengliao_junliao_on 
shengliao_junliao_on=0;
set(handles.shengliao_junhua_close,'BackgroundColor',[1 0 0]);
set(handles.shengliao_junhua_open,'BackgroundColor',[0.941 0.941 0.941]);

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
set(handles.gui_feeding_duct_tempr_2_sp_display,'String',num2str(slide_value));

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
set(handles.gui_1st_cooler_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on slider movement.
function gui_2nd_chamber_pressure_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%2.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_2nd_chamber_pressure_sp_display,'String',num2str(slide_value,formatSpec));
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
global gui_fjlT_sp decomposing_furnace_tempr_1_sp ydlBHcnt ydlBHFlag
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.gui_decomposing_furnace_tempr_1_sp_display,'String',num2str(slide_value,formatSpec));
%如果手动调节分解炉温度滑动条后，先将窑电流饱和逻辑复位然后继续判断
gui_fjlT_sp = slide_value;
decomposing_furnace_tempr_1_sp = gui_fjlT_sp; %将gui界面温度实时更新给内部温度值
ydlBHcnt = 0; %窑电流饱和计时器复位
ydlBHFlag = 0;%窑电流饱和标志位复位

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
global decomposing_furnace_tempr_on decomposing_furnace_tempr_1_sp ydlBHcnt ydlBHFlag gui_fjlT_sp
decomposing_furnace_tempr_on =1;
set(handles.gui_decomposing_furnace_tempr_1_on_button,'BackgroundColor',[0 1 0]);

set(handles.gui_decomposing_furnace_tempr_off_button,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
decomposing_furnace_tempr_1_sp = gui_fjlT_sp; %将gui界面温度实时更新给内部温度值
ydlBHcnt = 0; %窑电流饱和计时器复位
ydlBHFlag = 0;%窑电流饱和标志位复位


% --- Executes on button press in gui_decomposing_furnace_tempr_off_button.



% --- Executes on button press in gui_decomposing_furnace_tempr_off_button.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',about);


% --- Executes on slider movement.
function chongban_flow_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to chongban_flow_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%4.1f';
set(handles.chongban_flow_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function chongban_flow_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chongban_flow_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function chongban_flow_sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chongban_flow_sp (see GCBO)
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


% --- Executes on button press in pushbutton36.
function param_setting_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pophandles blj_freqMAX blj_freqMIN yaotou_coalMAX yaotou_coalMIN yaowei_coalMAX yaowei_coalMIN 
set(0,'CurrentFigure',param_setting);
% % pophandles = guihandles;
% % blj_freqMAX=str2double(get(pophandles.blj_freqMAX,'String'));
% % blj_freqMIN=str2double(get(pophandles.blj_freqMIN,'String'));
% % yaotou_coalMAX=str2double(get(pophandles.yaotou_coalMAX,'String'));
% % yaotou_coalMIN=str2double(get(pophandles.yaotou_coalMIN,'String'));
% % yaowei_coalMAX=str2double(get(pophandles.yaowei_coalMAX,'String'));
% % yaowei_coalMIN=str2double(get(pophandles.yaowei_coalMIN,'String'));


% --- Executes on slider movement.
function NOX_SP_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_SP_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.NOX_SP,'String',num2str(slide_value,formatSpec));

% --- Executes during object creation, after setting all properties.
function NOX_SP_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NOX_SP_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in NOX_ctrl_on.
function NOX_ctrl_on_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_ctrl_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_NH3
sign_NH3 = 1;
set(handles.NOX_ctrl_on,'BackgroundColor',[0 1 0]);

set(handles.NOX_ctrl_off,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in NOX_ctrl_off.
function NOX_ctrl_off_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_ctrl_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_NH3
sign_NH3 = 0;

set(handles.NOX_ctrl_off,'BackgroundColor',[1 0 0]);
set(handles.NOX_ctrl_on,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on slider movement.
function NH3_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.NH3_limit_show,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function NH3_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in frequency_pressure_close.
function frequency_pressure_close_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_furnace_pressure
sign_furnace_pressure =0;
set(handles.frequency_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);

set(handles.frequency_pressure_close,'BackgroundColor',[1 0 0]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on slider movement.
function frequency_pressure_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%2.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.frequency_pressure_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function frequency_pressure_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in frequency_pressure_open.
function frequency_pressure_open_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sign_furnace_pressure
sign_furnace_pressure =1;
set(handles.frequency_pressure_open,'BackgroundColor',[0 1 0]);

set(handles.frequency_pressure_close,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in ploy.
function ploy_Callback(hObject, eventdata, handles)
% hObject    handle to ploy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data1
[cc,c]=size(data1);
t=2:c;
figure;
p2 = plot(t,data1(2,2:c));     
xlabel('时间(s)')
% set(p2(1),'ylim',[(data(64,b+1)-500),(data(64,b+1)+500)],'ytick',[(data(64,b+1)-500):100:(data(64,b+1)+500)]);
% set(p2(2),'ylim',[(data(64,b+1)-500),(data(64,b+1)+500)],'ytick',[(data(64,b+1)-500):100:(data(64,b+1)+500)]);


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',adjust);


% --- Executes on slider movement.
function slider39_Callback(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_g11_current_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_1st_cooler_on_button.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_1st_cooler_off_button.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_1st_cooler_on_button_bed.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to gui_1st_cooler_on_button_bed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider40_Callback(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_2nd_chamber_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider41_Callback(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider42_Callback(hObject, eventdata, handles)
% hObject    handle to slider42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in NOX_ctrl_on.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_ctrl_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in NOX_ctrl_off.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_ctrl_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider45_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_SP_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NOX_SP_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider44_Callback(hObject, eventdata, handles)
% hObject    handle to slider44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider49_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider49_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_decomposing_furnace_tempr_1_on_button.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_1_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_decomposing_furnace_tempr_off_button.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to gui_decomposing_furnace_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider52_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in frequency_pressure_open.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in frequency_pressure_close.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_pressure_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in shengliao_junhua_open.
function pushbutton71_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_junhua_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider55_Callback(hObject, eventdata, handles)
% hObject    handle to chongban_flow_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chongban_flow_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in shengliao_junhua_close.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to shengliao_junhua_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider54_Callback(hObject, eventdata, handles)
% hObject    handle to slider54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider54_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


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


% --- Executes on slider movement.
function slider53_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_tempr_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_tempr_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gui_klin_tempr_on_button.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_tempr_on_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gui_klin_tempr_off_button.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to gui_klin_tempr_off_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ploy.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to ploy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_klin_head_pv_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_klin_head_pv_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function wei_toucoal_rati_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wei_toucoal_rati (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function gui_klin_rev_pv_display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_klin_rev_pv_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text369_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text369 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
% % % % function ecfw_sp_slider_Callback(hObject, eventdata, handles)
% % % % % hObject    handle to ecfw_sp_slider (see GCBO)
% % % % % eventdata  reserved - to be defined in a future version of MATLAB
% % % % % handles    structure with handles and user data (see GUIDATA)
% % % % a=get(hObject,'Value');%获取滑块当前值
% % % % slide_value=round(a);%将滑块的值赋给value
% % % % set(hObject,'Value',slide_value);%不用管
% % % % formatSpec='%3.1f';
% % % % % set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
% % % % set(handles.ecfw_sp,'String',num2str(slide_value,formatSpec));
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


% --- Executes on button press in ecfw_open.
function ecfw_open_Callback(hObject, eventdata, handles)
% hObject    handle to ecfw_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ecfw_on 
ecfw_on =1;
set(handles.ecfw_open,'BackgroundColor',[0 1 0]);

set(handles.ecfw_close,'BackgroundColor',[0.941 0.941 0.941]);
% set(handles.gui_feeding_duct_tempr_2_on_button,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in ecfw_close.
function ecfw_close_Callback(hObject, eventdata, handles)
% hObject    handle to ecfw_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ecfw_on man_in_blj 
global first_cooler_rev_on paramdata zxyCnt stop_zxyCnt stop_zxyFlag recover_flag blj_speed_stop_flag
global blj_low_time_cnt blj_low_pressure blj_high_speed ecfw_spcnt
first_cooler_rev_on=0;
zxyCnt = 0; %启动自寻优计时器清零
stop_zxyCnt = 0; %停止自寻优计时器清零
stop_zxyFlag = 0; %停止自寻优触发条件复位
recover_flag = false;
blj_speed_stop_flag = false;
blj_low_time_cnt = 1;
blj_low_pressure = 0;
blj_high_speed = 0;
ecfw_on=0;
man_in_blj = false;
ecfw_spcnt = -1; %停止控制器时，将该值复位
set(handles.ecfw_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.ecfw_close,'BackgroundColor',[1 0 0]);
set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]); 
% paramdata = xml_read('param_set.xml');

% --- Executes on button press in param_setting1.
function param_setting1_Callback(hObject, eventdata, handles)
% hObject    handle to param_setting1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global paramhandles
% paramhandles = guihandles;
set(0,'CurrentFigure',param_setting1);


% --- Executes on button press in zhuansu_input.
function zhuansu_input_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blj_mode
blj_mode = true;
set(0,'CurrentFigure',zhuansu_man);


% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data sizecon
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(2,2:c),t,data(16,2:c)); 
figure;
p1 = plotyy(t,data(2,2:c),t,data(1,2:c)); 
figure;
p1 = plotyy(t,data(2,2:c),t,data(5,2:c)); 


% --- Executes on button press in weimei_input.
function weimei_input_Callback(hObject, eventdata, handles)
% hObject    handle to weimei_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fjl_mode
fjl_mode = true;
set(0,'CurrentFigure',weimei_man);


% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % % global ydl_mode
% % % ydl_mode = true;
% % % set(0,'CurrentFigure',toumei_man);


% --- Executes during object creation, after setting all properties.
function slider57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% % % global data
% % % [cc,c]=size(data);
% % % t=2:c;
% % % figure;
% % % p1 = plotyy(t,data(18,2:c),t,data(76,2:c));
% % % figure;
% % % p1 = plotyy(t,data(18,2:c),t,data(30,2:c));
% % % figure;
% % % p1 = plotyy(t,data(18,2:c),t,data(36,2:c));


% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(13,2:c),t,data(11,2:c));
figure;
p1 = plotyy(t,data(13,2:c),t,data(15,2:c));


% --- Executes during object creation, after setting all properties.
function NH3_escape_pv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_escape_pv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
