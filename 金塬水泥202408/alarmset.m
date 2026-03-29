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

% Last Modified by GUIDE v2.5 06-Jan-2022 13:43:13

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
global blj_lower_limit blj_upper_limit xialiao_left_lower_limit xialiao_left_upper_limit xialiao_right_upper_limit xialiao_right_lower_limit
global data b   tmmax tmmin

%赋初值


%%这里的代码只是为了遵循matlab渲染滑动条规则而给个在max/min范围的初始值




set(handles.blj_upper_limit,'String',blj_upper_limit);
set(handles.blj_upper,'Value',blj_upper_limit);
set(handles.blj_upper,'Max',blj_upper_limit+20,'Min',blj_upper_limit-20);
set(handles.blj_upper,'SliderStep',[1/40,5/40]);

set(handles.blj_lower_limit,'String',blj_lower_limit);
set(handles.blj_lower,'Value',blj_lower_limit);
set(handles.blj_lower,'Max',blj_lower_limit+20,'Min',blj_lower_limit-20);
set(handles.blj_lower,'SliderStep',[1/40,5/40]);

set(handles.tmmax,'String',tmmax);
set(handles.tmmax_slider,'Value',tmmax);
set(handles.tmmax_slider,'Max',tmmax+2.5,'Min',tmmax-2.5);
set(handles.tmmax_slider,'SliderStep',[0.1/5,1/5]);

set(handles.tmmin,'String',tmmin);
set(handles.tmmin_slider,'Value',tmmin);
set(handles.tmmin_slider,'Max',tmmin+2.5,'Min',tmmin-2.5);
set(handles.tmmin_slider,'SliderStep',[0.1/5,1/5]);

set(handles.xialiao_left_upper_limit,'String',xialiao_left_upper_limit);
set(handles.xialiao_left_upper,'Value',xialiao_left_upper_limit);
set(handles.xialiao_left_upper,'Max',950,'Min',870);
set(handles.xialiao_left_upper,'SliderStep',[1/80,10/80]);

set(handles.xialiao_left_lower_limit,'String',xialiao_left_lower_limit);
set(handles.xialiao_left_lower,'Value',xialiao_left_lower_limit);
set(handles.xialiao_left_lower,'Max',910,'Min',830);
set(handles.xialiao_left_lower,'SliderStep',[1/80,10/80]);

set(handles.xialiao_right_upper_limit,'String',xialiao_right_upper_limit);
set(handles.xialiao_right_upper,'Value',xialiao_right_upper_limit);
set(handles.xialiao_right_upper,'Max',0,'Min',-50);
set(handles.xialiao_right_upper,'SliderStep',[1/50,10/50]);

set(handles.xialiao_right_lower_limit,'String',xialiao_right_lower_limit);
set(handles.xialiao_right_lower,'Value',xialiao_right_lower_limit);
set(handles.xialiao_right_lower,'Max',-50,'Min',-150);
set(handles.xialiao_right_lower,'SliderStep',[1/100,10/100]);
% --- Outputs from this function are returned to the command line.
function varargout = alarmset_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function blj_upper_Callback(hObject, eventdata, handles)
% hObject    handle to blj_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_upper_limit
blj_upper_limit = get(hObject,'Value');%获取滑块当前值

Sv = (round(blj_upper_limit*10))/10;
set(handles.blj_upper_limit,'String',num2str(Sv));
% decomposing_furnace_tempr_2_upperlimitS= Sv; 


% --- Executes during object creation, after setting all properties.
function blj_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_lower_Callback(hObject, eventdata, handles)
% hObject    handle to blj_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_lower_limit
blj_lower_limit = get(hObject,'Value');%获取滑块当前值


Sv = (round(blj_lower_limit*10))/10;
set(handles.blj_lower_limit,'String',num2str(Sv));
% decomposing_furnace_tempr_2_upperlimitS= Sv; 


% --- Executes during object creation, after setting all properties.
function blj_lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xialiao_left_upper_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_left_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global xialiao_left_upper_limit
xialiao_left_upper_limit = get(hObject,'Value');%获取滑块当前值
b = round(xialiao_left_upper_limit*10);
Sv = round(b/10);
set(handles.xialiao_left_upper_limit,'String',num2str(Sv));
% decomposing_furnace_tempr_2_upperlimitS= Sv; 



% --- Executes during object creation, after setting all properties.
function xialiao_left_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_left_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xialiao_left_lower_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_left_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global xialiao_left_lower_limit
xialiao_left_lower_limit = get(hObject,'Value');%获取滑块当前值
b = round(xialiao_left_lower_limit*10);
Sv = round(b/10);
set(handles.xialiao_left_lower_limit,'String',num2str(Sv));
% decomposing_furnace_tempr_2_upperlimitS= Sv; 


% --- Executes during object creation, after setting all properties.
function xialiao_left_lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_left_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.


% --- Executes on slider movement.
function xialiao_right_upper_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_right_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global xialiao_right_upper_limit
xialiao_right_upper_limit = get(hObject,'Value');%获取滑块当前值
b = round(xialiao_right_upper_limit*10);
Sv = round(b/10);
set(handles.xialiao_right_upper_limit,'String',num2str(Sv));

% --- Executes during object creation, after setting all properties.
function xialiao_right_upper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_right_upper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xialiao_right_lower_Callback(hObject, eventdata, handles)
% hObject    handle to xialiao_right_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global xialiao_right_lower_limit
xialiao_right_lower_limit = get(hObject,'Value');%获取滑块当前值
b = round(xialiao_right_lower_limit*10);
Sv = round(b/10);
set(handles.xialiao_right_lower_limit,'String',num2str(Sv));

% --- Executes during object creation, after setting all properties.
function xialiao_right_lower_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xialiao_right_lower (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tmmax_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tmmax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tmmax
tmmax = get(hObject,'Value');%获取滑块当前值
b = round(tmmax*10);
Sv = round(b/10);
set(handles.tmmax,'String',num2str(Sv));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tmmax_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmmax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function tmmin_slider_Callback(hObject, eventdata, handles)
% hObject    handle to tmmin_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tmmin
tmmin = get(hObject,'Value');%获取滑块当前值
b = round(tmmin*10);
Sv = round(b/10);
set(handles.tmmin,'String',num2str(Sv));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function tmmin_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tmmin_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
