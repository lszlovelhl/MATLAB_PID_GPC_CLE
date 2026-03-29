function varargout = stop_roll_notification(varargin)
% STOP_ROLL_NOTIFICATION MATLAB code for stop_roll_notification.fig
%      STOP_ROLL_NOTIFICATION, by itself, creates a new STOP_ROLL_NOTIFICATION or raises the existing
%      singleton*.
%
%      H = STOP_ROLL_NOTIFICATION returns the handle to a new STOP_ROLL_NOTIFICATION or the handle to
%      the existing singleton*.
%
%      STOP_ROLL_NOTIFICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STOP_ROLL_NOTIFICATION.M with the given input arguments.
%
%      STOP_ROLL_NOTIFICATION('Property','Value',...) creates a new STOP_ROLL_NOTIFICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stop_roll_notification_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stop_roll_notification_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stop_roll_notification

% Last Modified by GUIDE v2.5 10-Aug-2015 20:48:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stop_roll_notification_OpeningFcn, ...
                   'gui_OutputFcn',  @stop_roll_notification_OutputFcn, ...
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


% --- Executes just before stop_roll_notification is made visible.
function stop_roll_notification_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stop_roll_notification (see VARARGIN)

% Choose default command line output for stop_roll_notification
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stop_roll_notification wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stop_roll_notification_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OK_button.
function OK_button_Callback(hObject, eventdata, handles)
global wait_time_select_hobj wait_on
% hObject    handle to OK_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wait_on=1;
val = get(handles.wait_min_pop,'Value');
set(wait_time_select_hobj,'Value',val)
uiresume(handles.apcgui)
% close('stop_roll_notification.fig');
close(figure(gcf))
% --- Executes on button press in CANCEL_button.
function CANCEL_button_Callback(hObject, eventdata, handles)
global wait_on
% hObject    handle to CANCEL_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wait_on=0;

% --- Executes on selection change in wait_min_pop.
function wait_min_pop_Callback(hObject, eventdata, handles)
% hObject    handle to wait_min_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns wait_min_pop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wait_min_pop


% --- Executes during object creation, after setting all properties.
function wait_min_pop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wait_min_pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
