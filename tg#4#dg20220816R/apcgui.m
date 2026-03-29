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

% Last Modified by GUIDE v2.5 16-Jun-2022 12:30:39

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
global first_time_connect_flag airgaspotial gpc_a gpc_lmd  luwen_set temprature_time airpressure_sp pressure_sp
global daobj group A B P yr gpcmv workpoint apc_on saturate gap_on lastsave temprature_on paiyan_set airfa_set gasfa_set  air_valve gas_valve
global wait_on deadzone  GuFeng_on temp_open tempu upid_old
global alarm_button_clicked alarm_sound_flag alarm_timer steeldata addmvsign flow_max flow_min
global gaspressure_sp junregpcflag overtoptimes flowsetoffflag choose_fj krb1 krb2 krb3
global temp1_flag temp2_flag temp3_flag temp4_flag huanxiang_first huanxiang_second air_pressure_huanxiang
global wait_warm wait_minutes wait_minutes1 wait1 first_time_connect_flag1
global flow_max1 flow_max2 flow_max3 flow_min1 flow_min2 flow_min3
global dengwen luya_press steel_num air_value gas_value runTime
global kongyanprop meiyanprop luyabili luyabili_a air_stop gas_stop upid
global kongyan_kp kongyan_ki meiyan_kp meiyan_ki  air_kp air_ki gas_kp gas_ki gas_gpc_lmd gas_gpc_a  air_kp_da air_ki_da gas_kp_da gas_ki_da gas_gpc_lmd_da gas_gpc_a_da 
global fengji_canshu luya_canshu temp_buchang flow_buchang main_lj time_clock1 disconnect_time during_time
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to apcgui (see VARARGIN)

% Choose default command line output for apcgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% 关闭相关警告设置
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

% UIWAIT makes apcgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%初始化参数;
main_lj = 0;
runTime=0;
air_stop = [0 0 0];
gas_stop = [0 0 0];
air_value=[50 50 50];
gas_value=[50 50 50];
steel_num = 1;
dengwen = 0;
wait_warm = 0; % 是否待温  1待温 0否
krb1 = 0;
krb2 = 0;
krb3 = 0;
air_pressure_huanxiang = 4.6;
huanxiang_first = 0;
huanxiang_second = 0;
choose_fj = 0; %默认不选择
flowsetoffflag=0;
junregpcflag = 0; %默认均热段不启动gpc计算（因为该厂流量计在低阀位时不准）
overtoptimes = zeros(1,3);
addmvsign = 0;  %控制炉压时需要调节排烟阀门
alarm_sound_flag = 0; %报警声标志
alarm_timer = 120; %再次报警倒计时
alarm_button_clicked = 0; %是否点击报警按钮（点击后会暂时消失）
first_time_connect_flag=1;
first_time_connect_flag1=1;
luya_press = 35;
%gpc initialize
% A=[-0.9887 1;-0.9901 1;-0.9898 1;-0.9798 1];%%%%%均热-0.9873
% B=[8.402e-5;4.416e-5;1.715e-5;2.886e-4];%%%+1.81065e-4

% A=[-0.9478 1;-0.9475 1;-0.9535 1];
% B=[0.002055;0.0001804;0.0002004];
% workpoint=[1152,6769.8;1270.6,14963;1269,8691.4];
% 1s
% A=[-0.995223768714290,1;-0.996488371205284,1;-0.999865680982166,1];
% B=[2.418442146028103e-05;1.277648176709758e-05;8.478357918464302e-06];
% 10s
A=[-0.9533,1;-0.9654,1;-0.9987,1];
B=[0.0002367;0.0001258;8.473e-05];
workpoint=[1.553677665900000e+04,1.075370031700000e+03;2.077503489908333e+04,1.220026901289333e+03;9.726504469038095e+03,1.180778577847619e+03];
P=[0.01,0.01;0.01,0.01];
gpc_a=[0.75;0.95;0.95];
gpc_lmd=[0.006;0.006;0.006]; 
yr=[20;20;20];
% workpoint=[1213.086,11155.7;1131.8,13660;1217.4,6452.3;1217.5,6851.2];%%%%+
% workpoint=[1217,8965.9;996.9,9533.2;852,5579.5;1177.8,9862.3];
apc_on=[0;0;0];
gap_on=[0;0;0];
gpcmv=[];
airgaspotial=[0.74 0.74 0.75];
airpressure_sp=4.8;
gaspressure_sp=6.5;
pressure_sp=9;
paiyan_set=[130 130 130];
luwen_set=[1120 1260 1280];
airfa_set=[50 50 50];
gasfa_set=[50 50 50];
air_valve=[0 0 0];
gas_valve=[0 0 0];
upid=zeros(1,19);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
steeldata=xml_read('steel_set.xml');
disconnect_time = steeldata.time(1,1).parameter.ATTRIBUTE.disconnect_time;
during_time = steeldata.time(1,1).parameter.ATTRIBUTE.during_time;
% % % OPCIP=steeldata.common(1,1).parameter.ATTRIBUTE.OPCIP;
% % % OPCServer=steeldata.common(1,1).parameter.ATTRIBUTE.OPCServer;
% % % daobj=opcda(OPCIP,OPCServer);
% % % %这里默认是超出10s即退出连接，有时现场网络慢，需要加长这个时间
% % % %daojb.Timeout=30s; 
% % % group = addgroup(daobj);
time_clock1 = steeldata.common(1,1).parameter.ATTRIBUTE.initime;


flow_max3 = steeldata.flow_limit.parameter(3).ATTRIBUTE.flow3_max;
flow_max2 = steeldata.flow_limit.parameter(2).ATTRIBUTE.flow2_max;
flow_max1 = steeldata.flow_limit.parameter(1).ATTRIBUTE.flow1_max;

flow_min1 = steeldata.flow_limit.parameter(1).ATTRIBUTE.flow1_min;
flow_min2 = steeldata.flow_limit.parameter(2).ATTRIBUTE.flow2_min;
flow_min3 = steeldata.flow_limit.parameter(3).ATTRIBUTE.flow3_min;
% flow_min(4) = steeldata.common(1,1).parameter.ATTRIBUTE.flow4_min;
% pid gpc 参数设置
val = 1;
fengji_canshu(1) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji1_kp;
fengji_canshu(2) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji1_ki;
fengji_canshu(3) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji2_kp;
fengji_canshu(4) = steeldata.fengji(val,1).parameter.ATTRIBUTE.fengji2_ki;
luya_canshu(1) = steeldata.luya(val,1).parameter.ATTRIBUTE.luya_kp;
luya_canshu(2) = steeldata.luya(val,1).parameter.ATTRIBUTE.luya_ki;

