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

% Last Modified by GUIDE v2.5 12-Nov-2020 16:13:18

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
global paramdata temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2
global junhua_alpha junhua_beta junhua_gamma gwfj_alpha gwfj_beta gwfj_gamma NH3_alpha1 NH3_beta1 NH3_gamma1 NH3_alpha2 NH3_beta2 NH3_gamma2

%% xml读取数据
paramdata = xml_read('param_set.xml');

%分解炉
temp_fjl_alpha1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1;     %  稳态
temp_fjl_lambda1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1;
temp_fjl_alpha2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2;      % 大偏差
temp_fjl_lambda2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2;

%头煤压力
temp_toumei_alpha = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_alpha;
temp_toumei_beta = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta;
temp_toumei_gamma = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_gamma;

%篦冷机
temp_blj_alpha1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1;   % 小偏差
temp_blj_beta1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1;
temp_blj_gamma1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1;

temp_blj_alpha2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2;   % 大偏差
temp_blj_beta2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2;
temp_blj_gamma2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2;

%均化库
junhua_alpha = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_alpha;  
junhua_beta = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_beta;
junhua_gamma = paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_gamma;

%高温分机
gwfj_alpha = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_alpha;  
gwfj_beta = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_beta;
gwfj_gamma = paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_gamma;

%  氨水
NH3_alpha1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_alpha1;   % 内
NH3_beta1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_beta1;
NH3_gamma1 = paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_gamma1;

NH3_alpha2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_alpha2;   % 外
NH3_beta2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_beta2;
NH3_gamma2 = paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_gamma2;

%% 初值设定
%分解炉
set(handles.fjl_alpha1,'String',temp_fjl_alpha1);
set(handles.fjl_alpha1_slider,'Value',temp_fjl_alpha1);
set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda1,'String',temp_fjl_lambda1);
set(handles.fjl_lambda1_slider,'Value',temp_fjl_lambda1);
set(handles.fjl_lambda1_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda1_slider,'SliderStep',[5/5000,10/5000]);

set(handles.fjl_alpha2,'String',temp_fjl_alpha2);
set(handles.fjl_alpha2_slider,'Value',temp_fjl_alpha2);
set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

set(handles.fjl_lambda2,'String',temp_fjl_lambda2);
set(handles.fjl_lambda2_slider,'Value',temp_fjl_lambda2);
set(handles.fjl_lambda2_slider,'Max',5000,'Min',0);
set(handles.fjl_lambda2_slider,'SliderStep',[5/5000,10/5000]);

%头煤压力
set(handles.toumei_p,'String',temp_toumei_alpha);
set(handles.toumei_p_slider,'Value',temp_toumei_alpha);
set(handles.toumei_p_slider,'Max',2,'Min',0);
set(handles.toumei_p_slider,'SliderStep',[0.01/2,0.02/2]);

set(handles.toumei_i,'String',temp_toumei_beta);
set(handles.toumei_i_slider,'Value',temp_toumei_beta);
set(handles.toumei_i_slider,'Max',300,'Min',0);
set(handles.toumei_i_slider,'SliderStep',[1/300,5/300]);

set(handles.toumei_d,'String',temp_toumei_gamma);
set(handles.toumei_d_slider,'Value',temp_toumei_gamma);
set(handles.toumei_d_slider,'Max',1,'Min',0);
set(handles.toumei_d_slider,'SliderStep',[0.01/1,0.05/1]);

%篦冷机1
formatSpec = '%4.2f';
set(handles.blj_p1,'String',num2str(temp_blj_alpha1,formatSpec));
set(handles.blj_p1_slider,'Value',temp_blj_alpha1);
set(handles.blj_p1_slider,'Max',1,'Min',0);
set(handles.blj_p1_slider,'SliderStep',[0.001/1,0.01/1]);

