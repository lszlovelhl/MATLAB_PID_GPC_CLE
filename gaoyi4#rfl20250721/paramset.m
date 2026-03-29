function varargout = paramset(varargin)
% PARAMSET MATLAB code for paramset.fig
%      PARAMSET, by itself, creates a new PARAMSET or raises the existing
%      singleton*.
%
%      H = PARAMSET returns the handle to a new PARAMSET or the handle to
%      the existing singleton*.
%
%      PARAMSET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMSET.M with the given input arguments.
%
%      PARAMSET('Property','Value',...) creates a new PARAMSET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before paramset_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to paramset_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help paramset

% Last Modified by GUIDE v2.5 20-Feb-2022 15:45:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paramset_OpeningFcn, ...
                   'gui_OutputFcn',  @paramset_OutputFcn, ...
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


% --- Executes just before paramset is made visible.
function paramset_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to paramset (see VARARGIN)

% Choose default command line output for paramset
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); 
figFrame.setFigureIcon(newIcon); 
% UIWAIT makes paramset wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global paramdata

mid_1 = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.gdwddef;        %炉顶温度初始化
set(handles.text2,'String',mid_1);
set(handles.slider1,'Value',mid_1);
set(handles.slider1,'Max',1440,'Min',1240);
set(handles.slider1,'SliderStep',[1/200,2/200]);

mid_2 = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.gdwddef;
set(handles.text3,'String',mid_2);
set(handles.slider2,'Value',mid_2);
set(handles.slider2,'Max',1440,'Min',1240);
set(handles.slider2,'SliderStep',[1/200,2/200]);

mid_3 = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.gdwddef;
set(handles.text4,'String',mid_3);
set(handles.slider3,'Value',mid_3);
set(handles.slider3,'Max',1440,'Min',1240);
set(handles.slider3,'SliderStep',[1/200,2/200]);

mid_4 = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.slsjdef;         %烧炉时间初始化
set(handles.text9,'String',mid_4);
set(handles.slider4,'Value',mid_4);
set(handles.slider4,'Max',150,'Min',0);
set(handles.slider4,'SliderStep',[1/150,2/150]);

mid_5 = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.slsjdef;
set(handles.text10,'String',mid_5);
set(handles.slider5,'Value',mid_5);
set(handles.slider5,'Max',150,'Min',0);
set(handles.slider5,'SliderStep',[1/150,2/150]);

mid_6 = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.slsjdef;
set(handles.text11,'String',mid_6);
set(handles.slider6,'Value',mid_6);
set(handles.slider6,'Max',150,'Min',0);
set(handles.slider6,'SliderStep',[1/150,2/150]);

mid_9 = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.mqlllower; %煤气流量下限初始化
set(handles.text17,'String',mid_9);
set(handles.slider9,'Value',mid_9);
set(handles.slider9,'Max',30000,'Min',10000);
set(handles.slider9,'SliderStep',[1/20000,10/20000]);

mid_10 = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.mqlllower;  %煤气流量下限初始化
set(handles.text16,'String',mid_10);
set(handles.slider7,'Value',mid_10);
set(handles.slider7,'Max',30000,'Min',10000);
set(handles.slider7,'SliderStep',[1/20000,10/20000]);

mid_11 = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.mqlllower; %煤气流量下限初始化
set(handles.text20,'String',mid_11);
set(handles.slider8,'Value',mid_11);
set(handles.slider8,'Max',30000,'Min',10000);
set(handles.slider8,'SliderStep',[1/20000,10/20000]);

mid_15 = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmid; %废气温度调节
set(handles.text25,'String',mid_15);
set(handles.slider13,'Value',mid_15);
set(handles.slider13,'Max',400,'Min',230);
set(handles.slider13,'SliderStep',[1/170,2/170]);

mid_16 = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmid;
set(handles.text26,'String',mid_16);
set(handles.slider14,'Value',mid_16);
set(handles.slider14,'Max',400,'Min',230);
set(handles.slider14,'SliderStep',[1/170,2/170]);

