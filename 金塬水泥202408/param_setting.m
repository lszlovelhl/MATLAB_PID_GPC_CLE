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

% Last Modified by GUIDE v2.5 19-May-2023 17:09:59

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
global   zhuansu_MAX zhuansu_MIN douti_MAX douti_MIN toumei_MAX toumei_MIN paramdata cd3_MAX cd3_MIN
global SLcangzhong_MAX SLcangzhong_MIN fjlumax
global SLvalveR_sp_MIN SLvalveR_sp_MAX  toupai_max toupai_min
global avgt avgpress avgspeed midspeed changespeed
global xialiao_max xialiao_min   weipai_max weipai_min
global fj11dl0 fj11dl1 fj11dl2 fj11dl3 fj11dl4
%% 读取初始值
paramdata = xml_read('param_set.xml');
zhuansu_MAX = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MAX;
zhuansu_MIN = paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MIN;

toumei_MAX = paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MAX;
toumei_MIN = paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MIN;
SLvalveR_sp_MAX = paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MAX;
SLvalveR_sp_MIN = paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MIN ;
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
weipai_max = paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_max;
weipai_min = paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_min;

fj11dl_defV0 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV0;
fj11dl_defV1 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV1;
fj11dl_defV2 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV2;
fj11dl_defV3 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV3;
fj11dl_defV4 = paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl_defV4;

% set(handles.fjlumaxsp,'String',num2str(fjlumax,'%4.3f'));
%% 初值设定

set(handles.toupai_max,'String',toupai_max);
set(handles.toupai_max_slider,'Value',toupai_max);
set(handles.toupai_max_slider,'Max',toupai_max+10,'Min',toupai_max-10);
set(handles.toupai_max_slider,'SliderStep',[1/20,2/20]);


set(handles.toupai_min,'String',toupai_min);
set(handles.toupai_min_slider,'Value',toupai_min);
set(handles.toupai_min_slider,'Max',toupai_min+10,'Min',toupai_min-10);
set(handles.toupai_min_slider,'SliderStep',[1/20,2/20]);


%尾排风机转速
set(handles.weipai_max,'String',weipai_max);
set(handles.weipai_max_slider,'Value',weipai_max);
set(handles.weipai_max_slider,'Max',weipai_max+20,'Min',weipai_max-20);
set(handles.weipai_max_slider,'SliderStep',[0.1/40,1/40]);

set(handles.weipai_min,'String',weipai_min);
set(handles.weipai_min_slider,'Value',weipai_min);
set(handles.weipai_min_slider,'Max',weipai_min+20,'Min',weipai_min-20);
set(handles.weipai_min_slider,'SliderStep',[0.1/40,1/40]);

set(handles.SLvalveR_sp_MAX,'String',SLvalveR_sp_MAX);
set(handles.SLvalveR_sp_MAX_slider,'Value',SLvalveR_sp_MAX);
set(handles.SLvalveR_sp_MAX_slider,'Max',SLvalveR_sp_MAX+40,'Min',SLvalveR_sp_MAX-40);
set(handles.SLvalveR_sp_MAX_slider,'SliderStep',[1/80,5/80]);

set(handles.SLvalveR_sp_MIN,'String',SLvalveR_sp_MIN);
set(handles.SLvalveR_sp_MIN_slider,'Value',SLvalveR_sp_MIN);
set(handles.SLvalveR_sp_MIN_slider,'Max',SLvalveR_sp_MIN+40,'Min',SLvalveR_sp_MIN-40);
set(handles.SLvalveR_sp_MIN_slider,'SliderStep',[1/80,5/80]);

set(handles.zhuansu_MAX,'String',zhuansu_MAX);
set(handles.zhuansu_MAX_slider,'Value',zhuansu_MAX);
set(handles.zhuansu_MAX_slider,'Max',zhuansu_MAX+30,'Min',zhuansu_MAX-30);
set(handles.zhuansu_MAX_slider,'SliderStep',[1/60,5/60]);

set(handles.zhuansu_MIN,'String',zhuansu_MIN);
set(handles.zhuansu_MIN_slider,'Value',zhuansu_MIN);
set(handles.zhuansu_MIN_slider,'Max',zhuansu_MIN+30,'Min',zhuansu_MIN-30);
set(handles.zhuansu_MIN_slider,'SliderStep',[1/60,5/60]);

