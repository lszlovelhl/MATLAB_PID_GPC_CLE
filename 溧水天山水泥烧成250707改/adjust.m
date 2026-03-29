function varargout = adjust(varargin)
% ADJUST MATLAB code for adjust.fig
%      ADJUST, by itself, creates a new ADJUST or raises the existing
%      singleton*.
%
%      H = ADJUST returns the handle to a new ADJUST or the handle to
%      the existing singleton*.
%
%      ADJUST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADJUST.M with the given input arguments.
%
%      ADJUST('Property','Value',...) creates a new ADJUST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before adjust_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to adjust_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help adjust

% Last Modified by GUIDE v2.5 23-Apr-2023 11:38:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @adjust_OpeningFcn, ...
                   'gui_OutputFcn',  @adjust_OutputFcn, ...
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


% --- Executes just before adjust is made visible.
function adjust_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to adjust (see VARARGIN)

% Choose default command line output for adjust
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes adjust wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%global 变量
global  paramdata blj_a1 blj_lmd1 blj_a2  blj_lmd2 toumei_p toumei_i toumei_d douti_p1 douti_i1 douti_d1 fjl_a0 fjl_b0 fjl_a1 fjl_b1
global toupai_i1 toupai_p1 toupai_d1 gwfj_p gwfj_i gwfj_d
%% xml读取数据
paramdata = xml_read('param_set.xml');
fjl_a0 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha1;
fjl_b0 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda1;
fjl_a1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2;
fjl_b1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2;
blj_a1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a1;
blj_lmd1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd1;
blj_a2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a2;
blj_lmd2 = paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd2;

douti_p1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_alpha;
douti_i1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_beta;
douti_d1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_gamma;

toumei_p = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha;
toumei_i = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta;
toumei_d = paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_gamma;

toupai_p1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_alpha;
toupai_i1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_beta;
toupai_d1 = paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_gamma;

gwfj_p = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_alpha;
gwfj_i = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_beta;
gwfj_d = paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_gamma;


%% 初值设定
%分解炉
set(handles.fjl_alpha1,'String',fjl_a0);
set(handles.fjl_alpha1_slider,'Value',fjl_a0);
set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda1,'String',fjl_b0);
set(handles.fjl_lambda1_slider,'Value',fjl_b0);
set(handles.fjl_lambda1_slider,'Max',8000,'Min',0);
set(handles.fjl_lambda1_slider,'SliderStep',[10/8000,100/8000]);

set(handles.fjl_alpha2,'String',fjl_a1);
set(handles.fjl_alpha2_slider,'Value',fjl_a1);
set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda2,'String',fjl_b1);
set(handles.fjl_lambda2_slider,'Value',fjl_b1);
set(handles.fjl_lambda2_slider,'Max',10000,'Min',0);
set(handles.fjl_lambda2_slider,'SliderStep',[10/10000,100/10000]);

%篦冷机回路
set(handles.blj_a1,'String',blj_a1);
set(handles.blj_a1_slider,'Value',blj_a1);
set(handles.blj_a1_slider,'Max',2,'Min',0.9);
set(handles.blj_a1_slider,'SliderStep',[0.001/1.1,0.01/1.1]);

set(handles.blj_lmd1,'String',blj_lmd1);
set(handles.blj_lmd1_slider,'Value',blj_lmd1);
set(handles.blj_lmd1_slider,'Max',10000,'Min',0);
set(handles.blj_lmd1_slider,'SliderStep',[10/10000,100/10000]);

set(handles.blj_a2,'String',blj_a2);
set(handles.blj_a2_slider,'Value',blj_a2);
set(handles.blj_a2_slider,'Max',2,'Min',0.9);
set(handles.blj_a2_slider,'SliderStep',[0.001/1.1,0.01/1.1]);

set(handles.blj_lmd2,'String',blj_lmd2);
set(handles.blj_lmd2_slider,'Value',blj_lmd2);
set(handles.blj_lmd2_slider,'Max',10000,'Min',0);
set(handles.blj_lmd2_slider,'SliderStep',[10/10000,100/10000]);



%头煤压力
set(handles.toumei_p,'String',toumei_p);
set(handles.toumei_p_slider,'Value',toumei_p);
set(handles.toumei_p_slider,'Max',1,'Min',0);
set(handles.toumei_p_slider,'SliderStep',[0.001/1,0.01/1]);

set(handles.toumei_i,'String',toumei_i);
set(handles.toumei_i_slider,'Value',toumei_i);
set(handles.toumei_i_slider,'Max',500,'Min',0);
set(handles.toumei_i_slider,'SliderStep',[1/500,5/500]);


%斗提电流控制回路
set(handles.douti_p1,'String',douti_p1);
set(handles.douti_p1_slider,'Value',douti_p1);
set(handles.douti_p1_slider,'Max',1,'Min',0);
set(handles.douti_p1_slider,'SliderStep',[0.001/1,0.01/1]);

