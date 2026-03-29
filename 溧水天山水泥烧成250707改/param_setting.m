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

% Last Modified by GUIDE v2.5 20-Mar-2025 23:56:37

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
global paramdata blj_max blj_min fjl_max fjl_min dt_max dt_min  tm_max tm_min yt_max yt_min gwfj_max gwfj_min
global fj11dl_defV0 fj11dl_defV1 fj11dl_defV2 fj11dl_defV3 fj11dl0 fj11dl1 fj11dl2 fj11dl3
paramdata = xml_read('param_set.xml');
blj_max = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_max;
blj_min = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_min;
fjl_max = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_max;
fjl_min = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_min;
dt_max = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_max;
dt_min = paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_min;
tm_max = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_max;
tm_min = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_min;
yt_max = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_max;
yt_min = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_min;
gwfj_max = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_max;
gwfj_min = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_min;
fj11dl0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0;
fj11dl1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1;
fj11dl2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2;
fj11dl3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3;
fj11dl_defV0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV0;
fj11dl_defV1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV1;
fj11dl_defV2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV2;
fj11dl_defV3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV3;

pressure_vd = paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd; 
pressure_vd_low = paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd_low;
zhuansu_mid = paramdata.commdata(1).parameter(13).ATTRIBUTE.zhuansu_mid; 
ysphfjdl = paramdata.commdata(1).parameter(13).ATTRIBUTE.ysphfjdl; 
ecfw_sp = paramdata.commdata(1).parameter(13).ATTRIBUTE.ecfw_sp; 
set(handles.fj11dl_defV0,'String',fj11dl_defV0);
set(handles.fj11dl_defV1,'String',fj11dl_defV1);
set(handles.fj11dl_defV2,'String',fj11dl_defV2);
set(handles.fj11dl_defV3,'String',fj11dl_defV3);
%篦冷机滑动条设定

set(handles.fj11dl3,'String',fj11dl3);
set(handles.fjdl_slider3,'Value',fj11dl3);
set(handles.fjdl_slider3,'Max',fj11dl_defV3+25,'Min',fj11dl_defV3-25);
set(handles.fjdl_slider3,'SliderStep',[1/50,2/50]);

set(handles.fj11dl2,'String',fj11dl2);
set(handles.fjdl_slider2,'Value',fj11dl2);
set(handles.fjdl_slider2,'Max',fj11dl_defV2+25,'Min',fj11dl_defV2-25);
set(handles.fjdl_slider2,'SliderStep',[1/50,2/50]);

set(handles.fj11dl1,'String',fj11dl1);
set(handles.fjdl_slider1,'Value',fj11dl1);
set(handles.fjdl_slider1,'Max',fj11dl_defV1+25,'Min',fj11dl_defV1-25);
set(handles.fjdl_slider1,'SliderStep',[1/50,2/50]);

set(handles.fj11dl0,'String',fj11dl0);
set(handles.fjdl_slider0,'Value',fj11dl0);
set(handles.fjdl_slider0,'Max',fj11dl_defV0+25,'Min',fj11dl_defV0-25);
set(handles.fjdl_slider0,'SliderStep',[1/50,2/50]);

set(handles.blj_up,'String',blj_max);
set(handles.blj_up_slider,'Value',blj_max);
set(handles.blj_up_slider,'Max',blj_max+5,'Min',blj_max-5);
set(handles.blj_up_slider,'SliderStep',[0.02/20,0.5/20]);

set(handles.blj_down,'String',blj_min);
set(handles.blj_down_slider,'Value',blj_min);
set(handles.blj_down_slider,'Max',blj_min+5,'Min',blj_min-5);
set(handles.blj_down_slider,'SliderStep',[0.02/20,0.5/20]);
%分解炉滑动条设定
set(handles.fjl_up,'String',fjl_max);
set(handles.fjl_up_slider,'Value',fjl_max);
set(handles.fjl_up_slider,'Max',fjl_max+5,'Min',fjl_max-5);
set(handles.fjl_up_slider,'SliderStep',[0.1/10,1/10]);

set(handles.fjl_down,'String',fjl_min);
set(handles.fjl_down_slider,'Value',fjl_min);
set(handles.fjl_down_slider,'Max',fjl_min+5,'Min',fjl_min-5);
set(handles.fjl_down_slider,'SliderStep',[0.1/10,1/10]);
%斗提电流喂料量滑动条设定
set(handles.dt_up,'String',dt_max);
set(handles.dt_up_slider,'Value',dt_max);
set(handles.dt_up_slider,'Max',dt_max+50,'Min',dt_max-50);
set(handles.dt_up_slider,'SliderStep',[0.5/100,2/100]);

