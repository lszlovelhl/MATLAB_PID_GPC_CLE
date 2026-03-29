function varargout = adjust(varargin)
% ADJUST MATLAB code for adjust.fig
%      ADJUST, by itself, creates a new ADJUST or raises the existing
%      singleton*.
%
%      H = ADJUST returns the handle to a new ADJUST or the handle to
%      the existing singleton*
%
%      ADJUST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADJUST.M with the given input arguments.
%
%      ADJUST('Property','Value',...) creates a new ADJUST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before adjust_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to adjust_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help adjust

% Last Modified by GUIDE v2.5 04-Apr-2023 16:59:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @adjust_OpeningFcn, ...
                   'gui_OutputFcn',  @adjust_OutputFcn, ...
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


% --- Executes just before adjust is made visible.
function adjust_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to adjust (see VARARGIN)

% Choose default command line output for adjust
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes adjust wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%global 变量



global  paramdata blj_a1 blj_lmd1 blj_a2  blj_lmd2 tm_p1 tm_i1 tm_d1 douti_p1 douti_i1 douti_d1 fjl_a1 fjl_lmd1 fjl_a2 fjl_lmd2
global toupai_i1 toupai_p1 toupai_d1 zhuansu_mean press_mean period zhuansu_step zhuansu_mid
global ydl_p1 ydl_i1 ydl_d1 ysfjdl gyfpressure_vd gyfpressure_vd2
%% xml读取数据
paramdata = xml_read('param_set.xml');
blj_a1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a1;
blj_lmd1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd1;
blj_a2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a2;
blj_lmd2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd2;

tm_p1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_p1;
tm_i1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_i1;
tm_d1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_d1;

douti_p1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_p1;
douti_i1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_i1;
douti_d1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_d1;

fjl_a1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a1;
fjl_lmd1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd1;
fjl_a2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a2;
fjl_lmd2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd2;

toupai_p1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_p1;
toupai_i1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_i1;
toupai_d1 = paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_d1;

zhuansu_mean = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mean;
press_mean = paramdata.commdata(1).parameter(14).ATTRIBUTE.press_mean;
period = paramdata.commdata(1).parameter(14).ATTRIBUTE.period;
zhuansu_step = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_step;
zhuansu_mid = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mid;
ysfjdl = paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdl;
gyfpressure_vd= paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd;
gyfpressure_vd2= paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd2;

%窑电流
ydl_p1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_p1;
ydl_i1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_i1;
ydl_d1 = paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_d1;
%% 初值设定
%二次风温自寻优
set(handles.zhuansu_mean,'String',zhuansu_mean);
set(handles.zhuansu_mean_slider,'Value',zhuansu_mean);
set(handles.zhuansu_mean_slider,'Max',4,'Min',0);
set(handles.zhuansu_mean_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.zhuansu_mid,'String',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Value',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Max',4,'Min',0);
set(handles.zhuansu_mid_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.text207,'String',gyfpressure_vd);
set(handles.slider97,'Value',gyfpressure_vd);
set(handles.slider97,'Max',18,'Min',10);
set(handles.slider97,'SliderStep',[0.1/8,1/8]);

set(handles.text209,'String',gyfpressure_vd2);
set(handles.slider98,'Value',gyfpressure_vd2);
set(handles.slider98,'Max',19,'Min',11);
set(handles.slider98,'SliderStep',[0.1/8,1/8]);

set(handles.press_mean,'String',press_mean);
set(handles.press_mean_slider,'Value',press_mean);
set(handles.press_mean_slider,'Max',10,'Min',8);
set(handles.press_mean_slider,'SliderStep',[0.05/2,0.1/2]);

set(handles.period,'String',period);
set(handles.period_slider,'Value',period);
set(handles.period_slider,'Max',10000,'Min',0);
set(handles.period_slider,'SliderStep',[100/10000,500/10000]);