set(handles.blj_i1,'String',temp_blj_beta1);
set(handles.blj_i1_slider,'Value',temp_blj_beta1);
set(handles.blj_i1_slider,'Max',2000,'Min',0);
set(handles.blj_i1_slider,'SliderStep',[1/200,10/2000]);

formatSpec = '%3.2f';
set(handles.blj_d1,'String',num2str(temp_blj_gamma1,formatSpec));
set(handles.blj_d1_slider,'Value',temp_blj_gamma1);
set(handles.blj_d1_slider,'Max',1,'Min',0);
set(handles.blj_d1_slider,'SliderStep',[0.01/1,0.05/1]);

%篦冷机2
set(handles.blj_p2,'String',temp_blj_alpha2);
set(handles.blj_p2_slider,'Value',temp_blj_alpha2);
set(handles.blj_p2_slider,'Max',1,'Min',0);
set(handles.blj_p2_slider,'SliderStep',[0.001/1,0.01/1]);

set(handles.blj_i2,'String',temp_blj_beta2);
set(handles.blj_i2_slider,'Value',temp_blj_beta2);
set(handles.blj_i2_slider,'Max',2000,'Min',0);
set(handles.blj_i2_slider,'SliderStep',[1/2000,10/2000]);

set(handles.blj_d2,'String',temp_blj_gamma2);
set(handles.blj_d2_slider,'Value',temp_blj_gamma2);
set(handles.blj_d2_slider,'Max',1,'Min',0);
set(handles.blj_d2_slider,'SliderStep',[0.01/1,0.05/1]);

% 均化库
set(handles.junhua_p,'String',junhua_alpha);
set(handles.junhua_p_slider,'Value',junhua_alpha);
set(handles.junhua_p_slider,'Max',1,'Min',0);
set(handles.junhua_p_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.junhua_i,'String',junhua_beta);
set(handles.junhua_i_slider,'Value',junhua_beta);
set(handles.junhua_i_slider,'Max',100,'Min',0);
set(handles.junhua_i_slider,'SliderStep',[1/100,5/100]);

set(handles.junhua_d,'String',junhua_gamma);
set(handles.junhua_d_slider,'Value',junhua_gamma);
set(handles.junhua_d_slider,'Max',1,'Min',0);
set(handles.junhua_d_slider,'SliderStep',[0.01/1,0.05/1]);
%高温风机
set(handles.gwfj_p,'String',gwfj_alpha);
set(handles.gwfj_p_slider,'Value',gwfj_alpha);
set(handles.gwfj_p_slider,'Max',1,'Min',0);
set(handles.gwfj_p_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.gwfj_i,'String',gwfj_beta);
set(handles.gwfj_i_slider,'Value',gwfj_beta);
set(handles.gwfj_i_slider,'Max',100,'Min',0);
set(handles.gwfj_i_slider,'SliderStep',[1/100,5/100]);

set(handles.gwfj_d,'String',gwfj_gamma);
set(handles.gwfj_d_slider,'Value',gwfj_gamma);
set(handles.gwfj_d_slider,'Max',1,'Min',0);
set(handles.gwfj_d_slider,'SliderStep',[0.01/1,0.05/1]);

% 氨水
set(handles.NH3_p1,'String',NH3_alpha1);   %  内
set(handles.NH3_p1_slider,'Value',NH3_alpha1);
set(handles.NH3_p1_slider,'Max',1,'Min',0);
set(handles.NH3_p1_slider,'SliderStep',[0.01/1,0.1/1]);

set(handles.NH3_i1,'String',NH3_beta1);
set(handles.NH3_i1_slider,'Value',NH3_beta1);
set(handles.NH3_i1_slider,'Max',100,'Min',0);
set(handles.NH3_i1_slider,'SliderStep',[1/100,5/100]);

set(handles.NH3_d1,'String',NH3_gamma1);
set(handles.NH3_d1_slider,'Value',NH3_gamma1);
set(handles.NH3_d1_slider,'Max',1,'Min',0);
set(handles.NH3_d1_slider,'SliderStep',[0.01/1,0.05/1]);

