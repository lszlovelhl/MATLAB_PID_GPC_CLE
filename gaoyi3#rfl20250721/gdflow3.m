function varargout = gdflow(varargin)
% GDFLOW MATLAB code for gdflow.fig
%      GDFLOW, by itself, creates a new GDFLOW or raises the existing
%      singleton*.
%
%      H = GDFLOW returns the handle to a new GDFLOW or the handle to
%      the existing singleton*.
%
%      GDFLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GDFLOW.M with the given input arguments.
%
%      GDFLOW('Property','Value',...) creates a new GDFLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gdflow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gdflow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gdflow

% Last Modified by GUIDE v2.5 02-Sep-2024 20:26:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gdflow_OpeningFcn, ...
                   'gui_OutputFcn',  @gdflow_OutputFcn, ...
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


% --- Executes just before gdflow is made visible.
function gdflow_OpeningFcn(hObject, eventdata, handles, varargin)
global gd_gas3 gas_lower3  paramdata
gd_gas3_max = paramdata.commdata(1).parameter(2).ATTRIBUTE.gd_gas3_max;

set(handles.text2,'String',gd_gas3);
set(handles.slider1,'Value',gd_gas3);
set(handles.slider1,'Max',gd_gas3_max,'Min',gas_lower3);
set(handles.slider1,'SliderStep',[1000/(gd_gas3_max-gas_lower3),5000/(gd_gas3_max-gas_lower3)]);



% Choose default command line output for gdflow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gdflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gdflow_OutputFcn(hObject, eventdata, handles) 
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
slide_value=get(hObject,'Value');%获取滑块当前值
set(hObject,'Value',slide_value);
set(handles.text2,'String',num2str(slide_value));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
global burning autoswitch daobj autoshaolu gap_on gd_gas3
if burning(3) == 1&&strcmp(daobj.Status,'connected')
    gd_gas3 = str2double(get(handles.text2,'String'));
    set(handles.text2,'String',gd_gas3);
    set(handles.slider1,'Value',gd_gas3);
    if temp_open(3)==0    
     left_time(3)=-1;
    end
    temp_open(3)=1;
    max_burning(3)=1;
    min_burning(3)=0;
    a_write=[0 0 1];
    max_min_timeFlag(3)=90;
    pidloop(10,3)=0;          %1#炉打开自动控制        
    pidloop(10,6)=0;
    delete(handles.figure1);
end
if strcmp(daobj.Status,'disconnected')
    msgbox('中控未连接！');    
end
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