% % set(handles.zhuansu_step,'String',zhuansu_step);
% % set(handles.zhuansu_step_slider,'Value',zhuansu_step);
% % set(handles.zhuansu_step_slider,'Max',4,'Min',0);
% % set(handles.zhuansu_step_slider,'SliderStep',[0.05/4,0.1/4]);

%分解炉
set(handles.fjl_alpha1,'String',fjl_a1);
set(handles.fjl_alpha1_slider,'Value',fjl_a1);
set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda1,'String',fjl_lmd1);
set(handles.fjl_lambda1_slider,'Value',fjl_lmd1);
set(handles.fjl_lambda1_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda1_slider,'SliderStep',[5/5000,10/5000]);

set(handles.fjl_alpha2,'String',fjl_a2);
set(handles.fjl_alpha2_slider,'Value',fjl_a2);
set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda2,'String',fjl_lmd2);
set(handles.fjl_lambda2_slider,'Value',fjl_lmd2);
set(handles.fjl_lambda2_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda2_slider,'SliderStep',[5/5000,10/5000]);

%篦冷机回路
formatSpec = '%5.4f';
set(handles.blj_a1,'String',num2str(blj_a1,formatSpec));
set(handles.blj_a1_slider,'Value',blj_a1);
set(handles.blj_a1_slider,'Max',0.1,'Min',0);
set(handles.blj_a1_slider,'SliderStep',[0.0002/0.1,0.0005/0.1]);

set(handles.blj_lmd1,'String',blj_lmd1);
set(handles.blj_lmd1_slider,'Value',blj_lmd1);
set(handles.blj_lmd1_slider,'Max',300,'Min',0);
set(handles.blj_lmd1_slider,'SliderStep',[1/300,2/300]);



formatSpec = '%5.4f';
set(handles.blj_a2,'String',num2str(blj_a2,formatSpec));
set(handles.blj_a2_slider,'Value',blj_a2);
set(handles.blj_a2_slider,'Max',0.1,'Min',0);
set(handles.blj_a2_slider,'SliderStep',[0.0002/0.1,0.0005/0.1]);

set(handles.blj_lmd2,'String',blj_lmd2);
set(handles.blj_lmd2_slider,'Value',blj_lmd2);
set(handles.blj_lmd2_slider,'Max',300,'Min',0);
set(handles.blj_lmd2_slider,'SliderStep',[1/300,2/300]);


%头煤压力
set(handles.toumei_p,'String',tm_p1);
set(handles.toumei_p_slider,'Value',tm_p1);
set(handles.toumei_p_slider,'Max',1,'Min',0);
set(handles.toumei_p_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.toumei_i,'String',tm_i1);
set(handles.toumei_i_slider,'Value',tm_i1);
set(handles.toumei_i_slider,'Max',200,'Min',0);
set(handles.toumei_i_slider,'SliderStep',[1/200,5/200]);

set(handles.toumei_d,'String',tm_d1);
set(handles.toumei_d_slider,'Value',tm_d1);
set(handles.toumei_d_slider,'Max',1,'Min',0);
set(handles.toumei_d_slider,'SliderStep',[0.01/1,0.05/1]);



%斗提电流控制回路
formatSpec = '%4.3f';
set(handles.douti_p1,'String',num2str(douti_p1,formatSpec));
set(handles.douti_p1_slider,'Value',douti_p1);
set(handles.douti_p1_slider,'Max',20,'Min',0);
set(handles.douti_p1_slider,'SliderStep',[0.01/20,1/20]);

set(handles.douti_i1,'String',douti_i1);
set(handles.douti_i1_slider,'Value',douti_i1);
set(handles.douti_i1_slider,'Max',200,'Min',0);
set(handles.douti_i1_slider,'SliderStep',[1/200,5/200]);

formatSpec = '%4.3f';
set(handles.douti_d1,'String',num2str(douti_d1,formatSpec));
set(handles.douti_d1_slider,'Value',douti_d1);
set(handles.douti_d1_slider,'Max',1,'Min',0);
set(handles.douti_d1_slider,'SliderStep',[0.01/1,0.05/1]);

