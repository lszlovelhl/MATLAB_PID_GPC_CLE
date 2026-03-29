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

% Last Modified by GUIDE v2.5 24-Jun-2023 19:29:25

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
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma temp_toumei_alpha1 temp_toumei_beta1 temp_toumei_gamma1 temp_toumei_alpha2 temp_toumei_beta2 temp_toumei_gamma2
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2
global temp_SLcangzhong_alpha temp_SLcangzhong_beta temp_SLcangzhong_gamma temp_SLcangzhong_alpha1 temp_SLcangzhong_beta1 temp_SLcangzhong_gamma1 temp_SLcangzhong_alpha2 temp_SLcangzhong_beta2 temp_SLcangzhong_gamma2
global temp_blj4_alpha temp_blj4_beta temp_blj4_gamma
global yaotou_p yaotou_i yaotou_d douti_p douti_i douti_d gwfj_p gwfj_d gwfj_i
global xhfj_p xhfj_i xhfj_d
%% xml读取数据
paramdata = xml_read('param_set.xml');

%分解炉
temp_fjl_alpha1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_alpha1;
temp_fjl_lambda1 = paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_lambda1;
temp_fjl_alpha2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2;
temp_fjl_lambda2 = paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2;

%头煤压力
temp_toumei_alpha1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha1;
temp_toumei_beta1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda1;
temp_toumei_gamma1 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_gamma1;

temp_toumei_alpha2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha2;
temp_toumei_beta2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda2;
temp_toumei_gamma2 = paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_gamma2;

%篦冷机
temp_blj_alpha1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_alpha1;
temp_blj_beta1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_beta1;
temp_blj_gamma1 = paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_gamma1;

temp_blj_alpha2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_alpha2;
temp_blj_beta2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_beta2;
temp_blj_gamma2 = paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_gamma2;

temp_blj4_alpha = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_alpha;
temp_blj4_beta = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_beta;
temp_blj4_gamma = paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_gamma;

%生料仓重

temp_SLcangzhong_alpha = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_alpha;
temp_SLcangzhong_beta = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_beta;
temp_SLcangzhong_gamma = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_gamma;

%窑头负压
yaotou_p = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_p;
yaotou_i = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_i;
yaotou_d = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_d;
%斗提电流
douti_p = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_p;
douti_i = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_i;
douti_d = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_d;
%高温风机
gwfj_p = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p;
gwfj_i = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i;
gwfj_d = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d;
%循环风机
xhfj_p = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_p;
xhfj_i = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_i;
xhfj_d = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_d;
%% 初值设定
%分解炉

set(handles.fjl_alpha1,'String',temp_fjl_alpha1);
set(handles.fjl_alpha1_slider,'Value',temp_fjl_alpha1);
set(handles.fjl_alpha1_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha1_slider,'SliderStep',[0.0001/0.1,0.001/0.1]);

set(handles.fjl_lambda1,'String',temp_fjl_lambda1);
set(handles.fjl_lambda1_slider,'Value',temp_fjl_lambda1);
set(handles.fjl_lambda1_slider,'Max',temp_fjl_lambda1+500,'Min',temp_fjl_lambda1-500);
set(handles.fjl_lambda1_slider,'SliderStep',[1/1000,5/1000]);

set(handles.fjl_alpha2,'String',temp_fjl_alpha2);
set(handles.fjl_alpha2_slider,'Value',temp_fjl_alpha2);
set(handles.fjl_alpha2_slider,'Max',1,'Min',0.9);
set(handles.fjl_alpha2_slider,'SliderStep',[0.0001/0.1,0.001/0.1]);

set(handles.fjl_lambda2,'String',temp_fjl_lambda2);
set(handles.fjl_lambda2_slider,'Value',temp_fjl_lambda2);
set(handles.fjl_lambda2_slider,'Max',temp_fjl_lambda2+500,'Min',temp_fjl_lambda2-500);
set(handles.fjl_lambda2_slider,'SliderStep',[1/1000,5/1000]);

%头煤压力
formatSpec = '%4.4f';
set(handles.toumei_p1,'String',num2str(temp_toumei_alpha1,formatSpec));
set(handles.toumei_p1_slider,'Value',temp_toumei_alpha1);
set(handles.toumei_p1_slider,'Max',5,'Min',0);
set(handles.toumei_p1_slider,'SliderStep',[0.0001/5,0.001/5]);