set(handles.NH3_p2,'String',NH3_alpha2);   %  外
set(handles.NH3_p2_slider,'Value',NH3_alpha2);
set(handles.NH3_p2_slider,'Max',20,'Min',0);
set(handles.NH3_p2_slider,'SliderStep',[0.1/20,1/20]);

set(handles.NH3_i2,'String',NH3_beta2);
set(handles.NH3_i2_slider,'Value',NH3_beta2);
set(handles.NH3_i2_slider,'Max',100,'Min',0);
set(handles.NH3_i2_slider,'SliderStep',[1/100,5/100]);

set(handles.NH3_d2,'String',NH3_gamma2);
set(handles.NH3_d2_slider,'Value',NH3_gamma2);
set(handles.NH3_d2_slider,'Max',1,'Min',0);
set(handles.NH3_d2_slider,'SliderStep',[0.01/1,0.05/1]);


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
global paramdata 
% paramdata = xml_read('param_set.xml');
paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1=str2double(get(handles.fjl_alpha1,'String'));
paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1=str2double(get(handles.fjl_lambda1,'String'));
paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2=str2double(get(handles.fjl_alpha2,'String'));
paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2=str2double(get(handles.fjl_lambda2,'String'));

paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_alpha=str2double(get(handles.toumei_p,'String'));
paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta=str2double(get(handles.toumei_i,'String'));
paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_gamma=str2double(get(handles.toumei_d,'String'));

paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1=str2double(get(handles.blj_p1,'String'));
paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1=str2double(get(handles.blj_i1,'String'));
paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1=str2double(get(handles.blj_d1,'String'));
paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2=str2double(get(handles.blj_p2,'String'));
paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2=str2double(get(handles.blj_i2,'String'));
paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2=str2double(get(handles.blj_d2,'String'));

paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_alpha=str2double(get(handles.junhua_p,'String'));
paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_beta=str2double(get(handles.junhua_i,'String'));
paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_gamma=str2double(get(handles.junhua_d,'String'));

paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_alpha=str2double(get(handles.gwfj_p,'String'));
paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_beta=str2double(get(handles.gwfj_i,'String'));
paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_gamma=str2double(get(handles.gwfj_d,'String'));

paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_alpha1=str2double(get(handles.NH3_p1,'String'));
paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_beta1=str2double(get(handles.NH3_i1,'String'));
paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_gamma1=str2double(get(handles.NH3_d1,'String'));

paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_alpha2=str2double(get(handles.NH3_p2,'String'));
paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_beta2=str2double(get(handles.NH3_i2,'String'));
paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_gamma2=str2double(get(handles.NH3_d2,'String'));
wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
xml_write('param_set.xml',paramdata,'paramdata',wPref);
delete(handles.figure1);

% --- Executes on button press in set_default.
function set_default_Callback(hObject, eventdata, handles)
% hObject    handle to set_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2
global junhua_alpha junhua_beta junhua_gamma gwfj_alpha gwfj_beta gwfj_gamma NH3_alpha1 NH3_beta1 NH3_gamma1 NH3_alpha2 NH3_beta2 NH3_gamma2

