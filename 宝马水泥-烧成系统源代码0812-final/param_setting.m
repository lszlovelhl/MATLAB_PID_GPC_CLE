function varargout = param_setting(varargin)
% PARAM_SETTING MATLAB code for param_setting.fig
%      PARAM_SETTING, by itself, creates a new PARAM_SETTING or raises the existing
%      singleton*.
%
%      H = PARAM_SETTING returns the handle to a new PARAM_SETTING or the handle to
%      the existing singleton*.
%
%      PARAM_SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAM_SETTING.M with the given input arguments.
%
%      PARAM_SETTING('Property','Value',...) creates a new PARAM_SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before param_setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to param_setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help param_setting

% Last Modified by GUIDE v2.5 25-Jun-2022 09:34:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @param_setting_OpeningFcn, ...
                   'gui_OutputFcn',  @param_setting_OutputFcn, ...
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


% --- Executes just before param_setting is made visible.
function param_setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to param_setting (see VARARGIN)

% Choose default command line output for param_setting
global blj_freqMAX blj_freqMIN yaotou_coalMAX yaotou_coalMIN yaowei_coalMAX yaowei_coalMIN NH3_MAX NH3_MIN junhua_MAX junhua_MIN  gaowenfengji_MAX gaowenfengji_MIN
global gaowenfengji_compensate gaowenfengji_rati yachuang_mv pressure_vd zhuansu_mid slqkxs scfqkxs ysphfjdl
global ecfw_sp
%%初值设定
set(handles.yaowei_coalMAX,'String',yaowei_coalMAX);
set(handles.yaowei_coalMAX_slider,'Value',yaowei_coalMAX);
set(handles.yaowei_coalMAX_slider,'Max',13,'Min',6);
set(handles.yaowei_coalMAX_slider,'SliderStep',[0.1/7,0.5/7]);


set(handles.yaowei_coalMIN,'String',yaowei_coalMIN);
set(handles.yaowei_coalMIN_slider,'Value',yaowei_coalMIN);
set(handles.yaowei_coalMIN_slider,'Max',10,'Min',4);
set(handles.yaowei_coalMIN_slider,'SliderStep',[0.1/6,0.5/6]);


set(handles.yaotou_coalMAX,'String',yaotou_coalMAX);
set(handles.yaotou_coalMAX_slider,'Value',yaotou_coalMAX);
set(handles.yaotou_coalMAX_slider,'Max',12,'Min',6);
set(handles.yaotou_coalMAX_slider,'SliderStep',[0.1/6,0.5/6]);

set(handles.yaotou_coalMIN,'String',yaotou_coalMIN);
set(handles.yaotou_coalMIN_slider,'Value',yaotou_coalMIN);
set(handles.yaotou_coalMIN_slider,'Max',10,'Min',4);
set(handles.yaotou_coalMIN_slider,'SliderStep',[0.1/6,0.5/6]);

set(handles.blj_freqMAX,'String',blj_freqMAX);
set(handles.blj_freqMAX_slider,'Value',blj_freqMAX);
set(handles.blj_freqMAX_slider,'Max',40,'Min',20);
set(handles.blj_freqMAX_slider,'SliderStep',[0.1/20,0.5/20]);

set(handles.blj_freqMIN,'String',blj_freqMIN);
set(handles.blj_freqMIN_slider,'Value',blj_freqMIN);
set(handles.blj_freqMIN_slider,'Max',27,'Min',17);
set(handles.blj_freqMIN_slider,'SliderStep',[0.1/10,0.5/10]);

set(handles.NH3_MAX,'String',NH3_MAX);
set(handles.NH3_MAX_Slider,'Value',NH3_MAX);
set(handles.NH3_MAX_Slider,'Max',100,'Min',20);
set(handles.NH3_MAX_Slider,'SliderStep',[1/80,5/80]);

set(handles.NH3_MIN,'String',NH3_MIN);
set(handles.NH3_MIN_Slider,'Value',NH3_MIN);
set(handles.NH3_MIN_Slider,'Max',60,'Min',0);
set(handles.NH3_MIN_Slider,'SliderStep',[1/60,5/60]);

set(handles.junhuaku_MAX,'String',junhua_MAX);
set(handles.junhuaku_MAX_slider,'Value',junhua_MAX);
set(handles.junhuaku_MAX_slider,'Max',80,'Min',30);
set(handles.junhuaku_MAX_slider,'SliderStep',[1/50,5/50]);

set(handles.junhuaku_MIN,'String',junhua_MIN);
set(handles.junhuaku_MIN_slider,'Value',junhua_MIN);
set(handles.junhuaku_MIN_slider,'Max',60,'Min',10);
set(handles.junhuaku_MIN_slider,'SliderStep',[1/50,5/50]);

set(handles.gaowenfengji_MAX,'String',gaowenfengji_MAX);
set(handles.gaowenfengji_MAX_slider,'Value',gaowenfengji_MAX);
set(handles.gaowenfengji_MAX_slider,'Max',60,'Min',30);
set(handles.gaowenfengji_MAX_slider,'SliderStep',[0.1/30,1/30]);