%头排风机
set(handles.toupai_p1,'String',toupai_p1);
set(handles.toupai_p1_slider,'Value',toupai_p1);
set(handles.toupai_p1_slider,'Max',1,'Min',0);
set(handles.toupai_p1_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.toupai_i1,'String',toupai_i1);
set(handles.toupai_i1_slider,'Value',toupai_i1);
set(handles.toupai_i1_slider,'Max',200,'Min',0);
set(handles.toupai_i1_slider,'SliderStep',[1/200,5/200]);

set(handles.toupai_d1,'String',toupai_d1);
set(handles.toupai_d1_slider,'Value',toupai_d1);
set(handles.toupai_d1_slider,'Max',1,'Min',0);
set(handles.toupai_d1_slider,'SliderStep',[0.01/1,0.05/1]);

%窑电流
set(handles.text203,'String',ydl_p1);
set(handles.slider93,'Value',ydl_p1);
set(handles.slider93,'Max',0.01,'Min',0);
set(handles.slider93,'SliderStep',[0.0001/0.01,0.0005/0.01]);

set(handles.text204,'String',ydl_i1);
set(handles.slider94,'Value',ydl_i1);
set(handles.slider94,'Max',200,'Min',0);
set(handles.slider94,'SliderStep',[1/200,5/200]);

set(handles.text205,'String',ydl_d1);
set(handles.slider95,'Value',tm_d1);
set(handles.slider95,'Max',1,'Min',0);
set(handles.slider95,'SliderStep',[0.01/1,0.05/1]);

newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
% --- Outputs from this function are returned to the command line.
function varargout = adjust_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata  toupai_p1 toupai_i1 toupai_d1 zhuansu_mean press_mean period zhuansu_step zhuansu_mid
global blj_a1 blj_lmd1 blj_a2  blj_lmd2 tm_p1 tm_i1 tm_d1 douti_p1 douti_i1 douti_d1 fjl_a1 fjl_lmd1 fjl_a2 fjl_lmd2
global ydl_p1 ydl_i1 ydl_d1 ysfjdl gyfpressure_vd gyfpressure_vd2
% paramdata = xml_read('param_set.xml');
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a1 = blj_a1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd1 = blj_lmd1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a2 = blj_a2;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd2 = blj_lmd2;

paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_p1 = tm_p1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_i1 = tm_i1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_d1 = tm_d1;

paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_p1 = douti_p1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_i1 = douti_i1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_d1 = douti_d1;

paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a1 = fjl_a1;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd1 = fjl_lmd1;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a2 = fjl_a2;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd2 = fjl_lmd2;

paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_p1 = toupai_p1;
paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_i1 = toupai_i1;
paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_d1 = toupai_d1;
   
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mean = zhuansu_mean;
paramdata.commdata(1).parameter(14).ATTRIBUTE.press_mean = press_mean;
paramdata.commdata(1).parameter(14).ATTRIBUTE.period = period;
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_step = zhuansu_step;
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mid = zhuansu_mid;
paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdl = ysfjdl;
paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd = gyfpressure_vd;
paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd2 = gyfpressure_vd2;

paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_p1 = ydl_p1;
paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_i1 = ydl_i1;
paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_d1 = ydl_d1;
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
delete(handles.figure1);

% --- Executes on button press in set_default.
function set_default_Callback(hObject, eventdata, handles)
% hObject    handle to set_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma zhuansu_mean press_mean period zhuansu_step
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1 toupai_p1 toupai_i1 toupai_d1 zhuansu_mid
global blj_a1 blj_lmd1 blj_a2  blj_lmd2 tm_p1 tm_i1 tm_d1 douti_p1 douti_i1 douti_d1 fjl_a1 fjl_lmd1 fjl_a2 fjl_lmd2
global ydl_p1 ydl_i1 ydl_d1 ysfjdl gyfpressure_vd gyfpressure_vd2