mid_17 = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmid;
set(handles.text27,'String',mid_17);
set(handles.slider15,'Value',mid_17);
set(handles.slider15,'Max',400,'Min',230);
set(handles.slider15,'SliderStep',[1/170,2/170]);

mid_12 = paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmax;
set(handles.text22,'String',mid_12);
set(handles.slider10,'Value',mid_12);
set(handles.slider10,'Max',500,'Min',320);
set(handles.slider10,'SliderStep',[1/180,2/180]);

mid_13 = paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmax; 
set(handles.text23,'String',mid_13);
set(handles.slider11,'Value',mid_13);
set(handles.slider11,'Max',500,'Min',320);
set(handles.slider11,'SliderStep',[1/180,2/180]);

mid_14 = paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmax; 
set(handles.text24,'String',mid_14);
set(handles.slider12,'Value',mid_14);
set(handles.slider12,'Max',500,'Min',320);
set(handles.slider12,'SliderStep',[1/180,2/180]);

mid_8 = paramdata.commdata(1).parameter(2).ATTRIBUTE.zrkqyldef;%助燃风主管压力初始化
set(handles.text30,'String',mid_8);
set(handles.slider16,'Value',mid_8);
set(handles.slider16,'Max',20,'Min',0);
set(handles.slider16,'SliderStep',[0.5/20,1/20]);

mid_9 = paramdata.commdata(1).parameter(2).ATTRIBUTE.mqgwyldef;%煤气管网压力初始化
set(handles.text36,'String',mid_9);
set(handles.slider17,'Value',mid_9);
set(handles.slider17,'Max',20,'Min',0);
set(handles.slider17,'SliderStep',[0.5/20,1/20]);

%设置换炉顺序
popmenuswitchorder1 = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder1;
popmenuswitchorder2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder2;
popmenuswitchorder3 = paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder3;
set(handles.popupmenu1,'Value',popmenuswitchorder1);
set(handles.popupmenu2,'Value',popmenuswitchorder2);
set(handles.popupmenu3,'Value',popmenuswitchorder3);


krb1 = paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1;         %空燃比
set(handles.text45,'String',krb1);
set(handles.slider18,'Value',krb1);
set(handles.slider18,'Max',1,'Min',0.4);
set(handles.slider18,'SliderStep',[0.01/0.6,0.02/0.6]);

krb2 = paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1;
set(handles.text46,'String',krb2);
set(handles.slider19,'Value',krb2);
set(handles.slider19,'Max',1,'Min',0.4);
set(handles.slider19,'SliderStep',[0.01/0.6,0.02/0.6]);

krb3 = paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1;
set(handles.text47,'String',krb3);
set(handles.slider20,'Value',krb3);
set(handles.slider20,'Max',1,'Min',0.4);
set(handles.slider20,'SliderStep',[0.01/0.6,0.02/0.6]);

% --- Outputs from this function are returned to the command line.
function varargout = paramset_OutputFcn(hObject, eventdata, handles) 
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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.text2,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.text3,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);

set(handles.text4,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text9,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text10,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text11,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text16,'String',num2str(slide_value));

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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text20,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
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
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text17,'String',num2str(slide_value));

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
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text22,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text23,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text24,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text25,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text26,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text27,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
 slide_value=roundn(a,-1);
