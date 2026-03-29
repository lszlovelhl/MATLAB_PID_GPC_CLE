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

% Last Modified by GUIDE v2.5 30-Dec-2023 13:45:32

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
%% 初始化配置参数
global paramdata first_time_connect_flag_ontimer  connect_con first_time_connect_flag first daobj group
global blj_on fjl_on douti_on toumei_on upid gw_fj_press_on
global A B P gpc_a gpc_lmd workpoint B2 A2 workpoint2
global blj_vd zhuansu_MAX zhuansu_MIN temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2 fjl_vd fjl_max fjl_min fjl_delvd1 fjl_delvd2 fjl_delvd3 fjl_delvd4
global dt_max dt_min dtdl_sp fjl_temp_sp
global tm_alpha tm_beta tm_gamma tm_max tm_min tm_alpha1 tm_beta1 tm_gamma1
global fj11dl_sp dtdlcntflag dtdlcnt f11dl_asc f11dl_flat f11dl_desc u_blj_speed
global p_blj_a1 p_blj_lmd1 p_blj_a2 p_blj_lmd2 dtdlcntMax blj_delvd1_up blj_delvd2_up blj_delvd3_up blj_delvd4_up blj_delvd1_down blj_delvd2_down blj_delvd3_down blj_delvd4_down
global u_dtdl_wll u_decomposing_furnace_tempr man_in_blj man_in_fjl man_in_dtdl man_in_toumei man_in_gaowen
global his_file_path his_file_row his_data last_path hisdatadays keycount hitdata_title
global wmfy_sp u_final fjl_test
global man_weimei man_zhuansu
global douti_jisuan toumei_jisuan gw_fj_jisuan toupai_jisuan
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global fazu1_max fazu1_min fazu2_max fazu2_min alarm_sound_flag alarm_timer alarm_button_clicked
global man_blj_time_cnt man_fjl_time_cnt fjl_cle_test fjl_tishenji
global gwfj_alpha gwfj_beta gwfj_gamma gwfj_max gwfj_min

%%%%%wyx 2023/4/24
global blj_fjdl fjl_wendu douti_dl yaotou_wm wpfj_zs
paramdata = xml_read('param_set.xml');

% 配置opc参数
first_time_connect_flag_ontimer=8;
connect_con=0;%连接状态
first_time_connect_flag=1;%首次连接
first = 1;
daobj=opcda(paramdata.commdata(1).parameter(1).ATTRIBUTE.opcID,paramdata.commdata(1).parameter(1).ATTRIBUTE.opcServerName);
group = addgroup(daobj);
%初始化开关量 0 表示手动 1 表示自动
blj_on = 0;
fjl_on = 0;
douti_on = 0;
toumei_on = 0;
gw_fj_press_on = 0;
%初始化数值
upid=[12 18 24 10 10 10 10 20];
%手动干预数值初始化 1表示手动干预 0表示自动
man_in_blj = 0;
man_in_fjl = 0;
man_in_dtdl = 0;
man_in_toumei = 0;
man_in_gaowen = 0;
man_zhuansu = 6;
man_weimei = 13;
man_blj_time_cnt = 0;
man_fjl_time_cnt = 0;


%篦冷机相关数值初始化
dtdlcntflag = 0;
dtdlcnt = 0;
fj11dl_sp = 250;
f11dl_asc = 0;  %F1M1风机电流趋势指标初始化
f11dl_flat = 0;
f11dl_desc = 0;
u_blj_speed = 5.5;
workpoint2=[6.9347,202.9620];
A2=[-0.6612,1];
B2=-0.03589;
%分解炉gpc 参数
A=[-0.9931,1];
B=0.2614;
P=[0.01,0.01;0.01,0.01];
gpc_a=0.99;
gpc_lmd=80;
workpoint=[8.5549,873.5283];
u_decomposing_furnace_tempr = 15;
wmfy_sp=24;
u_final=0;
fjl_test=0;
fjl_cle_test=0;
fjl_temp_sp=840;
%%%%%wyx 2023/4/24
blj_fjdl=0;
fjl_wendu=0;
douti_dl=0;
yaotou_wm=0;
wpfj_zs=0;

fjl_tishenji=0;