button2=questdlg('确定恢复默认值？','恢复默认值','Yes','No','Yes');
    
    
if strcmp(button2,'Yes')

paramdata = xml_read('param_set.xml');

blj_a1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.blj_a1;
blj_lmd1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.blj_lmd1;
blj_a2 = paramdata.commdata(1).parameter(8).ATTRIBUTE.blj_a2;
blj_lmd2 = paramdata.commdata(1).parameter(8).ATTRIBUTE.blj_lmd2;

tm_p1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.tm_p1;
tm_i1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.tm_i1;
tm_d1 = paramdata.commdata(1).parameter(9).ATTRIBUTE.tm_d1;

douti_p1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.douti_p1;
douti_i1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.douti_i1;
douti_d1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.douti_d1;

fjl_a1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_a1;
fjl_lmd1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_lmd1;
fjl_a2 = paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_a2;
fjl_lmd2 = paramdata.commdata(1).parameter(11).ATTRIBUTE.fjl_lmd2;

toupai_p1 = paramdata.commdata(1).parameter(13).ATTRIBUTE.toupai_p1;
toupai_i1 = paramdata.commdata(1).parameter(13).ATTRIBUTE.toupai_i1;
toupai_d1 = paramdata.commdata(1).parameter(13).ATTRIBUTE.toupai_d1;

zhuansu_mean = paramdata.commdata(1).parameter(15).ATTRIBUTE.zhuansu_mean;
press_mean = paramdata.commdata(1).parameter(15).ATTRIBUTE.press_mean;
period = paramdata.commdata(1).parameter(15).ATTRIBUTE.period;
zhuansu_step = paramdata.commdata(1).parameter(15).ATTRIBUTE.zhuansu_step;
zhuansu_mid = paramdata.commdata(1).parameter(15).ATTRIBUTE.zhuansu_mid;
ysfjdl = paramdata.commdata(1).parameter(4).ATTRIBUTE.ysfjdl;
gyfpressure_vd= paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd;
gyfpressure_vd2= paramdata.commdata(1).parameter(4).ATTRIBUTE.gyfpressure_vd2;

ydl_p1 = paramdata.commdata(1).parameter(17).ATTRIBUTE.ydl_p1;
ydl_i1 = paramdata.commdata(1).parameter(17).ATTRIBUTE.ydl_i1;
ydl_d1 = paramdata.commdata(1).parameter(17).ATTRIBUTE.ydl_d1;

    %保存到xml
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a1 = blj_a1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd1 = blj_lmd1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_a2 = blj_a2;
paramdata.commdata(1).parameter(4).ATTRIBUTE.blj_lmd2 = blj_lmd2;

paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_p1 = tm_p1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_i1 = tm_i1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_d1 = tm_d1;

paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_p1 = douti_p1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_i1 = douti_i1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.douti_d1 = douti_d1;

paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a1 = fjl_a1;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd1 = fjl_lmd1;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_a2 = fjl_a2;
paramdata.commdata(1).parameter(7).ATTRIBUTE.fjl_lmd2 = fjl_lmd2;

paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_p1 = toupai_p1;
paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_i1 = toupai_i1;
paramdata.commdata(1).parameter(12).ATTRIBUTE.toupai_d1 = toupai_d1;

paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mean = zhuansu_mean;
paramdata.commdata(1).parameter(14).ATTRIBUTE.press_mean = press_mean;
paramdata.commdata(1).parameter(14).ATTRIBUTE.period = period;
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_step = zhuansu_step;
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_mid = zhuansu_mid;

paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_p1 = ydl_p1;
paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_i1 = ydl_i1;
paramdata.commdata(1).parameter(16).ATTRIBUTE.ydl_d1 = ydl_d1;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
%     set(handles.save_state,'String','已恢复默认值');