button2=questdlg('确定恢复默认值？','恢复默认值','Yes','No','Yes');
if strcmp(button2,'Yes')
    paramdata = xml_read('param_set.xml');

    %分解炉
    temp_fjl_alpha1 = paramdata.commdata(1).parameter(17).ATTRIBUTE.fjl_alpha1;
    temp_fjl_lambda1 = paramdata.commdata(1).parameter(17).ATTRIBUTE.fjl_lambda1;
    temp_fjl_alpha2 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_alpha2;
    temp_fjl_lambda2 = paramdata.commdata(1).parameter(18).ATTRIBUTE.fjl_lambda2;

    %头煤压力
    temp_toumei_alpha = paramdata.commdata(1).parameter(19).ATTRIBUTE.toumei_alpha;
    temp_toumei_beta = paramdata.commdata(1).parameter(19).ATTRIBUTE.toumei_beta;
    temp_toumei_gamma = paramdata.commdata(1).parameter(19).ATTRIBUTE.toumei_gamma;

    %篦冷机
    temp_blj_alpha1 = paramdata.commdata(1).parameter(20).ATTRIBUTE.blj_alpha1;
    temp_blj_beta1 = paramdata.commdata(1).parameter(20).ATTRIBUTE.blj_beta1;
    temp_blj_gamma1 = paramdata.commdata(1).parameter(20).ATTRIBUTE.blj_gamma1;

    temp_blj_alpha2 = paramdata.commdata(1).parameter(21).ATTRIBUTE.blj_alpha2;
    temp_blj_beta2 = paramdata.commdata(1).parameter(21).ATTRIBUTE.blj_beta2;
    temp_blj_gamma2 = paramdata.commdata(1).parameter(21).ATTRIBUTE.blj_gamma2;
    %均化库
    junhua_alpha = paramdata.commdata(1).parameter(22).ATTRIBUTE.junhua_alpha;  
    junhua_beta = paramdata.commdata(1).parameter(22).ATTRIBUTE.junhua_beta;
    junhua_gamma = paramdata.commdata(1).parameter(22).ATTRIBUTE.junhua_gamma;

    %高温分机
    gwfj_alpha = paramdata.commdata(1).parameter(23).ATTRIBUTE.gwfj_alpha;  
    gwfj_beta = paramdata.commdata(1).parameter(23).ATTRIBUTE.gwfj_beta;
    gwfj_gamma = paramdata.commdata(1).parameter(23).ATTRIBUTE.gwfj_gamma;

    %  氨水
    NH3_alpha1 = paramdata.commdata(1).parameter(24).ATTRIBUTE.NH3_alpha1;   % 内
    NH3_beta1 = paramdata.commdata(1).parameter(24).ATTRIBUTE.NH3_beta1;
    NH3_gamma1 = paramdata.commdata(1).parameter(24).ATTRIBUTE.NH3_gamma1;

    NH3_alpha2 = paramdata.commdata(1).parameter(25).ATTRIBUTE.NH3_alpha2;   % 外
    NH3_beta2 = paramdata.commdata(1).parameter(25).ATTRIBUTE.NH3_beta2;
    NH3_gamma2 = paramdata.commdata(1).parameter(25).ATTRIBUTE.NH3_gamma2;

    %保存到xml
    paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1=temp_fjl_alpha1;
    paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1=temp_fjl_lambda1;
    paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2=temp_fjl_alpha2;
    paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2=temp_fjl_lambda2;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_alpha=temp_toumei_alpha;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta=temp_toumei_beta;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_gamma=temp_toumei_gamma;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1=temp_blj_alpha1;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1=temp_blj_beta1;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1=temp_blj_gamma1;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2=temp_blj_alpha2;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2=temp_blj_beta2;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2=temp_blj_gamma2;
    
    paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_alpha=junhua_alpha;
    paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_beta=junhua_beta;
    paramdata.commdata(1).parameter(13).ATTRIBUTE.junhua_gamma=junhua_gamma;
    
    paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_alpha=gwfj_alpha;
    paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_beta=gwfj_beta;
    paramdata.commdata(1).parameter(14).ATTRIBUTE.gwfj_gamma=gwfj_gamma;
    
    paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_alpha1=NH3_alpha1;
    paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_beta1=NH3_beta1;
    paramdata.commdata(1).parameter(15).ATTRIBUTE.NH3_gamma1=NH3_gamma1;
    
    paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_alpha2=NH3_alpha2;
    paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_beta2=NH3_beta2;
    paramdata.commdata(1).parameter(16).ATTRIBUTE.NH3_gamma2=NH3_gamma2;

    wPref.StructItem = false; %为了保证xml文件保存后与原文件xml格式相同，否则会增添item项
    xml_write('param_set.xml',paramdata,'paramdata',wPref);

    %显示初始值
    %分解炉
    set(handles.fjl_alpha1,'String',temp_fjl_alpha1);
    set(handles.fjl_alpha1_slider,'Value',temp_fjl_alpha1);
    set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
    set(handles.fjl_alpha1_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

    set(handles.fjl_lambda1,'String',temp_fjl_lambda1);
    set(handles.fjl_lambda1_slider,'Value',temp_fjl_lambda1);
    set(handles.fjl_lambda1_slider,'Max',5000,'Min',0);
    set(handles.fjl_lambda1_slider,'SliderStep',[5/5000,10/5000]);

    set(handles.fjl_alpha2,'String',temp_fjl_alpha2);
    set(handles.fjl_alpha2_slider,'Value',temp_fjl_alpha2);
    set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
    set(handles.fjl_alpha2_slider,'SliderStep',[0.001/0.1,0.01/0.1]);

    set(handles.fjl_lambda2,'String',temp_fjl_lambda2);
    set(handles.fjl_lambda2_slider,'Value',temp_fjl_lambda2);
    set(handles.fjl_lambda2_slider,'Max',5000,'Min',0);
    set(handles.fjl_lambda2_slider,'SliderStep',[5/5000,10/5000]);

    %头煤压力
    set(handles.toumei_p,'String',temp_toumei_alpha);
    set(handles.toumei_p_slider,'Value',temp_toumei_alpha);
    set(handles.toumei_p_slider,'Max',2,'Min',0);
    set(handles.toumei_p_slider,'SliderStep',[0.01/2,0.02/2]);

    set(handles.toumei_i,'String',temp_toumei_beta);
    set(handles.toumei_i_slider,'Value',temp_toumei_beta);
    set(handles.toumei_i_slider,'Max',300,'Min',0);
    set(handles.toumei_i_slider,'SliderStep',[1/300,5/300]);

    set(handles.toumei_d,'String',temp_toumei_gamma);
    set(handles.toumei_d_slider,'Value',temp_toumei_gamma);
    set(handles.toumei_d_slider,'Max',1,'Min',0);
    set(handles.toumei_d_slider,'SliderStep',[0.01/1,0.05/1]);

    %篦冷机1
    formatSpec = '%3.2f';
    set(handles.blj_p1,'String',num2str(temp_blj_alpha1,formatSpec));
    set(handles.blj_p1_slider,'Value',temp_blj_alpha1);
    set(handles.blj_p1_slider,'Max',100,'Min',0);
    set(handles.blj_p1_slider,'SliderStep',[0.1/100,1/100]);

    set(handles.blj_i1,'String',temp_blj_beta1);
    set(handles.blj_i1_slider,'Value',temp_blj_beta1);
    set(handles.blj_i1_slider,'Max',100,'Min',0);
    set(handles.blj_i1_slider,'SliderStep',[1/100,5/100]);

    formatSpec = '%3.2f';
    set(handles.blj_d1,'String',num2str(temp_blj_gamma1,formatSpec));
    set(handles.blj_d1_slider,'Value',temp_blj_gamma1);
    set(handles.blj_d1_slider,'Max',1,'Min',0);
    set(handles.blj_d1_slider,'SliderStep',[0.01/1,0.05/1]);

    %篦冷机2
    set(handles.blj_p2,'String',temp_blj_alpha2);
    set(handles.blj_p2_slider,'Value',temp_blj_alpha2);
    set(handles.blj_p2_slider,'Max',100,'Min',0);
    set(handles.blj_p2_slider,'SliderStep',[0.1/100,1/100]);

    set(handles.blj_i2,'String',temp_blj_beta2);
    set(handles.blj_i2_slider,'Value',temp_blj_beta2);
    set(handles.blj_i2_slider,'Max',100,'Min',0);
    set(handles.blj_i2_slider,'SliderStep',[1/100,5/100]);

    set(handles.blj_d2,'String',temp_blj_gamma2);
    set(handles.NH3_d2_slider,'Value',temp_blj_gamma2);
    set(handles.NH3_d2_slider,'Max',1,'Min',0);
    set(handles.NH3_d2_slider,'SliderStep',[0.01/1,0.05/1]);

    % 均化库
    set(handles.junhua_p,'String',junhua_alpha);
    set(handles.junhua_p_slider,'Value',junhua_alpha);
    set(handles.junhua_p_slider,'Max',1,'Min',0);
    set(handles.junhua_p_slider,'SliderStep',[0.01/1,0.1/1]);

    set(handles.junhua_i,'String',junhua_beta);
    set(handles.junhua_i_slider,'Value',junhua_beta);
    set(handles.junhua_i_slider,'Max',100,'Min',0);
    set(handles.junhua_i_slider,'SliderStep',[1/100,5/100]);

    set(handles.junhua_d,'String',junhua_gamma);
    set(handles.junhua_d_slider,'Value',junhua_gamma);
    set(handles.junhua_d_slider,'Max',1,'Min',0);
    set(handles.junhua_d_slider,'SliderStep',[0.01/1,0.05/1]);
    %高温风机
    set(handles.gwfj_p,'String',gwfj_alpha);
    set(handles.gwfj_p_slider,'Value',gwfj_alpha);
    set(handles.gwfj_p_slider,'Max',1,'Min',0);
    set(handles.gwfj_p_slider,'SliderStep',[0.01/1,0.1/1]);

    set(handles.gwfj_i,'String',gwfj_beta);
    set(handles.gwfj_i_slider,'Value',gwfj_beta);
    set(handles.gwfj_i_slider,'Max',100,'Min',0);
    set(handles.gwfj_i_slider,'SliderStep',[1/100,5/100]);

    set(handles.gwfj_d,'String',gwfj_gamma);
    set(handles.gwfj_d_slider,'Value',gwfj_gamma);
    set(handles.gwfj_d_slider,'Max',1,'Min',0);
    set(handles.gwfj_d_slider,'SliderStep',[0.01/1,0.05/1]);

    % 氨水
    set(handles.NH3_p1,'String',NH3_alpha1);   %  内
    set(handles.NH3_p1_slider,'Value',NH3_alpha1);
    set(handles.NH3_p1_slider,'Max',1,'Min',0);
    set(handles.NH3_p1_slider,'SliderStep',[0.01/1,0.1/1]);

    set(handles.NH3_i1,'String',NH3_beta1);
    set(handles.NH3_i1_slider,'Value',NH3_beta1);
    set(handles.NH3_i1_slider,'Max',100,'Min',0);
    set(handles.NH3_i1_slider,'SliderStep',[1/100,5/100]);

    set(handles.NH3_d1,'String',NH3_gamma1);
    set(handles.NH3_d1_slider,'Value',NH3_gamma1);
    set(handles.NH3_d1_slider,'Max',1,'Min',0);
    set(handles.NH3_d1_slider,'SliderStep',[0.01/1,0.05/1]);

    set(handles.NH3_p2,'String',NH3_alpha2);   %  外
    set(handles.NH3_p2_slider,'Value',NH3_alpha2);
    set(handles.NH3_p2_slider,'Max',20,'Min',0);
    set(handles.NH3_p2_slider,'SliderStep',[0.1/20,1/20]);

    set(handles.NH3_i2,'String',NH3_beta2);
    set(handles.NH3_i2_slider,'Value',NH3_beta2);
    set(handles.NH3_i2_slider,'Max',100,'Min',0);
    set(handles.NH3_i2_slider,'SliderStep',[1/100,5/100]);

    set(handles.NH3_d2,'String',NH3_gamma2);
    set(handles.NH3_d2_slider,'Value',NH3_gamma2);
    set(handles.NH3_d2_slider,'Max',1,'Min',0);
    set(handles.NH3_d2_slider,'SliderStep',[0.01/1,0.05/1]);
end

% --- Executes on slider movement.
function toumei_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_toumei_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.toumei_p,'String',num2str(a,formatSpec));
temp_toumei_alpha=str2double(get(handles.toumei_p,'String'));

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
global temp_toumei_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.toumei_i,'String',num2str(a,formatSpec));
temp_toumei_beta=str2double(get(handles.toumei_i,'String'));

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
global temp_toumei_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.toumei_d,'String',num2str(a,formatSpec));
temp_toumei_gamma=str2double(get(handles.toumei_d,'String'));

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
global temp_fjl_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.fjl_alpha1,'String',num2str(a,formatSpec));
temp_fjl_alpha1=str2double(get(handles.fjl_alpha1,'String'));

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
global temp_fjl_lambda1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.fjl_lambda1,'String',num2str(a,formatSpec));
temp_fjl_lambda1=str2double(get(handles.fjl_lambda1,'String'));

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
global temp_fjl_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.3f';
set(handles.fjl_alpha2,'String',num2str(a,formatSpec));
temp_fjl_alpha2=str2double(get(handles.fjl_alpha2,'String'));

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
global temp_fjl_lambda2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4d';
set(handles.fjl_lambda2,'String',num2str(a,formatSpec));
temp_fjl_lambda2=str2double(get(handles.fjl_lambda2,'String'));

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
function NH3_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global NH3_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.NH3_p1,'String',num2str(a,formatSpec));
NH3_alpha1=str2double(get(handles.NH3_p1,'String'));