set(hObject,'Value',slide_value);
set(handles.text30,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata wendu_max1 wendu_max2 wendu_max3  wendu_middle1 wendu_middle2 wendu_middle3
global time1_set time2_set time3_set  ts1 ts2 ts3 gas_lower1 gas_lower2 gas_lower3 air_pressure
global apcguiHandles gas_pressure popmenuswitchorder default_airgaspotial

popmemuswitch1 = get(handles.popupmenu1,'Value');
popmemuswitch2 = get(handles.popupmenu2,'Value');
popmemuswitch3 = get(handles.popupmenu3,'Value');
% if popmemuswitch1 == popmemuswitch2 || popmemuswitch1 == popmemuswitch3 || popmemuswitch2 == popmemuswitch3
%     msgbox('换炉顺序设置有误，请重新设置再保存！');
if ~((popmemuswitch1 == 1 && popmemuswitch2== 2&&popmemuswitch3 ==3)||(popmemuswitch1 == 3 && popmemuswitch2== 2&&popmemuswitch3 ==1))
    msgbox('换炉顺序设置有误，请重新设置成:1# 2# 3# 或者 3# 2# 1# 再保存！');

else
    %拱顶温度
    paramdata.furnacetype(1).parameter(2).ATTRIBUTE.gdwddef = str2double(get(handles.text2,'String'));
    paramdata.furnacetype(2).parameter(2).ATTRIBUTE.gdwddef = str2double(get(handles.text3,'String'));
    paramdata.furnacetype(3).parameter(2).ATTRIBUTE.gdwddef = str2double(get(handles.text4,'String'));

    %烧炉时间
    paramdata.furnacetype(1).parameter(2).ATTRIBUTE.slsjdef = str2double(get(handles.text9,'String'));
    paramdata.furnacetype(2).parameter(2).ATTRIBUTE.slsjdef = str2double(get(handles.text10,'String'));
    paramdata.furnacetype(3).parameter(2).ATTRIBUTE.slsjdef = str2double(get(handles.text11,'String'));

    %煤气流量下限
    paramdata.furnacetype(1).parameter(2).ATTRIBUTE.mqlllower = str2double(get(handles.text17,'String'));
    paramdata.furnacetype(2).parameter(2).ATTRIBUTE.mqlllower = str2double(get(handles.text16,'String'));
    paramdata.furnacetype(3).parameter(2).ATTRIBUTE.mqlllower = str2double(get(handles.text20,'String'));

    %废气温度中值
    paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmid = str2double(get(handles.text25,'String'));
    paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmid = str2double(get(handles.text26,'String'));
    paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmid = str2double(get(handles.text27,'String'));

    %废气温度最大值
    paramdata.furnacetype(1).parameter(2).ATTRIBUTE.fqwdmax = str2double(get(handles.text22,'String'));
    paramdata.furnacetype(2).parameter(2).ATTRIBUTE.fqwdmax = str2double(get(handles.text23,'String'));
    paramdata.furnacetype(3).parameter(2).ATTRIBUTE.fqwdmax = str2double(get(handles.text24,'String'));

    %助燃空气压力
    paramdata.commdata(1).parameter(2).ATTRIBUTE.zrkqyldef = str2double(get(handles.text30,'String'));

    %煤气管网压力
    paramdata.commdata(1).parameter(2).ATTRIBUTE.mqgwyldef = str2double(get(handles.text36,'String'));
    
    %设置换炉顺序
    paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder1 = popmemuswitch1;
    paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder2 = popmemuswitch2;
    paramdata.commdata(1).parameter(3).ATTRIBUTE.popmenuswitchorder3 = popmemuswitch3;
    
    %默认空燃比
    paramdata.furnacetype(1).parameter(1).ATTRIBUTE.kongranbi1_1 = str2double(get(handles.text45,'String'));
    paramdata.furnacetype(2).parameter(1).ATTRIBUTE.kongranbi2_1 = str2double(get(handles.text46,'String'));
    paramdata.furnacetype(3).parameter(1).ATTRIBUTE.kongranbi3_1 = str2double(get(handles.text47,'String'));

    wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
    xml_write('parament_set.xml',paramdata,'paramdata',wPref);

    ts1 = str2double(get(handles.text2,'String'));
    ts2 = str2double(get(handles.text3,'String'));
    ts3 = str2double(get(handles.text4,'String'));
    time1_set = str2double(get(handles.text9,'String'));
    time2_set = str2double(get(handles.text10,'String'));
    time3_set = str2double(get(handles.text11,'String'));
    gas_lower1 = str2double(get(handles.text17,'String'));
    gas_lower2 = str2double(get(handles.text16,'String'));
    gas_lower3 = str2double(get(handles.text20,'String'));
    wendu_middle1=str2double(get(handles.text25,'String'));
    wendu_middle2=str2double(get(handles.text26,'String'));
    wendu_middle3=str2double(get(handles.text27,'String'));
    wendu_max1 = str2double(get(handles.text22,'String'));
    wendu_max2 = str2double(get(handles.text23,'String'));
    wendu_max3 = str2double(get(handles.text24,'String'));
    air_pressure = str2double(get(handles.text30,'String'));
    gas_pressure = str2double(get(handles.text36,'String'));
    popmenuswitchorder(1) = popmemuswitch1;
    popmenuswitchorder(2) = popmemuswitch2;
    popmenuswitchorder(3) = popmemuswitch3;
    
    default_airgaspotial(1) = str2double(get(handles.text45,'String'));
    default_airgaspotial(2) = str2double(get(handles.text46,'String'));
    default_airgaspotial(3) = str2double(get(handles.text47,'String'));

    set(apcguiHandles.ts1,'String',num2str(ts1));
    set(apcguiHandles.ts2,'String',num2str(ts2));
    set(apcguiHandles.ts3,'String',num2str(ts3));

    set(apcguiHandles.time1,'String',num2str(time1_set));
    set(apcguiHandles.time2,'String',num2str(time2_set));
    set(apcguiHandles.time3,'String',num2str(time3_set));

    set(apcguiHandles.gas_lower1,'String',num2str(gas_lower1));
    set(apcguiHandles.gas_lower2,'String',num2str(gas_lower2));
    set(apcguiHandles.gas_lower3,'String',num2str(gas_lower3));

    set(apcguiHandles.wendu_middle1,'String',num2str(wendu_middle1));
    set(apcguiHandles.wendu_middle2,'String',num2str(wendu_middle2));
    set(apcguiHandles.wendu_middle3,'String',num2str(wendu_middle3));

    set(apcguiHandles.wendu_max1,'String',num2str(wendu_max1));
    set(apcguiHandles.wendu_max2,'String',num2str(wendu_max2));
    set(apcguiHandles.wendu_max3,'String',num2str(wendu_max3));

    set(apcguiHandles.air_pressure,'String',num2str(air_pressure));
    set(apcguiHandles.text187,'String',num2str(gas_pressure));
    
    curhuanlusx = [num2str(popmenuswitchorder(1)) '#' ' ' num2str(popmenuswitchorder(2)) '#' ' ' num2str(popmenuswitchorder(3)) '#'];
    set(apcguiHandles.text192,'String',curhuanlusx);
    msgbox('                 保存成功','Save');
    delete(handles.figure1);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(hObject,'Value');%获取滑块当前值
slide_value=roundn(a,-1);
set(hObject,'Value',slide_value);
set(handles.text36,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% global popmenuswitchorder
val = get(hObject,'Value');
% popmenuswitchorder(1) = val;
% paramlist = get(hObject,'String');
% strval = paramlist{val};
% disp([num2str(val) ':' strval]);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
% global popmenuswitchorder
val = get(hObject,'Value');
% popmenuswitchorder(2) = val;
% paramlist = get(hObject,'String');
% strval = paramlist{val};
% disp([num2str(val) ':' strval]);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
% global popmenuswitchorder
val = get(hObject,'Value');
% popmenuswitchorder(1) = val;
% paramlist = get(hObject,'String');
% strval = paramlist{val};
% disp([num2str(val) ':' strval]);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slide_value=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text45,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slide_value=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text46,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slide_value=get(hObject,'Value');%获取滑块当前值
% slide_value=round(a);
set(hObject,'Value',slide_value);
set(handles.text47,'String',num2str(slide_value));

% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