kongyan_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(1)= steeldata.jiayi(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(1) = steeldata.jiayi(val,1).parameter.ATTRIBUTE.flow_buchang;
 
kongyan_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(2)= steeldata.jiaer(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(2) = steeldata.jiaer(val,1).parameter.ATTRIBUTE.flow_buchang;

kongyan_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.kongyan_kp;
kongyan_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.kongyan_ki;
meiyan_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.meiyan_kp;
meiyan_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.meiyan_ki;
air_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_kp;
air_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_ki;
gas_kp(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_kp;
gas_ki(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_ki;
gas_gpc_lmd(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_lmd;
gas_gpc_a(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_a;
air_kp_da(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.air_kp_da;
air_ki_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.air_ki_da;
gas_kp_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gas_kp_da;
gas_ki_da(3)= steeldata.junre(val,1).parameter.ATTRIBUTE.gas_ki_da;
gas_gpc_lmd_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_lmd_da;
gas_gpc_a_da(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.gpc_a_da;
temp_buchang(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.temp_buchang;
flow_buchang(3) = steeldata.junre(val,1).parameter.ATTRIBUTE.flow_buchang;
%初始化热料
kongyanprop(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.kongyan1_prop;
kongyanprop(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.kongyan2_prop;
kongyanprop(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.kongyan3_prop;
meiyanprop(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.meiyan1_prop;
meiyanprop(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.meiyan2_prop;
meiyanprop(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.meiyan3_prop;

luyabili(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.luyabili1_g;
luyabili(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.luyabili2_g;
luyabili(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.luyabili3_g;
luyabili_a(1) = steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.luyabili1_a;
luyabili_a(2) = steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.luyabili2_a;
luyabili_a(3) = steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.luyabili3_a;

wait_on=zeros(4,1);         %一加热段、二加热段、均热段待轧判别
% do_it=2;
temp_open=zeros(4,1);
GuFeng_on=0;
temprature_time = 0;
temprature_on = 0;
upid_old = zeros(17,1);
% deadzone=zeros(3,1);%煤气流量阀位 空气流量阀位 烟气流量阀位
deadzone=[1;1;1];%煤气流量阀位 空气流量阀位 烟气流量阀位
tempu=zeros(4,1);%煤气流量计算值
lastsave='none';
saturate=[1;1;1];%0:low 1:normal 2:high 下饱和 正常 上饱和
%% 炉温设定值初始化
mid_luwen1=luwen_set(1);
set(handles.ts_1,'String',mid_luwen1);
set(handles.T_slider1,'Value',mid_luwen1);
set(handles.T_slider1,'Max',mid_luwen1+100,'Min',mid_luwen1-200);
set(handles.T_slider1,'SliderStep',[1/300,5/300]);

mid_luwen2=luwen_set(2);
set(handles.ts_2,'String',mid_luwen2);
set(handles.T_slider2,'Value',mid_luwen2);
set(handles.T_slider2,'Max',mid_luwen2+180,'Min',mid_luwen2-220);
set(handles.T_slider2,'SliderStep',[1/400,5/400]);

mid_luwen3=luwen_set(3);
set(handles.ts_3,'String',mid_luwen3);
set(handles.T_slider3,'Value',mid_luwen3);
set(handles.T_slider3,'Max',mid_luwen3+190,'Min',mid_luwen3-210);
set(handles.T_slider3,'SliderStep',[1/400,5/400]);

% % % mid_luwen4=luwen_set(4);
% % % set(handles.ts_4,'String',mid_luwen4);
% % % set(handles.T_slider4,'Value',mid_luwen4);
% % % set(handles.T_slider4,'Max',mid_luwen3+190,'Min',mid_luwen3-210);
% % % set(handles.T_slider4,'SliderStep',[1/400,5/400]);
%% 待温设置
wait_warm = 0; % 是否待温  1待温 0否
set(handles.button_temp,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
set(handles.leftTime1,'Visible','off');
set(handles.leftTime,'Visible','off');
    
%% 空燃比初始化
mid_agp1=airgaspotial(1);
set(handles.agp1_set,'String',mid_agp1);
set(handles.P_slider1,'Value',mid_agp1);
set(handles.P_slider1,'Max',mid_agp1+0.7,'Min',mid_agp1-0.3);
set(handles.P_slider1,'SliderStep',[0.01/1,0.02/1]);

% mid_2=str2num(get(handles.agp_2,'String'));
mid_agp2=airgaspotial(2);
set(handles.agp2_set,'String',mid_agp2);
set(handles.P_slider2,'Value',mid_agp2);
set(handles.P_slider2,'Max',mid_agp2+0.7,'Min',mid_agp2-0.3);
set(handles.P_slider2,'SliderStep',[0.01/1,0.02/1]);

% mid_3=str2num(get(handles.agp_3,'String'));
mid_agp3=airgaspotial(3);
set(handles.agp3_set,'String',mid_agp3);
set(handles.P_slider3,'Value',mid_agp3);
set(handles.P_slider3,'Max',mid_agp3+0.7,'Min',mid_agp3-0.3);
set(handles.P_slider3,'SliderStep',[0.01/1,0.02/1]);

% % % mid_agp4=airgaspotial(4);
% % % set(handles.agp4_set,'String',mid_agp4);
% % % set(handles.P_slider4,'Value',mid_agp4);
% % % set(handles.P_slider4,'Max',mid_agp4+0.7,'Min',mid_agp4-0.3);
% % % set(handles.P_slider4,'SliderStep',[0.01/1,0.02/1]);
%% 排烟温度设定值初始化
mid_paiyan1=paiyan_set(1);
set(handles.smoke_ta1_set,'String',mid_paiyan1);
set(handles.smoke_tg1_set,'String',mid_paiyan1);
set(handles.smoke_ta1_slider1_set,'Value',mid_paiyan1);
set(handles.smoke_tg1_slider1_set,'Value',mid_paiyan1);
set(handles.smoke_ta1_slider1_set,'Max',mid_paiyan1+60,'Min',mid_paiyan1-60);
set(handles.smoke_tg1_slider1_set,'Max',mid_paiyan1+60,'Min',mid_paiyan1-60);
set(handles.smoke_ta1_slider1_set,'SliderStep',[1/120,5/120]);
set(handles.smoke_tg1_slider1_set,'SliderStep',[1/120,5/120]);

mid_paiyan2=paiyan_set(2);
set(handles.smoke_ta2_set,'String',mid_paiyan2);
set(handles.smoke_tg2_set,'String',mid_paiyan2);
set(handles.smoke_ta2_slider2_set,'Value',mid_paiyan2);
set(handles.smoke_tg2_slider2_set,'Value',mid_paiyan2);
set(handles.smoke_ta2_slider2_set,'Max',mid_paiyan2+60,'Min',mid_paiyan2-60);
set(handles.smoke_tg2_slider2_set,'Max',mid_paiyan2+60,'Min',mid_paiyan2-60);
set(handles.smoke_ta2_slider2_set,'SliderStep',[1/120,5/120]);
set(handles.smoke_tg2_slider2_set,'SliderStep',[1/120,5/120]);

mid_paiyan3=paiyan_set(3);
set(handles.smoke_ta3_set,'String',mid_paiyan3);
set(handles.smoke_tg3_set,'String',mid_paiyan3);
set(handles.smoke_ta3_slider3_set,'Value',mid_paiyan3);
set(handles.smoke_tg3_slider3_set,'Value',mid_paiyan3);
set(handles.smoke_ta3_slider3_set,'Max',mid_paiyan3+60,'Min',mid_paiyan3-60);
set(handles.smoke_tg3_slider3_set,'Max',mid_paiyan3+60,'Min',mid_paiyan3-60);
set(handles.smoke_ta3_slider3_set,'SliderStep',[1/120,5/120]);
set(handles.smoke_tg3_slider3_set,'SliderStep',[1/120,5/120]);

% % % mid_paiyan4=paiyan_set(4);
% % % set(handles.smoke_ta4_set,'String',mid_paiyan4);
% % % set(handles.smoke_tg4_set,'String',mid_paiyan4);
% % % set(handles.smoke_ta4_slider4_set,'Value',mid_paiyan4);
% % % set(handles.smoke_tg4_slider4_set,'Value',mid_paiyan4);
% % % set(handles.smoke_ta4_slider4_set,'Max',mid_paiyan4+60,'Min',mid_paiyan4-60);
% % % set(handles.smoke_tg4_slider4_set,'Max',mid_paiyan4+60,'Min',mid_paiyan4-60);
% % % set(handles.smoke_ta4_slider4_set,'SliderStep',[1/120,5/120]);
% % % set(handles.smoke_tg4_slider4_set,'SliderStep',[1/120,5/120]);
%% 空气压力设定值初始化
mid_airpre=airpressure_sp;
set(handles.air_pressure_sp,'String',mid_airpre);
set(handles.air_pressure_slider,'Value',mid_airpre); 
set(handles.air_pressure_slider,'Max',mid_airpre+5,'Min',mid_airpre-5);
set(handles.air_pressure_slider,'SliderStep',[0.1/10,0.2/10]);
 
 %% 煤气压力设定值初始化
mid_gaspre=gaspressure_sp;
set(handles.gas_pressure_sp,'String',mid_gaspre);
set(handles.gas_pressure_slider,'Value',mid_gaspre); 
set(handles.gas_pressure_slider,'Max',mid_gaspre+5,'Min',mid_gaspre-5);
set(handles.gas_pressure_slider,'SliderStep',[0.1/10,0.2/10]);
%% 炉压设定值
luya=30;
set(handles.luya_set,'String',luya);
set(handles.luya_slider,'Value',luya); 
set(handles.luya_slider,'Max',luya+40,'Min',luya-20);
set(handles.luya_slider,'SliderStep',[1/60,2/60]);
%% 空煤烟引风机
kongyan1=30;
set(handles.ky_yfj,'String',5);
set(handles.ky_yfj_slider,'Value',5); 
set(handles.ky_yfj_slider,'Max',kongyan1+10,'Min',kongyan1-30);
set(handles.ky_yfj_slider,'SliderStep',[0.1/40,0.5/40]);
meiyan1=30;
set(handles.my_yfj,'String',5);
set(handles.my_yfj_slider,'Value',5); 
set(handles.my_yfj_slider,'Max',meiyan1+10,'Min',meiyan1-30);
set(handles.my_yfj_slider,'SliderStep',[0.1/40,0.5/40]);

%% 流量上下限设定
set(handles.first_up_text,'String',flow_max1);
set(handles.first_up_slider,'Value',flow_max1); 
set(handles.first_up_slider,'Max',26000,'Min',10000);
set(handles.first_up_slider,'SliderStep',[100/16000,500/16000]);

set(handles.second_up_text,'String',flow_max2);
set(handles.second_up_slider,'Value',flow_max2); 
set(handles.second_up_slider,'Max',34000,'Min',15000);
set(handles.second_up_slider,'SliderStep',[100/19000,500/19000]);

set(handles.third_up_text,'String',flow_max3);
set(handles.third_up_slider,'Value',flow_max3); 
set(handles.third_up_slider,'Max',19000,'Min',10000);
set(handles.third_up_slider,'SliderStep',[100/9000,500/9000]);

set(handles.first_down_text,'String',flow_min1);
set(handles.first_down_slider,'Value',flow_min1); 
set(handles.first_down_slider,'Max',25000,'Min',3000);
set(handles.first_down_slider,'SliderStep',[100/22000,500/22000]);

set(handles.second_down_text,'String',flow_min2);
set(handles.second_down_slider,'Value',flow_min2); 
set(handles.second_down_slider,'Max',25000,'Min',3000);
set(handles.second_down_slider,'SliderStep',[100/22000,500/22000]);

set(handles.third_down_text,'String',flow_min3);
set(handles.third_down_slider,'Value',flow_min3); 
set(handles.third_down_slider,'Max',15000,'Min',3000);
set(handles.third_down_slider,'SliderStep',[100/12000,500/12000]);
%% 引风机值设定
set(handles.buchang_value,'String',0);
set(handles.buchang_slider,'Value',0); 
set(handles.buchang_slider,'Max',5,'Min',-5);
set(handles.buchang_slider,'SliderStep',[1/10,2/10]);

set(handles.yfj_max_value,'String',39);
set(handles.yfj_slider_max,'Value',39); 
set(handles.yfj_slider_max,'Max',45,'Min',30);
set(handles.yfj_slider_max,'SliderStep',[1/15,2/15]);

set(handles.yfj_min_value,'String',33);
set(handles.yfj_slider_min,'Value',33); 
set(handles.yfj_slider_min,'Max',45,'Min',20);
set(handles.yfj_slider_min,'SliderStep',[1/25,2/25]);

%% 炉膛压力设定值初始化
% % % mid_pre=pressure_sp;
% % % set(handles.gas_pressure_sp,'String',mid_pre);
% % % set(handles.gas_pressure_slider,'Value',mid_airpre); 
% % % set(handles.gas_pressure_slider,'Max',mid_airpre+5,'Min',mid_airpre-3);
% --- Outputs from this function are returned to the command line.

%% 温度选择初始化  1表示选择A侧 0表示选择B侧
temp1_flag = 1; %加一段
set(handles.temp1_nan,'BackgroundColor',[0 1 0]);
set(handles.temp1_bei,'BackgroundColor',[0.941 0.941 0.941]);
temp2_flag = 1; %加二段
set(handles.temp2_nan,'BackgroundColor',[0 1 0]);
set(handles.temp2_bei,'BackgroundColor',[0.941 0.941 0.941]);
temp3_flag = 1; %加三段
set(handles.temp3_nan,'BackgroundColor',[0 1 0]);
set(handles.temp3_bei,'BackgroundColor',[0.941 0.941 0.941]);
% % % temp4_flag = 1; %均热
% % % set(handles.temp4_nan,'BackgroundColor',[0 1 0]);
% % % set(handles.temp4_bei,'BackgroundColor',[0.941 0.941 0.941]);



function varargout = apcgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function menu_about_Callback(hObject, eventdata, handles)
% hObject    handle to menu_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',about);

% --------------------------------------------------------------------
function menu_copyright_Callback(hObject, eventdata, handles)
% hObject    handle to menu_copyright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hm = msgbox('唐山科新节能技术有限公司版权所有','版权信息');
% set(0,'CurrentFigure',about);
% newIcon = javax.swing.ImageIcon('icon.png')
% figFrame = get(hm,'JavaFrame'); %取得Figure的JavaFrame。
% figFrame.setFigureIcon(newIcon); %修改图标


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global daobj auth daobj1

% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
quesbutton=questdlg('确定退出？','退出程序','是','否','是');
if strcmp(quesbutton,'是') 
    if ~isempty(timerfind)
        stop(timerfind)
        delete(timerfind)
    end
    if ~isempty(daobj) && strcmp(daobj.Status,'connected')
        disconnect(daobj)
    end
    if ~isempty(daobj1) && strcmp(daobj1.Status,'connected')
        disconnect(daobj1)
    end
    delete(hObject);
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in connectwincc.
function connectwincc_Callback(hObject, eventdata, handles)
global daobj group tempdata data  itemset  first_time_connect_flag auth pidloop loopnum steeldata diff_time during_time
global daobj1 first_time_connect_flag1 group1 itemset1 pidloop1 loopnum1 steeldata1 data1 tempdata1 main_lj time_clock1
global disconnect_time
% hObject    handle to connectwincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nowTime = clock;
disconnect_time = steeldata.time(1,1).parameter.ATTRIBUTE.disconnect_time;
diff_time = etime(nowTime,str2num(disconnect_time))/3600;
if diff_time >= 24
    during_time = during_time+diff_time;
end
steeldata.time(1,1).parameter.ATTRIBUTE.during_time = during_time;
xml_write('steel_set.xml',steeldata);


set(handles.connectwincc,'Enable','off')
auth=0;%当其为0时即无法工作
% id = hostid;
% if strcmp(id{1},'161051')
%读写key文件
OPCIP=steeldata.common(1,1).parameter.ATTRIBUTE.OPCIP;
OPCServer=steeldata.common(1,1).parameter.ATTRIBUTE.OPCServer;
OPCIP1=steeldata.common(1,1).parameter.ATTRIBUTE.OPCIP1;
OPCServer1=steeldata.common(1,1).parameter.ATTRIBUTE.OPCServer1;
daobj=opcda(OPCIP,OPCServer);
daobj1=opcda(OPCIP1,OPCServer1);
%这里默认是超出10s即退出连接，有时现场网络慢，需要加长这个时间
%daojb.Timeout=30s; 
group = addgroup(daobj);
group1 = addgroup(daobj1);
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
            first_time_connect_flag=1;
%% additem初始化参数
        connect(daobj);
        itemset=additem(group, {'YJKQ_PQ',...
                                '一加热段空气流量阀体反馈',...
                                'YJMQ_PQ',...
                                '一加热段煤气流量阀体反馈',...
                                '一加热段空气流量',...
                                '一加热段煤气流量',...
                                'B侧1组空烟温度',...
                                'B侧1组煤烟温度',...
                                '换向当前时间',...
                                '一加热段B侧炉顶温度',...
                                'YJKY_PQ',...
                                '一加热段空烟流量阀体反馈',...
                                'YJMY_PQ',...
                                '一加热段煤烟流量阀体反馈',...
                                '一加热段A侧炉顶温度',...
                                'EJKQ_PQ',...
                                '二加热段空气流量阀体反馈',...
                                'EJMQ_PQ',...
                                '二加热段煤气流量阀体反馈',...
                                '二加热段空气流量',...
                                '二加热段煤气流量',...
                                'B侧2组空烟温度',...
                                'B侧2组煤烟温度',...
                                'kyfj_hz',...
                                '二加热段B侧炉顶温度',...
                                'EJKY_PQ',...
                                '二加热段空烟流量阀体反馈',...
                                'EJMY_PQ',...
                                '二加热段煤烟流量阀体反馈',...
                                '二加热段A侧炉顶温度',...
                                'JRKQ_PQ',...
                                '均热段空气流量阀体反馈',...
                                'JRMQ_PQ',...
                                '均热段煤气流量阀体反馈',...
                                '均热段空气流量',...
                                '均热段煤气流量',...
                                'B侧3组空烟温度',...
                                'B侧3组煤烟温度',...
                                '换向周期设定',...
                                '均热段B侧炉顶温度',...
                                'JRKY_PQ',...
                                '均热段空烟气流量阀体反馈',...
                                'JRMY_PQ',...
                                '均热段煤烟气流量阀体反馈',...
                                '均热段A侧炉顶温度',...
                                'B侧4组空烟温度',...
                                'B侧4组煤烟温度',...
                                'B侧5组空烟温度',...
                                'B侧5组煤烟温度',...
                                '炉膛压力',...
                                '空气总管压力',...
                                '煤气总管压力',...
                                'zr0_sd',...
                                'zr_sd',...
                                'A侧1组空烟温度',...
                                'A侧1组煤烟温度',...
                                'A侧2组空烟温度',...
                                'A侧2组煤烟温度',...
                                '煤气流量累计',...
                                '空气流量累计',...
                                'A侧3组空烟温度',...
                                'A侧3组煤烟温度',...
                                'A侧4组空烟温度',...
                                'A侧4组煤烟温度',...
                                'A侧5组空烟温度',...
                                'A侧5组煤烟温度'...
                                'YHL3-FK'...
                                'YHL2-FK'...
                                'YHL1-FK'...
                                'A1阀门处于燃烧状态'...
                                '热值仪'...
                                '高温计'});
           
          %% connect to opcserver,init data 进行连接
            connect(daobj);
            % tempdata=read(group);
            % data=tempdata;
            tempdata=read(group);
            data=zeros(length(tempdata)+60,1);%初始化data
            data(1:6,1)=fix(clock);% fix是化小数为整数，方法是舍去小数部分，clock是6x1的向量，其元素是日期（年月日时分秒），且第一列的元素全为日期，向量可以拓展，即列数可以增加。除第一列外，每列元素均为84+12个PID的值
            %% prepare pidloop and pid parameter
            loopnum=18;% 实际前14个有效：一加煤气 二加煤气 三加煤气 一加空气 二加空气 三加空气 一加空烟 二加空烟 三加空烟 一加煤烟 二加煤烟 三加煤烟 空气总管压力 煤气总管压力 均热煤气 均热空气 均热空烟 均热煤烟
            % pidloop=zeros(9,loopnum);
            pidloop=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%sp    1
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%pv    2
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%mv    3
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%e0    4
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%e1    5
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%e2   6
                     0.003 0.003 0.003 0.0035 0.0062 0.006 0.006 0.0065 0.9 0.92 0.85 0.85 0.82 0.82 0.82 0.82 3.5 3.5 0 0 0 0;%kp    7
                     %30 30 30 30 30 30;%ti
                     60 65 65 55 55 60 60 50 75 65 70 75 55 70 70 70 50 60 0 0 0 0;%ti    8
                     
                     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;%td    9
                     1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;%man_on    10
                     71 71 71 71 51 51 51 51 51 51 51 51 51 51 51 51 50 50 51 51 50 50;%upperlimit    11
                     5  5  5   5   5  5  5  5 5  5  5  5 5 5 5 5 28 28 5 5 5 5;%lowerlimit    12
                     3 3 3 3 3 3 1 1 1 1 1 1 0.2 1 1 1 0 0 1 1 1 1;%deadzone    13
                     ];



        else
            itemset=additem(group, {'YJKQ_PQ',...
                                '一加热段空气流量阀体反馈',...
                                'YJMQ_PQ',...
                                '一加热段煤气流量阀体反馈',...
                                '一加热段空气流量',...
                                '一加热段煤气流量',...
                                'B侧1组空烟温度',...
                                'B侧1组煤烟温度',...
                                '换向当前时间',...
                                '一加热段B侧炉顶温度',...
                                'YJKY_PQ',...
                                '一加热段空烟流量阀体反馈',...
                                'YJMY_PQ',...
                                '一加热段煤烟流量阀体反馈',...
                                '一加热段A侧炉顶温度',...
                                'EJKQ_PQ',...
                                '二加热段空气流量阀体反馈',...
                                'EJMQ_PQ',...
                                '二加热段煤气流量阀体反馈',...
                                '二加热段空气流量',...
                                '二加热段煤气流量',...
                                'B侧2组空烟温度',...
                                'B侧2组煤烟温度',...
                                'kyfj_hz',...
                                '二加热段B侧炉顶温度',...
                                'EJKY_PQ',...
                                '二加热段空烟流量阀体反馈',...
                                'EJMY_PQ',...
                                '二加热段煤烟流量阀体反馈',...
                                '二加热段A侧炉顶温度',...
                                'JRKQ_PQ',...
                                '均热段空气流量阀体反馈',...
                                'JRMQ_PQ',...
                                '均热段煤气流量阀体反馈',...
                                '均热段空气流量',...
                                '均热段煤气流量',...
                                'B侧3组空烟温度',...
                                'B侧3组煤烟温度',...
                                '换向周期设定',...
                                '均热段B侧炉顶温度',...
                                'JRKY_PQ',...
                                '均热段空烟气流量阀体反馈',...
                                'JRMY_PQ',...
                                '均热段煤烟气流量阀体反馈',...
                                '均热段A侧炉顶温度',...
                                'B侧4组空烟温度',...
                                'B侧4组煤烟温度',...
                                'B侧5组空烟温度',...
                                'B侧5组煤烟温度',...
                                '炉膛压力',...
                                '空气总管压力',...
                                '煤气总管压力',...
                                'zr0_sd',...
                                'zr_sd',...
                                'A侧1组空烟温度',...
                                'A侧1组煤烟温度',...
                                'A侧2组空烟温度',...
                                'A侧2组煤烟温度',...
                                '煤气流量累计',...
                                '空气流量累计',...
                                'A侧3组空烟温度',...
                                'A侧3组煤烟温度',...
                                'A侧4组空烟温度',...
                                'A侧4组煤烟温度',...
                                'A侧5组空烟温度',...
                                'A侧5组煤烟温度'...
                                'YHL3-FK'...
                                'YHL2-FK'...
                                'YHL1-FK'...
                                'A1阀门处于燃烧状态'...
                                '热值仪'...
                                '高温计'});
            connect(daobj);
        end
        
        t_iohandle = timer('Name','apctimer','TimerFcn', {@onTimer_io_4duan, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器
        start(t_iohandle);%启动定时器
        main_lj = 1;
        %% 第二个opc链接
%         if strcmp(daobj1.Status,'disconnected')%这里即是判断是否处于连接状态，如果没有处于连接状态的做法
%             if first_time_connect_flag1==1%当没有处于连接状态时，一定要让这个变量处于0，才能连接。
%                 first_time_connect_flag1=0;
%                 connect(daobj1);
%                itemset1=additem(group1, {  
%                         'v4.DPU1002.SH0001.PA1.OUT',...
%                         'v4.DPU1002.HW.AI010201.PV',...
%                         'v4.DPU1002.SH0001.PA2.OUT',...
%                         'v4.DPU1002.HW.AI010202.PV',...
%                         'v4.DPU1002.HW.AI030101.PV',...
%                         'V4.DPU1002.SH0021.BALM1.PV',...
%                         'V4.DPU1002.SH0022.BALM1.PV',...
%                         'V4.DPU1002.HW.AQ010101.PV',...
%                         'V4.DPU1002.HW.AQ010102.PV'});
%                 tempdata1=read(group1);
%                 data1=zeros(length(tempdata1)+60,1);%初始化data
%                 data1(1:6,1)=fix(clock);
%                 loopnum1 = 13;
%                 pidloop1=[0 0 0 0 0 0 0 0 0 0 0 0 0 ;%sp
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%pv
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%mv
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e0
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e1
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%e2
%                       0.001 0.001 0.0029 0.0066 0.0061 0.0061 0.9 0.92 0.70 0.82 0.82 0.35 4 ;%kp  Need_to_be_modified
%                    
%                       88 90 90 75 75 50 75 65 95 55 70 110 30 ;%ti  Need_to_be_modified
%                       
%                       0 0 0 0 0 0 0 0 0 0 0 0 0 ;%td  
%                       1 1 1 1 1 1 1 1 1 1 1 1 1 ;%man_on
%                       100 100 100 100 100 100 100 100 100 100 100 100 65 ;%upperlimit  Need_to_be_modified
%                       5  7  6   10   7   16  6  6  5  6  5  5 20 ;%lowerlimit  Need_to_be_modified
%                       1 1 1 1 1 1 1 1 1 1 1 1 0 ;%deadzone  Need_to_be_modified
%                       ];
%             else
%                 itemset1=additem(group1, {  
%                         'v4.DPU1002.SH0001.PA1.OUT',...
%                         'v4.DPU1002.HW.AI010201.PV',...
%                         'v4.DPU1002.SH0001.PA2.OUT',...
%                         'v4.DPU1002.HW.AI010202.PV',...
%                         'v4.DPU1002.HW.AI030101.PV',...
%                         'V4.DPU1002.SH0021.BALM1.PV',...
%                         'V4.DPU1002.SH0022.BALM1.PV',...
%                         'V4.DPU1002.HW.AQ010101.PV',...
%                         'V4.DPU1002.HW.AQ010102.PV'});
%                 connect(daobj1);
%             end
% %             t_iohandle1 = timer('Name','apctimer1','TimerFcn', {@on_timer1, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器 
% %                 start(t_iohandle1);%启动定时器
%         end
        %% 
         set(handles.text1,'String','已连接');
%        set(handles.connectwincc,'Enable','off')
         set(handles.disconnect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
         set(handles.connectwincc,'BackgroundColor',[0 1 0]);
        else
            msgbox('已经连接，不需要重复点击','提示')
        end

else
    auth=0;
    close(handles.figure1);%关闭figure
end
set(handles.connectwincc,'Enable','on')


% --- Executes on button press in disconnect_wincc.
function disconnect_wincc_Callback(hObject, eventdata, handles)
global daobj pidloop temp_open gap_on conn data tempdata
global daobj1 tempdata1 data1 air_stop gas_stop main_lj disconnect_time steeldata

% hObject    handle to disconnect_wincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disconnect_time = clock;
steeldata.time(1,1).parameter.ATTRIBUTE.disconnect_time = num2str(disconnect_time);
xml_write('steel_set.xml',steeldata);

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
 data=zeros(length(tempdata)+60,1);
%set(handles.figure1,'ForegroundColor',[0 0 0]); 
%% 引风机连接断开
if strcmp(daobj1.Status,'connected')
    disconnect(daobj1);
    datetime = datestr(now,30);
    s = ['save(''data1',datetime(1:8),datetime(10:13),'.mat'',''data1'');'];
    eval(s);
    lastsave = ['data1',datetime(1:8),datetime(10:13),'.mat'];
end
data1=zeros(length(tempdata1)+60,1);
set(handles.yfj_connect,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yfj_disconnect,'BackgroundColor',[1 0 0]);
set(handles.alarm,'String','引风机连接已经中断，请切回手动');   
set(handles.alarm,'BackgroundColor',[1 0 0]);

%%
set(handles.connectwincc,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);

set(handles.text1,'String','已断开');
% set(handles.connectwincc,'Enable','on')
main_lj=0;
%% 排烟温度趋势判断关闭
air_stop(1) = 0;
gas_stop(1) = 0;
air_stop(2) = 0;
gas_stop(2) = 0;
air_stop(3) = 0;
gas_stop(3) = 0;
%% 炉温开关全部关闭
temp_open(1,1)=0;
temp_open(2,1)=0;
temp_open(3,1)=0;
% % % temp_open(4,1)=0;
set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon1_close,'BackgroundColor',[1 0 0]);
set(handles.apcon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon2_close,'BackgroundColor',[1 0 0]);
set(handles.apcon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon3_close,'BackgroundColor',[1 0 0]);
% % % set(handles.apcon4_open,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.apcon4_close,'BackgroundColor',[1 0 0]);

%% 烟温以及压力开关全部关闭
pidloop(10,7)=1;
pidloop(10,8)=1;
pidloop(10,9)=1;
pidloop(10,10)=1;
pidloop(10,11)=1;
pidloop(10,12)=1;
pidloop(10,13)=1;
pidloop(10,14)=1;
pidloop(10,17)=1;
pidloop(10,18)=1;
set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc1_close,'BackgroundColor',[1 0 0]);
set(handles.tsc2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc2_close,'BackgroundColor',[1 0 0]);
set(handles.tsc3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc3_close,'BackgroundColor',[1 0 0]);
set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc4_close,'BackgroundColor',[1 0 0]);
set(handles.air_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.air_pressure_close,'BackgroundColor',[1 0 0]);
set(handles.gas_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gas_pressure_close,'BackgroundColor',[1 0 0]);
%% 空燃比开关全部关闭
gap_on=[0;0;0];
pidloop(10,4)=1;
pidloop(10,5)=1;
pidloop(10,6)=1;
pidloop(10,16)=1;
set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon1_close,'BackgroundColor',[1 0 0]);
set(handles.gapon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon2_close,'BackgroundColor',[1 0 0]);
set(handles.gapon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon3_close,'BackgroundColor',[1 0 0]);
% % % set(handles.gapon4_open,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.gapon4_close,'BackgroundColor',[1 0 0]);
% --- Executes on selection change in steeltype_pop.
function steeltype_pop_Callback(hObject, eventdata, handles)
global waitparameter t1sp t2sp t3sp t4sp steeldata  gas1_limit gas2_limit gas3_limit gas4_limit slect_gang row  val  wait_time_select
global A B workpoint
% hObject    handle to steeltype_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns steeltype_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from steeltype_pop
val = get(hObject,'Value');%获取钢种的类型  1 2 3 4
slect_gang=val;%根据选择钢种选择流量上下限
%% 根据选择配置钢种控制参数
steeldata=xml_read('steel_set.xml');
t1sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t1;
t2sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t2;
t3sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t3;
t4sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t4;

gas1_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f1;
gas2_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f2;
gas3_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f3;
gas4_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f4;

[l temp]=size(steeldata.steeltype(val,1).parameter.wait);
waitparameter=zeros(l,4);
for i=1:l
    waitparameter(i,:)=[steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.minute ...
                      steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.t1     ...
                      steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.t2     ...
                      steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.t3     ...
                      steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.t4     ...

%                       steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.dj     ...
%                       steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.d1     ...
%                       steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.d2     ...
                      
                     ];
end
wait_time_select=cell(l,1);
for i=1:l
    wait_time_select{i}=[num2str(steeldata.steeltype(val,1).parameter.wait(i).ATTRIBUTE.minute) '分钟'];
end

set(handles.ts_1,'String',t1sp);
set(handles.ts_2,'String',t2sp);
set(handles.ts_3,'String',t3sp);
set(handles.ts_4,'String',t4sp);


%%%滑块值初始化%%%%%%%
set(handles.ts_1,'String',num2str(t1sp));
% mid_1=str2num(get(handles.ts_1,'String'));
set(handles.T_slider1,'Value',t1sp);
set(handles.T_slider1,'Max',t1sp+100,'Min',t1sp-200);
set(handles.T_slider1,'SliderStep',[1/300,5/300]);
%%
set(handles.ts_2,'String',num2str(t2sp));
% mid_2=str2num(get(handles.ts_2,'String'));
set(handles.T_slider2,'Value',t2sp);
set(handles.T_slider2,'Max',t2sp+180,'Min',t2sp-220);
set(handles.T_slider2,'SliderStep',[1/400,5/400]);
%%
set(handles.ts_3,'String',num2str(t3sp));
% mid_3=str2num(get(handles.ts_3,'String'));
set(handles.T_slider3,'Value',t3sp);
set(handles.T_slider3,'Max',t3sp+190,'Min',t3sp-210);
set(handles.T_slider3,'SliderStep',[1/400,5/400]);
%%
set(handles.ts_4,'String',num2str(t4sp));
% mid_3=str2num(get(handles.ts_3,'String'));
set(handles.T_slider4,'Value',t4sp);
set(handles.T_slider4,'Max',t4sp+190,'Min',t4sp-210);
set(handles.T_slider4,'SliderStep',[1/400,5/400]);
% --- Executes during object creation, after setting all properties.
function steeltype_pop_CreateFcn(hObject, eventdata, handles)
global ts1_hobj
% hObject    handle to steeltype_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ts1_hobj=hObject;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

%判断当前matlab是不是windows版本，同时当前对象的背景颜色与根对象默认背景颜色(一般为灰色)是不是相同，如果是，那么当前对象的背景色改为白色。
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
steeldata=xml_read('steel_set.xml');
[l temp]=size(steeldata.steeltype);
steeltypestring=cell(l,1);
for i=1:l
    steeltypestring{i}=steeldata.steeltype(i,1).ATTRIBUTE.name;
end
set(hObject,'String',steeltypestring);

% --- Executes on slider movement.
function T_slider1_Callback(hObject, eventdata, handles)
% hObject    handle to T_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管

% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.ts_1,'String',num2str(slide_value));%随着value的值不同，其将会数值将会发生改变，这里num2str的作用是将数字转换为字符串，其实这里不用这个函数也行

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function T_slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function T_slider2_Callback(hObject, eventdata, handles)
% hObject    handle to T_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

% set(handles.ts2,'String',num2str(slide_value));
set(handles.ts_2,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function T_slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function T_slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in apcon1_open.
function apcon1_open_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apcon1_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(1,1)=1;
set(handles.apcon1_open,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.apcon1_close,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色

% --- Executes on button press in apcon2_open.
function apcon2_open_Callback(hObject, eventdata, handles)
global temp_open 
% hObject    handle to apcon2_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(2,1)=1;
set(handles.apcon2_open,'BackgroundColor',[0 1 0]);
set(handles.apcon2_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in apcon1_close.
function apcon1_close_Callback(hObject, eventdata, handles)
global temp_open 
% hObject    handle to apcon1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(1,1)=0;
set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
set(handles.apcon1_close,'BackgroundColor',[1 0 0]);%将close设置为红色

% --- Executes on button press in apcon2_close.
function apcon2_close_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apcon2_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(2,1)=0;
set(handles.apcon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon2_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in apnon_all_open.
function apnon_all_open_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apnon_all_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(1,1)=1;
temp_open(2,1)=1;
temp_open(3,1)=1;
% % % temp_open(4,1)=1; %代表均热段开关
set(handles.apcon1_open,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.apcon1_close,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
set(handles.apcon2_open,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.apcon2_close,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
set(handles.apcon3_open,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.apcon3_close,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
% % % set(handles.apcon4_open,'BackgroundColor',[0 1 0]);%将打开设置为绿色
% % % set(handles.apcon4_close,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色

% --- Executes on button press in apcon_all_close.
function apcon_all_close_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apcon_all_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(1,1)=0;
temp_open(2,1)=0;
temp_open(3,1)=0;
% % % temp_open(4,1)=0;
set(handles.apcon1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon1_close,'BackgroundColor',[1 0 0]);
set(handles.apcon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon2_close,'BackgroundColor',[1 0 0]);
set(handles.apcon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon3_close,'BackgroundColor',[1 0 0]);
% % % set(handles.apcon4_open,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.apcon4_close,'BackgroundColor',[1 0 0]);
% --- Executes during object creation, after setting all properties.
function smoke_ta1_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta1_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% --- Executes on slider movement.

function smoke_ta1_slider1_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_ta1_slider1_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_ta1_set,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function smoke_ta1_slider1_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta1_slider1_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function smoke_ta2_slider2_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_ta2_slider2_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_ta2_set,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function smoke_ta2_slider2_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta2_slider2_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function smoke_ta4_slider4_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function smoke_tg1_slider1_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_tg1_slider1_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_tg1_set,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function smoke_tg1_slider1_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_tg1_slider1_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function smoke_tg2_slider2_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_tg2_slider2_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_tg2_set,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function smoke_tg2_slider2_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_tg2_slider2_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function smoke_tg4_slider4_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_tg4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in tsc1_open.
function tsc1_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to tsc1_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,7)=0;            %空烟温度回路切自动
pidloop(10,10)=0;           %煤烟温度回路切自动
set(handles.tsc1_open,'BackgroundColor',[0 1 0]);
set(handles.tsc1_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in tsc2_open.
function tsc2_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to tsc2_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,8)=0;            %空烟温度回路切自动
pidloop(10,11)=0;           %煤烟温度回路切自动
set(handles.tsc2_open,'BackgroundColor',[0 1 0]);
set(handles.tsc2_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in tsc1_close.
function tsc1_close_Callback(hObject, eventdata, handles)
global pidloop air_stop gas_stop
% hObject    handle to tsc1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,7)=1;%空烟温度回路切自动
pidloop(10,10)=1;%煤烟温度回路切自动
air_stop(1) = 0;
gas_stop(1) = 0;
set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc1_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in tsc2_close.
function tsc2_close_Callback(hObject, eventdata, handles)
global pidloop air_stop gas_stop
% hObject    handle to tsc2_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,8)=1;%空烟温度回路切自动
pidloop(10,11)=1;%煤烟温度回路切自动
air_stop(2) = 0;
gas_stop(2) = 0;
set(handles.tsc2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc2_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in tsc_all_open.
function tsc_all_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to tsc_all_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,7)=0;
pidloop(10,8)=0;
pidloop(10,9)=0;
pidloop(10,10)=0;
pidloop(10,11)=0;
pidloop(10,12)=0;
% % % pidloop(10,17)=0;
% % % pidloop(10,18)=0;
set(handles.tsc1_open,'BackgroundColor',[0 1 0]);
set(handles.tsc1_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc2_open,'BackgroundColor',[0 1 0]);
set(handles.tsc2_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc3_open,'BackgroundColor',[0 1 0]);
set(handles.tsc3_close,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.tsc4_open,'BackgroundColor',[0 1 0]);
% % % set(handles.tsc4_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in tsc_all_close.
function tsc_all_close_Callback(hObject, eventdata, handles)
global pidloop air_stop gas_stop
% hObject    handle to tsc_all_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,7)=1;
pidloop(10,8)=1;
pidloop(10,9)=1;
pidloop(10,10)=1;
pidloop(10,11)=1;
pidloop(10,12)=1;
pidloop(10,17)=1;
pidloop(10,18)=1;
air_stop(1) = 0;
gas_stop(1) = 0;
air_stop(2) = 0;
gas_stop(2) = 0;
air_stop(3) = 0;
gas_stop(3) = 0;
set(handles.tsc1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc1_close,'BackgroundColor',[1 0 0]);
set(handles.tsc2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc2_close,'BackgroundColor',[1 0 0]);
set(handles.tsc3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc3_close,'BackgroundColor',[1 0 0]);
% % % set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.tsc4_close,'BackgroundColor',[1 0 0]);
% --- Executes on slider movement.
function air_pressure_slider_Callback(hObject, eventdata, handles)
% hObject    handle to air_pressure_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.air_pressure_sp,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air_pressure_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air_pressure_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in air_pressure_open.
function air_pressure_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to air_pressure_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,13)=0;            %空气总管压力回路切自动
set(handles.air_pressure_open,'BackgroundColor',[0 1 0]);
set(handles.air_pressure_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in air_pressure_close.
function air_pressure_close_Callback(hObject, eventdata, handles)
global pidloop
global choose_fj

% hObject    handle to air_pressure_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,13)=1;%空气总管压力回路切自动
%%%choose_fj = 0;
set(handles.air_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.air_pressure_close,'BackgroundColor',[1 0 0]);
%%%set(handles.fengji_1,'BackgroundColor',[0.941 0.941 0.941]);
%%%set(handles.fengji_2,'BackgroundColor',[0.941 0.941 0.941]);
% --- Executes on slider movement.
function P_slider1_Callback(hObject, eventdata, handles)
global  airgaspotial
% hObject    handle to P_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
agp1_value=b/100;
set(hObject,'Value',agp1_value);
set(handles.agp1_set,'String',num2str(agp1_value));
airgaspotial(1)=agp1_value;

% --- Executes during object creation, after setting all properties.
function P_slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function P_slider2_Callback(hObject, eventdata, handles)
global airgaspotial
% hObject    handle to P_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
agp2_value=b/100;
set(hObject,'Value',agp2_value);
set(handles.agp2_set,'String',num2str(agp2_value));
airgaspotial(2)=agp2_value;

% --- Executes during object creation, after setting all properties.
function P_slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function P_slider3_Callback(hObject, eventdata, handles)
global airgaspotial
% hObject    handle to P_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
agp3_value=b/100;
set(hObject,'Value',agp3_value);
set(handles.agp3_set,'String',num2str(agp3_value));
airgaspotial(3)=agp3_value;

% --- Executes during object creation, after setting all properties.
function P_slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% --- Executes on button press in gapon1_open.
function gapon1_open_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon1_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(1)=1;
pidloop(10,4)=0;
% set(handles.gapon1,'String','开启');
set(handles.gapon1_open,'BackgroundColor',[0 1 0]);
set(handles.gapon1_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gapon2_open.
function gapon2_open_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon2_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(2)=1;
pidloop(10,5)=0;
% set(handles.gapon2,'String','开启');
set(handles.gapon2_open,'BackgroundColor',[0 1 0]);
set(handles.gapon2_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gapon3_open.
function gapon3_open_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon3_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(3)=1;
pidloop(10,6)=0;
% set(handles.gapon3,'String','开启');
set(handles.gapon3_open,'BackgroundColor',[0 1 0]);
set(handles.gapon3_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gapon1_close.
function gapon1_close_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(1)=0;
pidloop(10,4)=1;
% set(handles.gapon1,'String','关闭');
set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon1_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in gapon2_close.
function gapon2_close_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon2_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(2)=0;
pidloop(10,5)=1;
% set(handles.gapon2,'String','关闭');
set(handles.gapon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon2_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in gapon3_close.
function gapon3_close_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon3_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(3)=0;
pidloop(10,6)=1;
% set(handles.gapon3,'String','关闭');
set(handles.gapon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon3_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in gapon_all_open.
function gapon_all_open_Callback(hObject, eventdata, handles)
global gap_on pidloop
% hObject    handle to gapon_all_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on=[1;1;1];
pidloop(10,4)=0;
pidloop(10,5)=0;
pidloop(10,6)=0;
% % % pidloop(10,16)=0;
set(handles.gapon1_open,'BackgroundColor',[0 1 0]);
set(handles.gapon1_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon2_open,'BackgroundColor',[0 1 0]);
set(handles.gapon2_close,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon3_open,'BackgroundColor',[0 1 0]);
set(handles.gapon3_close,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.gapon4_open,'BackgroundColor',[0 1 0]);
% % % set(handles.gapon4_close,'BackgroundColor',[0.941 0.941 0.941]);
% --- Executes on button press in gapon_all_close.
function gapon_all_close_Callback(hObject, eventdata, handles)
global gap_on pidloop steeldata
% hObject    handle to gapon_all_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on=[0;0;0];
pidloop(10,4)=1;
pidloop(10,5)=1;
pidloop(10,6)=1;
pidloop(10,16)=1;
set(handles.gapon1_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon1_close,'BackgroundColor',[1 0 0]);
set(handles.gapon2_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon2_close,'BackgroundColor',[1 0 0]);
set(handles.gapon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon3_close,'BackgroundColor',[1 0 0]);
% % % set(handles.gapon4_open,'BackgroundColor',[0.941 0.941 0.941]);
% % % set(handles.gapon4_close,'BackgroundColor',[1 0 0]);


% --- Executes during object creation, after setting all properties.
function ts_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ts_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
global wait_on t1sp t2sp t3sp  waitparameter 
wait_on(1,1)=0;
wait_on(2,1)=0;
wait_on(3,1)=0;
ts1=t1sp;
ts2=t2sp;
ts3=t3sp;
%%%%%%%%%%%%%%%%三加段开轧处理
set(handles.ts_1,'String',num2str(ts1));
mid_1=str2num(get(handles.ts_1,'String'));
set(handles.T_slider1,'Value',mid_1);
set(handles.T_slider1,'Max',mid_1+60,'Min',mid_1-200);
set(handles.T_slider1,'SliderStep',[1/260,5/260]);

set(handles.ts_2,'String',num2str(ts2));
mid_2=str2num(get(handles.ts_2,'String'));
set(handles.T_slider2,'Value',mid_2);
set(handles.T_slider2,'Max',mid_2+60,'Min',mid_2-200);
set(handles.T_slider2,'SliderStep',[1/260,5/260]);

set(handles.ts_3,'String',num2str(ts3));
mid_3=str2num(get(handles.ts_3,'String'));
set(handles.T_slider3,'Value',mid_3);
set(handles.T_slider3,'Max',mid_3+60,'Min',mid_3-60);
set(handles.T_slider3,'SliderStep',[1/120,5/120]);


%%

% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton32,'BackgroundColor',[0 1 0]);
set(handles.pushbutton33,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
global wait_on t1sp t2sp t3sp waitparameter  
wait_on(1,1)=1;
wait_on(2,1)=1;
wait_on(3,1)=1;
val2 = get(handles.wait_time_select,'Value');
delta_temp=waitparameter(val2,2:4);
ts1=t1sp+delta_temp(1);
ts2=t2sp+delta_temp(2);
ts3=t3sp+delta_temp(3);

set(handles.ts_1,'String',num2str(ts1));
mid_1=str2num(get(handles.ts_1,'String'));
set(handles.T_slider1,'Value',mid_1);
set(handles.T_slider1,'Max',mid_1+60,'Min',mid_1-200);
set(handles.T_slider1,'SliderStep',[1/260,5/260]);

set(handles.ts_2,'String',num2str(ts2));
mid_2=str2num(get(handles.ts_2,'String'));
set(handles.T_slider2,'Value',mid_2);
set(handles.T_slider2,'Max',mid_2+60,'Min',mid_2-200);
set(handles.T_slider2,'SliderStep',[1/260,5/260]);

set(handles.ts_3,'String',num2str(ts3));
mid_3=str2num(get(handles.ts_3,'String'));
set(handles.T_slider3,'Value',mid_3);
set(handles.T_slider3,'Max',mid_3+60,'Min',mid_3-60);
set(handles.T_slider3,'SliderStep',[1/120,5/120]);

% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)set(handles.pushbutton32,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.pushbutton32,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.pushbutton33,'BackgroundColor',[0 1 0]);


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air_vs1,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas_vs1,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.gas_vs4,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.air_vs4,'String',num2str(slide_value));


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
function slider21_Callback(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.gas_vs2,'String',num2str(slide_value));


% --- Executes during object creation, after setting all properties.
function slider21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider22_Callback(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.air_vs2,'String',num2str(slide_value));



% --- Executes during object creation, after setting all properties.
function slider22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in valve_open4.
function valve_open4_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_open4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open4,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.valve_close4,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
air_valve(4)=1;
gas_valve(4)=1;


% --- Executes on button press in valve_open2.
function valve_open2_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_open2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open2,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.valve_close2,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
air_valve(2)=1;
gas_valve(2)=1;



% --- Executes on button press in valve_open1.
function valve_open1_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_open1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open1,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.valve_close1,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
air_valve(1)=1;
gas_valve(1)=1;



% --- Executes on button press in valve_close1.
function valve_close1_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_close1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open1,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
set(handles.valve_close1,'BackgroundColor',[1 0 0]);%将close设置为红色
air_valve(1)=0;
gas_valve(1)=0;



% --- Executes on button press in valve_close4.
function valve_close4_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_close4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open4,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
set(handles.valve_close4,'BackgroundColor',[1 0 0]);%将close设置为红色
air_valve(4)=0;
gas_valve(4)=0;


% --- Executes on button press in valve_close2.
function valve_close2_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_close2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open2,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
set(handles.valve_close2,'BackgroundColor',[1 0 0]);%将close设置为红色
air_valve(2)=0;
gas_valve(2)=0;


% --- Executes on selection change in wait_time_select.
function wait_time_select_Callback(hObject, eventdata, handles)
global waitparameter wait_on val
steeldata=xml_read('steel_set.xml');
second=steeldata.steeltype(val,1).parameter.ATTRIBUTE.second;
t1sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t1;
t2sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t2;
t3sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.t3;
% t4sp=steeldata.steeltype(val,1).parameter.ATTRIBUTE.tj;
gas1_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f1;
gas2_limit=steeldata.steeltype(val,1).parameter.ATTRIBUTE.f2;
delta_temp=zeros(1,4);
val2 = get(handles.wait_time_select,'Value');
delta_temp=waitparameter(val2,2:4);

if wait_on(1,1)==1;
    ts1=t1sp+delta_temp(1);
    ts2=t2sp+delta_temp(2);
    ts3=t3sp+delta_temp(3);
%     ts4=t4sp+delta_temp(4);
else
    ts1=t1sp;
    ts2=t2sp;
    ts3=t3sp;
%     ts4=t4sp;
end
set(handles.ts_1,'String',num2str(ts1));
mid_1=str2num(get(handles.ts_1,'String'));
set(handles.T_slider1,'Value',mid_1);
set(handles.T_slider1,'Max',mid_1+60,'Min',mid_1-200);
set(handles.T_slider1,'SliderStep',[1/260,5/260]);

set(handles.ts_2,'String',num2str(ts2));
mid_2=str2num(get(handles.ts_2,'String'));
set(handles.T_slider2,'Value',mid_2);
set(handles.T_slider2,'Max',mid_2+60,'Min',mid_2-200);
set(handles.T_slider2,'SliderStep',[1/260,5/260]);

set(handles.ts_3,'String',num2str(ts3));
mid_3=str2num(get(handles.ts_3,'String'));
set(handles.T_slider3,'Value',mid_3);
set(handles.T_slider3,'Max',mid_3+60,'Min',mid_3-60);
set(handles.T_slider3,'SliderStep',[1/120,5/120]);

% set(handles.ts_4,'String',num2str(ts4));
% mid_4=str2num(get(handles.ts_4,'String'));
% set(handles.T_slider4,'Value',mid_4);
% set(handles.T_slider4,'Max',mid_4+60,'Min',mid_4-60);
% hObject    handle to wait_time_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wait_time_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wait_time_select


% --- Executes during object creation, after setting all properties.
function wait_time_select_CreateFcn(hObject, eventdata, handles)
global wait_time_select_hobj wait_time_select
wait_time_select_hobj=hObject;
% hObject    handle to wait_time_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
wait_time_select{1}=[num2str(20) '分钟'];
wait_time_select{2}=[num2str(40) '分钟'];
wait_time_select{3}=[num2str(60) '分钟'];
wait_time_select{4}=[num2str(90) '分钟'];
wait_time_select{5}=[num2str(120) '分钟'];
wait_time_select{6}=[num2str(240) '分钟'];
set(hObject,'String', wait_time_select);


% --- Executes on button press in apcon3_open.
function apcon3_open_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apcon3_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(3,1)=1;
set(handles.apcon3_open,'BackgroundColor',[0 1 0]);
set(handles.apcon3_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in apcon3_close.
function apcon3_close_Callback(hObject, eventdata, handles)
global temp_open 
% hObject    handle to apcon3_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(3,1)=0;
set(handles.apcon3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon3_close,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function smoke_tg3_slider3_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_tg3_slider3_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_tg3_set,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function smoke_tg3_slider3_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_tg3_slider3_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function smoke_ta3_slider3_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_ta3_slider3_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_ta3_set,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function smoke_ta3_slider3_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta3_slider3_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in tsc3_open.
function tsc3_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to tsc3_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,9)=0;            %空烟温度回路切自动
pidloop(10,12)=0;           %煤烟温度回路切自动
set(handles.tsc3_open,'BackgroundColor',[0 1 0]);
set(handles.tsc3_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in tsc3_close.
function tsc3_close_Callback(hObject, eventdata, handles)
% hObject    handle to tsc3_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pidloop air_stop gas_stop
pidloop(10,9)=1;%空烟温度回路切自动
pidloop(10,12)=1;%煤烟温度回路切自动
air_stop(3) = 0;
gas_stop(3) = 0;
set(handles.tsc3_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc3_close,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function T_slider3_Callback(hObject, eventdata, handles)
% hObject    handle to T_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

% set(handles.ts2,'String',num2str(slide_value));
set(handles.ts_3,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function T_slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider26_Callback(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.gas_vs3,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider27_Callback(hObject, eventdata, handles)
% hObject    handle to slider27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.air_vs3,'String',num2str(slide_value));
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


% --- Executes on button press in valve_open3.
function valve_open3_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_open3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open3,'BackgroundColor',[0 1 0]);%将打开设置为绿色
set(handles.valve_close3,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
air_valve(3)=1;
gas_valve(3)=1;

% --- Executes on button press in valve_close3.
function valve_close3_Callback(hObject, eventdata, handles)
global air_valve gas_valve
% hObject    handle to valve_close3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.valve_open3,'BackgroundColor',[0.941 0.941 0.941]);%设置颜色，将open设置为灰色
set(handles.valve_close3,'BackgroundColor',[1 0 0]);%将close设置为红色
air_valve(3)=0;
gas_valve(3)=0;

% --- Executes during object creation, after setting all properties.
function P_slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function disconnect_wincc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disconnect_wincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function gas_pressure_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gas_pressure_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.gas_pressure_sp,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gas_pressure_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas_pressure_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gas_pressure_open.
function gas_pressure_open_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to gas_pressure_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,14)=0;            %煤气总管压力回路切自动
set(handles.gas_pressure_open,'BackgroundColor',[0 1 0]);
set(handles.gas_pressure_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gas_pressure_close.
function gas_pressure_close_Callback(hObject, eventdata, handles)
global pidloop
% hObject    handle to gas_pressure_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pidloop(10,14)=1;%空气总管压力回路切自动
set(handles.gas_pressure_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gas_pressure_close,'BackgroundColor',[1 0 0]);


% --- Executes during object creation, after setting all properties.
function pressure_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressure_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function air_pressure_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air_pressure_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pressure_p.
function pressure_p_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pressure_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function agp1_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to agp1_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over T_slider1.
function T_slider1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to T_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on T_slider1 and none of its controls.
function T_slider1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to T_slider1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object deletion, before destroying properties.
function air_pressure_close_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to air_pressure_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function tp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton77.
function pushbutton77_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global alarm_button_clicked alarm_sound_flag
alarm_button_clicked = 1;
alarm_sound_flag = 0;
set(handles.pushbutton34,'visible','off');
clear sound;


% --- Executes on slider movement.
function P_slider4_Callback(hObject, eventdata, handles)
global airgaspotial
% hObject    handle to P_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
agp4_value=b/100;
set(hObject,'Value',agp4_value);
set(handles.agp4_set,'String',num2str(agp4_value));
airgaspotial(4)=agp4_value;


% --- Executes during object creation, after setting all properties.
function slider33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gapon4_open.
function gapon4_open_Callback(hObject, eventdata, handles)
% hObject    handle to gapon4_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gap_on pidloop
% hObject    handle to gapon1_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gap_on(4)=1;
pidloop(10,16)=0;
% set(handles.gapon1,'String','开启');
set(handles.gapon4_open,'BackgroundColor',[0 1 0]);
set(handles.gapon4_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in gapon4_close.
function gapon4_close_Callback(hObject, eventdata, handles)
% hObject    handle to gapon4_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gap_on pidloop
gap_on(4)=0;
pidloop(10,16)=1;
% set(handles.gapon3,'String','关闭');
set(handles.gapon4_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.gapon4_close,'BackgroundColor',[1 0 0]);

% --- Executes on button press in apcon4_open.
function apcon4_open_Callback(hObject, eventdata, handles)
global temp_open 
% hObject    handle to apcon2_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(4,1)=1; %代表加三段开关
set(handles.apcon4_open,'BackgroundColor',[0 1 0]);
set(handles.apcon4_close,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on button press in apcon4_close.
function apcon4_close_Callback(hObject, eventdata, handles)
global temp_open
% hObject    handle to apcon2_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_open(4,1)=0;
set(handles.apcon4_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apcon4_close,'BackgroundColor',[1 0 0]);


% --- Executes on slider movement.
function smoke_tg4_slider4_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_tg4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_tg4_set,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_tg4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function smoke_ta4_slider4_set_Callback(hObject, eventdata, handles)
% hObject    handle to smoke_ta4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.smoke_ta4_set,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoke_ta4_slider4_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in tsc4_open.
function tsc4_open_Callback(hObject, eventdata, handles)
% hObject    handle to tsc4_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pidloop;
pidloop(10,17)=0;            %空烟温度回路切自动
pidloop(10,18)=0;           %煤烟温度回路切自动
set(handles.tsc4_open,'BackgroundColor',[0 1 0]);
set(handles.tsc4_close,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in tsc4_close.
function tsc4_close_Callback(hObject, eventdata, handles)
% hObject    handle to tsc4_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pidloop
pidloop(10,17)=1;%空烟温度回路切自动
pidloop(10,18)=1;%煤烟温度回路切自动

set(handles.tsc4_open,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.tsc4_close,'BackgroundColor',[1 0 0]);

% --- Executes on slider movement.
function T_slider4_Callback(hObject, eventdata, handles)
% hObject    handle to T_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

% set(handles.ts2,'String',num2str(slide_value));
set(handles.ts_4,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in fengji_1.
function fengji_1_Callback(hObject, eventdata, handles)
% hObject    handle to fengji_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choose_fj
choose_fj = 1;
set(handles.fengji_1,'BackgroundColor',[0 1 0]);
set(handles.fengji_2,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in fengji_2.
function fengji_2_Callback(hObject, eventdata, handles)
% hObject    handle to fengji_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choose_fj
choose_fj = 2;
set(handles.fengji_2,'BackgroundColor',[0 1 0]);
set(handles.fengji_1,'BackgroundColor',[0.941 0.941 0.941]);


% --------------------------------------------------------------------
function setting_Callback(hObject, eventdata, handles)
% hObject    handle to setting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',setting);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gas1_flow_Callback(hObject, eventdata, handles)
% hObject    handle to gas1_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画一加煤气流量
global data
a=data(131,:);       %a表示流量设定值，b表示流量测量值
b=data(141,:);       %b=data(91,:);
c=data(3,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(4,2:end);
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 10 100])
hold on
plot(d)

% --------------------------------------------------------------------
function air1_flow_Callback(hObject, eventdata, handles)
% hObject    handle to air1_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画一加空气流量
global data
a=data(135,:);
b=data(5,:);
c=data(1,2:end);
d=data(2,2:end);
figure(1);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% --------------------------------------------------------------------
function gas1_temp_Callback(hObject, eventdata, handles)
% hObject    handle to gas1_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%一加煤烟
global data
figure(1);
subplot(2,1,1)                  %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(158,:);
b=data(171,:);%+data(16,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(13,:),'r');      

% --------------------------------------------------------------------
function air1_temp_Callback(hObject, eventdata, handles)
% hObject    handle to air1_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 一加空烟
global data
figure(1);
subplot(2,1,1)
a=data(154,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(167,:);%+data(15,:))./2;
plot(a,'r');

hold on
plot(b);
subplot(2,1,2);
plot(data(11,:),'r');     

% --------------------------------------------------------------------
function gas2_flow_Callback(hObject, eventdata, handles)
% hObject    handle to gas2_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
a=data(132,:);       %a表示流量设定值，b表示流量测量值
% b=data(21,:);
b=data(142,:);
c=data(18,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(19,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% --------------------------------------------------------------------
function air2_flow_Callback(hObject, eventdata, handles)
% hObject    handle to air2_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画二加空气PID
global data
figure(1);
a=data(136,:);
% b=data(20,:);
b=data(146,:);
c=data(16,2:end);
d=data(17,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% --------------------------------------------------------------------
function gas2_temp_Callback(hObject, eventdata, handles)
% hObject    handle to gas2_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(159,:);
b=data(172,:);%+data(32,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(28,:),'r');     

% --------------------------------------------------------------------
function air2_temp_Callback(hObject, eventdata, handles)
% hObject    handle to air2_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
subplot(2,1,1)
a=data(155,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(168,:);%+data(31,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(26,:),'r');    

% --------------------------------------------------------------------
function gas3_flow_Callback(hObject, eventdata, handles)
% hObject    handle to gas3_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
a=data(133,:);       %a表示流量设定值，b表示流量测量值
b=data(36,:);
c=data(33,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(34,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% --------------------------------------------------------------------
function air3_flow_Callback(hObject, eventdata, handles)
% hObject    handle to air3_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画san加空气PID
global data
figure(1);
a=data(137,:);
b=data(35,:);
c=data(31,2:end);
d=data(32,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
%axis([0 1000 0 100])
hold on
plot(d)

% --------------------------------------------------------------------
function gas3_temp_Callback(hObject, eventdata, handles)
% hObject    handle to gas3_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(160,:);
b=data(173,:);%+data(32,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(43,:),'r');   

% --------------------------------------------------------------------
function air3_temp_Callback(hObject, eventdata, handles)
% hObject    handle to air3_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%三加空烟pid
global data
figure(1);
subplot(2,1,1)
a=data(156,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(169,:);%+data(31,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(41,:),'r');  

% --------------------------------------------------------------------
function gas4_flow_Callback(hObject, eventdata, handles)
% hObject    handle to gas4_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
a=data(134,:);       %a表示流量设定值，b表示流量测量值
b=data(51,:);
c=data(48,2:end);    %c表示阀门设定值，d表示阀门测量值
d=data(49,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b)
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

% --------------------------------------------------------------------
function air4_flow_Callback(hObject, eventdata, handles)
% hObject    handle to air4_flow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 画均热空气PID
global data
figure(1);
a=data(138,:);
b=data(50,:);
c=data(46,2:end);
d=data(47,2:end);
subplot(2,1,1)
plot(a,'r');
hold on
plot(b);
subplot(2,1,2)
plot(c,'r')
hold on
plot(d)

% --------------------------------------------------------------------
function gas4_temp_Callback(hObject, eventdata, handles)
% hObject    handle to gas4_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
subplot(2,1,1)                   %a表示煤烟温度设定值，b表示煤烟温度测量值
a=data(161,:);
b=data(174,:);%+data(48,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(58,:),'r');     

% --------------------------------------------------------------------
function air4_temp_Callback(hObject, eventdata, handles)
% hObject    handle to air4_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data
figure(1);
subplot(2,1,1)
a=data(157,:);                   %a表示空烟温度设定值，b表示空烟温度测量值
b=data(170,:);%+data(47,:))./2;
plot(a,'r');
hold on
plot(b);
subplot(2,1,2);
plot(data(56,:),'r');   


% --- Executes on button press in temp1_bei.
function temp1_bei_Callback(hObject, eventdata, handles)
% hObject    handle to temp1_bei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp1_flag
temp1_flag = 0;
set(handles.temp1_bei,'BackgroundColor',[0 1 0]);
set(handles.temp1_nan,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp1_nan.
function temp1_nan_Callback(hObject, eventdata, handles)
% hObject    handle to temp1_nan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp1_flag
temp1_flag = 1;
set(handles.temp1_nan,'BackgroundColor',[0 1 0]);
set(handles.temp1_bei,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp2_bei.
function temp2_bei_Callback(hObject, eventdata, handles)
% hObject    handle to temp2_bei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp2_flag
temp2_flag = 0;
set(handles.temp2_bei,'BackgroundColor',[0 1 0]);
set(handles.temp2_nan,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp2_nan.
function temp2_nan_Callback(hObject, eventdata, handles)
% hObject    handle to temp2_nan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp2_flag
temp2_flag = 1;
set(handles.temp2_nan,'BackgroundColor',[0 1 0]);
set(handles.temp2_bei,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp3_bei.
function temp3_bei_Callback(hObject, eventdata, handles)
% hObject    handle to temp3_bei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp3_flag
temp3_flag = 0;
set(handles.temp3_bei,'BackgroundColor',[0 1 0]);
set(handles.temp3_nan,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp3_nan.
function temp3_nan_Callback(hObject, eventdata, handles)
% hObject    handle to temp3_nan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp3_flag
temp3_flag = 1;
set(handles.temp3_nan,'BackgroundColor',[0 1 0]);
set(handles.temp3_bei,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp4_bei.
function temp4_bei_Callback(hObject, eventdata, handles)
% hObject    handle to temp4_bei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp4_flag
temp4_flag = 0;
set(handles.temp4_bei,'BackgroundColor',[0 1 0]);
set(handles.temp4_nan,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in temp4_nan.
function temp4_nan_Callback(hObject, eventdata, handles)
% hObject    handle to temp4_nan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp4_flag
temp4_flag = 1;
set(handles.temp4_nan,'BackgroundColor',[0 1 0]);
set(handles.temp4_bei,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on slider movement.
function luya_slider_Callback(hObject, eventdata, handles)
% hObject    handle to luya_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.luya_set,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function luya_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to luya_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in button_temp.
function button_temp_Callback(hObject, eventdata, handles)
% hObject    handle to button_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wait_warm wait_minutes wait_minutes1 steeldata val
steeldata=xml_read('steel_set.xml');
if wait_warm == 0
%     set(handles.button_temp,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
    set(handles.button_temp,'BackgroundColor',[0 1 0]);%将打开设置为绿色
    set(handles.leftTime1,'Visible','on');
    set(handles.leftTime,'Visible','on');
    list = get(handles.wait_minutes,'string');
    
    wait_minutes = str2double(list{get(handles.wait_minutes,'value')}); % 获取待温时间
    wait_minutes1 = wait_minutes * 60;
    wait_warm = 1;
    val = get(handles.wait_minutes,'value');
    luwen1_temp=steeldata.steel(val,1).parameter.ATTRIBUTE.t1;
    luwen2_temp=steeldata.steel(val,1).parameter.ATTRIBUTE.t2;
    luwen3_temp=steeldata.steel(val,1).parameter.ATTRIBUTE.t3;
    
    set(handles.T_slider1,'Value',luwen1_temp);
    set(handles.ts_1,'String',luwen1_temp);
        % 二段待温处理
    set(handles.T_slider2,'Value',luwen2_temp);
    set(handles.ts_2,'String',luwen2_temp);
        % 均热段待温处理
    set(handles.T_slider3,'Value',luwen3_temp);
    set(handles.ts_3,'String',luwen3_temp);
else
    luwen1_temp = 1085;
    set(handles.T_slider1,'Value',luwen1_temp);
    set(handles.ts_1,'String',luwen1_temp);
        % 二段待温处理
    luwen2_temp = 1240;
    set(handles.T_slider2,'Value',luwen2_temp);
    set(handles.ts_2,'String',luwen2_temp);
        % 均热段待温处理
     luwen3_temp = 1260;
     set(handles.T_slider3,'Value',luwen3_temp);
     set(handles.ts_3,'String',luwen3_temp);
    set(handles.button_temp,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
    set(handles.leftTime1,'Visible','off');
    set(handles.leftTime,'Visible','off');
    wait_warm = 0;
end


% --- Executes on selection change in wait_minutes.
function wait_minutes_Callback(hObject, eventdata, handles)
% hObject    handle to wait_minutes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wait_minutes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wait_minutes


% --- Executes during object creation, after setting all properties.
function wait_minutes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wait_minutes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function my_yfj_slider_Callback(hObject, eventdata, handles)
% hObject    handle to my_yfj_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.my_yfj,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function my_yfj_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to my_yfj_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ky_yfj_slider_Callback(hObject, eventdata, handles)
% hObject    handle to ky_yfj_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.ky_yfj,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ky_yfj_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ky_yfj_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function first_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to first_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_max1
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.first_up_text,'String',num2str(slide_value));
flow_max1 = slide_value;

% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function first_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function first_up_text_Callback(hObject, eventdata, handles)
% hObject    handle to first_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of first_up_text as text
%        str2double(get(hObject,'String')) returns contents of first_up_text as a double


% --- Executes during object creation, after setting all properties.
function first_up_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function first_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to first_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_min1
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.first_down_text,'String',num2str(slide_value));
flow_min1 = slide_value;
% steeldata.flow_limit.parameter(1).ATTRIBUTE.flow1_min = slide_value;
% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function first_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function first_down_text_Callback(hObject, eventdata, handles)
% hObject    handle to first_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of first_down_text as text
%        str2double(get(hObject,'String')) returns contents of first_down_text as a double


% --- Executes during object creation, after setting all properties.
function first_down_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to first_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function second_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to second_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_max2
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.second_up_text,'String',num2str(slide_value));
flow_max2 = slide_value;

% steeldata.flow_limit.parameter(2).ATTRIBUTE.flow2_max = slide_value;
% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function second_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to second_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function second_up_text_Callback(hObject, eventdata, handles)
% hObject    handle to second_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of second_up_text as text
%        str2double(get(hObject,'String')) returns contents of second_up_text as a double


% --- Executes during object creation, after setting all properties.
function second_up_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to second_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function second_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to second_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_min2
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.second_down_text,'String',num2str(slide_value));
flow_min2 = slide_value;
% steeldata.flow_limit.parameter(2).ATTRIBUTE.flow2_min = slide_value;
% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function second_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to second_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function second_down_text_Callback(hObject, eventdata, handles)
% hObject    handle to second_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of second_down_text as text
%        str2double(get(hObject,'String')) returns contents of second_down_text as a double


% --- Executes during object creation, after setting all properties.
function second_down_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to second_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function third_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to third_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_max3
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.third_up_text,'String',num2str(slide_value));
flow_max3 = slide_value;
% steeldata.flow_limit.parameter(3).ATTRIBUTE.flow3_max = slide_value;
% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function third_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to third_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function third_up_text_Callback(hObject, eventdata, handles)
% hObject    handle to third_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of third_up_text as text
%        str2double(get(hObject,'String')) returns contents of third_up_text as a double


% --- Executes during object creation, after setting all properties.
function third_up_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to third_up_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function third_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to third_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steeldata flow_min3
% steeldata=xml_read('steel_set.xml');

a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
flow_min3 = slide_value;
set(handles.third_down_text,'String',num2str(slide_value));
% steeldata.flow_limit.parameter(3).ATTRIBUTE.flow3_min = slide_value;
% xml_write('steel_set.xml',steeldata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function third_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to third_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function third_down_text_Callback(hObject, eventdata, handles)
% hObject    handle to third_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of third_down_text as text
%        str2double(get(hObject,'String')) returns contents of third_down_text as a double


% --- Executes during object creation, after setting all properties.
function third_down_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to third_down_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dengwen.
function dengwen_Callback(hObject, eventdata, handles)
% hObject    handle to dengwen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dengwen
if dengwen == 0
    set(handles.dengwen,'BackgroundColor',[0 1 0]);%将打开设置为绿色
    set(handles.dengwen,'String','380钢种');
    dengwen = 1;
else
    dengwen = 0;
    set(handles.dengwen,'BackgroundColor',[0.941 0.941 0.941]);%将关闭设置为灰色
    set(handles.dengwen,'String','460钢种');
end


% --- Executes on selection change in steelMenu.
function steelMenu_Callback(hObject, eventdata, handles)
% hObject    handle to steelMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global steel_num kongyanprop meiyanprop luyabili luyabili_a steeldata
steel_num = get(handles.steelMenu,'value');
if steel_num <=2
    % 一段温度处理
    luwen1_temp = 1120;
    set(handles.T_slider1,'Value',luwen1_temp);
     set(handles.ts_1,'String',luwen1_temp);
    % 二段温度处理
    luwen2_temp = 1273;
    set(handles.T_slider2,'Value',luwen2_temp);
    set(handles.ts_2,'String',luwen2_temp);
    % 均热段温度处理
    luwen3_temp = 1293;
    set(handles.T_slider3,'Value',luwen3_temp);
    set(handles.ts_3,'String',luwen3_temp);
else
    % 一段温度处理
    luwen1_temp = 1060;
    set(handles.T_slider1,'Value',luwen1_temp);
     set(handles.ts_1,'String',luwen1_temp);
    % 二段温度处理
    luwen2_temp = 1210;
    set(handles.T_slider2,'Value',luwen2_temp);
    set(handles.ts_2,'String',luwen2_temp);
    % 均热段温度处理
    luwen3_temp = 1220;
    set(handles.T_slider3,'Value',luwen3_temp);
    set(handles.ts_3,'String',luwen3_temp);
end
steeldata=xml_read('steel_set.xml');
kongyanprop(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.kongyan1_prop;
kongyanprop(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.kongyan2_prop;
kongyanprop(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.kongyan3_prop;
meiyanprop(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.meiyan1_prop;
meiyanprop(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.meiyan2_prop;
meiyanprop(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.meiyan3_prop;

luyabili(1)=steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.luyabili1_g;
luyabili(2)=steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.luyabili2_g;
luyabili(3)=steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.luyabili3_g;
luyabili_a(1) = steeldata.steel_type(steel_num,1).parameter(1).ATTRIBUTE.luyabili1_a;
luyabili_a(2) = steeldata.steel_type(steel_num,1).parameter(2).ATTRIBUTE.luyabili2_a;
luyabili_a(3) = steeldata.steel_type(steel_num,1).parameter(3).ATTRIBUTE.luyabili3_a;
% Hints: contents = cellstr(get(hObject,'String')) returns steelMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from steelMenu


% --- Executes during object creation, after setting all properties.
function steelMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to steelMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in yfj_connect.
function yfj_connect_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global daobj1 first_time_connect_flag1 group1 itemset1 pidloop1 loopnum1 steeldata1 data1 tempdata1 steeldata
global choose_fj yfj_timer main_lj
if main_lj == 1 && (choose_fj ==1 || choose_fj == 2)
    OPCIP1=steeldata.common(1,1).parameter.ATTRIBUTE.OPCIP1;
    OPCServer1=steeldata.common(1,1).parameter.ATTRIBUTE.OPCServer1;
    daobj1=opcda(OPCIP1,OPCServer1);
    group1 = addgroup(daobj1);
    if strcmp(daobj1.Status,'disconnected')%这里即是判断是否处于连接状态，如果没有处于连接状态的做法
        if first_time_connect_flag1==1%当没有处于连接状态时，一定要让这个变量处于0，才能连接。
            first_time_connect_flag1=1;
            connect(daobj1);
            itemset1=additem(group1, {  
                            'v4.DPU1002.SH0001.PA1.OUT',...
                            'v4.DPU1002.HW.AI010201.PV',...
                            'v4.DPU1002.SH0001.PA2.OUT',...
                            'v4.DPU1002.HW.AI010202.PV',...
                            'v4.DPU1002.HW.AI030101.PV',...
                            'V4.DPU1002.SH0021.BALM1.PV',...
                            'V4.DPU1002.SH0022.BALM1.PV',...
                            'V4.DPU1002.HW.AQ010101.PV',...
                            'V4.DPU1002.HW.AQ010102.PV'});
            connect(daobj1);
            tempdata1=read(group1);
            data1=zeros(length(tempdata1)+60,1);%初始化data
            data1(1:6,1)=fix(clock);
            loopnum1 = 13;
            pidloop1=[0 0 0 0 0 0 0 0 0 0 0 0 0 ;%sp
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
                  5  7  6   10   7   16  6  6  5  6  5  5 20 ;%lowerlimit  Need_to_be_modified
                  1 1 1 1 1 1 1 1 1 1 1 1 0 ;%deadzone  Need_to_be_modified
                  ];
        else
            itemset1=additem(group1, {  
                            'v4.DPU1002.SH0001.PA1.OUT',...
                            'v4.DPU1002.HW.AI010201.PV',...
                            'v4.DPU1002.SH0001.PA2.OUT',...
                            'v4.DPU1002.HW.AI010202.PV',...
                            'v4.DPU1002.HW.AI030101.PV',...
                            'V4.DPU1002.SH0021.BALM1.PV',...
                            'V4.DPU1002.SH0022.BALM1.PV',...
                            'V4.DPU1002.HW.AQ010101.PV',...
                            'V4.DPU1002.HW.AQ010102.PV'});
            connect(daobj1);
        end
    yfj_timer = timer('Name','apctimer1','TimerFcn', {@on_timer1, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');%定义定时器 
    start(yfj_timer);%启动定时器
    %  set(handles.yfj_connect,'String','已连接');
    %        set(handles.connectwincc,'Enable','off')
     set(handles.alarm,'String','连接正常');   
     set(handles.alarm,'BackgroundColor',[0 1 0]);
     set(handles.yfj_disconnect,'BackgroundColor',[0.941 0.941 0.941]);
     set(handles.yfj_connect,'BackgroundColor',[0 1 0]);
    else
    msgbox('已经连接，不需要重复点击','提示')
    end
else
    msgbox('请先连接中控和选择鼓风机')

end
% --- Executes on button press in yfj_disconnect.
function yfj_disconnect_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_disconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global daobj1 tempdata1 data1 yfj_timer

if ishandle(yfj_timer) && isvalid(yfj_timer)
    stop(yfj_timer);
    delete(yfj_timer);
end

%% 引风机连接断开
if strcmp(daobj1.Status,'connected')
    disconnect(daobj1);
    datetime = datestr(now,30);
    s = ['save(''data1',datetime(1:8),datetime(10:13),'.mat'',''data1'');'];
    eval(s);
    lastsave = ['data1',datetime(1:8),datetime(10:13),'.mat'];
end
data1=zeros(length(tempdata1)+60,1);
set(handles.yfj_connect,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.yfj_disconnect,'BackgroundColor',[1 0 0]);

% --- Executes on button press in alarm.
function alarm_Callback(hObject, eventdata, handles)
% hObject    handle to alarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function buchang_slider_Callback(hObject, eventdata, handles)
% hObject    handle to buchang_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.buchang_value,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function buchang_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buchang_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yfj_slider_max_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_slider_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.yfj_max_value,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yfj_slider_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfj_slider_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yfj_slider_min_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_slider_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%取滑块当前值
slide_value=round(a*100)/100;
set(hObject,'Value',slide_value);
set(handles.yfj_min_value,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yfj_slider_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfj_slider_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function buchang_value_Callback(hObject, eventdata, handles)
% hObject    handle to buchang_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of buchang_value as text
%        str2double(get(hObject,'String')) returns contents of buchang_value as a double


% --- Executes during object creation, after setting all properties.
function buchang_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buchang_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yfj_max_value_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yfj_max_value as text
%        str2double(get(hObject,'String')) returns contents of yfj_max_value as a double


% --- Executes during object creation, after setting all properties.
function yfj_max_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfj_max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yfj_min_value_Callback(hObject, eventdata, handles)
% hObject    handle to yfj_min_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yfj_min_value as text
%        str2double(get(hObject,'String')) returns contents of yfj_min_value as a double


% --- Executes during object creation, after setting all properties.
function yfj_min_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfj_min_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