% --- Executes during object creation, after setting all properties.
function NH3_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global NH3_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.NH3_i1,'String',num2str(a,formatSpec));
NH3_beta1=str2double(get(handles.NH3_i1,'String'));

% --- Executes during object creation, after setting all properties.
function NH3_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global NH3_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.NH3_d1,'String',num2str(a,formatSpec));
NH3_gamma1=str2double(get(handles.NH3_d1,'String'));

% --- Executes during object creation, after setting all properties.
function NH3_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global NH3_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.NH3_p2,'String',num2str(a,formatSpec));
NH3_alpha2=str2double(get(handles.NH3_p2,'String'));

% --- Executes during object creation, after setting all properties.
function NH3_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global NH3_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.NH3_i2,'String',num2str(a,formatSpec));
NH3_beta2=str2double(get(handles.NH3_i2,'String'));

% --- Executes during object creation, after setting all properties.
function NH3_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function NH3_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to NH3_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NH3_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.NH3_d2,'String',num2str(a,formatSpec));
NH3_gamma2=str2double(get(handles.NH3_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function NH3_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NH3_d2_slider (see GCBO)
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
function junhua_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to junhua_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global junhua_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.junhua_p,'String',num2str(a,formatSpec));
junhua_alpha=str2double(get(handles.junhua_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function junhua_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to junhua_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function junhua_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to junhua_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global junhua_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.junhua_i,'String',num2str(a,formatSpec));
junhua_beta=str2double(get(handles.junhua_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function junhua_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to junhua_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function junhua_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to junhua_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global junhua_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.junhua_d,'String',num2str(a,formatSpec));
junhua_gamma=str2double(get(handles.junhua_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function junhua_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to junhua_d_slider (see GCBO)
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
global gwfj_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.3f';
set(handles.gwfj_p,'String',num2str(a,formatSpec));
gwfj_alpha=str2double(get(handles.gwfj_p,'String'));
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
global gwfj_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%2d';
set(handles.gwfj_i,'String',num2str(a,formatSpec));
gwfj_beta=str2double(get(handles.gwfj_i,'String'));
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
formatSpec = '%4.2f';
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
