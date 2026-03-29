function varargout = zhuansu_man(varargin)
% ZHUANSU_MAN MATLAB code for zhuansu_man.fig
%      ZHUANSU_MAN, by itself, creates a new ZHUANSU_MAN or raises the existing
%      singleton*.
%
%      H = ZHUANSU_MAN returns the handle to a new ZHUANSU_MAN or the handle to
%      the existing singleton*.
%
%      ZHUANSU_MAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZHUANSU_MAN.M with the given input arguments.
%
%      ZHUANSU_MAN('Property','Value',...) creates a new ZHUANSU_MAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zhuansu_man_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zhuansu_man_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zhuansu_man

% Last Modified by GUIDE v2.5 18-Nov-2022 17:49:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zhuansu_man_OpeningFcn, ...
                   'gui_OutputFcn',  @zhuansu_man_OutputFcn, ...
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


% --- Executes just before zhuansu_man is made visible.
function zhuansu_man_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zhuansu_man (see VARARGIN)

% Choose default command line output for zhuansu_man
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zhuansu_man wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zhuansu_man_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  man_in_fjl man_weimei fjl_max fjl_min fjl_on
if fjl_on == 1
    temp_man_weimei = str2double(get(handles.edit1,'String'));
    if temp_man_weimei > fjl_max || temp_man_weimei < fjl_min || isnan(temp_man_weimei) == 1
        msgbox('该喂煤量不在上下限范围内！','提示','确认');
        man_in_fjl = 0;
    else
        man_weimei = temp_man_weimei;
        man_in_fjl = 1;
        delete(handles.figure1);
    end
end




% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function edit1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