%显示初始值
%二次风温自寻优
set(handles.zhuansu_mean,'String',zhuansu_mean);
set(handles.zhuansu_mean_slider,'Value',zhuansu_mean);
set(handles.zhuansu_mean_slider,'Max',4,'Min',0);
set(handles.zhuansu_mean_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.text207,'String',gyfpressure_vd);
set(handles.slider97,'Value',gyfpressure_vd);
set(handles.slider97,'Max',10,'Min',18);
set(handles.slider97,'SliderStep',[0.1/8,1/8]);

set(handles.text209,'String',gyfpressure_vd2);
set(handles.slider98,'Value',gyfpressure_vd2);
set(handles.slider98,'Max',11,'Min',19);
set(handles.slider98,'SliderStep',[0.1/8,1/8]);

set(handles.zhuansu_mid,'String',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Value',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Max',4,'Min',0);
set(handles.zhuansu_mid_slider,'SliderStep',[0.05/4,0.1/4]);

set(handles.press_mean,'String',press_mean);
set(handles.press_mean_slider,'Value',press_mean);
set(handles.press_mean_slider,'Max',10,'Min',8);
set(handles.press_mean_slider,'SliderStep',[0.05/2,0.1/2]);

set(handles.period,'String',period);
set(handles.period_slider,'Value',period);
set(handles.period_slider,'Max',10000,'Min',0);
set(handles.period_slider,'SliderStep',[100/10000,500/10000]);

set(handles.zhuansu_step,'String',zhuansu_step);
set(handles.zhuansu_step_slider,'Value',zhuansu_step);
set(handles.zhuansu_step_slider,'Max',4,'Min',0);
set(handles.zhuansu_step_slider,'SliderStep',[0.05/4,0.1/4]);

%分解炉
set(handles.fjl_alpha1,'String',fjl_a1);
set(handles.fjl_alpha1_slider,'Value',fjl_a1);
set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda1,'String',fjl_lmd1);
set(handles.fjl_lambda1_slider,'Value',fjl_lmd1);
set(handles.fjl_lambda1_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda1_slider,'SliderStep',[5/5000,10/5000]);

set(handles.fjl_alpha2,'String',fjl_a2);
set(handles.fjl_alpha2_slider,'Value',fjl_a2);
set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda2,'String',fjl_lmd2);
set(handles.fjl_lambda2_slider,'Value',fjl_lmd2);
set(handles.fjl_lambda2_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda2_slider,'SliderStep',[5/5000,10/5000]);

%篦冷机回路
formatSpec = '%5.4f';
set(handles.blj_a1,'String',num2str(blj_a1,formatSpec));
set(handles.blj_a1_slider,'Value',blj_a1);
set(handles.blj_a1_slider,'Max',1,'Min',0.9);
set(handles.blj_a1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.blj_lmd1,'String',blj_lmd1);
set(handles.blj_lmd1_slider,'Value',blj_lmd1);
set(handles.blj_lmd1_slider,'Max',5000,'Min',0);
set(handles.blj_lmd1_slider,'SliderStep',[10/5000,20/5000]);



formatSpec = '%5.4f';
set(handles.blj_a2,'String',num2str(blj_a2,formatSpec));
set(handles.blj_a2_slider,'Value',blj_a2);
set(handles.blj_a2_slider,'Max',1,'Min',0.9);
set(handles.blj_a2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.blj_lmd2,'String',blj_lmd2);
set(handles.blj_lmd2_slider,'Value',blj_lmd2);
set(handles.blj_lmd2_slider,'Max',5000,'Min',0);
set(handles.blj_lmd2_slider,'SliderStep',[10/5000,20/5000]);


%头煤压力
set(handles.toumei_p,'String',tm_p1);
set(handles.toumei_p_slider,'Value',tm_p1);
set(handles.toumei_p_slider,'Max',1,'Min',0);
set(handles.toumei_p_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.toumei_i,'String',tm_i1);
set(handles.toumei_i_slider,'Value',tm_i1);
set(handles.toumei_i_slider,'Max',200,'Min',0);
set(handles.toumei_i_slider,'SliderStep',[1/200,5/200]);

