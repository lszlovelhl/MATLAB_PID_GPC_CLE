function varargout = gd_gas1(varargin)
% GD_GAS1 MATLAB code for gd_gas1.fig
%      GD_GAS1, by itself, creates a new GD_GAS1 or raises the existing
%      singleton*.
%
%      H = GD_GAS1 returns the handle to a new GD_GAS1 or the handle to
%      the existing singleton*.
%
%      GD_GAS1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GD_GAS1.M with the given input arguments.
%
%      GD_GAS1('Property','Value',...) creates a new GD_GAS1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gd_gas1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gd_gas1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gd_gas1

% Last Modified by GUIDE v2.5 09-Oct-2024 09:52:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gd_gas1_OpeningFcn, ...
                   'gui_OutputFcn',  @gd_gas1_OutputFcn, ...
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


% --- Executes just before gd_gas1 is made visible.
function gd_gas1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gd_gas1 (see VARARGIN)
global gd_gas2 gas_lower2 paramdata
gd_gas2_max = paramdata.commdata(1).parameter(2).ATTRIBUTE.gd_gas2_max;
set(handles.text2,'String',gd_gas2);
set(handles.slider1,'Value',gd_gas2);
set(handles.slider1,'Max',gd_gas2_max,'Min',gas_lower2);
set(handles.slider1,'SliderStep',[1000/(gd_gas2_max-gas_lower2),5000/(gd_gas2_max-gas_lower2)]);

% Choose default command line output for gd_gas1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gd_gas1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gd_gas1_OutputFcn(hObject, eventdata, handles) 
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
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global burning autoswitch daobj autoshaolu gap_on gd_gas2
global temp_open pidloop max_burning min_burning max_min_timeFlag a_write  left_time
if burning(2) == 1&&strcmp(daobj.Status,'connected')
    gd_gas2 = str2double(get(handles.text2,'String'));
    set(handles.text2,'String',gd_gas2);
    set(handles.slider1,'Value',gd_gas2);
    if temp_open(2)==0    
     left_time(2)=-1;
    end
    temp_open(2)=1;
    max_burning(2)=1;
    min_burning(2)=0;
    a_write=[0 1 0];
    max_min_timeFlag(2)=90;
    pidloop(10,2)=0;          %1#炉打开自动控制        
    pidloop(10,5)=0;
    delete(handles.figure1);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