set(handles.toumei_MAX,'String',toumei_MAX);
set(handles.toumei_MAX_slider,'Value',toumei_MAX);
set(handles.toumei_MAX_slider,'Max',toumei_MAX+3,'Min',toumei_MAX-3);
set(handles.toumei_MAX_slider,'SliderStep',[0.1/6,0.5/6]);

set(handles.toumei_MIN,'String',toumei_MIN);
set(handles.toumei_MIN_slider,'Value',toumei_MIN);
set(handles.toumei_MIN_slider,'Max',toumei_MIN+3,'Min',toumei_MIN-3);
set(handles.toumei_MIN_slider,'SliderStep',[0.1/6,0.5/6]);

%% 分档
set(handles.text90,'String',fj11dl4);
set(handles.slider36,'Value',fj11dl4);
set(handles.slider36,'Max',fj11dl4+15,'Min',fj11dl4-15);
set(handles.slider36,'SliderStep',[1/30,2/30]);

set(handles.text80,'String',fj11dl3);
set(handles.slider32,'Value',fj11dl3);
set(handles.slider32,'Max',fj11dl3+15,'Min',fj11dl3-15);
set(handles.slider32,'SliderStep',[1/30,2/30]);

set(handles.text81,'String',fj11dl2);
set(handles.slider33,'Value',fj11dl2);
set(handles.slider33,'Max',fj11dl2+15,'Min',fj11dl2-15);
set(handles.slider33,'SliderStep',[1/30,2/30]);

set(handles.text82,'String',fj11dl1);
set(handles.slider34,'Value',fj11dl1);
set(handles.slider34,'Max',fj11dl1+15,'Min',fj11dl1-15);
set(handles.slider34,'SliderStep',[1/30,2/30]);

set(handles.text83,'String',fj11dl0);
set(handles.slider35,'Value',fj11dl0);
set(handles.slider35,'Max',fj11dl_defV0+15,'Min',fj11dl_defV0-15);
set(handles.slider35,'SliderStep',[1/30,2/30]);

set(handles.text89,'String',fj11dl_defV4);
set(handles.text73,'String',fj11dl_defV3);
set(handles.text77,'String',fj11dl_defV2);
set(handles.text78,'String',fj11dl_defV1);
set(handles.text79,'String',fj11dl_defV0);


%%


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
function zhuansu_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to zhuansu_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global zhuansu_MAX paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.zhuansu_MAX,'String',num2str(slide_value));
zhuansu_MAX=str2double(get(handles.zhuansu_MAX,'String'));
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MAX=zhuansu_MAX;
xml_write('param_set.xml',paramdata);

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
global zhuansu_MIN paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.zhuansu_MIN,'String',num2str(slide_value));
zhuansu_MIN=str2double(get(handles.zhuansu_MIN,'String'));
paramdata.commdata(1).parameter(14).ATTRIBUTE.zhuansu_MIN=zhuansu_MIN;
xml_write('param_set.xml',paramdata);

% --- Executes during object creation, after setting all properties.
function zhuansu_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zhuansu_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLvalveR_sp_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLvalveR_sp_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global SLvalveR_sp_MAX paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.SLvalveR_sp_MAX,'String',num2str(slide_value));
SLvalveR_sp_MAX=str2double(get(handles.SLvalveR_sp_MAX,'String'));
paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MAX=SLvalveR_sp_MAX;
xml_write('param_set.xml',paramdata);

% --- Executes during object creation, after setting all properties.
function SLvalveR_sp_MAX_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLvalveR_sp_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLvalveR_sp_MIN_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLvalveR_sp_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global SLvalveR_sp_MIN paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.SLvalveR_sp_MIN,'String',num2str(slide_value));
SLvalveR_sp_MIN=str2double(get(handles.SLvalveR_sp_MIN,'String'));
paramdata.commdata(1).parameter(17).ATTRIBUTE.SLvalveR_sp_MIN=SLvalveR_sp_MIN;
xml_write('param_set.xml',paramdata);

