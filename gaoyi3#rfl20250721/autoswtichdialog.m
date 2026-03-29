function varargout = autoswtichdialog(varargin)
% AUTOSWTICHDIALOG MATLAB code for autoswtichdialog.fig
%      AUTOSWTICHDIALOG, by itself, creates a new AUTOSWTICHDIALOG or raises the existing
%      singleton*.
%
%      H = AUTOSWTICHDIALOG returns the handle to a new AUTOSWTICHDIALOG or the handle to
%      the existing singleton*.
%
%      AUTOSWTICHDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOSWTICHDIALOG.M with the given input arguments.
%
%      AUTOSWTICHDIALOG('Property','Value',...) creates a new AUTOSWTICHDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before autoswtichdialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to autoswtichdialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help autoswtichdialog

% Last Modified by GUIDE v2.5 27-Dec-2019 15:47:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @autoswtichdialog_OpeningFcn, ...
                   'gui_OutputFcn',  @autoswtichdialog_OutputFcn, ...
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


% --- Executes just before autoswtichdialog is made visible.
function autoswtichdialog_OpeningFcn(hObject, eventdata, handles, varargin)
global javaFramedlg dlgopen
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to autoswtichdialog (see VARARGIN)

% Choose default command line output for autoswtichdialog
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
newIcon = javax.swing.ImageIcon('icon.png');
figFrame = get(hObject,'JavaFrame'); 
figFrame.setFigureIcon(newIcon);
    javaFramedlg=get(hObject,'JavaFrame');
    dlgopen=1;

% UIWAIT makes autoswtichdialog wait for user response (see UIRESUME)
% uiwait(handles.dlgfigure1);


% --- Outputs from this function are returned to the command line.
function varargout = autoswtichdialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global autoswitchdialog dlgopen
dlgopen=0;
autoswitchdialog = 'ÊÇ';
delete(handles.dlgfigure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global autoswitchdialog dlgopen
dlgopen=0;
autoswitchdialog = '·ñ';
delete(handles.dlgfigure1);


% --- Executes when user attempts to close dlgfigure1.
function dlgfigure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to dlgfigure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global huanludlg_tag dlgopen
dlgopen=0;
huanludlg_tag=0;
delete(hObject);
