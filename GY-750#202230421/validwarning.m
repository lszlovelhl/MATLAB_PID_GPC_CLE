function varargout = validwarning(varargin)
% VALIDWARNING MATLAB code for validwarning.fig
%      VALIDWARNING, by itself, creates a new VALIDWARNING or raises the existing
%      singleton*.
%
%      H = VALIDWARNING returns the handle to a new VALIDWARNING or the handle to
%      the existing singleton*.
%
%      VALIDWARNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VALIDWARNING.M with the given input arguments.
%
%      VALIDWARNING('Property','Value',...) creates a new VALIDWARNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before validwarning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to validwarning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help validwarning

% Last Modified by GUIDE v2.5 21-May-2015 21:17:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @validwarning_OpeningFcn, ...
                   'gui_OutputFcn',  @validwarning_OutputFcn, ...
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


% --- Executes just before validwarning is made visible.
function validwarning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to validwarning (see VARARGIN)

% Choose default command line output for validwarning
handles.output = hObject;
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); %取得Figure的JavaFrame。
figFrame.setFigureIcon(newIcon); %修改图标
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% 关闭相关警告设置

% Update handles structure
guidata(hObject, handles);
load('key');
usedtime=decodekey(key.usedtime);
validtime=decodekey(key.validtime);
set(handles.validtime_txt,'String',num2str(validtime));
set(handles.usedtime_txt,'String',num2str(usedtime));

% UIWAIT makes validwarning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = validwarning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