%斗提电流相关参数
dtdl_sp=130;
u_dtdl_wll = 245;
%篦冷机参数获取

p_blj_a1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a1;
p_blj_lmd1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd1;
p_blj_a2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a2;
p_blj_lmd2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd2;
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
zhuansu_MAX = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_max;
zhuansu_MIN = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_min;
%分解炉gpc参数获取
temp_fjl_alpha1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha1;
temp_fjl_lambda1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda1;
temp_fjl_alpha2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2;
temp_fjl_lambda2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2;
fjl_vd = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_vd;
fjl_max = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_max;
fjl_min = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_min;
fjl_delvd1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd1;
fjl_delvd2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd2;
fjl_delvd3 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd3;
fjl_delvd4 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_delvd4;
%斗提电流pid参数获取
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

%警告
decomposing_furnace_tempr_2_upperlimitS = paramdata.commdata(1).parameter(10).ATTRIBUTE.decomposing_furnace_tempr_2_upperlimitS;
decomposing_furnace_tempr_2_lowerlimitS= paramdata.commdata(1).parameter(10).ATTRIBUTE.decomposing_furnace_tempr_2_lowerlimitS;
snd_chamber_pressure_upperlimitS = paramdata.commdata(1).parameter(10).ATTRIBUTE.snd_chamber_pressure_upperlimitS;
snd_chamber_pressure_lowerlimitS = paramdata.commdata(1).parameter(10).ATTRIBUTE.snd_chamber_pressure_lowerlimitS;
fazu1_max = paramdata.commdata(1).parameter(10).ATTRIBUTE.fazu1_max;
fazu1_min = paramdata.commdata(1).parameter(10).ATTRIBUTE.fazu1_min;
fazu2_max = paramdata.commdata(1).parameter(10).ATTRIBUTE.fazu2_max;
fazu2_min = paramdata.commdata(1).parameter(10).ATTRIBUTE.fazu2_min;
alarm_sound_flag = 0;
alarm_timer = 120;
alarm_button_clicked = 0;

%初始化各回路计算值，主要用于离线观察
douti_jisuan = 210;
toumei_jisuan = 8;
gw_fj_jisuan = 37;
toupai_jisuan =80;

%初始化滑动条数值
%分解炉滑动条
fjl_dl_slider = 840;
set(handles.fjl_temp_sp,'String',fjl_dl_slider);
set(handles.fjl_slider,'Value',fjl_dl_slider);
set(handles.fjl_slider,'Max',fjl_dl_slider + 100,'Min',fjl_dl_slider - 100);
set(handles.fjl_slider,'SliderStep',[1/200,5/200]);
%斗提电流滑动条
dt_dl_slider = 125;
set(handles.douti_sp,'String',dt_dl_slider);
set(handles.douti_slider,'Value',dt_dl_slider);
set(handles.douti_slider,'Max',dt_dl_slider+50,'Min',dt_dl_slider-50);
set(handles.douti_slider,'SliderStep',[1/100,5/100]);
%头煤滑动条
toumei_sp = 24.5;
set(handles.toumei_sp,'String',toumei_sp);
set(handles.toumei_slider,'Value',toumei_sp);
set(handles.toumei_slider,'Max',toumei_sp+12,'Min',toumei_sp-12);
set(handles.toumei_slider,'SliderStep',[0.1/24,1/24]);
%高温风机进口负压滑动条
gw_fj_press_sp = -5500;
set(handles.gw_fj_press_sp,'String',gw_fj_press_sp);
set(handles.gw_fj_press_sp_slider,'Value',gw_fj_press_sp);
set(handles.gw_fj_press_sp_slider,'Max',gw_fj_press_sp+2500,'Min',gw_fj_press_sp-2500);
set(handles.gw_fj_press_sp_slider,'SliderStep',[10/5000,100/5000]);

%csv数据
% Choose default command line output for apcgui
handles.output = hObject;
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

