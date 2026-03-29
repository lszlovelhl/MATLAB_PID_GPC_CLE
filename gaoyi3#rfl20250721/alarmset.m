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

% Last Modified by GUIDE v2.5 11-Jan-2019 22:34:26

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
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); 
figFrame.setFigureIcon(newIcon); 
% UIWAIT makes alarmset wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global identifier FQTmpupperlimitS FQTmplowerlimitS GDupperlimitS GDlowerlimitS
%%这里的代码只是为了遵循matlab渲染滑动条规则而给个在max/min范围的初始值
set(handles.text12,'String',GDupperlimitS(identifier));
set(handles.slider1,'Value',GDupperlimitS(identifier));
% set(handles.slider1,'Max',UpTmpupperMax(identifier),'Min',UpTmpupperMin(identifier));
% set(handles.slider1,'SliderStep',[1/(UpTmpupperMax(identifier)-UpTmpupperMin(identifier)),2/(UpTmpupperMax(identifier)-UpTmpupperMin(identifier))]);

set(handles.text13,'String',GDlowerlimitS(identifier));
set(handles.slider2,'Value',GDlowerlimitS(identifier));
% set(handles.slider2,'Max',DownTmplowerMax(identifier),'Min',DownTmplowerMin(identifier));
% set(handles.slider2,'SliderStep',[1/(DownTmplowerMax(identifier)-DownTmplowerMin(identifier)),2/(DownTmplowerMax(identifier)-DownTmplowerMin(identifier))]);

set(handles.text14,'String',FQTmpupperlimitS(identifier));
set(handles.slider4,'Value',FQTmpupperlimitS(identifier));
% set(handles.slider4,'Max',CoalHeightupperMax(identifier),'Min',CoalHeightupperMin(identifier));
% set(handles.slider4,'SliderStep',[0.05/(CoalHeightupperMax(identifier)-CoalHeightupperMin(identifier)),0.1/(CoalHeightupperMax(identifier)-CoalHeightupperMin(identifier))]);

set(handles.text15,'String',FQTmplowerlimitS(identifier));
set(handles.slider5,'Value',FQTmplowerlimitS(identifier));
% set(handles.slider5,'Max',CoalHeightlowerMax(identifier),'Min',CoalHeightlowerMin(identifier));
% set(handles.slider5,'SliderStep',[0.05/(CoalHeightlowerMax(identifier)-CoalHeightlowerMin(identifier)),0.1/(CoalHeightlowerMax(identifier)-CoalHeightlowerMin(identifier))]);

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
global pophandles GDupperlimitS identifier
a = get(hObject,'Value');%获取滑块当前值
b = round(a*10);
Sv = round(b/10);
set(hObject,'Value',Sv);
set(pophandles.text12,'String',num2str(Sv));
GDupperlimitS(identifier) = Sv; 


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
global pophandles GDlowerlimitS identifier
a = get(hObject,'Value');%获取滑块当前值
b = round(a*10);
Sv = round(b/10);
set(hObject,'Value',Sv);
set(pophandles.text13,'String',num2str(Sv));
GDlowerlimitS(identifier) = Sv;

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
global pophandles FQTmpupperlimitS identifier
a = get(hObject,'Value');%获取滑块当前值
b = round(a*100);
Sv = b/100;
set(hObject,'Value',Sv);
set(pophandles.text14,'String',num2str(Sv));
FQTmpupperlimitS(identifier) = Sv;


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
global pophandles FQTmplowerlimitS identifier
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles.text15,'String',num2str(Sv));
FQTmplowerlimitS(identifier) = Sv;


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