set(handles.gaowenfengji_MIN,'String',gaowenfengji_MIN);
set(handles.gaowenfengji_MIN_slider,'Value',gaowenfengji_MIN);
set(handles.gaowenfengji_MIN_slider,'Max',60,'Min',30);
set(handles.gaowenfengji_MIN_slider,'SliderStep',[0.1/30,1/30]);

set(handles.gaowenfengji_compensate,'String',gaowenfengji_compensate);
set(handles.gaowenfengji_compensate_slider,'Value',gaowenfengji_compensate);
set(handles.gaowenfengji_compensate_slider,'Max',2,'Min',0);
set(handles.gaowenfengji_compensate_slider,'SliderStep',[0.1/2,0.5/2]);

set(handles.gaowenfengji_rati,'String',gaowenfengji_rati);
set(handles.gaowenfengji_rati_slider,'Value',gaowenfengji_rati);
set(handles.gaowenfengji_rati_slider,'Max',10,'Min',0);
set(handles.gaowenfengji_rati_slider,'SliderStep',[0.1/10,1/10]);


%篦速变化速度
set(handles.text32,'String',yachuang_mv);
set(handles.slider18,'Value',yachuang_mv);
set(handles.slider18,'Max',2,'Min',0);
set(handles.slider18,'SliderStep',[0.05/2,0.1/2]);

%为篦床压力上限
set(handles.text34,'String',pressure_vd);
set(handles.slider16,'Value',pressure_vd);
set(handles.slider16,'Max',10,'Min',5);
set(handles.slider16,'SliderStep',[0.1/5,0.5/5]);

%一室平衡风机电流下限
set(handles.text45,'String',ysphfjdl);
set(handles.slider22,'Value',ysphfjdl);
set(handles.slider22,'Max',69,'Min',61);
set(handles.slider22,'SliderStep',[1/8,2/8]);

%中场转速
set(handles.text36,'String',zhuansu_mid);
set(handles.slider17,'Value',zhuansu_mid);
set(handles.slider17,'Max',35,'Min',10);
set(handles.slider17,'SliderStep',[1/25,2/25]);

%二次风温度期望值
set(handles.text42,'String',ecfw_sp);
set(handles.slider21,'Value',ecfw_sp);
set(handles.slider21,'Max',1300,'Min',1150);
set(handles.slider21,'SliderStep',[1/150,10/150]);


%生料前馈系数
set(handles.text38,'String',slqkxs);
set(handles.slider19,'Value',slqkxs);
set(handles.slider19,'Max',1,'Min',0);
set(handles.slider19,'SliderStep',[0.001/1,0.01/1]);

%三次风前馈系数
set(handles.text40,'String',scfqkxs);
set(handles.slider19,'Value',scfqkxs);
set(handles.slider19,'Max',1,'Min',0);
set(handles.slider19,'SliderStep',[0.001/1,0.05/1]);

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

% UIWAIT makes param_setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = param_setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function blj_freqMAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_freqMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.blj_freqMAX,'String',num2str(slide_value));
% blj_freqMAX=str2double(get(handles.blj_freqMAX,'String'));

% --- Executes during object creation, after setting all properties.
function blj_freqMAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_freqMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_freqMIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_freqMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.blj_freqMIN,'String',num2str(slide_value));
% blj_freqMIN=str2double(get(handles.blj_freqMIN,'String'));

% --- Executes during object creation, after setting all properties.
function blj_freqMIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_freqMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaowei_coalMAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaowei_coalMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaowei_coalMAX,'String',num2str(slide_value));
% yaowei_coalMAX=str2double(get(handles.yaowei_coalMAX,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaowei_coalMIN,'String',num2str(slide_value));
% yaowei_coalMIN=str2double(get(handles.yaowei_coalMIN,'String'));

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
function yaotou_coalMAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_coalMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaotou_coalMAX,'String',num2str(slide_value));
% yaotou_coalMAX=str2double(get(handles.yaotou_coalMAX,'String'));

% --- Executes during object creation, after setting all properties.
function yaotou_coalMAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_coalMAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaotou_coalMIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_coalMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.yaotou_coalMIN,'String',num2str(slide_value));
% yaotou_coalMIN=str2double(get(handles.yaotou_coalMIN,'String'));

% --- Executes during object creation, after setting all properties.
function yaotou_coalMIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_coalMIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_MAX_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_MAX_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.NH3_MAX,'String',num2str(slide_value));
% NH3_MAX=str2double(get(handles.NH3_MAX,'String'));


% --- Executes during object creation, after setting all properties.
function NH3_MAX_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_MAX_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_MIN_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_MIN_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.NH3_MIN,'String',num2str(slide_value));
% NH3_MIN=str2double(get(handles.NH3_MIN,'String'));