set(handles.douti_i1,'String',douti_i1);
set(handles.douti_i1_slider,'Value',douti_i1);
set(handles.douti_i1_slider,'Max',500,'Min',0);
set(handles.douti_i1_slider,'SliderStep',[1/500,5/500]);


%头排风机
set(handles.toupai_p1,'String',toupai_p1);
set(handles.toupai_p1_slider,'Value',toupai_p1);
set(handles.toupai_p1_slider,'Max',1,'Min',0);
set(handles.toupai_p1_slider,'SliderStep',[0.0001/1,0.005/1]);

set(handles.toupai_i1,'String',toupai_i1);
set(handles.toupai_i1_slider,'Value',toupai_i1);
set(handles.toupai_i1_slider,'Max',500,'Min',0);
set(handles.toupai_i1_slider,'SliderStep',[1/500,5/500]);

%高温风机
set(handles.gwfj_p,'String',gwfj_p);
set(handles.gwfj_p_slider,'Value',gwfj_p);
set(handles.gwfj_p_slider,'Max',1,'Min',0);
set(handles.gwfj_p_slider,'SliderStep',[0.0001/1,0.005/1]);

set(handles.gwfj_i,'String',gwfj_i);
set(handles.gwfj_i_slider,'Value',gwfj_i);
set(handles.gwfj_i_slider,'Max',500,'Min',0);
set(handles.gwfj_i_slider,'SliderStep',[1/500,5/500]);