set(handles.dt_down,'String',dt_min);
set(handles.dt_down_slider,'Value',dt_min);
set(handles.dt_down_slider,'Max',dt_min+50,'Min',dt_min-50);
set(handles.dt_down_slider,'SliderStep',[0.5/100,2/100]);
%头煤给煤量滑动条设定
set(handles.tm_up,'String',tm_max);
set(handles.tm_up_slider,'Value',tm_max);
set(handles.tm_up_slider,'Max',tm_max+20,'Min',tm_max-20);
set(handles.tm_up_slider,'SliderStep',[0.1/40,1/40]);

set(handles.tm_down,'String',tm_min);
set(handles.tm_down_slider,'Value',tm_min);
set(handles.tm_down_slider,'Max',tm_min+20,'Min',tm_min-20);
set(handles.tm_down_slider,'SliderStep',[0.1/40,1/40]);
%头排风机给转速设定
set(handles.tp_up,'String',yt_max);
set(handles.tp_up_slider,'Value',yt_max);
set(handles.tp_up_slider,'Max',yt_max+50,'Min',yt_max-50);
set(handles.tp_up_slider,'SliderStep',[0.1/100,2/100]);

set(handles.tp_down,'String',yt_min);
set(handles.tp_down_slider,'Value',yt_min);
set(handles.tp_down_slider,'Max',yt_min+50,'Min',yt_min-50);
set(handles.tp_down_slider,'SliderStep',[0.1/100,2/100]);
%高温风机给转速设定
set(handles.gwfj_up,'String',gwfj_max);
set(handles.gwfj_up_slider,'Value',gwfj_max);
set(handles.gwfj_up_slider,'Max',gwfj_max+50,'Min',gwfj_max-50);
set(handles.gwfj_up_slider,'SliderStep',[0.1/100,2/100]);