% --- Executes during object creation, after setting all properties.
function SLvalveR_sp_MIN_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLvalveR_sp_MIN_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_MAX_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_MAX_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global toumei_MAX paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.toumei_MAX,'String',num2str(slide_value));
toumei_MAX=str2double(get(handles.toumei_MAX,'String'));
paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MAX=toumei_MAX;
xml_write('param_set.xml',paramdata);

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
global toumei_MIN paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.toumei_MIN,'String',num2str(slide_value));
toumei_MIN=str2double(get(handles.toumei_MIN,'String'));
paramdata.commdata(1).parameter(16).ATTRIBUTE.toumei_MIN=toumei_MIN;
xml_write('param_set.xml',paramdata);

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
function fjlumax_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjlumax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fjlumax paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*1000))/1000;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.fjlumaxsp,'String',num2str(slide_value,'%4.3f'));
fjlumax=str2double(get(handles.fjlumaxsp,'String'));
paramdata.commdata(1).parameter(22).ATTRIBUTE.fjlumax=fjlumax;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjlumax_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjlumax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_max_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_max paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.toupai_max,'String',num2str(slide_value));
toupai_max=str2double(get(handles.toupai_max,'String'));
paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_max=toupai_max;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_max_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_min_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_min paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.toupai_min,'String',num2str(slide_value));
toupai_min=str2double(get(handles.toupai_min,'String'));
paramdata.commdata(1).parameter(24).ATTRIBUTE.toupai_min=toupai_min;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_min_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function avgspeed_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avgspeed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.



% --- Executes during object creation, after setting all properties.
function avgt_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avgt_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function midspeed_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to midspeed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function changespeed_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to changespeed_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xialiao_max_slider_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xialiao_max paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.xialiao_max,'String',num2str(slide_value));
xialiao_max=str2double(get(handles.xialiao_max,'String'));
paramdata.commdata(1).parameter(27).ATTRIBUTE.xialiao_max=xialiao_max;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function xialiao_max_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xialiao_min_slider_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xialiao_min paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.xialiao_min,'String',num2str(slide_value));
xialiao_min=str2double(get(handles.xialiao_min,'String'));
paramdata.commdata(1).parameter(27).ATTRIBUTE.xialiao_min=xialiao_min;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function xialiao_min_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end








% --- Executes during object creation, after setting all properties.



% --- Executes on slider movement.
function weipai_max_slider_Callback(hObject, eventdata, handles)
% hObject    handle to weipai_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weipai_max paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.weipai_max,'String',num2str(slide_value));
weipai_max=str2double(get(handles.weipai_max,'String'));
paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_max=weipai_max;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function weipai_max_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weipai_max_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function weipai_min_slider_Callback(hObject, eventdata, handles)
% hObject    handle to weipai_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weipai_min paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.weipai_min,'String',num2str(slide_value));
weipai_min=str2double(get(handles.weipai_min,'String'));
paramdata.commdata(1).parameter(30).ATTRIBUTE.weipai_min=weipai_min;
xml_write('param_set.xml',paramdata);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function weipai_min_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to weipai_min_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider36_Callback(hObject, eventdata, handles)
% hObject    handle to slider36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fj11dl4 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text90,'String',num2str(slide_value));
fj11dl4=str2double(get(handles.text90,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl4=fj11dl4;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% --- Executes during object creation, after setting all properties.
function slider36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider32_Callback(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fj11dl3 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text80,'String',num2str(slide_value));
fj11dl3=str2double(get(handles.text80,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl3=fj11dl3;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);


% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider33_Callback(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fj11dl2 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text81,'String',num2str(slide_value));
fj11dl2=str2double(get(handles.text81,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl2=fj11dl2;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% --- Executes during object creation, after setting all properties.
function slider33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider34_Callback(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fj11dl1 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text82,'String',num2str(slide_value));
fj11dl1=str2double(get(handles.text82,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl1=fj11dl1;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% --- Executes during object creation, after setting all properties.
function slider34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider35_Callback(hObject, eventdata, handles)
% hObject    handle to slider35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fj11dl0 paramdata
a=get(hObject,'Value');%获取滑块当前值
slide_value=(round(a*10))/10;%将滑块的值赋给value
set(hObject,'Value',slide_value);%不用管
set(handles.text83,'String',num2str(slide_value));
fj11dl0=str2double(get(handles.text83,'String'));
paramdata.commdata(1).parameter(7).ATTRIBUTE.fj11dl0=fj11dl0;
% xml_write('param_set.xml',paramdata);
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);

% --- Executes during object creation, after setting all properties.
function slider35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


