function varargout = apc(varargin)
% APC MATLAB code for apc.fig
%      APC, by itself, creates a new APC or raises the existing
%      singleton*.
%
%      H = APC returns the handle to a new APC or the handle to
%      the existing singleton*.
%
%      APC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APC.M with the given input arguments.
%
%      APC('Property','Value',...) creates a new APC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before apc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to apc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help apc

% Last Modified by GUIDE v2.5 05-Sep-2022 15:18:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @apc_OpeningFcn, ...
                   'gui_OutputFcn',  @apc_OutputFcn, ...
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


% --- Executes just before apc is made visible.
function apc_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
global first_time_connect_flag daobj group default_tempture default_time temp_open time_count gas_open air_open tem_dec_flag  max_airgaspotial min_airgaspotial  feiqi_temp_set
global mv default_gas_pressure default_air_pressure pidloop apc_on  tempu   max_burning min_burning feiqitemp_select gongdingtemp_select  sumOfFlow max_min_timeFlag a_write ff1_min ff3_min ff2_min
global default_airgaspotial deadzone loopnum upid_old gap_on  left_time temp_set1 temp_set2 temp_set3  gas_limit good_airgaspotial  gas_lower  wendu_max  wendu_middle ff1 ff2 ff3 ff1_max ff2_max ff3_max
global default_airgaspotial_set paramdata apcguiHandles 
global wendu_max1 wendu_max2 wendu_max3  wendu_middle1 wendu_middle2 wendu_middle3
global time1_set time2_set time3_set  ts1 ts2 ts3 gas_lower1 gas_lower2 gas_lower3 air_pressure gas_pressure
global identifier alarm_button_clicked FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS ifalarmsound
global airpressupperlimit airpresslowerlimit alarm_timer alarm_sound_flag autoswitch autoshaolu burning
global gaspressupperlimit gaspresslowerlimit selectedOrder popmenuswitchorder tempswitch autoswitchdialog

global older_gdwendu old_gdwendu side older_default_airgaspotial old_default_airgaspotial his_side jiangwentime
global jiangwenmax jiangwenmin final_side sidecount errortag huanludlg_tag SW_Checkbox
global menlucount dlgopen alarmflags fqtempswitch coswitch
global choose_fj open_flag air_pressure_offset tem_dec_flag_up_cnt tem_dec_flag_down_cnt flow_buchang
global gd_gas1 gd_gas2 gd_gas3
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to apc (see VARARGIN)
gd_gas1 = 70000;
gd_gas2 = 70000;
gd_gas3 = 70000;
air_pressure_offset=0;
alarmflags=[0,0,0];
dlgopen=0;
autoswitchdialog = 'null';
errortag=0;
huanludlg_tag=0;
apcguiHandles = handles;
paramdata=xml_read('parament_set.xml');
menlucount = paramdata.commdata(1).parameter(2).ATTRIBUTE.menlucount;
%初始化参数
first_time_connect_flag=1;
opcip = paramdata.commdata(1).parameter(1).ATTRIBUTE.OPCIP;
opcserver = paramdata.commdata(1).parameter(1).ATTRIBUTE.OPCServer;
daobj=opcda(opcip,opcserver);
group = addgroup(daobj);
jiangwentime=[-1,-1,-1];
sidecount=[-1,-1,-1];
tempswitch=[0,1,0];
fqtempswitch=[1,1,1];