hitdata_title={ '日期时间',...
    '一室篦床压力',...
    '一段篦冷机转速给定值',...
    '一段篦冷机转速测量值',...
    '二室篦床压力',...
    'FAM1冷却风机电流',...
    'FBM1冷却风机电流',...
    'F1M1冷却风机电流',...
    'F2M1冷却风机电流',...
    'F3M1冷却风机电流',...
    '氨逃逸量',...
    '分解炉出口温度',...
    'C5出口温度',...
    '分解炉喂煤量给定值',...
    '分解炉喂煤量测量值',...
    '三次风温',...
    '窑头温度(二次风温)',...
    '窑尾温度',...
    '窑头喂煤量给定值',...
    '窑头喂煤量测量值',...
    '窑头负压',...
    '窑尾负压',...
    '回转窑轴电流',...
    '回转窑转速测量值',...
    '回转窑转速给定值',...
    '斗提电流',...
    '喂料量测量值',...
    'C1出口负压1',...
    '喂料量给定值',...
    '生料仓重反馈',...
    '头煤压力',...
    '高温风机转速给定',...
    '高温风机转速测量',...
    '尾煤风压',...
    '残氧(窑尾02)',...
    '尾煤仓重反馈',...
    'C1出口负压2',...
    'F1M1风机电流sp',...
    'C5出口温度sp',...
    'F1M1出口压力',...
    '斗提电流sp',...
    'F3M1出口压力',...
    '尾排风机设定值',...
    '尾排风机测量值',...
    '头排风机开度设定',...
    '窑尾分析CO反馈',...
    '尾煤称煤粉负荷率',...
    '头排风机转速测量值',...
    '头排风机开度测量',...
    'FAM1风机频率',...
    'FBM1风机频率',...
    'F1M1风机频率',...
    'F2M1风机频率',...
    'F3M1风机频率',...
    '高温风机出口压力',...
    '高温风机进口压力',...
    '头煤累计'...
    '尾煤累计'
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
paramdata = xml_read('param_set.xml');

%% 结束配置
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




% --- Executes on button press in disconnectopc.
function disconnectopc_Callback(hObject, eventdata, handles)
% hObject    handle to disconnectopc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global daobj data
global blj_on flj_on douti_on toumei_on  gw_fj_press_on connect_con tempdata dtdlcnt dtdlcntflag
global man_blj_time_cnt man_fjl_time_cnt auth
auth=1;%%%%Need_to_be_modified
if auth==1
    button2=questdlg('确定断开？','断开连接','Yes','No','Yes');
    if strcmp(button2,'Yes')
        %%%%%%%%Need_to_be_modified
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
        set(handles.disconnectopc,'BackgroundColor',[1 0 0]);
        % 关闭各个回路
        set(handles.blj_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.blj_button_off,'BackgroundColor',[1 0 0]);
        set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.fjl_button_off,'BackgroundColor',[1 0 0]);
        set(handles.douti_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.douti_button_off,'BackgroundColor',[1 0 0]);
        set(handles.toumei_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.toumei_button_off,'BackgroundColor',[1 0 0]);
        set(handles.gw_fj_press_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gw_fj_press_button_off,'BackgroundColor',[1 0 0]);
        connect_con=0;
        blj_on = 0;
        flj_on = 0;
        douti_on = 0;
        toumei_on = 0;
        gw_fj_press_on = 0;
        dtdlcnt=0;
        dtdlcntflag=0;
        man_blj_time_cnt = 0;
        man_fjl_time_cnt = 0;
        %wyx 2023/6/27 新增回路开关记录txt
        curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
        timestr=curT(1:10);
        fid=fopen(['EHD\data',timestr,'.txt'],'at');
        fprintf(fid,'%s\n',curT);
        fprintf(fid,'%s\n','所有回路关闭');
        fclose(fid);
        data=zeros(length(tempdata)+50,1);
        %%%%%%%%%%Need_to_be_modified
        %         delete(hObject);
    end;
else
    delete(hObject);
end


% --- Executes on button press in gui_auto_off.
function gui_auto_off_Callback(hObject, eventdata, handles)
% hObject    handle to gui_auto_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blj_on fjl_on douti_on toumei_on  gw_fj_press_on
global  man_in_blj man_in_fjl man_in_dtdl man_in_toumei  man_in_gaowen
global man_blj_time_cnt man_fjl_time_cnt auth

