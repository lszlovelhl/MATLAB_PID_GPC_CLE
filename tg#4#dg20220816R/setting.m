function varargout = setting(varargin)
% SETTING MATLAB code for setting.fig
%      SETTING, by itself, creates a new SETTING or raises the existing
%      singleton*.
%
%      H = SETTING returns the handle to a new SETTING or the handle to
%      the existing singleton*.
%
%      SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTING.M with the given input arguments.
%
%      SETTING('Property','Value',...) creates a new SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help setting

% Last Modified by GUIDE v2.5 17-Aug-2021 09:54:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @setting_OpeningFcn, ...
                   'gui_OutputFcn',  @setting_OutputFcn, ...
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


% --- Executes just before setting is made visible.
function setting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to setting (see VARARGIN)
global data famen_ok famen_shang_xia b steeldata gas_fm_shang gas_fm_xia air_fm_shang air_fm_xia
% Choose default command line output for setting
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);
steeldata=xml_read('steel_set.xml');
% 获取阀门上下限
gas_fm_shang(1) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max1;
gas_fm_shang(2) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max2;
gas_fm_shang(3) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max3;

gas_fm_xia(1) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min1;
gas_fm_xia(2) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min2;
gas_fm_xia(3) = steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min3;

air_fm_shang(1) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max1;
air_fm_shang(2) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max2;
air_fm_shang(3) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max3;

air_fm_xia(1) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min1;
air_fm_xia(2) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min2;
air_fm_xia(3) = steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min3;

famen_ok = 0;
%加一段煤气阀门上限
gas1_fm_shang=gas_fm_shang(1);
set(handles.gas1_fm_max,'String',gas1_fm_shang);
set(handles.gas1_slider_fm_max,'Value',gas1_fm_shang);
set(handles.gas1_slider_fm_max,'Max',100,'Min',0);
set(handles.gas1_slider_fm_max,'SliderStep',[1/100,5/100]);

%加一段煤气阀门下限
gas1_fm_xia=gas_fm_xia(1);
set(handles.gas1_fm_min,'String',gas1_fm_xia);
set(handles.gas1_slider_fm_min,'Value',gas1_fm_xia);
set(handles.gas1_slider_fm_min,'Max',100,'Min',0);
set(handles.gas1_slider_fm_min,'SliderStep',[1/100,5/100]);

%加一段空气阀门上限
air1_fm_shang=air_fm_shang(1);
set(handles.air1_fm_max,'String',air1_fm_shang);
set(handles.air1_slider_fm_max,'Value',air1_fm_shang);
set(handles.air1_slider_fm_max,'Max',100,'Min',0);
set(handles.air1_slider_fm_max,'SliderStep',[1/100,5/100]);

%加一段空气阀门下限
air1_fm_xia=air_fm_xia(1);
set(handles.air1_fm_min,'String',air1_fm_xia);
set(handles.air1_slider_fm_min,'Value',air1_fm_xia);
set(handles.air1_slider_fm_min,'Max',100,'Min',0);
set(handles.air1_slider_fm_min,'SliderStep',[1/100,5/100]);

%加二段煤气阀门上限
gas2_fm_shang=gas_fm_shang(2);
set(handles.gas2_fm_max,'String',gas2_fm_shang);
set(handles.gas2_slider_fm_max,'Value',gas2_fm_shang);
set(handles.gas2_slider_fm_max,'Max',100,'Min',0);
set(handles.gas2_slider_fm_max,'SliderStep',[1/100,5/100]);

%加二段煤气阀门下限
gas2_fm_xia=gas_fm_xia(2);
set(handles.gas2_fm_min,'String',gas2_fm_xia);
set(handles.gas2_slider_fm_min,'Value',gas2_fm_xia);
set(handles.gas2_slider_fm_min,'Max',100,'Min',0);
set(handles.gas2_slider_fm_min,'SliderStep',[1/100,5/100]);

%加二段空气阀门上限
air2_fm_shang=air_fm_shang(2);
set(handles.air2_fm_max,'String',air2_fm_shang);
set(handles.air2_slider_fm_max,'Value',air2_fm_shang);
set(handles.air2_slider_fm_max,'Max',100,'Min',0);
set(handles.air2_slider_fm_max,'SliderStep',[1/100,5/100]);

%加二段空气阀门下限
air2_fm_xia=air_fm_xia(2);
set(handles.air2_fm_min,'String',air2_fm_xia);
set(handles.air2_slider_fm_min,'Value',air2_fm_xia);
set(handles.air2_slider_fm_min,'Max',100,'Min',0);
set(handles.air2_slider_fm_min,'SliderStep',[1/100,5/100]);

%加三段煤气阀门上限
gas3_fm_shang=gas_fm_shang(3);
set(handles.gas3_fm_max,'String',gas3_fm_shang);
set(handles.gas3_slider_fm_max,'Value',gas3_fm_shang);
set(handles.gas3_slider_fm_max,'Max',100,'Min',0);
set(handles.gas3_slider_fm_max,'SliderStep',[1/100,5/100]);

%加三段煤气阀门下限
gas3_fm_xia=gas_fm_xia(3);
set(handles.gas3_fm_min,'String',gas3_fm_xia);
set(handles.gas3_slider_fm_min,'Value',gas3_fm_xia);
set(handles.gas3_slider_fm_min,'Max',100,'Min',0);
set(handles.gas3_slider_fm_min,'SliderStep',[1/100,5/100]);