% --- Executes during object creation, after setting all properties.
function NH3_MIN_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_MIN_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata blj_freqMAX blj_freqMIN yaotou_coalMAX yaotou_coalMIN yaowei_coalMAX yaowei_coalMIN 
global NH3_MAX NH3_MIN junhua_MAX junhua_MIN gaowenfengji_MAX gaowenfengji_MIN gaowenfengji_compensate gaowenfengji_rati
global  yachuang_mv pressure_vd zhuansu_mid slqkxs scfqkxs ecfw_sp ysphfjdl
% yaotou
paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.yaotou_coalMAX,'String'));
paramdata.alarms(1).yaotou(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.yaotou_coalMIN,'String'));
yaotou_coalMAX = str2double(get(handles.yaotou_coalMAX,'String'));
yaotou_coalMIN = str2double(get(handles.yaotou_coalMIN,'String'));
% yaowei
paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.yaowei_coalMAX,'String'));
paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.yaowei_coalMIN,'String'));
paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.slqkxs = str2double(get(handles.text38,'String'));
paramdata.alarms(1).yaowei(1).parameter(1).ATTRIBUTE.scfqkxs = str2double(get(handles.text40,'String'));
yaowei_coalMAX = str2double(get(handles.yaowei_coalMAX,'String'));
yaowei_coalMIN = str2double(get(handles.yaowei_coalMIN,'String'));
slqkxs = str2double(get(handles.text38,'String'));
scfqkxs = str2double(get(handles.text40,'String'));
% bilengji
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.blj_freqMAX,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.blj_freqMIN,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.pressure_vd = str2double(get(handles.text34,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ysphfjdl = str2double(get(handles.text45,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.yachuang_mv = str2double(get(handles.text32,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.zhuansu_mid = str2double(get(handles.text36,'String'));
paramdata.alarms(1).bilengji(1).parameter(1).ATTRIBUTE.ecfwsp = str2double(get(handles.text42,'String'));
blj_freqMAX = str2double(get(handles.blj_freqMAX,'String'));
blj_freqMIN = str2double(get(handles.blj_freqMIN,'String'));
pressure_vd = str2double(get(handles.text34,'String'));
ysphfjdl = str2double(get(handles.text45,'String'));
yachuang_mv = str2double(get(handles.text32,'String'));
zhuansu_mid = str2double(get(handles.text36,'String'));
ecfw_sp = str2double(get(handles.text42,'String'));

% NH3
paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.NH3_MAX,'String'));
paramdata.alarms(1).NH3(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.NH3_MIN,'String'));
NH3_MAX = str2double(get(handles.NH3_MAX,'String'));
NH3_MIN = str2double(get(handles.NH3_MIN,'String'));

% junhuaku
paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.junhuaku_MAX,'String'));
paramdata.alarms(1).junhuaku(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.junhuaku_MIN,'String'));
junhua_MAX = str2double(get(handles.junhuaku_MAX,'String'));
junhua_MIN = str2double(get(handles.junhuaku_MIN,'String'));

%高温风机
paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.uplimit = str2double(get(handles.gaowenfengji_MAX,'String'));
paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.downlimit = str2double(get(handles.gaowenfengji_MIN,'String'));
gaowenfengji_MAX = str2double(get(handles.gaowenfengji_MAX,'String'));
gaowenfengji_MIN = str2double(get(handles.gaowenfengji_MIN,'String'));

paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.compensate = str2double(get(handles.gaowenfengji_compensate,'String'));
paramdata.alarms(1).gaowenfengji(1).parameter(1).ATTRIBUTE.rati = str2double(get(handles.gaowenfengji_rati,'String'));
gaowenfengji_compensate = str2double(get(handles.gaowenfengji_compensate,'String'));
gaowenfengji_rati = str2double(get(handles.gaowenfengji_rati,'String'));

wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
delete(handles.figure1);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on slider movement.
function junhuaku_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to junhuaku_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.junhuaku_MAX,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function junhuaku_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to junhuaku_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function junhuaku_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to junhuaku_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.junhuaku_MIN,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function junhuaku_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to junhuaku_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gaowenfengji_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.gaowenfengji_MAX,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gaowenfengji_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gaowenfengji_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.gaowenfengji_MIN,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gaowenfengji_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gaowenfengji_compensate_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_compensate_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.gaowenfengji_compensate,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gaowenfengji_compensate_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_compensate_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gaowenfengji_rati_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_rati_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.gaowenfengji_rati,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gaowenfengji_rati_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaowenfengji_rati_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text34,'String',num2str(slide_value));

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
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text36,'String',num2str(slide_value));

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
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text32,'String',num2str(slide_value));

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
slide_value=(round(a*1000))/1000;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text38,'String',num2str(slide_value));

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
slide_value=(round(a*1000))/1000;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text40,'String',num2str(slide_value));

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
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
set(handles.text42,'String',num2str(slide_value,formatSpec));

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
slide_value=round(a);%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
%formatSpec='%3.1f';
% set(handles.ts1,'String',num2str(slide_value));%ts1是指右上角的那个小框
%set(handles.text45,'String',num2str(slide_value,formatSpec));
set(handles.text45,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function text45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
