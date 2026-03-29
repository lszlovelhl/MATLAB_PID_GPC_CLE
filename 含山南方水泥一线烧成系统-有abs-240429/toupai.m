function varargout = toupai(varargin)
% TOUPAI MATLAB code for toupai.fig
%      TOUPAI, by itself, creates a new TOUPAI or raises the existing
%      singleton*.
%
%      H = TOUPAI returns the handle to a new TOUPAI or the handle to
%      the existing singleton*.
%
%      TOUPAI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOUPAI.M with the given input arguments.
%
%      TOUPAI('Property','Value',...) creates a new TOUPAI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before toupai_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to toupai_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help toupai

% Last Modified by GUIDE v2.5 05-Jan-2023 08:41:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @toupai_OpeningFcn, ...
                   'gui_OutputFcn',  @toupai_OutputFcn, ...
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


% --- Executes just before toupai is made visible.
function toupai_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to toupai (see VARARGIN)

% Choose default command line output for toupai
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes toupai wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = toupai_OutputFcn(hObject, eventdata, handles) 
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
global yaotou_on man_yaotou
global yt_max yt_min man_in_yaotou
if yaotou_on == 1 
    temp_man_toumei = str2double(get(handles.edit1,'String'));
    if temp_man_toumei > yt_max || temp_man_toumei < yt_min
        msgbox('该头排风机转速不在上下限范围内！','提示','确认');
        man_in_yaotou = 0;
    else
        man_yaotou = temp_man_toumei;
        man_in_yaotou = 1;
        delete(handles.figure1);
    end
end