set(handles.toumei_d,'String',tm_d1);
set(handles.toumei_d_slider,'Value',tm_d1);
set(handles.toumei_d_slider,'Max',1,'Min',0);
set(handles.toumei_d_slider,'SliderStep',[0.01/1,0.05/1]);



%斗提电流控制回路
formatSpec = '%4.3f';
set(handles.douti_p1,'String',num2str(douti_p1,formatSpec));
set(handles.douti_p1_slider,'Value',douti_p1);
set(handles.douti_p1_slider,'Max',20,'Min',0);
set(handles.douti_p1_slider,'SliderStep',[0.01/20,1/20]);

set(handles.douti_i1,'String',douti_i1);
set(handles.douti_i1_slider,'Value',douti_i1);
set(handles.douti_i1_slider,'Max',200,'Min',0);
set(handles.douti_i1_slider,'SliderStep',[1/200,5/200]);

formatSpec = '%4.3f';
set(handles.douti_d1,'String',num2str(douti_d1,formatSpec));
set(handles.douti_d1_slider,'Value',douti_d1);
set(handles.douti_d1_slider,'Max',1,'Min',0);
set(handles.douti_d1_slider,'SliderStep',[0.01/1,0.05/1]);

%头排风机
set(handles.toupai_p1,'String',toupai_p1);
set(handles.toupai_p1_slider,'Value',toupai_p1);
set(handles.toupai_p1_slider,'Max',1,'Min',0);
set(handles.toupai_p1_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.toupai_i1,'String',toupai_i1);
set(handles.toupai_i1_slider,'Value',toupai_i1);
set(handles.toupai_i1_slider,'Max',200,'Min',0);
set(handles.toupai_i1_slider,'SliderStep',[1/200,5/200]);

set(handles.toupai_d1,'String',toupai_d1);
set(handles.toupai_d1_slider,'Value',toupai_d1);
set(handles.toupai_d1_slider,'Max',1,'Min',0);
set(handles.toupai_d1_slider,'SliderStep',[0.01/1,0.05/1]);

%窑电流
set(handles.text203,'String',ydl_p1);
set(handles.slider93,'Value',ydl_p1);
set(handles.slider93,'Max',0.1,'Min',0);
set(handles.slider93,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.text204,'String',ydl_i1);
set(handles.slider94,'Value',ydl_i1);
set(handles.slider94,'Max',200,'Min',0);
set(handles.slider94,'SliderStep',[1/200,5/200]);

set(handles.text205,'String',ydl_d1);
set(handles.slider95,'Value',tm_d1);
set(handles.slider95,'Max',1,'Min',0);
set(handles.slider95,'SliderStep',[0.01/1,0.05/1]);
end

