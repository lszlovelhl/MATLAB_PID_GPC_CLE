function varargout = alarmset2(varargin)
% ALARMSET2 MATLAB code for alarmset2.fig
%      ALARMSET2, by itself, creates a new ALARMSET2 or raises the existing
%      singleton*.
%
%      H = ALARMSET2 returns the handle to a new ALARMSET2 or the handle to
%      the existing singleton*.
%
%      ALARMSET2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALARMSET2.M with the given input arguments.
%
%      ALARMSET2('Property','Value',...) creates a new ALARMSET2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before alarmset2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to alarmset2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help alarmset2

% Last Modified by GUIDE v2.5 28-Nov-2019 21:19:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @alarmset2_OpeningFcn, ...
                   'gui_OutputFcn',  @alarmset2_OutputFcn, ...
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


% --- Executes just before alarmset2 is made visible.
function alarmset2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to alarmset2 (see VARARGIN)

% Choose default command line output for alarmset2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame');
figFrame.setFigureIcon(newIcon);
% UIWAIT makes alarmset2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global airpressupperlimit airpresslowerlimit
%%这里的代码只是为了遵循matlab渲染滑动条规则而给个在max/min范围的初始值
set(handles.text11,'String',airpressupperlimit);
set(handles.slider1,'Value',airpressupperlimit);

set(handles.text12,'String',airpresslowerlimit);
set(handles.slider2,'Value',airpresslowerlimit);

set(handles.text25,'String',airpressupperlimit);
set(handles.slider7,'Value',airpressupperlimit);

set(handles.text26,'String',airpresslowerlimit);
set(handles.slider8,'Value',airpresslowerlimit);


% --- Outputs from this function are returned to the command line.
function varargout = alarmset2_OutputFcn(hObject, eventdata, handles) 
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
global pophandles2 airpressupperlimit
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles2.text11,'String',num2str(Sv));
airpressupperlimit = Sv;

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
global pophandles2 airpresslowerlimit
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles2.text12,'String',num2str(Sv));
airpresslowerlimit = Sv;

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
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
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
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles2 gaspressupperlimit
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles2.text25,'String',num2str(Sv));
gaspressupperlimit = Sv;

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
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pophandles2 gaspresslowerlimit
a=get(hObject,'Value');%获取滑块当前值
b=round(a*100);
Sv=b/100;
set(hObject,'Value',Sv);
set(pophandles2.text26,'String',num2str(Sv));
gaspresslowerlimit = Sv;

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