auth=1;%%%%Need_to_be_modified
if auth==1
    button2=questdlg('确定关闭全部回路？','关闭全部回路','Yes','No','Yes');
    if strcmp(button2,'Yes')
        blj_on=0;
        fjl_on=0;
        douti_on=0;
        toumei_on=0;
        gw_fj_press_on=0;
        
        man_in_blj=0;
        man_in_fjl=0;
        man_in_dtdl=0;
        man_in_toumei=0;
        man_in_gaowen=0;
        
        man_blj_time_cnt = 0;
        man_fjl_time_cnt = 0;
        
        %wyx 2023/6/27 新增回路开关记录txt
        curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
        timestr=curT(1:10);
        fid=fopen(['EHD\data',timestr,'.txt'],'at');
        fprintf(fid,'%s\n',curT);
        fprintf(fid,'%s\n','所有回路关闭');
        fclose(fid);
        %
        
        set(handles.blj_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.blj_button_off,'BackgroundColor',[1 0 0]);
        set(handles.douti_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.douti_button_off,'BackgroundColor',[1 0 0]);
        
        set(handles.fjl_button_off,'BackgroundColor',[1 0 0]);
        set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.toumei_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.toumei_button_off,'BackgroundColor',[1 0 0]);
        
        set(handles.gw_fj_press_button_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.gw_fj_press_button_off,'BackgroundColor',[1 0 0]);
        
        set(handles.gui_auto_off,'BackgroundColor',[1 0 0]);
    end;
else
    delete(hObject);
end


% --- Executes on button press in alarmbutton.
function alarmbutton_Callback(hObject, eventdata, handles)
% hObject    handle to alarmbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS pophandles
global alarm_sound_flag alarm_button_clicked fjl_max fjl_min
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

set(pophandles.figure1, 'WindowStyle', 'modal');
alarm_sound_flag = 0;
alarm_button_clicked = 1;
set(handles.alarmbutton,'BackgroundColor',[0.831 0.816 0.784]);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',param_setting);

% --- Executes on slider movement.
function first_dl_slider_Callback(hObject, eventdata, handles)
% hObject    handle to first_dl_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.first_dl_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function first_dl_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_dl_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in blj_button_on.
function blj_button_on_Callback(hObject, eventdata, handles)
% hObject    handle to blj_button_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blj_on blj_fjdl
if blj_fjdl<100;
    msgbox('该回路无法投运，请检查各项指标是否在正常运行范围内！','提示','确认');