jiangwenmax=[0,0,0]; jiangwenmin=[0,0,0];
gas_limit=[150 150 150];
left_time=[-1 -1 -1];
temp_set1=[ ];
temp_set2=[ ];
temp_set3=[ ];
feiqi_temp_set=[300 300 300];
burning = [0;0;0];
%% 参数设置初始化
% paramdata=xml_read('parament_set.xml');
default_airgaspotial(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
default_airgaspotial(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
default_airgaspotial(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
ff1=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.f1;
ff1_max=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.f1_max;
ff2=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.f2;
ff2_max=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.f2_max;
ff3=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.f3;
ff3_max=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.f3_max;
ff1_min=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.f1_min;
ff2_min=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.f2_min;
ff3_min=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.f3_min;
default_airgaspotial_set(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
default_airgaspotial_set(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
default_airgaspotial_set(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;

good_airgaspotial=default_airgaspotial;

% min_airgaspotial=default_airgaspotial;

min_airgaspotial(1)=default_airgaspotial_set(1)-0.05;
min_airgaspotial(2)=default_airgaspotial_set(2)-0.05;
min_airgaspotial(3)=default_airgaspotial_set(3)-0.05;

max_airgaspotial(1)=default_airgaspotial_set(1)+0.05;
max_airgaspotial(2)=default_airgaspotial_set(2)+0.05;
max_airgaspotial(3)=default_airgaspotial_set(3)+0.05;


old_default_airgaspotial=default_airgaspotial;
older_default_airgaspotial=default_airgaspotial;
old_gdwendu=[1320;1320;1320];
older_gdwendu=old_gdwendu;
side=[1,1,1];
his_side(1,:)=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
his_side(2,:)=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
his_side(3,:)=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
final_side=[1,1,1];
sumOfFlow=0;
tem_dec_flag=[1 1 1];   %用于空燃比寻优
tem_dec_flag_up_cnt=[0 0 0];
tem_dec_flag_down_cnt = [0 0 0];
temp_open=[0  0  0];  %标志位，标志着按钮打开后，可以进行下一步的GPC计算
max_burning=[0 0 0];
min_burning=[0 0 0];
a_write=[0 0 0];       %标志位，控制阀门写入速度，让写入操作一次只对一个阀门起作用
apc_on=[0  0  0];      %标志位，标志着GPC打开后置1，可以进行下一步的pid计算
gap_on=[0  0  0];      %标志位，标志着按钮打开后，空燃比由界面读取
deadzone=[0.1 0.1 0.1];%煤气流量阀位
time_count=[0  0  0];
upid_old = zeros(8,1);
tempu=zeros(3,1);%煤气流量计算值
feiqitemp_select=[1 1 1];
gongdingtemp_select=[1 1 1];
max_min_timeFlag=[-1 -1 -1];  %加烧或减烧时间标志位
flow_buchang = [0 0 0];%加烧或减烧初始化

default_tempture(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.gdwddef;
default_tempture(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.gdwddef;
default_tempture(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.gdwddef;
default_time(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.slsjdef;
default_time(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.slsjdef;
default_time(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.slsjdef;
gas_lower(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.mqlllower;
gas_lower(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.mqlllower;
gas_lower(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.mqlllower;
wendu_middle(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmid;
wendu_middle(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmid;
wendu_middle(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmid;
wendu_max(1) = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmax;
wendu_max(2) = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmax;
wendu_max(3) = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmax;
default_air_pressure = paramdata.commdata(1).parameter(2).ATTRIBUTE.zrkqyldef;
default_gas_pressure = paramdata.commdata(1).parameter(2).ATTRIBUTE.mqgwyldef;
popmenuswitchorder(1) = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder1;
popmenuswitchorder(2) = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder2;
popmenuswitchorder(3) = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder3;
curhuanlusx = [num2str(popmenuswitchorder(1)) '#' ' ' num2str(popmenuswitchorder(2)) '#' ' ' num2str(popmenuswitchorder(3)) '#'];
set(handles.text192,'String',curhuanlusx);

ts1=default_tempture(1);        %炉顶温度初始化
set(handles.ts1,'String',ts1);

ts2=default_tempture(2);
set(handles.ts2,'String',ts2);

ts3=default_tempture(3);
set(handles.ts3,'String',ts3);

time1_set=default_time(1);         %烧炉时间初始化
set(handles.time1,'String',time1_set);

time2_set=default_time(2);
set(handles.time2,'String',time2_set);

time3_set=default_time(3);
set(handles.time3,'String',time3_set);


air_pressure=default_air_pressure;           %空气主管压力初始化
set(handles.air_pressure,'String',air_pressure);

gas_pressure=default_gas_pressure;           %空气主管压力初始化
set(handles.text187,'String',gas_pressure);

choose_fj = 1;               %风机选择
set(handles.choose_fj1,'BackgroundColor',[0 1 0]);
set(handles.choose_fj2,'BackgroundColor',[0.941 0.941 0.941]);
air_1 = 9;     %空气主管压力初始化 
set(handles.air_press,'String',air_1);
% % % set(handles.air_slider,'Value',air_1);
% % % set(handles.air_slider,'Max',air_1+5,'Min',air_1-5);
% % % set(handles.air_slider,'SliderStep',[0.1/10,0.5/10]);
%% 将原先直接调节改变为相对偏移已有值偏移多少
set(handles.air_slider,'Value',0);
set(handles.air_slider,'Max',3,'Min',-3);
set(handles.air_slider,'SliderStep',[0.5/6,1/6]);
%CO测点初始化
% coswitch = 1;
set(handles.CO_cedian,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.CO_cedian2,'BackgroundColor',[0 1 0]);

%煤气压力设定低于 值 断开中控
gas_1 = 5;
set(handles.gas_press,'String',gas_1);
set(handles.gas_slider,'Value',gas_1);
set(handles.gas_slider,'Max',gas_1+5,'Min',gas_1-5);
set(handles.gas_slider,'SliderStep',[0.1/10,0.5/10]);
open_flag = 1;
gas_lower1=gas_lower(1);  %煤气流量下限初始化
set(handles.gas_lower1,'String',gas_lower1);

gas_lower2=gas_lower(2);  %煤气流量下限初始化
set(handles.gas_lower2,'String',gas_lower2);

gas_lower3=gas_lower(3);  %煤气流量下限初始化
set(handles.gas_lower3,'String',gas_lower3);
%%

wendu_max1=wendu_max(1); 
set(handles.wendu_max1,'String',wendu_max1);

wendu_max2=wendu_max(2);  
set(handles.wendu_max2,'String',wendu_max2);

wendu_max3=wendu_max(3);  
set(handles.wendu_max3,'String',wendu_max3);

wendu_middle1=wendu_middle(1);  
set(handles.wendu_middle1,'String',wendu_middle1);

% hd(1,:) = [1;2;3;handles.wendu_middle3];
% hd(2,:) = [3;3;3;handles.wendu_middle2];
wendu_middle2=wendu_middle(2);  
set(handles.wendu_middle2,'String',wendu_middle2);
%  i = 1;
% set(hd(i,4),'String',wendu_middle2);

wendu_middle3=wendu_middle(3);
% i = 2;
set(handles.wendu_middle3,'String',wendu_middle3);
% set(hd(i,4),'String',wendu_middle3);

identifier = 0;
FQTmpupperlimitS = [450,450,450];
FQTmplowerlimitS = [200,200,200];
GDupperlimitS = [1380,1380,1380];
GDlowerlimitS = [1200,1200,1200];
alarm_button_clicked = [0,0,0,0];
ifalarmsound = [0,0,0,0,0];
airpressupperlimit = 7.5;
airpresslowerlimit = 4.5;
gaspressupperlimit = 7.5;
gaspresslowerlimit = 4.5;
alarm_timer = [120,120,120,120];
alarm_sound_flag = 0;
autoswitch = 0; %自动换炉信号
autoshaolu = 0; %自动烧炉
set(handles.checkbox2,'Value',0) ;
set(handles.checkbox2,'Enable','off');
set(handles.checkbox2,'ForegroundColor',[0 0 0]);

%自动换炉时 变换顺序时需要不同炉号对应自己的变量数值
%变量依次为：空气阀设定值、煤气阀设定值、煤气阀反馈、煤气阀设定值、空气阀反馈、空气阀设定、焖炉转燃烧、燃烧转焖炉、焖炉转送风、送风转焖炉、烧炉按钮、烧炉关闭按钮、加烧按钮、减少按钮、煤气支管手动、空气支管手动
selectedOrder(1,:) = [3;1;2;1;4;3;14;15;16;17;handles.apc_1_on;handles.apc_1_off;handles.max_burn1;handles.min_burn1;18;19];
selectedOrder(2,:) = [22;20;21;20;23;22;33;34;35;36;handles.apc_2_on;handles.apc_2_off;handles.max_burn2;handles.min_burn2;37;38];
selectedOrder(3,:) = [41;39;40;39;42;41;52;53;54;55;handles.apc_3_on;handles.apc_3_off;handles.max_burn3;handles.min_burn3;56;57];

set(handles.tempswitch1_2,'BackgroundColor',[0 1 0]);
set(handles.tempswitch2_1,'BackgroundColor',[0 1 0]);
set(handles.tempswitch3_2,'BackgroundColor',[0 1 0]);
        
set(handles.pushbutton83,'BackgroundColor',[0 1 0]);
set(handles.pushbutton87,'BackgroundColor',[0 1 0]);
set(handles.pushbutton85,'BackgroundColor',[0 1 0]);
% 加烧减烧流量设定
set(handles.flow_buchang,'String',0);
set(handles.flow_slider,'Value',0);
set(handles.flow_slider,'Max',20000,'Min',-20000);
set(handles.flow_slider,'SliderStep',[1000/40000,3000/40000]);

set(handles.flow_buchang2,'String',0);
set(handles.flow_slider2,'Value',0);
set(handles.flow_slider2,'Max',20000,'Min',-20000);
set(handles.flow_slider2,'SliderStep',[1000/40000,3000/40000]);

set(handles.flow_buchang3,'String',0);
set(handles.flow_slider3,'Value',0);
set(handles.flow_slider3,'Max',20000,'Min',-20000);
set(handles.flow_slider3,'SliderStep',[1000/40000,3000/40000]);
% UIWAIT makes apc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = apc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in connect_wincc.
function connect_wincc_Callback(hObject, eventdata, handles)
global auth first_time_connect_flag daobj group itemset tempdata data loopnum pidloop contag dialogtimer
 % hObject    handle to connect_wincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% diary on %打开日志记录
set(handles.connect_wincc,'Enable','off')
auth=1;
%id=hostid;
% if strcmp(id{1},'161051')
% % %读写key文件
% % load('key');
% % usedtime=decodekey(key.usedtime);%这里的key文件主要是起加密作用，主要是给别人使用有时间限制的
% % validtime=decodekey(key.validtime);
% % license=decodekey(key.license);
% % usedtime=usedtime+1;
% % key.usedtime=encodekey(usedtime);
% % licensevalid=decodekey(key.licensevalid);
% % load('bak');  %%防止授权激活后，拷贝key出去，再次使用
% % usedtime1=decodekey(bak.usedtime);
% % usedtime1=usedtime1+1;
% % bak.usedtime=encodekey(usedtime1);
% % if (now - license<=7) && (now - license>=-7)&&licensevalid ==101110%-7表示防止现场电脑时间和生成key用的电脑时间不对应，所以扩大范围。有效期为7天
% %     licensevalid = 101111;
% %     usedtime1 = usedtime;
% %     bak.usedtime=encodekey(usedtime1);
% %     key.licensevalid = encodekey(licensevalid);%使license有效
% % end
% % save('key.mat','key');
% % save('bak.mat','bak');
% % 
% % if ((validtime-usedtime)>=0)&&(licensevalid==101111)%Need_to_be_modified
% % %     auth=1;
% %     if usedtime1 ~= usedtime     %%防止授权激活后，拷贝key出去，再次使用
% %         msgbox('授权有效期到期，请更新授权！');
% %     else
% %         auth=1;
% %     end
% % else
% %     msgbox('授权有效期到期，请更新授权！');
% % end

if auth==1
    if strcmp(daobj.Status,'disconnected')
        if first_time_connect_flag==1
            first_time_connect_flag=0;
            
 %% additem
       connect(daobj);
       itemset = additem(group, {'1#炉煤气支管调节阀.给定',...
                                '1#炉煤气支管调节阀.反馈',...
                                '1#炉助燃风支管调节阀.给定',...
                                '1#炉助燃风支管调节阀.反馈',...
                                '1#燃烧室温度s',...
                                '1#热风炉1#烟道支管温度',...
                                '1#炉煤气支管流量累积量',...
                                '1#热风炉2#烟道支管温度',...
                                '1#热风炉送风状态',...
                                '1#热风炉烧炉状态',...
                                '1#热风炉焖炉状态',...
                                '1#炉煤气支管流量',...
                                '1#炉助燃风支管流量',...
                                '1#热风炉烧炉操作',...
                                '煤气总管流量累积量',...
                                '1#热风炉送风操作',...
                                '1#热风炉手自动',...
                                '1#炉煤气支管调节阀.手自动',...
                                '1#炉助燃风支管调节阀.手自动',...
                                '2#炉煤气支管调节阀.给定',...
                                '2#炉煤气支管调节阀.反馈',...
                                '2#炉助燃风支管调节阀.给定',...
                                '2#炉助燃风支管调节阀.反馈',...
                                '2#燃烧室温度h',...
                                '2#热风炉1#烟道支管温度',...
                                '2#炉煤气支管流量累积量',...
                                '2#热风炉2#烟道支管温度',...
                                '2#热风炉送风状态',...
                                '2#热风炉烧炉状态',...
                                '2#热风炉焖炉状态',...
                                '2#炉煤气支管流量',...
                                '2#炉助燃风支管流量',...
                                '2#热风炉烧炉操作',...
                                '2#热风炉焖炉操作',...
                                '2#热风炉送风操作',...
                                '2#热风炉手自动',...
                                '2#炉煤气支管调节阀.手自动',...
                                '2#炉助燃风支管调节阀.手自动',...
                                '3#炉煤气支管调节阀.给定',...
                                '3#炉煤气支管调节阀.反馈',...
                                '3#炉助燃风支管调节阀.给定',...
                                '3#炉助燃风支管调节阀.反馈',...
                                '3#燃烧室温度s',...
                                '3#热风炉1#烟道支管温度',...
                                '3#炉煤气支管流量累积量',...
                                '3#热风炉2#烟道支管温度',...
                                '3#热风炉送风状态',...
                                '3#热风炉烧炉状态',...
                                '3#热风炉焖炉状态',...
                                '3#炉煤气支管流量',...
                                '3#炉助燃风支管流量',...
                                '3#热风炉烧炉操作',...
                                '3#热风炉焖炉操作',...
                                '3#热风炉送风操作',...
                                '3#热风炉手自动',...
                                '3#炉煤气支管调节阀.手自动',...
                                '3#炉助燃风支管调节阀.手自动',...
                                '热风总管混风前温度',...
                                '热风总管混风后温度',...
                                '煤气分析仪CO',...
                                '煤气总管预热后压力',...
                                '助燃风总管预热前压力',...
                                '2#助燃风机调节阀.给定',...
                                '2#助燃风机调节阀.反馈',...
                                '1#燃烧室温度h',...
                                '2#燃烧室温度s',...
                                '热风总管压力',...
                                '煤气总管预热前压力',...
                                '1#助燃风机调节阀.给定',...
                                '1#助燃风机调节阀.反馈',...
                                '3#燃烧室温度h'
                                });
                              
  %initialize parameter
  % connect to opcserver,init data 
%             connect(daobj);
            % tempdata=read(group);
            % data=tempdata;
            tempdata=read(group);
            data=zeros(length(tempdata),1);
            data(1:6,1)=fix(clock);      
               %% prepare pidloop and pid parameter
            loopnum=8;% 1#煤气 2#煤气 3#煤气 1#空气 2#空气 3#空气 煤气压力 空气压力
            % pidloop=zeros(9,loopnum);
            pidloop=[0 0 0 0 0 0 0 0  ;%sp
                           0 0 0 0 0 0 0 0  ;%pv
                           0 0 0 0 0 0 0 0  ;%mv
                           0 0 0 0 0 0 0 0  ;%e0
                           0 0 0 0 0 0 0 0  ;%e1
                           0 0 0 0 0 0 0 0  ;%e2
                           0.09 0.095 0.1 0.1 0.095 0.105 5 5 ;%kp
                          30 35 40 32 37 42 40 30  ;%ti
                          0 0 0 0 0 0 0 0 ;%td
                          1 1 1 1 1 1 1 1  ;%man_on
                          75 75 75 75 75 75 70 70 ;%upperlimit
                          10  10  10  10   10   10  5  10;%lowerlimit
                          1 1 1 1 1 1 0 0 ;%deadzone
                     ];
                       
        else
            delete(itemset);
            connect(daobj);
            
            itemset = additem(group, {'1#炉煤气支管调节阀.给定',...
                                '1#炉煤气支管调节阀.反馈',...
                                '1#炉助燃风支管调节阀.给定',...
                                '1#炉助燃风支管调节阀.反馈',...
                                '1#燃烧室温度s',...
                                '1#热风炉1#烟道支管温度',...
                                '1#炉煤气支管流量累积量',...
                                '1#热风炉2#烟道支管温度',...
                                '1#热风炉送风状态',...
                                '1#热风炉烧炉状态',...
                                '1#热风炉焖炉状态',...
                                '1#炉煤气支管流量',...
                                '1#炉助燃风支管流量',...
                                '1#热风炉烧炉操作',...
                                '煤气总管流量累积量',...
                                '1#热风炉送风操作',...
                                '1#热风炉手自动',...
                                '1#炉煤气支管调节阀.手自动',...
                                '1#炉助燃风支管调节阀.手自动',...
                                '2#炉煤气支管调节阀.给定',...
                                '2#炉煤气支管调节阀.反馈',...
                                '2#炉助燃风支管调节阀.给定',...
                                '2#炉助燃风支管调节阀.反馈',...
                                '2#燃烧室温度h',...
                                '2#热风炉1#烟道支管温度',...
                                '2#炉煤气支管流量累积量',...
                                '2#热风炉2#烟道支管温度',...
                                '2#热风炉送风状态',...
                                '2#热风炉烧炉状态',...
                                '2#热风炉焖炉状态',...
                                '2#炉煤气支管流量',...
                                '2#炉助燃风支管流量',...
                                '2#热风炉烧炉操作',...
                                '2#热风炉焖炉操作',...
                                '2#热风炉送风操作',...
                                '2#热风炉手自动',...
                                '2#炉煤气支管调节阀.手自动',...
                                '2#炉助燃风支管调节阀.手自动',...
                                '3#炉煤气支管调节阀.给定',...
                                '3#炉煤气支管调节阀.反馈',...
                                '3#炉助燃风支管调节阀.给定',...
                                '3#炉助燃风支管调节阀.反馈',...
                                '3#燃烧室温度s',...
                                '3#热风炉1#烟道支管温度',...
                                '3#炉煤气支管流量累积量',...
                                '3#热风炉2#烟道支管温度',...
                                '3#热风炉送风状态',...
                                '3#热风炉烧炉状态',...
                                '3#热风炉焖炉状态',...
                                '3#炉煤气支管流量',...
                                '3#炉助燃风支管流量',...
                                '3#热风炉烧炉操作',...
                                '3#热风炉焖炉操作',...
                                '3#热风炉送风操作',...
                                '3#热风炉手自动',...
                                '3#炉煤气支管调节阀.手自动',...
                                '3#炉助燃风支管调节阀.手自动',...
                                '热风总管混风前温度',...
                                '热风总管混风后温度',...
                                '煤气分析仪CO',...
                                '煤气总管预热后压力',...
                                '助燃风总管预热前压力',...
                                '2#助燃风机调节阀.给定',...
                                '2#助燃风机调节阀.反馈',...
                                '1#燃烧室温度h',...
                                '2#燃烧室温度s',...
                                '热风总管压力',...
                                '煤气总管预热前压力',...
                                '1#助燃风机调节阀.给定',...
                                '1#助燃风机调节阀.反馈',...
                                '3#燃烧室温度h'
                                });
        end
         
        t_iohandle = timer('Name','apctimer','TimerFcn', {@on_timer, handles},'ExecutionMode','fixedRate','Period',1,'BusyMode','queue');
        start(t_iohandle);  
         %% 
         set(handles.text3,'String','已连接');
          set(handles.connect_wincc,'BackgroundColor',[0 1 0]);
          set(handles.disconnect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
%          set(handles.text3,'ForegroundColor',[0 1 0]);
%          set(handles.connectwincc,'Enable','off')
    else
            msgbox('已经连接','错误')
     end
else
    auth=0;
    close(handles.figure1);%关闭figure
end
set(handles.connect_wincc,'Enable','on')






% --- Executes on button press in disconnect_wincc.
function disconnect_wincc_Callback(hObject, eventdata, handles)
global daobj temp_open  gas_open  air_open pidloop gap_on max_burning min_burning data
global autoswitch autoshaolu
% hObject    handle to disconnect_wincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button2=questdlg('确定断开？','断开中控','是','否','否');
if strcmp(button2,'是')
    if ~isempty(timerfind)
        stop(timerfind)
        delete(timerfind)
    end
    if strcmp(daobj.Status,'connected')
        disconnect(daobj)
    end
    set(handles.text3,'String','已断开');
    set(handles.text3,'ForegroundColor',[0 0 0]);
    temp_open(1)=0;
    temp_open(2)=0;
    temp_open(3)=0;
    max_burning=[0 0 0];
    min_burning=[0 0 0];

    set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
    set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
    set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
    set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
    set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
    pidloop(10,1)=1;          %1#炉打开手动控制        
    pidloop(10,4)=1;
    pidloop(10,2)=1;          %2#炉打开手动控制        
    pidloop(10,5)=1;
    pidloop(10,3)=1;          %3#炉打开手动控制        
    pidloop(10,6)=1;
    pidloop(10,7)=1;          %煤气总管打开手动控制        
    pidloop(10,8)=1;          %空气总管打开手动控制
    set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);


    set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
    gap_on(1)=0;
    gap_on(2)=0;
    gap_on(3)=0;

    autoswitch = 0;
    set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
    autoshaolu = 0; %连锁 关闭自动烧炉
    set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.checkbox2,'Value',0) ;
    set(handles.checkbox2,'Enable','off');
    set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    datetime = datestr(now,30);
    s = ['save(''data',datetime(1:8),datetime(10:13),'.mat'',''data'');'];
    eval(s);
    lastsave = ['data',datetime(1:8),datetime(10:13),'.mat'];
    
%     diary off %关闭日志记录
end;









% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in apc_1_on.
function apc_1_on_Callback(hObject, eventdata, handles)
global temp_open pidloop left_time max_burning min_burning default_airgaspotial good_airgaspotial min_airgaspotial a_write 
% hObject    handle to apc_1_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on paramdata
default_airgaspotial(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
% % % default_airgaspotial(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
% % % default_airgaspotial(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
if burning(1) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_1_on,'BackgroundColor',[0 1 0]);
    set(handles.apc_1_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
    if temp_open(1)==0    
     left_time(1)=-1;
    end
    temp_open(1)=1;
   
    max_burning(1)=0;
    min_burning(1)=0;
    a_write=[1 0 0];             %标志位控制阀门写入速度，让写入操作一次只对一个阀门起作用

    good_airgaspotial(1)=default_airgaspotial(1);
  
    pidloop(10,1)=0;          %1#炉打开自动控制        
    pidloop(10,4)=0;
    
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end




% --- Executes on button press in apc_2_on.
function apc_2_on_Callback(hObject, eventdata, handles)
global temp_open pidloop left_time max_burning min_burning default_airgaspotial good_airgaspotial min_airgaspotial a_write
% hObject    handle to apc_2_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on paramdata
% % % default_airgaspotial(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
default_airgaspotial(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
% % % default_airgaspotial(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
if burning(2) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_2_on,'BackgroundColor',[0 1 0]);
    set(handles.apc_2_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
    if temp_open(2)==0    
     left_time(2)=-1;
    end
    max_burning(2)=0;
    min_burning(2)=0;
    temp_open(2)=1;
    a_write=[0 1 0];

    good_airgaspotial(2)=default_airgaspotial(2);
    
    pidloop(10,2)=0;          %2#炉打开自动控制        
    pidloop(10,5)=0;
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end


% --- Executes on button press in apc_3_on.
function apc_3_on_Callback(hObject, eventdata, handles)
global temp_open pidloop left_time max_burning min_burning default_airgaspotial good_airgaspotial  a_write min_airgaspotial
% hObject    handle to apc_3_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on paramdata
% % % default_airgaspotial(1)=paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;
% % % default_airgaspotial(2)=paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
default_airgaspotial(3)=paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
if burning(3) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_3_on,'BackgroundColor',[0 1 0]);
    set(handles.apc_3_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
    if temp_open(3)==0    
     left_time(3)=-1;
    end
        temp_open(3)=1;
 
    max_burning(3)=0;
    min_burning(3)=0;

    a_write=[0 0 1];

    good_airgaspotial(3)=default_airgaspotial(3);

    pidloop(10,3)=0; %3#炉打开自动控制       
    pidloop(10,6)=0;
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end

% --- Executes on button press in apc_1_off.
function apc_1_off_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning autoshaolu
% hObject    handle to apc_1_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
temp_open(1)=0;
max_burning(1)=0;
min_burning(1)=0;
  pidloop(10,1)=1;          %1#炉打开手动控制        
  pidloop(10,4)=1;
 autoshaolu = 0; %关闭自动烧炉功能
 set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
 set(handles.checkbox2,'Value',0) ;
 set(handles.checkbox2,'ForegroundColor',[0 0 0]);



% --- Executes on button press in apc_2_off.
function apc_2_off_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning autoshaolu
% hObject    handle to apc_2_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
temp_open(2)=0;
max_burning(2)=0;
min_burning(2)=0;
  pidloop(10,2)=1;          %2#炉打开手动控制        
  pidloop(10,5)=1;
autoshaolu = 0; %关闭自动烧炉功能
set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.checkbox2,'Value',0) ;
set(handles.checkbox2,'ForegroundColor',[0 0 0]);
  
% --- Executes on button press in apc_3_off.
function apc_3_off_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning autoshaolu
% hObject    handle to apc_3_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
temp_open(3)=0;
max_burning(3)=0;
min_burning(3)=0;
  pidloop(10,3)=1;          %3#炉打开手动控制        
  pidloop(10,6)=1;
autoshaolu = 0; %关闭自动烧炉功能
set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.checkbox2,'Value',0) ;
set(handles.checkbox2,'ForegroundColor',[0 0 0]);
% --------------------------------------------------------------------
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_copyright_Callback(hObject, eventdata, handles)
% hObject    handle to menu_copyright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% hm = msgbox('唐山城鼓有限公司版权所有','版权信息');
set(0,'CurrentFigure',about);  
% newIcon = javax.swing.ImageIcon('icon.png')
% figFrame = get(hm,'JavaFrame'); %取得Figure的JavaFrame。
% figFrame.setFigureIcon(newIcon); %修改图标
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in air_pressure_on.
function air_pressure_on_Callback(hObject, eventdata, handles)
global pidloop choose_fj data b
global temp_open autoswitch daobj autoshaolu gap_on max_burning min_burning
% hObject    handle to air_pressure_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if choose_fj == 1 && data(69,b+1) > 0    
    if strcmp(daobj.Status,'connected')
        set(handles.air_pressure_on,'BackgroundColor',[0 1 0]);
        set(handles.air_pressure_off,'BackgroundColor',[0.941 0.941 0.941]);
        pidloop(10,8)=0;            %空气总管压力回路切自动
    end
elseif choose_fj == 2 && data(63,b+1) > 0
    if strcmp(daobj.Status,'connected')
        set(handles.air_pressure_on,'BackgroundColor',[0 1 0]);
        set(handles.air_pressure_off,'BackgroundColor',[0.941 0.941 0.941]);
        pidloop(10,8)=0;            %空气总管压力回路切自动
    end
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end


% --- Executes on button press in air_pressure_off.
function air_pressure_off_Callback(hObject, eventdata, handles)
global pidloop air_pressure_offset
% hObject    handle to air_pressure_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
pidloop(10,8)=1;            %空气总管压力回路切手动
air_pressure_offset=0;



function figure1_CloseRequestFcn(hObject, eventdata, handles)
global daobj auth
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% if auth==1
button2=questdlg('确定退出？','退出程序','是','否','否');
if strcmp(button2,'是')
    if ~isempty(timerfind)
    stop(timerfind)
    delete(timerfind)
    end
    if strcmp(daobj.Status,'connected')
    disconnect(daobj)
    end
    delete(hObject);
    diary off %关闭日志记录
end;
%  else
%     delete(hObject);
% end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
% set(hObject,'Value',slide_value);
% 
% 
% 
% set(handles.airgaspotial_1,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
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
% a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
% set(hObject,'Value',slide_value);
% 
% 
% 
% set(handles.airgaspotial_2,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% a=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
% set(hObject,'Value',slide_value);
% 
% 
% 
% set(handles.airgaspotial_3,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in airgaspotial_1_on.
function airgaspotial_1_on_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_1_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_1_on,'BackgroundColor',[0 1 0]);
set(handles.airgaspotial_1_off,'BackgroundColor',[0.941 0.941 0.941]);
gap_on(1)=1;

% --- Executes on button press in airgaspotial_1_off.
function airgaspotial_1_off_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_1_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_1_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.airgaspotial_1_off,'BackgroundColor',[1 0 0]);
gap_on(1)=0;
% --- Executes on button press in airgaspotial_2_on.
function airgaspotial_2_on_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_2_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_2_on,'BackgroundColor',[0 1 0]);
set(handles.airgaspotial_2_off,'BackgroundColor',[0.941 0.941 0.941]);
gap_on(2)=1;

% --- Executes on button press in airgaspotial_2_off.
function airgaspotial_2_off_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_2_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_2_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.airgaspotial_2_off,'BackgroundColor',[1 0 0]);
gap_on(2)=0;

% --- Executes on button press in airgaspotial_3_on.
function airgaspotial_3_on_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_3_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_3_on,'BackgroundColor',[0 1 0]);
set(handles.airgaspotial_3_off,'BackgroundColor',[0.941 0.941 0.941]);
gap_on(3)=1;

% --- Executes on button press in airgaspotial_3_off.
function airgaspotial_3_off_Callback(hObject, eventdata, handles)
global gap_on
% hObject    handle to airgaspotial_3_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.airgaspotial_3_on,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.airgaspotial_3_off,'BackgroundColor',[1 0 0]);
gap_on(3)=0;


% --- Executes during object creation, after setting all properties.
function disconnect_wincc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disconnect_wincc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
% b=round(a*100);
 airgaspotial1_value=a;    %b/100;
set(hObject,'Value',airgaspotial1_value);
set(handles.airgaspotial_1,'String',num2str(airgaspotial1_value));

% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
% b=round(a*100);
airgaspotial2_value=a;    % b/100;
set(hObject,'Value',airgaspotial2_value);
set(handles.airgaspotial_2,'String',num2str(airgaspotial2_value));

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
% b=round(a*100);
airgaspotial3_value=a;       %b/100;
set(hObject,'Value',airgaspotial3_value);
set(handles.airgaspotial_3,'String',num2str(airgaspotial3_value));
% airgaspotial(1)=agp1_value;

% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object deletion, before destroying properties.
function slider13_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider13.
function slider13_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider7.
function slider7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function time1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in max_burn1.
function max_burn1_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
% hObject    handle to max_burn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
set(0,'CurrentFigure',gd_gas1);


% --- Executes on button press in min_burn1.
function min_burn1_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time 
% hObject    handle to min_burn1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
if burning(1) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_1_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn1,'BackgroundColor',[0 1 0]);
    if temp_open(1)==0    
     left_time(1)=-1;
    end
    temp_open(1)=1;
    max_burning(1)=0;
    min_burning(1)=1;
    a_write=[1 0 0];
    max_min_timeFlag(1)=120;
    pidloop(10,1)=0;          %1#炉打开自动控制        
    pidloop(10,4)=0;
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end

% --- Executes on button press in max_burn2.
function max_burn2_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
% hObject    handle to max_burn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
set(0,'CurrentFigure',gd_gas2);



% --- Executes on button press in min_burn2.
function min_burn2_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
% hObject    handle to min_burn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
if burning(2) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_2_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn2,'BackgroundColor',[0 1 0]);
        if temp_open(2)==0    
     left_time(2)=-1;
    end
    temp_open(2)=1;
    max_burning(2)=0;
    min_burning(2)=1;
    a_write=[0 1 0];
    max_min_timeFlag(2)=120;
    pidloop(10,2)=0;          %1#炉打开自动控制        
    pidloop(10,5)=0;
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end

% --- Executes on button press in max_burn3.
function max_burn3_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
% hObject    handle to max_burn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
set(0,'CurrentFigure',gd_gas3);

% --- Executes on button press in min_burn3.
function min_burn3_Callback(hObject, eventdata, handles)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
% hObject    handle to min_burn3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on
if burning(3) == 1&&strcmp(daobj.Status,'connected')
    set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.apc_3_off,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.min_burn3,'BackgroundColor',[0 1 0]);
    if temp_open(3)==0    
     left_time(3)=-1;
    end
    temp_open(3)=1;
    max_burning(3)=0;
    min_burning(3)=1;
    a_write=[0 0 1];
    max_min_timeFlag(3)=120;
    pidloop(10,3)=0;          %1#炉打开自动控制        
    pidloop(10,6)=0;
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end


% --- Executes during object creation, after setting all properties.
function slider31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function param_edit_Callback(hObject, eventdata, handles)
% hObject    handle to param_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'CurrentFigure',paramset);
pophandles = guihandles;
set(pophandles.figure1, 'WindowStyle', 'modal');


% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS pophandles identifier
global alarm_sound_flag alarm_button_clicked test1227_2
% open('alarmset.fig');
identifier = 1;
set(0,'CurrentFigure',alarmset);
pophandles = guihandles;
   test1227_2=pophandles;
set(pophandles.text16,'String','1#炉');

set(pophandles.text12,'String',GDupperlimitS(1));
set(pophandles.slider1,'Value',GDupperlimitS(1));

set(pophandles.text13,'String',GDlowerlimitS(1));
set(pophandles.slider2,'Value',GDlowerlimitS(1));

set(pophandles.text14,'String',FQTmpupperlimitS(1));
set(pophandles.slider4,'Value',FQTmpupperlimitS(1));

set(pophandles.text15,'String',FQTmplowerlimitS(1));
set(pophandles.slider5,'Value',FQTmplowerlimitS(1));

set(pophandles.figure1, 'WindowStyle', 'modal');

alarm_sound_flag = 0;
alarm_button_clicked(1) = 1;
set(handles.pushbutton53,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS pophandles identifier
global alarm_sound_flag alarm_button_clicked
% open('alarmset.fig');
identifier = 2;
set(0,'CurrentFigure',alarmset);
pophandles = guihandles;

set(pophandles.text16,'String','2#炉');

set(pophandles.text12,'String',GDupperlimitS(2));
set(pophandles.slider1,'Value',GDupperlimitS(2));

set(pophandles.text13,'String',GDlowerlimitS(2));
set(pophandles.slider2,'Value',GDlowerlimitS(2));

set(pophandles.text14,'String',FQTmpupperlimitS(2));
set(pophandles.slider4,'Value',FQTmpupperlimitS(2));

set(pophandles.text15,'String',FQTmplowerlimitS(2));
set(pophandles.slider5,'Value',FQTmplowerlimitS(2));

set(pophandles.figure1, 'WindowStyle', 'modal');

alarm_sound_flag = 0;
alarm_button_clicked(2) = 1;
set(handles.pushbutton54,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS pophandles identifier
global alarm_sound_flag alarm_button_clicked
% open('alarmset.fig');
identifier = 3;
set(0,'CurrentFigure',alarmset);
pophandles = guihandles;

set(pophandles.text16,'String','3#炉');

set(pophandles.text12,'String',GDupperlimitS(3));
set(pophandles.slider1,'Value',GDupperlimitS(3));

set(pophandles.text13,'String',GDlowerlimitS(3));
set(pophandles.slider2,'Value',GDlowerlimitS(3));

set(pophandles.text14,'String',FQTmpupperlimitS(3));
set(pophandles.slider4,'Value',FQTmpupperlimitS(3));

set(pophandles.text15,'String',FQTmplowerlimitS(3));
set(pophandles.slider5,'Value',FQTmplowerlimitS(3));

set(pophandles.figure1, 'WindowStyle', 'modal');

alarm_sound_flag = 0;
alarm_button_clicked(3) = 1;
set(handles.pushbutton55,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global airpressupperlimit airpresslowerlimit pophandles2
global alarm_sound_flag alarm_button_clicked
global gaspressupperlimit gaspresslowerlimit
% open('alarmset.fig');
% % % set(0,'CurrentFigure',alarmset2);
% % % pophandles2 = guihandles;
% % % 
% % % 
% % % set(pophandles2.text11,'String',airpressupperlimit);
% % % set(pophandles2.slider1,'Value',airpressupperlimit);
% % % 
% % % set(pophandles2.text12,'String',airpresslowerlimit);
% % % set(pophandles2.slider2,'Value',airpresslowerlimit);
% % % 
% % % set(pophandles2.text25,'String',gaspressupperlimit);
% % % set(pophandles2.slider7,'Value',gaspressupperlimit);
% % % 
% % % set(pophandles2.text26,'String',gaspresslowerlimit);
% % % set(pophandles2.slider8,'Value',gaspresslowerlimit);
% % % 
% % % set(pophandles2.figure1, 'WindowStyle', 'modal');

alarm_sound_flag = 0;
alarm_button_clicked(4) = 1;
set(handles.pushbutton56,'BackgroundColor',[0.941 0.941 0.941]);


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global autoswitch autoshaolu
global daobj  gap_on temp_open pidloop max_burning min_burning 
autoswitch = 1-autoswitch;
if autoswitch
    set(handles.pushbutton57,'BackgroundColor',[0 1 0]);
        autoshaolu=0;
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','on');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
else
    set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
    autoshaolu = 0; %连锁 关闭自动烧炉
    set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
    set(handles.checkbox2,'Value',0) ;
    set(handles.checkbox2,'Enable','off');
    set(handles.checkbox2,'ForegroundColor',[0 0 0]);
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
        msgbox('中控未连接！');
    
end


% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global autoswitch autoshaolu
global daobj  gap_on temp_open pidloop max_burning min_burning 
if autoswitch %只有自动换炉 打开，自动烧炉功能才可用
    autoshaolu = 1-autoshaolu; 
    if autoshaolu
        set(handles.pushbutton58,'BackgroundColor',[0 1 0]);
    else
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
    end
end
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end

% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pidloop
global temp_open autoswitch daobj autoshaolu gap_on max_burning min_burning
if strcmp(daobj.Status,'connected')
    set(handles.pushbutton59,'BackgroundColor',[0 1 0]);
    set(handles.pushbutton60,'BackgroundColor',[0.941 0.941 0.941]);
    pidloop(10,7)=0;  
end%煤气管网压力回路切自动
if strcmp(daobj.Status,'disconnected')
        temp_open(1)=0;
        temp_open(2)=0;
        temp_open(3)=0;
        max_burning=[0 0 0];
        min_burning=[0 0 0];
        set(handles.text3,'String','已断开');
        set(handles.connect_wincc,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.disconnect_wincc,'BackgroundColor',[1 0 0]);
        set(handles.apc_1_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_1_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_2_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_2_off,'BackgroundColor',[1 0 0]);
        set(handles.apc_3_on,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.apc_3_off,'BackgroundColor',[1 0 0]);
        set(handles.max_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn2,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.max_burn3,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.min_burn3,'BackgroundColor',[0.941 0.941 0.941]);
          pidloop(10,1)=1;          %1#炉打开手动控制        
          pidloop(10,4)=1;
          pidloop(10,2)=1;          %2#炉打开手动控制        
          pidloop(10,5)=1;
          pidloop(10,3)=1;          %3#炉打开手动控制        
          pidloop(10,6)=1;
          pidloop(10,7)=1;          %煤气总管打开手动控制        
          pidloop(10,8)=1;          %空气总管打开手动控制
        set(handles.air_pressure_on,'BackgroundColor',[0.941 0.941 0.941]);   
        set(handles.air_pressure_off,'BackgroundColor',[1 0 0]);
        gap_on(1)=0;
        gap_on(2)=0;
        gap_on(3)=0;
        autoswitch = 0;
        set(handles.pushbutton57,'BackgroundColor',[0.941 0.941 0.941]);
        autoshaolu = 0; %连锁 关闭自动烧炉
        set(handles.pushbutton58,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.checkbox2,'Value',0) ;
        set(handles.checkbox2,'Enable','off');
        set(handles.checkbox2,'ForegroundColor',[0 0 0]);
    msgbox('中控未连接！');
    
end

% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pidloop
set(handles.pushbutton59,'BackgroundColor',[0.941 0.941 0.941]);
set(handles.pushbutton60,'BackgroundColor',[1 0 0]);
pidloop(10,7)=1;           %煤气管网压力回路切自动


% --- Executes on button press in tempswitch1_1.
function tempswitch1_1_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch1_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(1)==0
    button2=questdlg('将切换到S偶','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(1)=1;
        set(handles.tempswitch1_1,'BackgroundColor',[0 1 0]);
        set(handles.tempswitch1_2,'BackgroundColor',[0.941 0.941 0.941]);
    end
end



% --- Executes on button press in tempswitch2_2.
function tempswitch2_2_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(2)==1
    button2=questdlg('将切换到红外','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(2)=0;
        set(handles.tempswitch2_1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tempswitch2_2,'BackgroundColor',[0 1 0]);
    end
end



% --- Executes on button press in tempswitch3_1.
function tempswitch3_1_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch3_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(3)==0
    button2=questdlg('将切换到S偶','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(3)=1;
        set(handles.tempswitch3_1,'BackgroundColor',[0 1 0]);
        set(handles.tempswitch3_2,'BackgroundColor',[0.941 0.941 0.941]);
    end
end



% --- Executes on button press in tempswitch1_2.
function tempswitch1_2_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(1)==1
    button2=questdlg('将切换到红外','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(1)=0;
        set(handles.tempswitch1_1,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.tempswitch1_2,'BackgroundColor',[0 1 0]);
    end
end


% --- Executes on button press in tempswitch2_1.
function tempswitch2_1_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(2)==0
    button2=questdlg('将切换到S偶','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(2)=1;
        set(handles.tempswitch2_1,'BackgroundColor',[0 1 0]);
        set(handles.tempswitch2_2,'BackgroundColor',[0.941 0.941 0.941]);
    end
end


% --- Executes on button press in tempswitch3_2.
function tempswitch3_2_Callback(hObject, eventdata, handles)
% hObject    handle to tempswitch3_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tempswitch
if tempswitch(3)==1
    button2=questdlg('将切换到红外','切换测点？','是','否','否');
    if strcmp(button2,'是')
        tempswitch(3)=0;
        set(handles.tempswitch3_2,'BackgroundColor',[0 1 0]);
        set(handles.tempswitch3_1,'BackgroundColor',[0.941 0.941 0.941]);
    end
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton71.


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global autoswitch autoshaolu test
global daobj  gap_on temp_open pidloop max_burning min_burning 

if autoswitch&&get(handles.checkbox2,'Value') %只有自动换炉 打开，自动烧炉功能才可用
	autoshaolu = 1; 
    set(handles.checkbox2,'ForegroundColor',[1 0 0]);
end
if autoswitch&&~get(handles.checkbox2,'Value') %只有自动换炉 打开，自动烧炉功能才可用
	autoshaolu = 0; 
    set(handles.checkbox2,'ForegroundColor',[0 0 0]);
end
if ~autoswitch
    autoshaolu = 0;
    set(handles.checkbox2,'Value',0) ;
    set(handles.checkbox2,'Enable','off');
    set(handles.checkbox2,'ForegroundColor',[0 0 0]);
end

% --- Executes on button press in pushbutton82.


% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(1)==0
    button2=questdlg('将切换到测点1','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(1)=1;
        set(handles.pushbutton83,'BackgroundColor',[0 1 0]);
        set(handles.pushbutton86,'BackgroundColor',[0.941 0.941 0.941]);
    end
end

% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(2)==1
    button2=questdlg('将切换到测点2','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(2)=0;
        set(handles.pushbutton87,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.pushbutton84,'BackgroundColor',[0 1 0]);
    end
end

% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(3)==0
    button2=questdlg('将切换到测点1','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(3)=1;
        set(handles.pushbutton85,'BackgroundColor',[0 1 0]);
        set(handles.pushbutton88,'BackgroundColor',[0.941 0.941 0.941]);
    end
end

% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(1)==1
    button2=questdlg('将切换到测点2','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(1)=0;
        set(handles.pushbutton83,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.pushbutton86,'BackgroundColor',[0 1 0]);
    end
end

% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(2)==0
    button2=questdlg('将切换到测点1','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(2)=1;
        set(handles.pushbutton87,'BackgroundColor',[0 1 0]);
        set(handles.pushbutton84,'BackgroundColor',[0.941 0.941 0.941]);
    end
end

% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fqtempswitch
if fqtempswitch(3)==1
    button2=questdlg('将切换到测点2','切换测点？','是','否','否');
    if strcmp(button2,'是')
        fqtempswitch(3)=0;
        set(handles.pushbutton88,'BackgroundColor',[0 1 0]);
        set(handles.pushbutton85,'BackgroundColor',[0.941 0.941 0.941]);
    end
end


% --- Executes on slider movement.
function air_slider_Callback(hObject, eventdata, handles)
% hObject    handle to air_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;
set(hObject,'Value',slide_value);
%%这里将滑动条直接设定，改为在原先值上偏移多少
air_pressure=str2double(get(handles.air_press,'String'));
set(handles.air_press,'String',num2str(slide_value+air_pressure));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function air_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in choose_fj1.
function choose_fj1_Callback(hObject, eventdata, handles)
% hObject    handle to choose_fj1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choose_fj
choose_fj = 1;               %风机选择
set(handles.choose_fj1,'BackgroundColor',[0 1 0]);
set(handles.choose_fj2,'BackgroundColor',[0.941 0.941 0.941]);

% --- Executes on button press in choose_fj2.
function choose_fj2_Callback(hObject, eventdata, handles)
% hObject    handle to choose_fj2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global choose_fj
choose_fj = 2;               %风机选择
set(handles.choose_fj2,'BackgroundColor',[0 1 0]);
set(handles.choose_fj1,'BackgroundColor',[0.941 0.941 0.941]);


% --- Executes on slider movement.
function gas_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gas_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;
set(hObject,'Value',slide_value);
set(handles.gas_press,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gas_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global air_pressure_offset air_pressure
air_pressure_offset = air_pressure_offset - 0.5;
% air_pressure = air_pressure + air_pressure_offset;
% set(handles.air_press,'String',air_pressure);
% air_pressure=str2double(get(handles.air_press,'String'));
% set(handles.air_press,'String',num2str(air_pressure-air_pressure_offset));

% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global air_pressure_offset air_pressure
air_pressure_offset = air_pressure_offset + 0.5;
if air_pressure_offset > 11
    air_pressure_offset = 11
end
% air_pressure = air_pressure + air_pressure_offset;
% set(handles.air_press,'String',air_pressure);
% air_pressure=str2double(get(handles.air_press,'String'));
% set(handles.air_press,'String',num2str(air_pressure+air_pressure_offset));


% --- Executes on slider movement.
function flow_slider_Callback(hObject, eventdata, handles)
% hObject    handle to flow_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.flow_buchang,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function flow_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function flow_buchang_Callback(hObject, eventdata, handles)
% hObject    handle to flow_buchang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flow_buchang as text
%        str2double(get(hObject,'String')) returns contents of flow_buchang as a double


% --- Executes during object creation, after setting all properties.
function flow_buchang_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_buchang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function flow_slider2_Callback(hObject, eventdata, handles)
% hObject    handle to flow_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.flow_buchang2,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function flow_slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function flow_buchang2_Callback(hObject, eventdata, handles)
% hObject    handle to flow_buchang2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flow_buchang2 as text
%        str2double(get(hObject,'String')) returns contents of flow_buchang2 as a double


% --- Executes during object creation, after setting all properties.
function flow_buchang2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_buchang2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function flow_slider3_Callback(hObject, eventdata, handles)
% hObject    handle to flow_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.flow_buchang3,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function flow_slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function flow_buchang3_Callback(hObject, eventdata, handles)
% hObject    handle to flow_buchang3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of flow_buchang3 as text
%        str2double(get(hObject,'String')) returns contents of flow_buchang3 as a double


% --- Executes during object creation, after setting all properties.
function flow_buchang3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flow_buchang3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CO_cedian.
function CO_cedian_Callback(hObject, eventdata, handles)
% hObject    handle to CO_cedian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global coswitch
if coswitch ==1
    button2=questdlg('将切换到测点1','切换测点？','是','否','否');
    if strcmp(button2,'是')
        coswitch=0;
        set(handles.CO_cedian,'BackgroundColor',[0 1 0]);
        set(handles.CO_cedian2,'BackgroundColor',[0.941 0.941 0.941]);
    end
end


% --- Executes on button press in CO_cedian2.
function CO_cedian2_Callback(hObject, eventdata, handles)
% hObject    handle to CO_cedian2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global coswitch
if coswitch==0
    button2=questdlg('将切换到测点2','切换测点？','是','否','否');
    if strcmp(button2,'是')
        coswitch=1;
        set(handles.CO_cedian,'BackgroundColor',[0.941 0.941 0.941]);
        set(handles.CO_cedian2,'BackgroundColor',[0 1 0]);
    end
end