%加三段空气阀门上限
air3_fm_shang=air_fm_shang(3);
set(handles.air3_fm_max,'String',air3_fm_shang);
set(handles.air3_slider_fm_max,'Value',air3_fm_shang);
set(handles.air3_slider_fm_max,'Max',100,'Min',0);
set(handles.air3_slider_fm_max,'SliderStep',[1/100,5/100]);

%加三段空气阀门下限
air3_fm_xia=air_fm_xia(3);
set(handles.air3_fm_min,'String',air3_fm_xia);
set(handles.air3_slider_fm_min,'Value',air3_fm_xia);
set(handles.air3_slider_fm_min,'Max',100,'Min',0);
set(handles.air3_slider_fm_min,'SliderStep',[1/100,5/100]);

% %均热段煤气阀门上限
% gas4_fm_shang=data(86,b+1);
% set(handles.gas4_fm_max,'String',gas4_fm_shang);
% set(handles.gas4_slider_fm_max,'Value',gas4_fm_shang);
% set(handles.gas4_slider_fm_max,'Max',100,'Min',0);
% set(handles.gas4_slider_fm_max,'SliderStep',[1/100,5/100]);
% 
% %均热段煤气阀门下限
% gas4_fm_xia=data(87,b+1);
% set(handles.gas4_fm_min,'String',gas4_fm_xia);
% set(handles.gas4_slider_fm_min,'Value',gas4_fm_xia);
% set(handles.gas4_slider_fm_min,'Max',100,'Min',0);
% set(handles.gas4_slider_fm_min,'SliderStep',[1/100,5/100]);
% 
% %均热段空气阀门上限
% air4_fm_shang=data(88,b+1);
% set(handles.air4_fm_max,'String',air4_fm_shang);
% set(handles.air4_slider_fm_max,'Value',air4_fm_shang);
% set(handles.air4_slider_fm_max,'Max',100,'Min',0);
% set(handles.air4_slider_fm_max,'SliderStep',[1/100,5/100]);
% 
% %均热段空气阀门下限
% air4_fm_xia=data(89,b+1);
% set(handles.air4_fm_min,'String',air4_fm_xia);
% set(handles.air4_slider_fm_min,'Value',air4_fm_xia);
% set(handles.air4_slider_fm_min,'Max',100,'Min',0);
% set(handles.air4_slider_fm_min,'SliderStep',[1/100,5/100]);
% UIWAIT makes setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = setting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function gas1_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to gas1_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas1_fm_max,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gas1_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas1_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas1_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to gas1_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas1_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas1_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas1_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas2_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to gas2_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas2_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas2_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas2_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas2_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to gas2_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas2_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas2_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas2_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas3_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to gas3_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas3_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas3_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas3_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas3_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to gas3_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas3_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas3_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas3_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas4_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to gas4_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas4_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas4_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas4_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gas4_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to gas4_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.gas4_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function gas4_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gas4_slider_fm_min (see GCBO)
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
global famen_ok famen_shang_xia steeldata
 gas1_fm_max = str2double(get(handles.gas1_fm_max,'String'));
 gas2_fm_max = str2double(get(handles.gas2_fm_max,'String'));
 gas3_fm_max = str2double(get(handles.gas3_fm_max,'String'));
 
 gas1_fm_min = str2double(get(handles.gas1_fm_min,'String'));
 gas2_fm_min = str2double(get(handles.gas2_fm_min,'String'));
 gas3_fm_min = str2double(get(handles.gas3_fm_min,'String'));

 
 air1_fm_max = str2double(get(handles.air1_fm_max,'String'));
 air2_fm_max = str2double(get(handles.air2_fm_max,'String'));
 air3_fm_max = str2double(get(handles.air3_fm_max,'String'));

 
 air1_fm_min = str2double(get(handles.air1_fm_min,'String'));
 air2_fm_min = str2double(get(handles.air2_fm_min,'String'));
 air3_fm_min = str2double(get(handles.air3_fm_min,'String'));
 
% steeldata=xml_read('steel_set.xml');
% 获取阀门上下限
steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max1 = gas1_fm_max;
steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max2 = gas2_fm_max;
steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_max3 = gas3_fm_max;

steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min1 = gas1_fm_min;
steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min2 = gas2_fm_min;
steeldata.common(1,1).parameter.ATTRIBUTE.gas_valve_min3 = gas3_fm_min;

steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max1 = air1_fm_max;
steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max2 = air2_fm_max;
steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_max3 = air3_fm_max;

steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min1 = air1_fm_min;
steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min2 = air2_fm_min;
steeldata.common(1,1).parameter.ATTRIBUTE.air_valve_min3 = air3_fm_min;

wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('steel_set.xml',steeldata,'steeldata',wPref);
close(handles.figure1)
 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global famen_ok
famen_ok = 0; % 0表示不修改
close(handles.figure1)


% --- Executes on slider movement.
function air1_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to air1_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air1_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air1_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air1_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air1_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to air1_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air1_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air1_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air1_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air2_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to air2_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air2_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air2_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air2_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air2_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to air2_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air2_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air2_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air2_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air3_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to air3_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air3_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air3_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air3_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air3_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to air3_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air3_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air3_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air3_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air4_slider_fm_max_Callback(hObject, eventdata, handles)
% hObject    handle to air4_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air4_fm_max,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air4_slider_fm_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air4_slider_fm_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function air4_slider_fm_min_Callback(hObject, eventdata, handles)
% hObject    handle to air4_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.air4_fm_min,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function air4_slider_fm_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to air4_slider_fm_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