else
    blj_on = 1;
    %
    %wyx 2023/6/27 新增回路开关记录txt
    curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    timestr=curT(1:10);
    fid=fopen(['EHD\data',timestr,'.txt'],'at');
    fprintf(fid,'%s\n',curT);
    fprintf(fid,'%s\n','篦冷机回路开');
    fclose(fid);
    %
    
    set(handles.blj_button_on,'BackgroundColor',[0 1 0]);
    set(handles.blj_button_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
end

% --- Executes on button press in blj_button_off.
function blj_button_off_Callback(hObject, eventdata, handles)
% hObject    handle to blj_button_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global blj_on man_blj_time_cnt
blj_on = 0;
man_blj_time_cnt = 0;

%wyx 2023/6/27 新增回路开关记录txt
curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
timestr=curT(1:10);
fid=fopen(['EHD\data',timestr,'.txt'],'at');
fprintf(fid,'%s\n',curT);
fprintf(fid,'%s\n','篦冷机回路关');
fclose(fid);
%
set(handles.blj_button_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.blj_button_off,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function fjl_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.fjl_temp_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in fjl_button_on.
function fjl_button_on_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_button_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fjl_on fjl_wendu
if fjl_wendu<800;
    msgbox('该回路无法投运，请检查各项指标是否在正常运行范围内！','提示','确认');
else
    fjl_on = 1;
    %wyx 2023/6/27 新增回路开关记录txt
    curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    timestr=curT(1:10);
    fid=fopen(['EHD\data',timestr,'.txt'],'at');
    fprintf(fid,'%s\n',curT);
    fprintf(fid,'%s\n','分解炉回路开');
    fclose(fid);
    %
    set(handles.fjl_button_on,'BackgroundColor',[0 1 0]);
    set(handles.fjl_button_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
end


% --- Executes on button press in fjl_button_off.
function fjl_button_off_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_button_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fjl_on man_fjl_time_cnt
fjl_on = 0;
man_fjl_time_cnt = 0;
%wyx 2023/6/27 新增回路开关记录txt
curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
timestr=curT(1:10);
fid=fopen(['EHD\data',timestr,'.txt'],'at');
fprintf(fid,'%s\n',curT);
fprintf(fid,'%s\n','分解炉回路关');
fclose(fid);
%
set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.fjl_button_off,'BackgroundColor',[1 0 0]);




% --- Executes on slider movement.
function douti_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.douti_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in douti_button_on.
function douti_button_on_Callback(hObject, eventdata, handles)
% hObject    handle to douti_button_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_on douti_dl
if douti_dl<100;
    msgbox('该回路无法投运，请检查各项指标是否在正常运行范围内！','提示','确认');
else
    douti_on = 1;
    %wyx 2023/6/27 新增回路开关记录txt
    curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    timestr=curT(1:10);
    fid=fopen(['EHD\data',timestr,'.txt'],'at');
    fprintf(fid,'%s\n',curT);
    fprintf(fid,'%s\n','斗提电流回路开');
    fclose(fid);
    %
    set(handles.douti_button_on,'BackgroundColor',[0 1 0]);
    set(handles.douti_button_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
end


% --- Executes on button press in douti_button_off.
function douti_button_off_Callback(hObject, eventdata, handles)
% hObject    handle to douti_button_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_on
douti_on = 0;
%wyx 2023/6/27 新增回路开关记录txt
curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
timestr=curT(1:10);
fid=fopen(['EHD\data',timestr,'.txt'],'at');
fprintf(fid,'%s\n',curT);
fprintf(fid,'%s\n','斗提电流回路关');
fclose(fid);
%
set(handles.douti_button_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.douti_button_off,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function toumei_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%.1f';
set(handles.toumei_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toumei_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in toumei_button_on.
function toumei_button_on_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_button_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toumei_on yaotou_wm
if yaotou_wm<3;
    msgbox('该回路无法投运，请检查各项指标是否在正常运行范围内！','提示','确认');
else
    toumei_on = 1;
    %wyx 2023/6/27 新增回路开关记录txt
    curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    timestr=curT(1:10);
    fid=fopen(['EHD\data',timestr,'.txt'],'at');
    fprintf(fid,'%s\n',curT);
    fprintf(fid,'%s\n','头煤压力回路开');
    fclose(fid);
    %
    set(handles.toumei_button_on,'BackgroundColor',[0 1 0]);
    set(handles.toumei_button_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
end

% --- Executes on button press in toumei_button_off.
function toumei_button_off_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_button_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toumei_on
toumei_on = 0;
%wyx 2023/6/27 新增回路开关记录txt
curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
timestr=curT(1:10);
fid=fopen(['EHD\data',timestr,'.txt'],'at');
fprintf(fid,'%s\n',curT);
fprintf(fid,'%s\n','头煤压力回路关');
fclose(fid);
%
set(handles.toumei_button_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.toumei_button_off,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function gw_fj_press_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gw_fj_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.gw_fj_press_sp,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gw_fj_press_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gw_fj_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in connectopc.
function connectopc_Callback(hObject, eventdata, handles)
% hObject    handle to connectopc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global first  auth connect_con b tempmv first_time_connect_flag daobj group itemset tempdata data loopnum pidloop
global blj_on flj_on douti_on toumei_on gw_fj_press_on
try
    first=1;
    
    set(handles.connectopc,'Enable','off')
    auth =0;
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
                blj_on = 0;
                flj_on = 0;
                douti_on = 0;
                toumei_on = 0;
                gw_fj_press_on = 0;
                set(handles.disconnectopc,'BackgroundColor',[1 0 0]);
                set(handles.blj_button_on,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.blj_button_off,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.fjl_button_on,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.fjl_button_off,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.douti_button_on,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.douti_button_off,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.toumei_button_on,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.toumei_button_off,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.gw_fj_press_button_on,'BackgroundColor',[0.941 0.941 0.941]);
                set(handles.gw_fj_press_button_off,'BackgroundColor',[0.941 0.941 0.941]);
                connect(daobj);
                itemset=additem(group, {'DPAO_Valve1_Press_1',...
                    'DPAI_Cooler_FreqSet_1',...
                    'DPAO_Cooler_FreqFb_1',...
                    'DPAO_Valve1_Press_2',...
                    'FAM1_CUR',...
                    'FBM1_CUR',...
                    'F1M1_CUR',...
                    'F2M1_CUR',...
                    'F3M1_CUR',...
                    'NH3_PV',...
                    '5101T07_PV',...
                    '5101T05_PV',...
                    '7502F01_SP',...
                    '7502F01_PV',...
                    '5101T09_PV',...
                    '5701T01_PV',...
                    '5101T10_PV',...
                    '7503F01_SP',...
                    '7503F01_PV',...
                    '5701P01_PV',...
                    '5101P10_PV',...
                    '5601M1_CUR',...
                    '5601M1_PV',...
                    '5601M1_SV',...
                    '52091M_AVE',...
                    '5202AR_FPV',...
                    '5101P01_PV',...
                    '5202AR_FSV',...
                    '5201W01_PV',...
                    '7507P02_PV',...
                    'M4107_SV',...
                    'M4107_PV',...
                    '7507P01_PV',...
                    'N55O2_PV',...
                    '7502F01_T',...
                    '5101P16_PV',...
                    'PT1FA_PV',...
                    'PT1FB_PV',...
                    'PT1F1_PV',...
                    'PT1F2_PV',...
                    'PT1F3_PV',...
                    'M5406H_SV',...
                    'M5406H_PV',...
                    '5715Z01_SV',...
                    'N55CO_PV',...
                    '7502F01_W',...
                    'M5716_PV',...
                    '5715Z01_PV',...
                    'FAM1_PV',...
                    'FBM1_PV',...
                    'F1M1_PV',...
                    'F2M1_PV',...
                    'F3M1_PV',...
                    '5401P01_PV',...
                    '5401P02_PV',...
                    'SUM_7502F01'...
                    'SUM_7503F01'
                    });
                connect(daobj);
                tempdata=read(group);
                data=zeros(length(tempdata)+50,1);%初始化data  Need_to_be_modified
                data(1:6,1)=fix(clock);% fix是化小数为整数，方法是舍去小数部分，clock是6x1的向量，其元素是日期（年月日时分秒），且第一列的元素全为日期，向量可以拓展，即列数可以增加。除第一列外，每列元素均为84+12个PID的值
                %% prepare pidloop and pid parameter
                loopnum=1;
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
                itemset=additem(group, {'DPAO_Valve1_Press_1',...
                    'DPAI_Cooler_FreqSet_1',...
                    'DPAO_Cooler_FreqFb_1',...
                    'DPAO_Valve1_Press_2',...
                    'FAM1_CUR',...
                    'FBM1_CUR',...
                    'F1M1_CUR',...
                    'F2M1_CUR',...
                    'F3M1_CUR',...
                    'NH3_PV',...
                    '5101T07_PV',...
                    '5101T05_PV',...
                    '7502F01_SP',...
                    '7502F01_PV',...
                    '5101T09_PV',...
                    '5701T01_PV',...
                    '5101T10_PV',...
                    '7503F01_SP',...
                    '7503F01_PV',...
                    '5701P01_PV',...
                    '5101P10_PV',...
                    '5601M1_CUR',...
                    '5601M1_PV',...
                    '5601M1_SV',...
                    '52091M_AVE',...
                    '5202AR_FPV',...
                    '5101P01_PV',...
                    '5202AR_FSV',...
                    '5201W01_PV',...
                    '7507P02_PV',...
                    'M4107_SV',...
                    'M4107_PV',...
                    '7507P01_PV',...
                    'N55O2_PV',...
                    '7502F01_T',...
                    '5101P16_PV',...
                    'PT1FA_PV',...
                    'PT1FB_PV',...
                    'PT1F1_PV',...
                    'PT1F2_PV',...
                    'PT1F3_PV',...
                    'M5406H_SV',...
                    'M5406H_PV',...
                    '5715Z01_SV',...
                    'N55CO_PV',...
                    '7502F01_W',...
                    'M5716_PV',...
                    '5715Z01_PV',...
                    'FAM1_PV',...
                    'FBM1_PV',...
                    'F1M1_PV',...
                    'F2M1_PV',...
                    'F3M1_PV',...
                    '5401P01_PV',...
                    '5401P02_PV',...
                    'SUM_7502F01'...
                    'SUM_7503F01'
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
catch lasterror
    tete = lasterror.message;
    fiderror = fopen('logFile.txt','a+');
    fprintf(fiderror,'%s\n',tete);
    for e=1:length(lasterror.stack)
        fprintf(fiderror,'%s at %i\n',lasterror.stack(e).name, lasterror.stack(e).line);
    end
    fclose(fiderror);
end

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',about);


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global daobj auth
auth=1;%%%%Need_to_be_modified
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


% --- Executes on button press in blj_man.
function blj_man_Callback(hObject, eventdata, handles)
% hObject    handle to blj_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',zhuansu_man);

% --- Executes on button press in fjl_man.
function fjl_man_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',weimei_man);

% --- Executes on button press in dtdl_man.
function dtdl_man_Callback(hObject, eventdata, handles)
% hObject    handle to dtdl_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',dtdl_man);

% --- Executes on button press in toumei_man.
function toumei_man_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',toumei_man);


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',adjust);


% --- Executes on button press in fjl_pic.
function fjl_pic_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;

figure(3);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(15,2:c),t,data(12,2:c));
% legend('三次风温','分解炉温度');
axis(hAx(1),[-inf,inf,860,940]);
axis(hAx(2),[-inf,inf,830,870]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'三次风温');  % 为X轴加标签 ;
ylabel(hAx(2),'C5出口温度');  % 为X轴加标签

subplot(3,1,2);
[hAx,hLine1,hLine2] = plotyy(t,data(93,2:c),t,data(79,2:c));
% legend('尾煤量','尾煤风压');
axis manual;
axis(hAx(1),[-inf,inf,8,12]);
axis(hAx(2),[-inf,inf,20,26]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量计算值');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压滤波');  % 为X轴加标签

subplot(3,1,3);
[hAx,hLine1,hLine2] =plotyy(t,data(13,2:c),t,data(12,2:c));
% legend('尾煤量计算值','分解炉出口温度');
axis(hAx(1),[-inf,inf,8,12]);
axis(hAx(2),[-inf,inf,830,870]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量sp');  % 为X轴加标签
ylabel(hAx(2),'C5出口温度');  % 为X轴加标签

figure(2);
subplot(3,1,1);
[hAx,hLine1,hLine2] = plotyy(t,data(77,2:c),t,data(12,2:c));
% legend('尾煤风压sp','分解炉温度');
axis(hAx(1),[-inf,inf,20,26]);
axis(hAx(2),[-inf,inf,830,870]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤风压sp');  % 为X轴加标签 ;
ylabel(hAx(2),'C5出口温度');

subplot(3,1,2);
[hAx,hLine1,hLine2] = plotyy(t,data(33,2:c),t,data(77,2:c));
% legend('尾煤风压pv','尾煤风压sp');
axis(hAx(1),[-inf,inf,20,26]);
axis(hAx(2),[-inf,inf,20,26]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤风压pv');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压sp');


subplot(3,1,3);
[hAx,hLine1,hLine2] = plotyy(t,data(93,2:c),t,data(77,2:c));
% legend('尾煤量sp','尾煤风压sp');
axis(hAx(1),[-inf,inf,8,12]);
axis(hAx(2),[-inf,inf,20,26]);
xlabel('时间(s)');  % 为X轴加标签 ;
ylabel(hAx(1),'尾煤量计算值');  % 为X轴加标签 ;
ylabel(hAx(2),'尾煤风压sp');  % 为X轴加标签 ;


% --- Executes on button press in blj_pic.
function blj_pic_Callback(hObject, eventdata, handles)
% hObject    handle to blj_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(2,2:c),t,data(16,2:c));%二次风温
figure;
p1 = plotyy(t,data(2,2:c),t,data(39,2:c));%一室风压
figure;
p1 = plotyy(t,data(96,2:c),t,data(101,2:c));%11风机电流


% --- Executes on button press in gwfj_man.
function gwfj_man_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',gaowen_man);


% --- Executes on button press in gw_fj_press_button_on.
function gw_fj_press_button_on_Callback(hObject, eventdata, handles)
% hObject    handle to gw_fj_press_button_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gw_fj_press_on wpfj_zs
if wpfj_zs<30;
    msgbox('该回路无法投运，请检查各项指标是否在正常运行范围内！','提示','确认');
else
    gw_fj_press_on = 1;
    %wyx 2023/6/27 新增回路开关记录txt
    curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
    timestr=curT(1:10);
    fid=fopen(['EHD\data',timestr,'.txt'],'at');
    fprintf(fid,'%s\n',curT);
    fprintf(fid,'%s\n','高温风机回路开');
    fclose(fid);
    %
    set(handles.gw_fj_press_button_on,'BackgroundColor',[0 1 0]);
    set(handles.gw_fj_press_button_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.gui_auto_off,'BackgroundColor',[0.941 0.941 0.941]);
end


% --- Executes on button press in gw_fj_press_button_off.
function gw_fj_press_button_off_Callback(hObject, eventdata, handles)
% hObject    handle to gw_fj_press_button_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gw_fj_press_on
gw_fj_press_on = 0;
%wyx 2023/6/27 新增回路开关记录txt
curT = datestr(now,'yyyy-mm-dd HH:MM:SS');
timestr=curT(1:10);
fid=fopen(['EHD\data',timestr,'.txt'],'at');
fprintf(fid,'%s\n',curT);
fprintf(fid,'%s\n','高温风机回路关');
fclose(fid);
%
set(handles.gw_fj_press_button_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gw_fj_press_button_off,'BackgroundColor',[1 0 0]);


% --- Executes during object creation, after setting all properties.
function yaotou_press_sp_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_press_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in gwfj_pic.
function gwfj_pic_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(42,2:c),t,data(55,2:c));%尾排风机转速设定 高温风机进口负压反馈
figure;
p1 = plotyy(t,data(100,2:c),t,data(105,2:c));%尾排风机转速设定 高温风机进口负压滤波


% --- Executes on button press in dtdl_pic.
function dtdl_pic_Callback(hObject, eventdata, handles)
% hObject    handle to dtdl_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(28,2:c),t,data(25,2:c));%喂料量 斗提电流
figure;
p1 = plotyy(t,data(97,2:c),t,data(102,2:c));%喂料量 斗提电流滤波
figure;
p1 = plotyy(t,data(28,2:c),t,data(102,2:c));%喂料量 斗提电流滤波



% --- Executes on button press in toumei_pic.
function toumei_pic_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
[cc,c]=size(data);
t=2:c;
figure;
p1 = plotyy(t,data(18,2:c),t,data(30,2:c));%头煤设定 头煤压力反馈
figure;
p1 = plotyy(t,data(98,2:c),t,data(103,2:c));%头煤设定 头煤压力滤波
figure;
p1 = plotyy(t,data(98,2:c),t,data(22,2:c));%头煤设定 窑电流


% --- Executes on button press in fjl_weimei_jia.
function fjl_weimei_jia_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_weimei_jia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_in_fjl man_weimei
man_weimei = str2double(get(handles.fjl_wml_sp,'String'));
man_weimei = man_weimei + 0.1;
man_in_fjl = 1;


% --- Executes on button press in fjl_weimei_jian.
function fjl_weimei_jian_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_weimei_jian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_in_fjl man_weimei
man_weimei = str2double(get(handles.fjl_wml_sp,'String'));
man_weimei = man_weimei - 0.1;
man_in_fjl = 1;


% --- Executes on button press in blj_zhuansu_jia.
function blj_zhuansu_jia_Callback(hObject, eventdata, handles)
% hObject    handle to blj_zhuansu_jia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_zhuansu man_in_blj
man_zhuansu = str2double(get(handles.first_fj_sp,'String'));
man_zhuansu = man_zhuansu + 0.1;
man_in_blj = 1;


% --- Executes on button press in blj_zhuansu_jian.
function blj_zhuansu_jian_Callback(hObject, eventdata, handles)
% hObject    handle to blj_zhuansu_jian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global man_zhuansu man_in_blj
man_zhuansu = str2double(get(handles.first_fj_sp,'String'));
man_zhuansu = man_zhuansu - 0.1;
man_in_blj = 1;
