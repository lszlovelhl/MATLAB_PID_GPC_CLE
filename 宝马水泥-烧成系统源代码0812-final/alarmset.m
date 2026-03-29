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

% Last Modified by GUIDE v2.5 09-Sep-2020 11:19:13

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
global decomposing_furnace_tempr_2_upperMax decomposing_furnace_tempr_2_upperMin decomposing_furnace_tempr_2_lowerMax decomposing_furnace_tempr_2_lowerMin
global snd_chamber_pressure_upperMax snd_chamber_pressure_upperMin snd_chamber_pressure_lowerMax snd_chamber_pressure_lowerMin
global wlc_weight_upperlimitS wlc_weight_lowerlimitS NOX_upperlimits NOX_lowerlimits
%%这里的代码只是为了遵循matlab渲染滑动条规则而给个在max/min范围的初始值
set(handles.text12,'String',decomposing_furnace_tempr_2_upperlimitS);
set(handles.slider1,'Value',decomposing_furnace_tempr_2_upperlimitS);
set(handles.slider1,'Max',decomposing_furnace_tempr_2_upperMax,'Min',decomposing_furnace_tempr_2_upperMin);
set(handles.slider1,'SliderStep',[1/(decomposing_furnace_tempr_2_upperMax-decomposing_furnace_tempr_2_upperMin),2/(decomposing_furnace_tempr_2_upperMax-decomposing_furnace_tempr_2_upperMin)]);

set(handles.text13,'String',decomposing_furnace_tempr_2_lowerlimitS);
set(handles.slider2,'Value',decomposing_furnace_tempr_2_lowerlimitS);
set(handles.slider2,'Max',850,'Min',800);
set(handles.slider2,'SliderStep',[1/50,5/50]);

set(handles.text14,'String',snd_chamber_pressure_upperlimitS);
set(handles.slider4,'Value',snd_chamber_pressure_upperlimitS);
set(handles.slider4,'Max',snd_chamber_pressure_upperlimitS+2,'Min',snd_chamber_pressure_upperlimitS-2);
set(handles.slider4,'SliderStep',[0.1/4,1/4]);

set(handles.text15,'String',snd_chamber_pressure_lowerlimitS);
set(handles.slider5,'Value',snd_chamber_pressure_lowerlimitS);
set(handles.slider5,'Max',8,'Min',5);
set(handles.slider5,'SliderStep',[0.1/3,1/3]);

set(handles.text20,'String',wlc_weight_upperlimitS);
set(handles.slider6,'Value',wlc_weight_upperlimitS);
set(handles.slider6,'Max',80,'Min',60);
set(handles.slider6,'SliderStep',[1/20,1/10]);

set(handles.text21,'String',wlc_weight_lowerlimitS);
set(handles.slider7,'Value',wlc_weight_lowerlimitS);
set(handles.slider7,'Max',55,'Min',35);
set(handles.slider7,'SliderStep',[1/20,1/10]);

set(handles.NOX_upperlimits,'String',NOX_upperlimits);
set(handles.NOX_upperlimits_Slider,'Value',NOX_upperlimits);
set(handles.NOX_upperlimits_Slider,'Max',100,'Min',20);
set(handles.NOX_upperlimits_Slider,'SliderStep',[1/80,5/80]);

set(handles.NOX_lowerlimits,'String',NOX_lowerlimits);
set(handles.NOX_lowerlimits_Slider,'Value',NOX_lowerlimits);
set(handles.NOX_lowerlimits_Slider,'Max',30,'Min',0);
set(handles.NOX_lowerlimits_Slider,'SliderStep',[1/30,5/30]);

newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标

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
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles wlc_weight_upperlimitS
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.text20,'String',num2str(Sv));
wlc_weight_upperlimitS = Sv;

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
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles wlc_weight_lowerlimitS
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.text21,'String',num2str(Sv));
wlc_weight_lowerlimitS = Sv;

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NOX_upperlimits_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_upperlimits_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles NOX_upperlimits
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.NOX_upperlimits,'String',num2str(Sv));
NOX_upperlimits = Sv;


% --- Executes during object creation, after setting all properties.
function NOX_upperlimits_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NOX_upperlimits_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NOX_lowerlimits_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to NOX_lowerlimits_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles NOX_lowerlimits
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.NOX_lowerlimits,'String',num2str(Sv));
NOX_lowerlimits = Sv;

% --- Executes during object creation, after setting all properties.
function NOX_lowerlimits_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NOX_lowerlimits_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