set(handles.toumei_i1,'String',num2str(temp_toumei_beta1,formatSpec));
set(handles.toumei_i1_slider,'Value',temp_toumei_beta1);
set(handles.toumei_i1_slider,'Max',temp_toumei_beta1+500,'Min',0);
set(handles.toumei_i1_slider,'SliderStep',[1/(temp_toumei_beta1+500),10/(temp_toumei_beta1+500)]);

set(handles.toumei_d1,'String',num2str(temp_toumei_gamma1,formatSpec));
set(handles.toumei_d1_slider,'Value',temp_toumei_gamma1);
set(handles.toumei_d1_slider,'Max',0.1,'Min',0);
set(handles.toumei_d1_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

formatSpec = '%4.4f';
set(handles.toumei_p2,'String',num2str(temp_toumei_alpha2,formatSpec));
set(handles.toumei_p2_slider,'Value',temp_toumei_alpha2);
set(handles.toumei_p2_slider,'Max',5,'Min',0);
set(handles.toumei_p2_slider,'SliderStep',[0.0001/5,0.001/5]);

set(handles.toumei_i2,'String',num2str(temp_toumei_beta2,formatSpec));
set(handles.toumei_i2_slider,'Value',temp_toumei_beta2);
set(handles.toumei_i2_slider,'Max',temp_toumei_beta2+500,'Min',0);
set(handles.toumei_i2_slider,'SliderStep',[1/(temp_toumei_beta2+500),10/(temp_toumei_beta2+500)]);

set(handles.toumei_d2,'String',num2str(temp_toumei_gamma2,formatSpec));
set(handles.toumei_d2_slider,'Value',temp_toumei_gamma2);
set(handles.toumei_d2_slider,'Max',0.1,'Min',0);
set(handles.toumei_d2_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

%窑头负压
formatSpec = '%4.4f';
set(handles.yaotou_p,'String',num2str(yaotou_p,formatSpec));
set(handles.yaotou_p_slider,'Value',yaotou_p);
set(handles.yaotou_p_slider,'Max',0.5,'Min',0);
set(handles.yaotou_p_slider,'SliderStep',[0.0001/0.5,0.001/0.5]);

set(handles.yaotou_i,'String',num2str(yaotou_i,formatSpec));
set(handles.yaotou_i_slider,'Value',yaotou_i);
set(handles.yaotou_i_slider,'Max',40,'Min',0);
set(handles.yaotou_i_slider,'SliderStep',[0.01/40,0.1/40]);

set(handles.yaotou_d,'String',num2str(yaotou_d,formatSpec));
set(handles.yaotou_d_slider,'Value',yaotou_d);
set(handles.yaotou_d_slider,'Max',0.1,'Min',0);
set(handles.yaotou_d_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

%高温风机负压
formatSpec = '%4.4f';
set(handles.gwfj_p,'String',num2str(gwfj_p,formatSpec));
set(handles.gwfj_p_slider,'Value',gwfj_p);
set(handles.gwfj_p_slider,'Max',0.5,'Min',0);
set(handles.gwfj_p_slider,'SliderStep',[0.0001/0.5,0.001/0.5]);

set(handles.gwfj_i,'String',num2str(gwfj_i,formatSpec));
set(handles.gwfj_i_slider,'Value',gwfj_i);
set(handles.gwfj_i_slider,'Max',400,'Min',0);
set(handles.gwfj_i_slider,'SliderStep',[1/400,10/400]);

set(handles.gwfj_d,'String',num2str(gwfj_d,formatSpec));
set(handles.gwfj_d_slider,'Value',gwfj_d);
set(handles.gwfj_d_slider,'Max',0.1,'Min',0);
set(handles.gwfj_d_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

%篦冷机1
formatSpec = '%4.4f';
set(handles.blj_p1,'String',num2str(temp_blj_alpha1,formatSpec));
set(handles.blj_p1_slider,'Value',temp_blj_alpha1);
set(handles.blj_p1_slider,'Max',1,'Min',0.9);
set(handles.blj_p1_slider,'SliderStep',[0.0001/0.1,0.01/0.1]);

set(handles.blj_i1,'String',num2str(temp_blj_beta1,'%4.0f'));
set(handles.blj_i1_slider,'Value',temp_blj_beta1);
set(handles.blj_i1_slider,'Max',10000,'Min',0);
set(handles.blj_i1_slider,'SliderStep',[1/10000,10/10000]);

set(handles.blj_d1,'String',temp_blj_gamma1);
set(handles.blj_d1_slider,'Value',temp_blj_gamma1);
set(handles.blj_d1_slider,'Max',0.1,'Min',0);
set(handles.blj_d1_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

%篦冷机2
set(handles.blj_p2,'String',num2str(temp_blj_alpha2,formatSpec));
set(handles.blj_p2_slider,'Value',temp_blj_alpha2);
set(handles.blj_p2_slider,'Max',1,'Min',0.9);
set(handles.blj_p2_slider,'SliderStep',[0.0001/0.1,0.01/0.1]);

set(handles.blj_i2,'String',num2str(temp_blj_beta2,'%4.0f'));
set(handles.blj_i2_slider,'Value',temp_blj_beta2);
set(handles.blj_i2_slider,'Max',10000,'Min',0);
set(handles.blj_i2_slider,'SliderStep',[1/10000,10/10000]);

set(handles.blj_d2,'String',temp_blj_gamma2);
set(handles.blj_d2_slider,'Value',temp_blj_gamma2);
set(handles.blj_d2_slider,'Max',0.1,'Min',0);
set(handles.blj_d2_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

%生料仓重初值设定
formatSpec = '%4.4f';
set(handles.SLcangzhong_p,'String',num2str(temp_SLcangzhong_alpha,formatSpec));
set(handles.SLcangzhong_p_slider,'Value',temp_SLcangzhong_alpha);
set(handles.SLcangzhong_p_slider,'Max',5,'Min',0);
set(handles.SLcangzhong_p_slider,'SliderStep',[0.001/5,0.01/5]);

formatSpec = '%4.4f';
set(handles.SLcangzhong_i,'String',num2str(temp_SLcangzhong_beta,formatSpec));
set(handles.SLcangzhong_i_slider,'Value',temp_SLcangzhong_beta);
set(handles.SLcangzhong_i_slider,'Max',200,'Min',0);
set(handles.SLcangzhong_i_slider,'SliderStep',[0.01/200,0.1/200]);

formatSpec = '%4.4f';
set(handles.SLcangzhong_d,'String',num2str(temp_SLcangzhong_gamma,formatSpec));
set(handles.SLcangzhong_d_slider,'Value',temp_SLcangzhong_gamma);
set(handles.SLcangzhong_d_slider,'Max',temp_SLcangzhong_gamma+0.05,'Min',0);
set(handles.SLcangzhong_d_slider,'SliderStep',[0.01/0.1,0.05/0.1]);

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
global paramdata temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma temp_toumei_alpha1 temp_toumei_beta1 temp_toumei_gamma1 temp_toumei_alpha2 temp_toumei_beta2 temp_toumei_gamma2
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2
global temp_SLcangzhong_alpha temp_SLcangzhong_beta temp_SLcangzhong_gamma temp_SLcangzhong_alpha1 temp_SLcangzhong_beta1 temp_SLcangzhong_gamma1 temp_SLcangzhong_alpha2 temp_SLcangzhong_beta2 temp_SLcangzhong_gamma2
global temp_blj4_alpha temp_blj4_beta temp_blj4_gamma yaotou_p yaotou_i yaotou_d
global douti_p douti_i douti_d gwfj_p gwfj_i gwfj_d xhfj_p xhfj_i xhfj_d
set(handles.save_state,'String','已保存');
paramdata = xml_read('param_set.xml');
paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_alpha1=temp_fjl_alpha1;
paramdata.commdata(1).parameter(2).ATTRIBUTE.fjl_lambda1=temp_fjl_lambda1;
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_alpha2=temp_fjl_alpha2;
paramdata.commdata(1).parameter(3).ATTRIBUTE.fjl_lambda2=temp_fjl_lambda2;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha1=temp_toumei_alpha1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda1=temp_toumei_beta1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_gamma1=temp_toumei_gamma1;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_alpha2=temp_toumei_alpha2;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_lambda2=temp_toumei_beta2;
paramdata.commdata(1).parameter(4).ATTRIBUTE.toumei_gamma2=temp_toumei_gamma2;
paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_alpha1=temp_blj_alpha1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_beta1=temp_blj_beta1;
paramdata.commdata(1).parameter(5).ATTRIBUTE.blj_gamma1=temp_blj_gamma1;
paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_alpha2=temp_blj_alpha2;
paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_beta2=temp_blj_beta2;
paramdata.commdata(1).parameter(6).ATTRIBUTE.blj_gamma2=temp_blj_gamma2;
paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_alpha= temp_SLcangzhong_alpha;
paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_beta= temp_SLcangzhong_beta;
paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_gamma= temp_SLcangzhong_gamma;
paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_alpha=temp_blj4_alpha;
paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_beta=temp_blj4_beta;
paramdata.commdata(1).parameter(19).ATTRIBUTE.blj4_gamma=temp_blj4_gamma;
paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_p=yaotou_p;
paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_i=yaotou_i;
paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_d=yaotou_d;
paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_p=douti_p;
paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_i=douti_i;
paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_d=douti_d;
paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p=gwfj_p;
paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i=gwfj_i;
paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d=gwfj_d;
paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_p=xhfj_p;
paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_i=xhfj_i;
paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_d=xhfj_d;
xml_write('param_set.xml',paramdata);

% --- Executes on button press in set_default.
function set_default_Callback(hObject, eventdata, handles)
% hObject    handle to set_default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global paramdata temp_fjl_alpha1 temp_fjl_lambda1 temp_fjl_alpha2 temp_fjl_lambda2
global temp_toumei_alpha temp_toumei_beta temp_toumei_gamma temp_toumei_alpha1 temp_toumei_beta1 temp_toumei_gamma1 temp_toumei_alpha2 temp_toumei_beta2 temp_toumei_gamma2
global temp_blj_alpha1 temp_blj_beta1 temp_blj_gamma1
global temp_blj_alpha2 temp_blj_beta2 temp_blj_gamma2
global yaotou_p yaotou_i yaotou_d
global temp_SLcangzhong_alpha temp_SLcangzhong_beta temp_SLcangzhong_gamma temp_SLcangzhong_alpha1 temp_SLcangzhong_beta1 temp_SLcangzhong_gamma1 temp_SLcangzhong_alpha2 temp_SLcangzhong_beta2 temp_SLcangzhong_gamma2
global douti_p douti_i douti_d gwfj_p gwfj_i gwfj_d xhfj_p xhfj_i xhfj_d
button2=questdlg('确定恢复默认值？','恢复默认值','Yes','No','Yes');
    
    
if strcmp(button2,'Yes')

    
    paramdata = xml_read('param_set.xml');

    %分解炉
    temp_fjl_alpha1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1;
    temp_fjl_lambda1 = paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1;
    temp_fjl_alpha2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2;
    temp_fjl_lambda2 = paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2;

    %头煤压力
    temp_toumei_alpha1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_a1;
    temp_toumei_beta1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta1;
    temp_toumei_gamma1 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_g1;
    
    temp_toumei_alpha2 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_a2;
    temp_toumei_beta2 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta2;
    temp_toumei_gamma2 = paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_g2;

    %篦冷机
    temp_blj_alpha1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1;
    temp_blj_beta1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1;
    temp_blj_gamma1 = paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1;

    temp_blj_alpha2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2;
    temp_blj_beta2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2;
    temp_blj_gamma2 = paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2;
    
    %生料仓重
    temp_SLcangzhong_alpha = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_alpha1;
    temp_SLcangzhong_beta = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_beta1;
    temp_SLcangzhong_gamma = paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_gamma1;
    
    yaotou_p = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_p;
    yaotou_i = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_i;
    yaotou_d = paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_d;
    douti_p = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_p;
    douti_i = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_i;
    douti_d = paramdata.commdata(1).parameter(26).ATTRIBUTE.douti_d;
    gwfj_p = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p;
    gwfj_i = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i;
    gwfj_d = paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d;
    xhfj_p = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_p;
    xhfj_i = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_i;
    xhfj_d = paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_d;


    %保存到xml
    paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_alpha1=temp_fjl_alpha1;
    paramdata.commdata(1).parameter(8).ATTRIBUTE.fjl_lambda1=temp_fjl_lambda1;
    paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_alpha2=temp_fjl_alpha2;
    paramdata.commdata(1).parameter(9).ATTRIBUTE.fjl_lambda2=temp_fjl_lambda2;
    
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_a1=temp_toumei_alpha1;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta1=temp_toumei_beta1;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_g1=temp_toumei_gamma1;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_a2=temp_toumei_alpha2;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_beta2=temp_toumei_beta2;
    paramdata.commdata(1).parameter(10).ATTRIBUTE.toumei_g2=temp_toumei_gamma2;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_alpha1=temp_blj_alpha1;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_beta1=temp_blj_beta1;
    paramdata.commdata(1).parameter(11).ATTRIBUTE.blj_gamma1=temp_blj_gamma1;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_alpha2=temp_blj_alpha2;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_beta2=temp_blj_beta2;
    paramdata.commdata(1).parameter(12).ATTRIBUTE.blj_gamma2=temp_blj_gamma2;
    
    paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_alpha=temp_SLcangzhong_alpha;
    paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_beta=temp_SLcangzhong_beta;
    paramdata.commdata(1).parameter(20).ATTRIBUTE.SLcangzhong_gamma=temp_SLcangzhong_gamma;
    
    paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_p=yaotou_p;
    paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_i=yaotou_i;
    paramdata.commdata(1).parameter(23).ATTRIBUTE.yaotou_d=yaotou_d;
    paramdata.commdata(1).parameter(26).ATTRIBUTE.yaotou_p=douti_p;
    paramdata.commdata(1).parameter(26).ATTRIBUTE.yaotou_i=douti_i;
    paramdata.commdata(1).parameter(26).ATTRIBUTE.yaotou_d=douti_d;
    paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_p=gwfj_p;
    paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_i=gwfj_i;
    paramdata.commdata(1).parameter(29).ATTRIBUTE.gwfj_d=gwfj_d;
    paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_p=xhfj_p;
    paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_i=xhfj_i;
    paramdata.commdata(1).parameter(31).ATTRIBUTE.xhfj_d=xhfj_d;
    xml_write('param_set.xml',paramdata);
    set(handles.save_state,'String','已恢复默认值');

    %显示初始值
    set(handles.fjl_alpha1,'String',temp_fjl_alpha1);
    set(handles.fjl_alpha1_slider,'Value',temp_fjl_alpha1);

    set(handles.fjl_lambda1,'String',temp_fjl_lambda1);
    set(handles.fjl_lambda1_slider,'Value',temp_fjl_lambda1);

    set(handles.fjl_alpha2,'String',temp_fjl_alpha2);
    set(handles.fjl_alpha2_slider,'Value',temp_fjl_alpha2);

    set(handles.fjl_lambda2,'String',temp_fjl_lambda2);
    set(handles.fjl_lambda2_slider,'Value',temp_fjl_lambda2);

    %头煤压力
    set(handles.toumei_p1,'String',temp_toumei_alpha1);
    set(handles.toumei_p1_slider,'Value',temp_toumei_alpha1);

    set(handles.toumei_i1,'String',temp_toumei_beta1);
    set(handles.toumei_i1_slider,'Value',temp_toumei_beta1);

    set(handles.toumei_d1,'String',temp_toumei_gamma1);
    set(handles.toumei_d1_slider,'Value',temp_toumei_gamma1);
    
    set(handles.toumei_p2,'String',temp_toumei_alpha2);
    set(handles.toumei_p2_slider,'Value',temp_toumei_alpha2);

    set(handles.toumei_i2,'String',temp_toumei_beta2);
    set(handles.toumei_i2_slider,'Value',temp_toumei_beta2);

    set(handles.toumei_d2,'String',temp_toumei_gamma2);
    set(handles.toumei_d2_slider,'Value',temp_toumei_gamma2);
    
    %窑头负压
    set(handles.yaotou_p,'String',yaotou_p);
    set(handles.yaotou_p_slider,'Value',yaotou_p);

    set(handles.yaotou_i,'String',yaotou_i);
    set(handles.yaotou_i_slider,'Value',yaotou_i);

    set(handles.yaotou_d,'String',yaotou_d);
    set(handles.yaotou_d_slider,'Value',yaotou_d);
    
    %高温风机
    set(handles.gwfj_p,'String',gwfj_p);
    set(handles.gwfj_p_slider,'Value',gwfj_p);

    set(handles.gwfj_i,'String',gwfj_i);
    set(handles.gwfj_i_slider,'Value',gwfj_i);

    set(handles.gwfj_d,'String',gwfj_d);
    set(handles.gwfj_d_slider,'Value',gwfj_d);
    
    %斗提电流
    set(handles.douti_p,'String',douti_p);
    set(handles.douti_p_slider,'Value',douti_p);

    set(handles.douti_i,'String',douti_i);
    set(handles.douti_i_slider,'Value',douti_i);

    set(handles.douti_d,'String',douti_d);
    set(handles.douti_d_slider,'Value',douti_d);
    
    %循环风机
    set(handles.xhfj_p,'String',xhfj_p);
    set(handles.xhfj_p_slider,'Value',xhfj_p);

    set(handles.xhfj_i,'String',douti_i);
    set(handles.xhfj_i_slider,'Value',douti_i);

    set(handles.xhfj_d,'String',xhfj_d);
    set(handles.xhfj_d_slider,'Value',xhfj_d);
    
    %篦冷机1
    formatSpec = '%4.4f';
    set(handles.blj_p1,'String',num2str(temp_blj_alpha1,formatSpec));
    set(handles.blj_p1_slider,'Value',temp_blj_alpha1);

    set(handles.blj_i1,'String',temp_blj_beta1);
    set(handles.blj_i1_slider,'Value',temp_blj_beta1);


    set(handles.blj_d1,'String',temp_blj_gamma1);
    set(handles.blj_d1_slider,'Value',temp_blj_gamma1);

    %篦冷机2
    set(handles.blj_p2,'String',num2str(temp_blj_alpha2,formatSpec));
    set(handles.blj_p2_slider,'Value',temp_blj_alpha2);

    set(handles.blj_i2,'String',temp_blj_beta2);
    set(handles.blj_i2_slider,'Value',temp_blj_beta2);

    set(handles.blj_d2,'String',temp_blj_gamma2);
    set(handles.blj_d2_slider,'Value',temp_blj_gamma2);

    %生料仓重
    formatSpec = '%4.4f';
    set(handles.SLcangzhong_p,'String',num2str(temp_SLcangzhong_alpha,formatSpec));
    set(handles.SLcangzhong_p_slider,'Value',temp_SLcangzhong_alpha);
    
    set(handles.SLcangzhong_i,'String',num2str(temp_SLcangzhong_beta,formatSpec));
    set(handles.SLcangzhong_i_slider,'Value',temp_SLcangzhong_beta);
    
    set(handles.SLcangzhong_d,'String',num2str(temp_SLcangzhong_gamma,formatSpec));
    set(handles.SLcangzhong_d_slider,'Value',temp_SLcangzhong_gamma);
end
   


function toumei_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_toumei_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_p1,'String',num2str(a,formatSpec));
temp_toumei_alpha1=str2double(get(handles.toumei_p1,'String'));

%--- Executes during object creation, after setting all properties.
function toumei_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_toumei_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_i1,'String',num2str(a,formatSpec));
temp_toumei_beta1=str2double(get(handles.toumei_i1,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_toumei_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_d1,'String',num2str(a,formatSpec));
temp_toumei_gamma1=str2double(get(handles.toumei_d1,'String'));

% --- Executes during object creation, after setting all properties.
function toumei_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_d1_slider (see GCBO)
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
formatSpec = '%3.2f';
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
formatSpec = '%3.2f';
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
function blj_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.blj_p1,'String',num2str(a,formatSpec));
temp_blj_alpha1=str2double(get(handles.blj_p1,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_i1,'String',num2str(a,formatSpec));
temp_blj_beta1=str2double(get(handles.blj_i1,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d1,'String',num2str(a,formatSpec));
temp_blj_gamma1=str2double(get(handles.blj_d1,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.blj_p2,'String',num2str(a,formatSpec));
temp_blj_alpha2=str2double(get(handles.blj_p2,'String'));

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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_i2,'String',num2str(a,formatSpec));
temp_blj_beta2=str2double(get(handles.blj_i2,'String'));

% --- Executes during object creation, after setting all properties.
function blj_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%3.2f';
set(handles.blj_d2,'String',num2str(a,formatSpec));
temp_blj_gamma2=str2double(get(handles.blj_d2,'String'));

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
function SLcangzhong_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_p,'String',num2str(a,formatSpec));
temp_SLcangzhong_alpha=str2double(get(handles.SLcangzhong_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLcangzhong_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_i,'String',num2str(a,formatSpec));
temp_SLcangzhong_beta=str2double(get(handles.SLcangzhong_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLcangzhong_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_d,'String',num2str(a,formatSpec));
temp_SLcangzhong_gamma=str2double(get(handles.SLcangzhong_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj4_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj4_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj4_alpha
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.blj4_p,'String',num2str(a,formatSpec));
temp_blj4_alpha=str2double(get(handles.blj4_p,'String'));

% --- Executes during object creation, after setting all properties.
function blj4_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj4_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj4_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj4_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj4_beta
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.blj4_i,'String',num2str(a,formatSpec));
temp_blj4_beta=str2double(get(handles.blj4_i,'String'));

% --- Executes during object creation, after setting all properties.
function blj4_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj4_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blj4_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to blj4_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global temp_blj4_gamma
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.blj4_d,'String',num2str(a,formatSpec));
temp_blj4_gamma=str2double(get(handles.blj4_d,'String'));


% --- Executes during object creation, after setting all properties.
function blj4_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj4_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaotou_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaotou_p
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.yaotou_p,'String',num2str(a,formatSpec));
yaotou_p=str2double(get(handles.yaotou_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaotou_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaotou_i
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.yaotou_i,'String',num2str(a,formatSpec));
yaotou_i=str2double(get(handles.yaotou_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaotou_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to yaotou_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaotou_d
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.yaotou_d,'String',num2str(a,formatSpec));
yaotou_d=str2double(get(handles.yaotou_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaotou_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaotou_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_p
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.douti_p,'String',num2str(a,formatSpec));
douti_p=str2double(get(handles.douti_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_i
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.douti_i,'String',num2str(a,formatSpec));
douti_i=str2double(get(handles.douti_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function douti_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to douti_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global douti_d
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.douti_d,'String',num2str(a,formatSpec));
douti_d=str2double(get(handles.douti_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function douti_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to douti_d_slider (see GCBO)
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
formatSpec = '%4.4f';
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
global gwfj_d
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.gwfj_d,'String',num2str(a,formatSpec));
gwfj_d=str2double(get(handles.gwfj_d,'String'));
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
function xhfj_p_slider_Callback(hObject, eventdata, handles)
% hObject    handle to xhfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xhfj_p
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.xhfj_p,'String',num2str(a,formatSpec));
xhfj_p=str2double(get(handles.xhfj_p,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function xhfj_p_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xhfj_p_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xhfj_i_slider_Callback(hObject, eventdata, handles)
% hObject    handle to xhfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xhfj_i
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.xhfj_i,'String',num2str(a,formatSpec));
xhfj_i=str2double(get(handles.xhfj_i,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function xhfj_i_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xhfj_i_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xhfj_d_slider_Callback(hObject, eventdata, handles)
% hObject    handle to xhfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xhfj_d
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.xhfj_d,'String',num2str(a,formatSpec));
xhfj_d=str2double(get(handles.xhfj_d,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function xhfj_d_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xhfj_d_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function blj_p1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blj_p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function SLcangzhong_p1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_alpha1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_p1,'String',num2str(a,formatSpec));
temp_SLcangzhong_alpha1=str2double(get(handles.SLcangzhong_p1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_p1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_p1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLcangzhong_i1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_beta1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_i1,'String',num2str(a,formatSpec));
temp_SLcangzhong_beta1=str2double(get(handles.SLcangzhong_i1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_i1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_i1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function SLcangzhong_d1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_SLcangzhong_gamma1
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.SLcangzhong_d1,'String',num2str(a,formatSpec));
temp_SLcangzhong_gamma1=str2double(get(handles.SLcangzhong_d1,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function SLcangzhong_d1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SLcangzhong_d1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_p2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_toumei_alpha2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_p2,'String',num2str(a,formatSpec));
temp_toumei_alpha2=str2double(get(handles.toumei_p2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toumei_p2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_p2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_i2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_toumei_beta2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_i2,'String',num2str(a,formatSpec));
temp_toumei_beta2=str2double(get(handles.toumei_i2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toumei_i2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_i2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function toumei_d2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to toumei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global temp_toumei_gamma2
a=get(hObject,'Value');%获取滑块当前值
formatSpec = '%4.4f';
set(handles.toumei_d2,'String',num2str(a,formatSpec));
temp_toumei_gamma2=str2double(get(handles.toumei_d2,'String'));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function toumei_d2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to toumei_d2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