newIcon = javax.swing.ImageIcon('EnvieoICON.png');
figFrame = get(handles.figure1,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
% --- Outputs from this function are returned to the command line.
function varargout = adjust_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata  toupai_p1 toupai_i1 toupai_d1 gwfj_p gwfj_i gwfj_d
global blj_a1 blj_lmd1 blj_a2  blj_lmd2 toumei_p toumei_i toumei_d douti_p1 douti_i1 douti_d1 fjl_a0 fjl_b0 fjl_a1 fjl_b1



paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha1 = fjl_a0;
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda1 = fjl_b0;
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2 = fjl_a1;
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2 = fjl_b1;

paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a1 = blj_a1;
paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd1 = blj_lmd1;
paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_a2 = blj_a2;
paramdata.commdata(1).parameter(2).ATTRIBUTE.blj_lmd2 = blj_lmd2;

paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_alpha = douti_p1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.dtdl_beta = douti_i1;

paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_alpha = toumei_p;
paramdata.commdata(1).parameter(5).ATTRIBUTE.tm_beta = toumei_i;

paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_alpha = toupai_p1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.yt_beta = toupai_i1;

paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_alpha = gwfj_p;
paramdata.commdata(1).parameter(9).ATTRIBUTE.gwfj_beta = gwfj_i;

wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
delete(handles.figure1);



% --- Executes on slider movement.
function toumei_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global toumei_p
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.3f';
set(handles.toumei_p,'String',num2str(a,formatSpec));
toumei_p=str2double(get(handles.toumei_p,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global toumei_i
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.toumei_i,'String',num2str(a,formatSpec));
toumei_i=str2double(get(handles.toumei_i,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ydl_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toumei_d,'String',num2str(a,formatSpec));
ydl_d1=str2double(get(handles.toumei_d,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_alpha1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_a0
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.fjl_alpha1,'String',num2str(a,formatSpec));
fjl_a0=str2double(get(handles.fjl_alpha1,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_alpha1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_alpha1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_lambda1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_lambda1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_b0
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.0f';
set(handles.fjl_lambda1,'String',num2str(a,formatSpec));
fjl_b0=str2double(get(handles.fjl_lambda1,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_lambda1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_lambda1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
function fjl_alpha2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_a1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.fjl_alpha2,'String',num2str(a,formatSpec));
fjl_a1=str2double(get(handles.fjl_alpha2,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_alpha2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_alpha2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fjl_lambda2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fjl_lambda2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fjl_b1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.0f';
set(handles.fjl_lambda2,'String',num2str(a,formatSpec));
fjl_b1=str2double(get(handles.fjl_lambda2,'String'));

% --- Executes during object creation, after setting all properties.
function fjl_lambda2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fjl_lambda2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_a1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_a1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_a1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.blj_a1,'String',num2str(a,formatSpec));
blj_a1=str2double(get(handles.blj_a1,'String'));

% --- Executes during object creation, after setting all properties.
function blj_a1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_a1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_lmd1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_lmd1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_lmd1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.0f';
set(handles.blj_lmd1,'String',num2str(a,formatSpec));
blj_lmd1=str2double(get(handles.blj_lmd1,'String'));

% --- Executes during object creation, after setting all properties.
function blj_lmd1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_lmd1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdwai_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdwai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pdwai_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.pdwai_d1,'String',num2str(a,formatSpec));
pdwai_gamma1=str2double(get(handles.pdwai_d1,'String'));

% --- Executes during object creation, after setting all properties.
function pdwai_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdwai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_a2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_a2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_a2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%5.4f';
set(handles.blj_a2,'String',num2str(a,formatSpec));
blj_a2=str2double(get(handles.blj_a2,'String'));

% --- Executes during object creation, after setting all properties.
function blj_a2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_a2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_lmd2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_lmd2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global blj_lmd2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%.0f';
set(handles.blj_lmd2,'String',num2str(a,formatSpec));
blj_lmd2=str2double(get(handles.blj_lmd2,'String'));

% --- Executes during object creation, after setting all properties.
function blj_lmd2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_lmd2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdwai_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdwai_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdwai_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdwai_d2,'String',num2str(a,formatSpec));
pdwai_gamma2=str2double(get(handles.pdwai_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdwai_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdwai_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_alpha3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p3,'String',num2str(a,formatSpec));
temp_blj_alpha3=str2double(get(handles.blj_p3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_p3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_beta3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i3,'String',num2str(a,formatSpec));
temp_blj_beta3=str2double(get(handles.blj_i3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_i3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_d3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_gamma3
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d3,'String',num2str(a,formatSpec));
temp_blj_gamma3=str2double(get(handles.blj_d3,'String'));

% --- Executes during object creation, after setting all properties.
function blj_d3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.douti_p1,'String',num2str(a,formatSpec));
douti_p1=str2double(get(handles.douti_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.douti_i1,'String',num2str(a,formatSpec));
douti_i1=str2double(get(handles.douti_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.douti_d1,'String',num2str(a,formatSpec));
douti_d1=str2double(get(handles.douti_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_p
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.gwfj_p,'String',num2str(a,formatSpec));
gwfj_p=str2double(get(handles.gwfj_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_i
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.gwfj_i,'String',num2str(a,formatSpec));
gwfj_i=str2double(get(handles.gwfj_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gwfj_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gwfj_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.gwfj_d,'String',num2str(a,formatSpec));
gwfj_gamma=str2double(get(handles.gwfj_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gwfj_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider40_Callback(hObject, eventdata, handles)
% hObject    handle to slider40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider41_Callback(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider42_Callback(hObject, eventdata, handles)
% hObject    handle to slider42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider43_Callback(hObject, eventdata, handles)
% hObject    handle to slider43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider44_Callback(hObject, eventdata, handles)
% hObject    handle to slider44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider45_Callback(hObject, eventdata, handles)
% hObject    handle to slider45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p1,'String',num2str(a,formatSpec));
temp_blj_alpha1=str2double(get(handles.blj_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i1,'String',num2str(a,formatSpec));
temp_blj_beta1=str2double(get(handles.blj_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d1,'String',num2str(a,formatSpec));
temp_blj_gamma1=str2double(get(handles.blj_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.blj_p2,'String',num2str(a,formatSpec));
temp_blj_alpha2=str2double(get(handles.blj_p2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.blj_i2,'String',num2str(a,formatSpec));
temp_blj_beta2=str2double(get(handles.blj_i2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function set_default_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function save_state_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function blj_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_blj_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d2,'String',num2str(a,formatSpec));
temp_blj_gamma2=str2double(get(handles.blj_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function blj_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_p1,'String',num2str(a,formatSpec));
pdnei_alpha1=str2double(get(handles.pdnei_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.pdnei_i1,'String',num2str(a,formatSpec));
pdnei_beta1=str2double(get(handles.pdnei_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.pdnei_d1,'String',num2str(a,formatSpec));
pdnei_gamma1=str2double(get(handles.pdnei_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_p2,'String',num2str(a,formatSpec));
pdnei_alpha2=str2double(get(handles.pdnei_p2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.pdnei_i2,'String',num2str(a,formatSpec));
pdnei_beta2=str2double(get(handles.pdnei_i2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pdnei_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to pdnei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pdnei_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.pdnei_d2,'String',num2str(a,formatSpec));
pdnei_gamma2=str2double(get(handles.pdnei_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pdnei_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pdnei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_p1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toupai_p1,'String',num2str(a,formatSpec));
toupai_p1=str2double(get(handles.toupai_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_i1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3d';
set(handles.toupai_i1,'String',num2str(a,formatSpec));
toupai_i1=str2double(get(handles.toupai_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toupai_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toupai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global toupai_d1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.toupai_d1,'String',num2str(a,formatSpec));
toupai_d1=str2double(get(handles.toupai_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toupai_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toupai_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider88_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider88_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider89_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider89_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider90_Callback(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider90_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gwfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