set(handles.gwfj_down,'String',gwfj_min);
set(handles.gwfj_down_slider,'Value',gwfj_min);
set(handles.gwfj_down_slider,'Max',gwfj_min+50,'Min',gwfj_min-50);
set(handles.gwfj_down_slider,'SliderStep',[0.1/100,2/100]);
%固定篦床压力上限值
set(handles.pressure_vd,'String',pressure_vd);
set(handles.pressure_vd_slider,'Value',pressure_vd);
set(handles.pressure_vd_slider,'Max',pressure_vd+1000,'Min',pressure_vd-1000);
set(handles.pressure_vd_slider,'SliderStep',[10/2000,50/2000]);
%固定篦床压力下限值
set(handles.pressure_vd_low,'String',pressure_vd_low);
set(handles.pressure_vd_low_slider,'Value',pressure_vd_low);
set(handles.pressure_vd_low_slider,'Max',pressure_vd_low+1000,'Min',pressure_vd_low-1000);
set(handles.pressure_vd_low_slider,'SliderStep',[10/2000,50/2000]);
%电流下限
set(handles.ysphfjdl,'String',ysphfjdl);
set(handles.ysphfjdl_slider,'Value',ysphfjdl);
set(handles.ysphfjdl_slider,'Max',ysphfjdl+100,'Min',ysphfjdl-100);
set(handles.ysphfjdl_slider,'SliderStep',[1/200,5/200]);
%中场
set(handles.zhuansu_mid,'String',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Value',zhuansu_mid);
set(handles.zhuansu_mid_slider,'Max',zhuansu_mid+5,'Min',zhuansu_mid-5);
set(handles.zhuansu_mid_slider,'SliderStep',[0.02/20,0.5/20]);
%二次风温
set(handles.ecfw_sp,'String',ecfw_sp);
set(handles.ecfw_sp_slider,'Value',ecfw_sp);
set(handles.ecfw_sp_slider,'Max',ecfw_sp+1000,'Min',ecfw_sp-500);
set(handles.ecfw_sp_slider,'SliderStep',[10/1500,50/1500]);

% Choose default command line output for param_setting
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

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
function blj_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.2f';
set(handles.blj_up,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.2f';
set(handles.blj_down,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%.1f';
set(handles.fjl_up,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value;
set(hObject,'Value',slide_value);%不用管
formatSpec='%.1f';
set(handles.fjl_down,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function dt_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to dt_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.dt_up,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function dt_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function dt_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to dt_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.dt_down,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function dt_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dt_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tm_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tm_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.tm_up,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tm_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tm_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tm_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.tm_down,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tm_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tm_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tp_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tp_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.tp_up,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tp_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tp_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tp_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tp_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.tp_down,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tp_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tp_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata 
%篦冷机上下限 取消篦冷机上下限保存
paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_max = str2double(get(handles.blj_up,'String'));
paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_min = str2double(get(handles.blj_down,'String'));
%分解炉上下限
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_max = str2double(get(handles.fjl_up,'String'));
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_min = str2double(get(handles.fjl_down,'String'));
%斗提喂料量上下限
paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_max = str2double(get(handles.dt_up,'String'));
paramdata.commdata(1).parameter(4).ATTRIBUTE.dt_min = str2double(get(handles.dt_down,'String'));
%头煤给煤量上下限
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_max = str2double(get(handles.tm_up,'String'));
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_min = str2double(get(handles.tm_down,'String'));
%头排风机上下限
paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_max = str2double(get(handles.tp_up,'String'));
paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_min = str2double(get(handles.tp_down,'String'));
%高温风机上下限
paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_max = str2double(get(handles.gwfj_up,'String'));
paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_min = str2double(get(handles.gwfj_down,'String'));

%固定壁板上限
paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd = str2double(get(handles.pressure_vd,'String'));
%固定壁板下限
paramdata.commdata(1).parameter(13).ATTRIBUTE.pressure_vd_low = str2double(get(handles.pressure_vd_low,'String'));
%风机电流下限
paramdata.commdata(1).parameter(13).ATTRIBUTE.ysphfjdl = str2double(get(handles.ysphfjdl,'String'));
%中场转速
paramdata.commdata(1).parameter(13).ATTRIBUTE.zhuansu_mid = str2double(get(handles.zhuansu_mid,'String'));
%二次风温
paramdata.commdata(1).parameter(13).ATTRIBUTE.ecfw_sp = str2double(get(handles.ecfw_sp,'String'));
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
delete(handles.figure1);
% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes on slider movement.
function fjdl_slider0_Callback(hObject, eventdata, handles)
% hObject    handle to fjdl_slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fj11dl0 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fj11dl0,'String',num2str(slide_value));
fj11dl0=str2double(get(handles.fj11dl0,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0=fj11dl0;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjdl_slider0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjdl_slider0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjdl_slider1_Callback(hObject, eventdata, handles)
% hObject    handle to fjdl_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fj11dl1 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fj11dl1,'String',num2str(slide_value));
fj11dl1=str2double(get(handles.fj11dl1,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1=fj11dl1;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function fjdl_slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjdl_slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjdl_slider2_Callback(hObject, eventdata, handles)
% hObject    handle to fjdl_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fj11dl2 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fj11dl2,'String',num2str(slide_value));
fj11dl2=str2double(get(handles.fj11dl2,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2=fj11dl2;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjdl_slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjdl_slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjdl_slider3_Callback(hObject, eventdata, handles)
% hObject    handle to fjdl_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fj11dl3 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fj11dl3,'String',num2str(slide_value));
fj11dl3=str2double(get(handles.fj11dl3,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3=fj11dl3;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjdl_slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjdl_slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_up_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=a;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.gwfj_up,'String',num2str(slide_value,formatSpec));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_up_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_up_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_down_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.1f';
set(handles.gwfj_down,'String',num2str(slide_value,formatSpec));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_down_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_down_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pressure_vd_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pressure_vd_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.0f';
set(handles.pressure_vd,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pressure_vd_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressure_vd_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function ysphfjdl_slider_Callback(hObject, eventdata, handles)
% hObject    handle to ysphfjdl_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.0f';
set(handles.ysphfjdl,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function ysphfjdl_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ysphfjdl_slider (see GCBO)
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
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*100))/100;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.2f';
set(handles.zhuansu_mid,'String',num2str(slide_value,formatSpec));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
function ecfw_sp_slider_Callback(hObject, eventdata, handles)
% hObject    handle to ecfw_sp_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.0f';
set(handles.ecfw_sp,'String',num2str(slide_value,formatSpec));
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


% --- Executes on slider movement.
function pressure_vd_low_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pressure_vd_low_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
formatSpec='%3.0f';
set(handles.pressure_vd_low,'String',num2str(slide_value,formatSpec));

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pressure_vd_low_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressure_vd_low_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