% --- Executes on slider movement.
function toumei_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tm_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toumei_p,'String',num2str(a,formatSpec));
tm_p1=str2double(get(handles.toumei_p,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tm_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.toumei_i,'String',num2str(a,formatSpec));
tm_i1=str2double(get(handles.toumei_i,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global tm_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toumei_d,'String',num2str(a,formatSpec));
tm_d1=str2double(get(handles.toumei_d,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_alpha1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_a1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.fjl_alpha1,'String',num2str(a,formatSpec));
fjl_a1=str2double(get(handles.fjl_alpha1,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_alpha1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_lambda1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_lambda1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_lmd1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.fjl_lambda1,'String',num2str(a,formatSpec));
fjl_lmd1=str2double(get(handles.fjl_lambda1,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_lambda1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_lambda1_slider (see GCBO)
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
function fjl_alpha2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_a2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.fjl_alpha2,'String',num2str(a,formatSpec));
fjl_a2=str2double(get(handles.fjl_alpha2,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_alpha2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_lambda2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_lambda2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_lmd2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.fjl_lambda2,'String',num2str(a,formatSpec));
fjl_lmd2=str2double(get(handles.fjl_lambda2,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_lambda2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_lambda2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_a1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_a1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_a1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.blj_a1,'String',num2str(a,formatSpec));
blj_a1=str2double(get(handles.blj_a1,'String'));

% --- Executes during object creation, after setting all properties.
function blj_a1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_a1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_lmd1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_lmd1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_lmd1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.blj_lmd1,'String',num2str(a,formatSpec));
blj_lmd1=str2double(get(handles.blj_lmd1,'String'));

% --- Executes during object creation, after setting all properties.
function blj_lmd1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_lmd1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdwai_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdwai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pdwai_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.pdwai_d1,'String',num2str(a,formatSpec));
pdwai_gamma1=str2double(get(handles.pdwai_d1,'String'));

% --- Executes during object creation, after setting all properties.
function pdwai_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdwai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_a2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_a2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_a2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.blj_a2,'String',num2str(a,formatSpec));
blj_a2=str2double(get(handles.blj_a2,'String'));

% --- Executes during object creation, after setting all properties.
function blj_a2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_a2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_lmd2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_lmd2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_lmd2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.blj_lmd2,'String',num2str(a,formatSpec));
blj_lmd2=str2double(get(handles.blj_lmd2,'String'));

% --- Executes during object creation, after setting all properties.
function blj_lmd2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_lmd2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdwai_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdwai_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdwai_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdwai_d2,'String',num2str(a,formatSpec));
pdwai_gamma2=str2double(get(handles.pdwai_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdwai_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdwai_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_alpha3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p3,'String',num2str(a,formatSpec));
temp_blj_alpha3=str2double(get(handles.blj_p3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_p3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_beta3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i3,'String',num2str(a,formatSpec));
temp_blj_beta3=str2double(get(handles.blj_i3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_i3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_d3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_gamma3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d3,'String',num2str(a,formatSpec));
temp_blj_gamma3=str2double(get(handles.blj_d3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_d3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.douti_p1,'String',num2str(a,formatSpec));
douti_p1=str2double(get(handles.douti_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.douti_i1,'String',num2str(a,formatSpec));
douti_i1=str2double(get(handles.douti_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.douti_d1,'String',num2str(a,formatSpec));
douti_d1=str2double(get(handles.douti_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.gwfj_p,'String',num2str(a,formatSpec));
gwfj_alpha=str2double(get(handles.gwfj_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.gwfj_i,'String',num2str(a,formatSpec));
gwfj_beta=str2double(get(handles.gwfj_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.gwfj_d,'String',num2str(a,formatSpec));
gwfj_gamma=str2double(get(handles.gwfj_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider40_Callback(hObject, eventdata, handles)
% hObject    handle to slider40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


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


% --- Executes on slider movement.
function slider43_Callback(hObject, eventdata, handles)
% hObject    handle to slider43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider43 (see GCBO)
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
function slider45_Callback(hObject, eventdata, handles)
% hObject    handle to slider45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p1,'String',num2str(a,formatSpec));
temp_blj_alpha1=str2double(get(handles.blj_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i1,'String',num2str(a,formatSpec));
temp_blj_beta1=str2double(get(handles.blj_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d1,'String',num2str(a,formatSpec));
temp_blj_gamma1=str2double(get(handles.blj_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p2,'String',num2str(a,formatSpec));
temp_blj_alpha2=str2double(get(handles.blj_p2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i2,'String',num2str(a,formatSpec));
temp_blj_beta2=str2double(get(handles.blj_i2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function set_default_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function save_state_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function blj_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d2,'String',num2str(a,formatSpec));
temp_blj_gamma2=str2double(get(handles.blj_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_p1,'String',num2str(a,formatSpec));
pdnei_alpha1=str2double(get(handles.pdnei_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.pdnei_i1,'String',num2str(a,formatSpec));
pdnei_beta1=str2double(get(handles.pdnei_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.pdnei_d1,'String',num2str(a,formatSpec));
pdnei_gamma1=str2double(get(handles.pdnei_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_p2,'String',num2str(a,formatSpec));
pdnei_alpha2=str2double(get(handles.pdnei_p2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.pdnei_i2,'String',num2str(a,formatSpec));
pdnei_beta2=str2double(get(handles.pdnei_i2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_d2,'String',num2str(a,formatSpec));
pdnei_gamma2=str2double(get(handles.pdnei_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toupai_p1,'String',num2str(a,formatSpec));
toupai_p1=str2double(get(handles.toupai_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.toupai_i1,'String',num2str(a,formatSpec));
toupai_i1=str2double(get(handles.toupai_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toupai_d1,'String',num2str(a,formatSpec));
toupai_d1=str2double(get(handles.toupai_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zhuansu_mean_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_mean
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.zhuansu_mean,'String',num2str(a,formatSpec));
zhuansu_mean=str2double(get(handles.zhuansu_mean,'String'));


% --- Executes during object creation, after setting all properties.
function zhuansu_mean_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function press_mean_slider_Callback(hObject, eventdata, handles)
% hObject    handle to press_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global press_mean
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.press_mean,'String',num2str(a,formatSpec));
press_mean=str2double(get(handles.press_mean,'String'));

% --- Executes during object creation, after setting all properties.
function press_mean_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to press_mean_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function period_slider_Callback(hObject, eventdata, handles)
% hObject    handle to period_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global period
a=get(hObject,'Value');%获取滑块当前值
% formatSpec = '%3.2f';
set(handles.period,'String',num2str(a));
period=str2double(get(handles.period,'String'));

% --- Executes during object creation, after setting all properties.
function period_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to period_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zhuansu_step_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_step_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_step
a=get(hObject,'Value');%获取滑块当前值
% formatSpec = '%3.2f';
set(handles.zhuansu_step,'String',num2str(a));
zhuansu_step=str2double(get(handles.zhuansu_step,'String'));

% --- Executes during object creation, after setting all properties.
function zhuansu_step_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_step_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function zhuansu_mid_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_mid_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_mid
a=get(hObject,'Value');%获取滑块当前值
% formatSpec = '%3.2f';
set(handles.zhuansu_mid,'String',num2str(a));
zhuansu_mid=str2double(get(handles.zhuansu_mid,'String'));

% --- Executes during object creation, after setting all properties.
function zhuansu_mid_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_mid_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider95_Callback(hObject, eventdata, handles)
% hObject    handle to slider95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ydl_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.3f';
set(handles.text205,'String',num2str(a,formatSpec));
ydl_d1=str2double(get(handles.text205,'String'));

% --- Executes during object creation, after setting all properties.
function slider95_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider94_Callback(hObject, eventdata, handles)
% hObject    handle to slider94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ydl_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.text204,'String',num2str(a,formatSpec));
ydl_i1=str2double(get(handles.text204,'String'));

% --- Executes during object creation, after setting all properties.
function slider94_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider93_Callback(hObject, eventdata, handles)
% hObject    handle to slider93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ydl_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.text203,'String',num2str(a,formatSpec));
ydl_p1=str2double(get(handles.text203,'String'));

% --- Executes during object creation, after setting all properties.
function slider93_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider96_Callback(hObject, eventdata, handles)
% hObject    handle to slider96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider96_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider97_Callback(hObject, eventdata, handles)
% hObject    handle to slider97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gyfpressure_vd
a=get(hObject,'Value');%获取滑块当前值
% formatSpec = '%3.2f';
set(handles.text207,'String',num2str(a,'%.1f'));
gyfpressure_vd=str2double(get(handles.text207,'String'));

% --- Executes during object creation, after setting all properties.
function slider97_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider98_Callback(hObject, eventdata, handles)
% hObject    handle to slider98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gyfpressure_vd2
a=get(hObject,'Value');%获取滑块当前值
% formatSpec = '%3.2f';
set(handles.text209,'String',num2str(a,'%.1f'));
gyfpressure_vd2=str2double(get(handles.text209,'String'));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider98_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
