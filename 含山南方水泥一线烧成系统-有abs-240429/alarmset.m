function varargout = alarmset(varargin)
% ALARMSET MATLAB code for alarmset.fig
%      ALARMSET, by itself, creates a new ALARMSET or raises the existing
%      singleton*.
%
%      H = ALARMSET returns the handle to a new ALARMSET or the handle to
%      the existing singleton*.
%
%      ALARMSET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALARMSET.M with the given input arguments.
%
%      ALARMSET('Property','Value',...) creates a new ALARMSET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before alarmset_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to alarmset_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help alarmset

% Last Modified by GUIDE v2.5 13-Jan-2024 17:36:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @alarmset_OpeningFcn, ...
                   'gui_OutputFcn',  @alarmset_OutputFcn, ...
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


% --- Executes just before alarmset is made visible.
function alarmset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to alarmset (see VARARGIN)
% Choose default command line output for alarmset
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes alarmset wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global decomposing_furnace_tempr_2_upperlimitS decomposing_furnace_tempr_2_lowerlimitS snd_chamber_pressure_upperlimitS snd_chamber_pressure_lowerlimitS
global fjl_max fjl_min
%%这里的代码只是为了遵循matlab渲染滑动条规则而给个在max/min范围的初始值
set(handles.text12,'String',decomposing_furnace_tempr_2_upperlimitS);
set(handles.slider1,'Value',decomposing_furnace_tempr_2_upperlimitS);
set(handles.slider1,'Max',decomposing_furnace_tempr_2_upperlimitS+30,'Min',decomposing_furnace_tempr_2_upperlimitS-30);
set(handles.slider1,'SliderStep',[1/100,2/100]);

set(handles.text13,'String',decomposing_furnace_tempr_2_lowerlimitS);
set(handles.slider2,'Value',decomposing_furnace_tempr_2_lowerlimitS);
set(handles.slider2,'Max',decomposing_furnace_tempr_2_lowerlimitS+30,'Min',decomposing_furnace_tempr_2_lowerlimitS-30);
set(handles.slider2,'SliderStep',[1/70,5/70]);

set(handles.text14,'String',snd_chamber_pressure_upperlimitS);
set(handles.slider4,'Value',snd_chamber_pressure_upperlimitS);
set(handles.slider4,'Max',snd_chamber_pressure_upperlimitS+5,'Min',snd_chamber_pressure_upperlimitS-5);
set(handles.slider4,'SliderStep',[0.1/10,0.5/10]);

set(handles.text15,'String',snd_chamber_pressure_lowerlimitS);
set(handles.slider5,'Value',snd_chamber_pressure_lowerlimitS);
set(handles.slider5,'Max',snd_chamber_pressure_lowerlimitS + 5,'Min',snd_chamber_pressure_lowerlimitS - 5);
set(handles.slider5,'SliderStep',[0.1/10,0.5/10]);

% --- Outputs from this function are returned to the command line.
function varargout = alarmset_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles decomposing_furnace_tempr_2_upperlimitS
a = get(hObject,'Value');%获取滑块当前值
b = round(a*10);
Sv = round(b/10);
set(hObject,'Value',Sv);
set(pophandles.text12,'String',num2str(Sv));
decomposing_furnace_tempr_2_upperlimitS= Sv; 


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles decomposing_furnace_tempr_2_lowerlimitS
a = get(hObject,'Value');%获取滑块当前值
b = round(a*10);
Sv = round(b/10);
set(hObject,'Value',Sv);
set(pophandles.text13,'String',num2str(Sv));
decomposing_furnace_tempr_2_lowerlimitS = Sv;

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
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
global pophandles snd_chamber_pressure_upperlimitS
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.text14,'String',num2str(Sv));
 snd_chamber_pressure_upperlimitS = Sv;


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
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles snd_chamber_pressure_lowerlimitS
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.text15,'String',num2str(Sv));
snd_chamber_pressure_lowerlimitS = Sv;


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
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


% --- Executes on slider movement.
function fjl_maxSlider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_maxSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pophandles fjl_max
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.fjl_wml_up,'String',num2str(Sv));
 fjl_max = Sv;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_maxSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_maxSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_minSlider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_minSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pophandles fjl_min
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.fjl_vml_down,'String',num2str(Sv));
 fjl_min = Sv;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fjl_minSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_minSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fazu2_maxSlider_Callback(hObject, eventdata, handles)
% hObject    handle to fazu2_maxSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pophandles snd_chamber_pressure_upperlimitS fazu2_max
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.fazu2_max,'String',num2str(Sv));
 fazu2_max = Sv;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fazu2_maxSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fazu2_maxSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fazu2_minSlider_Callback(hObject, eventdata, handles)
% hObject    handle to fazu2_minSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pophandles snd_chamber_pressure_upperlimitS fazu2_min
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.fazu2_min,'String',num2str(Sv));
 fazu2_min = Sv;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fazu2_minSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fazu2_minSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
