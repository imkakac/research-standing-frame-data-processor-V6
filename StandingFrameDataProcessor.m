%Version 6 created by 08-22-2017
function varargout = StandingFrameDataProcessor(varargin)
% STANDINGFRAMEDATAPROCESSOR MATLAB code for StandingFrameDataProcessor2.fig
%      STANDINGFRAMEDATAPROCESSOR, by itself, creates a new STANDINGFRAMEDATAPROCESSOR or raises the existing
%      singleton*.
%
%      H = STANDINGFRAMEDATAPROCESSOR returns the handle to a new STANDINGFRAMEDATAPROCESSOR or the handle to
%      the existing singleton*.
%
%      STANDINGFRAMEDATAPROCESSOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STANDINGFRAMEDATAPROCESSOR.M with the given input arguments.
%
%      STANDINGFRAMEDATAPROCESSOR('Property','Value',...) creates a new STANDINGFRAMEDATAPROCESSOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StandingFrameDataProcessor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StandingFrameDataProcessor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StandingFrameDataProcessor

% Last Modified by GUIDE v2.5 22-Aug-2017 14:00:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StandingFrameDataProcessor_OpeningFcn, ...
                   'gui_OutputFcn',  @StandingFrameDataProcessor_OutputFcn, ...
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


% --- Executes just before StandingFrameDataProcessor is made visible.
function StandingFrameDataProcessor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StandingFrameDataProcessor (see VARARGIN)

% Choose default command line output for StandingFrameDataProcessor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StandingFrameDataProcessor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = StandingFrameDataProcessor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in readdata.
function openfile_Callback(hObject, eventdata, handles)
% hObject    handle to readdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [FileName,PathName] = uigetfile('*.dat','Open Standing Frame Data');
% set(handles.text1, 'String',FileName);
% set(handles.text2, 'String','File opened');
% handles.FileName = FileName;
% handles.PathName = PathName;
% guidata(hObject, handles);
% text1 = TimeFileName;
% text2 = 'opening...';


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


% --- Executes on button press in readdata.
function readdata_Callback(hObject, eventdata, handles)
% hObject    handle to readdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.dat','Open Standing Frame Data');
set(handles.text1, 'String',FileName);
Status = {'File opened'};
set(handles.text2, 'String',Status);
handles.FileName = FileName;
% handles.PathName = PathName;
guidata(hObject, handles);
Status = [Status;{'Reading File...'}];
set(handles.text2, 'String',Status);
pause(0.001);
% PathName = handles.PathName;
% FileName = handles.FileName;
StandingFrameFile = [PathName FileName];
HeaderFid = fopen(StandingFrameFile);

% for i = 1:4;tline = fgets(HeaderFid);end;
% tline = fgets(HeaderFid);
% Header = sscanf(tline, '%s', [1, inf]);

M1 = csvread(StandingFrameFile,5,0);

L_LC = M1(:,1:3);
R_LC = M1(:,4:6);
L_FP = M1(:,7:14);
R_FP = M1(:,15:22);

handles.L_LC = L_LC;
handles.R_LC = R_LC;
handles.L_FP = L_FP;
handles.R_FP = R_FP;


Status = [Status;{'Reading Done'}];
set(handles.text2, 'String',Status);


handles.Status = Status;
guidata(hObject, handles);

% --- Executes on button press in processdata.
function processdata_Callback(hObject, eventdata, handles)
% hObject    handle to processdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DeviceInfo = [0 0 0 0 0];
CheckLLC = get(handles.LLC, 'Value');
CheckRLC = get(handles.RLC, 'Value');
CheckLFP = get(handles.LFP, 'Value');
CheckRFP = get(handles.RFP, 'Value');
CheckFP4 = get(handles.FP4, 'Value');
DeviceInfo(1) = CheckLLC;
DeviceInfo(2) = CheckRLC;
DeviceInfo(3) = CheckLFP;
DeviceInfo(4) = CheckRFP;
DeviceInfo(5) = CheckFP4;

DeviceLabel = SelectedDevices (DeviceInfo);
ColumnHeader = HeaderofSelectedDevices (DeviceInfo);

Status = handles.Status;
Status = [Status;{DeviceLabel}];


FileName = handles.FileName;
File1 = FileName(1:end-4);
L_LC = handles.L_LC;
R_LC = handles.R_LC;
L_FP = handles.L_FP;
R_FP = handles.R_FP;

%%
ReCalInfo = [0 0 0 0];
ReCalLLC = get(handles.CalLLC, 'Value');
ReCalRLC = get(handles.CalRLC, 'Value');
ReCalLFP = get(handles.CalLFP, 'Value');
ReCalRFP = get(handles.CalRFP, 'Value');
ReCalInfo(1) = ReCalLLC;
ReCalInfo(2) = ReCalRLC;
ReCalInfo(3) = ReCalLFP;
ReCalInfo(4) = ReCalRFP;
LLC_offset = [0 0 0];
RLC_offset = [0 0 0];
LFP_offset = [0 0 0 0 0 0 0 0];
RFP_offset = [0 0 0 0 0 0 0 0];
if sum(ReCalInfo) ~= 0
    if ReCalInfo(1) ~= 0
        LLC_offset = [str2double(get(handles.LLCx, 'String')) ...
                      str2double(get(handles.LLCy, 'String')) ...
                      str2double(get(handles.LLCz, 'String'))];
        if isnan(LLC_offset)
            LLC_offset(isnan(LLC_offset)) = 0;
            h = msgbox('Non-numberic value inputted. Please check your input!', 'Error','error');
        end
        L_LC = ReCalibrate(L_LC, LLC_offset);
    end
    if ReCalInfo(2) ~= 0        
        RLC_offset = [str2double(get(handles.RLCx, 'String')) ...
                      str2double(get(handles.RLCy, 'String')) ...
                      str2double(get(handles.RLCz, 'String'))];
        if isnan(RLC_offset)
            RLC_offset(isnan(RLC_offset)) = 0;
            h = msgbox('Non-numberic value detected. Please check your recalibration input!', 'Error','error');
        end          
        R_LC = ReCalibrate(R_LC, RLC_offset);
    end
    if ReCalInfo(3) ~= 0        
        LFP_offset = [str2double(get(handles.LFPx12, 'String'))...
                      str2double(get(handles.LFPx34, 'String')) ...
                      str2double(get(handles.LFPy14, 'String'))...
                      str2double(get(handles.LFPy23, 'String')) ...
                      str2double(get(handles.LFPz1, 'String'))...
                      str2double(get(handles.LFPz2, 'String')) ...
                      str2double(get(handles.LFPz3, 'String'))...
                      str2double(get(handles.LFPz4, 'String'))];
        if isnan(LFP_offset)
            LFP_offset(isnan(LFP_offset)) = 0;
            h = msgbox('Non-numberic value inputted. Please check your input!', 'Error','error');
        end          
        L_FP = ReCalibrate(L_FP, LFP_offset);
    end
    if ReCalInfo(4) ~= 0        
        RFP_offset = [str2double(get(handles.RFPx12, 'String')) ...
                      str2double(get(handles.RFPx34, 'String')) ...
                      str2double(get(handles.RFPy14, 'String')) ...
                      str2double(get(handles.RFPy23, 'String')) ...
                      str2double(get(handles.RFPz1, 'String')) ...
                      str2double(get(handles.RFPz2, 'String')) ...
                      str2double(get(handles.RFPz3, 'String')) ...
                      str2double(get(handles.RFPz4, 'String'))];
        if isnan(RFP_offset)
            RFP_offset(isnan(RFP_offset)) = 0;
            h = msgbox('Non-numberic value inputted. Please check your input!', 'Error','error');
        end          
        R_FP = ReCalibrate(R_FP, RFP_offset);
    end
%     [L_LC, R_LC, L_FP, R_FP] = ReCalibrate(L_LC, R_LC, L_FP, R_FP, ...
%                                LLC_offset, RLC_offset, LFP_offset, RFP_offset);
    Status = [Status;{'Recalibration done!'}];
    set(handles.text2, 'String', Status);
    
    handles.LLC_offset = LLC_offset;
    handles.RLC_offset = RLC_offset;
    handles.LFP_offset = LFP_offset;
    handles.RFP_offset = RFP_offset;
    
    set(handles.LLC_offset,'Value')
    set(handles.RLC_offset,'Value')
    set(handles.LFP_offset,'Value')
    set(handles.RFP_offset,'Value')
    
    L_LC = newL_LC;
    R_LC = newR_LC;
    L_FP = newL_FP;
    R_FP = newR_FP;
    
end
handles.ReCalInfo = ReCalInfo;
% set(handles.ReCalInfo,'Value')

%%
[FinalData, FileSuffix, StatusText] = DataofSelectedDevices (DeviceInfo, L_LC, R_LC, L_FP, R_FP);

if DeviceInfo == [0 0 0 0 0]
    h = msgbox('Select Output Data', 'Error','error');
    set(handles.text2, 'String',Status);
else
    
%     set(handles.text2, 'String',num2str(size(FinalData)));
    columnHeader1 = sprintf(ColumnHeader); 
%     columnHeader1 = sprintf('RESEARCH STANDING FRAME DATA\nSCAN_RATE: 2000.0000\nSAMPLE_PER_PULSE: 250\n\nLLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz\n');  
    [file,path] = uiputfile([File1 FileSuffix],'Save Data As');
    c = [path file];
    fid = fopen(c,'w');
    fprintf(fid, '%s', columnHeader1);
    fclose(fid);
    Status = [Status;{StatusText}];
    set(handles.text2, 'String',Status);
    pause(0.001);
%   dlmwrite(c ,FinalData,'-append','delimiter',',','newline','pc');
%    dlmwrite(c ,FinalData,'-append','delimiter',','); %does not work with data processor
    % modified 07/13/2017 add precision
    dlmwrite(c ,FinalData,'-append','delimiter',',','precision','%.3f','newline','pc');
    Status = [Status;{'Saving done!'}];
    set(handles.text2, 'String', Status);
end
handles.Status = Status;
guidata(hObject, handles);

% --- Executes on button press in Validate.
% function Validate_Callback(hObject, eventdata, handles)
% % hObject    handle to Validate (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% % Status = handles.Status;
% ReCalInfo = handles.ReCalInfo;
% 
% if sum(ReCalInfo) == 0
%     h = msgbox('Please recalibrate the data first!', 'Error','error');
% else
%     LLC_offset = handles.LLC_offset;
%     RLC_offset = handles.RLC_offset;
%     LFP_offset = handles.LFP_offset;
%     RFP_offset = handles.RFP_offset;
%     DiffLLCx1 = LLC_offset(1);DiffLLCy1 = LLC_offset(2);DiffLLCz1 = LLC_offset(3);
%     DiffRLCx1 = RLC_offset(1);DiffRLCy1 = RLC_offset(2);DiffRLCz1 = RLC_offset(3);
%     DiffLFPx1 = sum(LFP_offset(1:2));DiffLFPy1 = sum(LFP_offset(3:4));DiffLFPz1 = sum(LFP_offset(5:8));
%     DiffRFPx1 = sum(RFP_offset(1:2));DiffRFPy1 = sum(RFP_offset(3:4));DiffRFPz1 = sum(RFP_offset(5:8));
% 
%     [FileName,PathName] = uigetfile('*.txt','Open Old Standing Frame Data');
%     OldStandingFrameFile = [PathName FileName];
%     M1 = csvread(OldStandingFrameFile,5,0);
% 
%     [FileName,PathName] = uigetfile('*.txt','Open New Standing Frame Data');
%     NewStandingFrameFile = [PathName FileName];
%     M2 = csvread(NewStandingFrameFile,5,0);
% 
%     Difference = M1-M2;
%     RealDiff = mean(Difference);
%     DiffLLCx2 = RealDiff(1);DiffLLCy2 = RealDiff(2);DiffLLCz2 = RealDiff(3);
%     DiffRLCx2 = RealDiff(4);DiffRLCy2 = RealDiff(5);DiffRLCz2 = RealDiff(6);
%     DiffLFPx2 = RealDiff(9);DiffLFPy2 = RealDiff(10);DiffLFPz2 = RealDiff(11);
%     DiffRFPx2 = RealDiff(14);DiffRFPy2 = RealDiff(15);DiffRFPz2 = RealDiff(16);
%     Status = [{'Saving done!'}; ['Expected difference is:' ...
%     'LLC (x:' num2str(DiffLLCx1) ' y:' num2str(DiffLLCy1) ' z:' num2str(DiffLLCz1) '); '... 
%     'RLC (x:' num2str(DiffRLCx1) ' y:' num2str(DiffRLCy1) ' z:' num2str(DiffRLCz1) '); '...
%     'LFP (x:' num2str(DiffLFPx1) ' y:' num2str(DiffLFPy1) ' z:' num2str(DiffLFPz1) '); '...
%     'RFP (x:' num2str(DiffRFPx1) ' y:' num2str(DiffRFPy1) ' z:' num2str(DiffRFPz1) ')'];
%     ['Real difference is:'...
%     'LLC (x:' num2str(DiffLLCx2) ' y:' num2str(DiffLLCy2) ' z:' num2str(DiffLLCz2) '); '...
%     'RLC (x:' num2str(DiffRLCx2) ' y:' num2str(DiffRLCy2) ' z:' num2str(DiffRLCz2) '); '...
%     'LFP (x:' num2str(DiffLFPx2) ' y:' num2str(DiffLFPy2) ' z:' num2str(DiffLFPz2) '); '...
%     'RFP (x:' num2str(DiffRFPx2) ' y:' num2str(DiffRFPy2) ' z:' num2str(DiffRFPz2) ')']];
%     set(handles.text2, 'String', Status);
% end
% --- Exec
function display_Callback(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display as text
%        str2double(get(hObject,'String')) returns contents of display as a double


% --- Executes during object creation, after setting all properties.
function display_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LLC.
function LLC_Callback(hObject, eventdata, handles)
% hObject    handle to LLC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LLC


% --- Executes on button press in RLC.
function RLC_Callback(hObject, eventdata, handles)
% hObject    handle to RLC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RLC


% --- Executes on button press in LFP.
function LFP_Callback(hObject, eventdata, handles)
% hObject    handle to LFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LFP


% --- Executes on button press in RFP.
function RFP_Callback(hObject, eventdata, handles)
% hObject    handle to RFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RFP


% --- Executes on button press in CalLLC.
function CalLLC_Callback(hObject, eventdata, handles)
% hObject    handle to CalLLC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CalLLC


% --- Executes on button press in CalRLC.
function CalRLC_Callback(hObject, eventdata, handles)
% hObject    handle to CalRLC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CalRLC


% --- Executes on button press in CalLFP.
function CalLFP_Callback(hObject, eventdata, handles)
% hObject    handle to CalLFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CalLFP


% --- Executes on button press in CalRFP.
function CalRFP_Callback(hObject, eventdata, handles)
% hObject    handle to CalRFP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CalRFP



function LLCx_Callback(hObject, eventdata, handles)
% hObject    handle to LLCx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LLCx as text
%        str2double(get(hObject,'String')) returns contents of LLCx as a double


% --- Executes during object creation, after setting all properties.
function LLCx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LLCx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LLCy_Callback(hObject, eventdata, handles)
% hObject    handle to LLCy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LLCy as text
%        str2double(get(hObject,'String')) returns contents of LLCy as a double


% --- Executes during object creation, after setting all properties.
function LLCy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LLCy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LLCz_Callback(hObject, eventdata, handles)
% hObject    handle to LLCz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LLCz as text
%        str2double(get(hObject,'String')) returns contents of LLCz as a double


% --- Executes during object creation, after setting all properties.
function LLCz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LLCz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RLCx_Callback(hObject, eventdata, handles)
% hObject    handle to RLCx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RLCx as text
%        str2double(get(hObject,'String')) returns contents of RLCx as a double


% --- Executes during object creation, after setting all properties.
function RLCx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RLCx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RLCy_Callback(hObject, eventdata, handles)
% hObject    handle to RLCy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RLCy as text
%        str2double(get(hObject,'String')) returns contents of RLCy as a double


% --- Executes during object creation, after setting all properties.
function RLCy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RLCy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RLCz_Callback(hObject, eventdata, handles)
% hObject    handle to RLCz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RLCz as text
%        str2double(get(hObject,'String')) returns contents of RLCz as a double


% --- Executes during object creation, after setting all properties.
function RLCz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RLCz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPx12_Callback(hObject, eventdata, handles)
% hObject    handle to LFPx12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPx12 as text
%        str2double(get(hObject,'String')) returns contents of LFPx12 as a double


% --- Executes during object creation, after setting all properties.
function LFPx12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPx12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPx34_Callback(hObject, eventdata, handles)
% hObject    handle to LFPx34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPx34 as text
%        str2double(get(hObject,'String')) returns contents of LFPx34 as a double


% --- Executes during object creation, after setting all properties.
function LFPx34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPx34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPy14_Callback(hObject, eventdata, handles)
% hObject    handle to LFPy14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPy14 as text
%        str2double(get(hObject,'String')) returns contents of LFPy14 as a double


% --- Executes during object creation, after setting all properties.
function LFPy14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPy14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPy23_Callback(hObject, eventdata, handles)
% hObject    handle to LFPy23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPy23 as text
%        str2double(get(hObject,'String')) returns contents of LFPy23 as a double


% --- Executes during object creation, after setting all properties.
function LFPy23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPy23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPz1_Callback(hObject, eventdata, handles)
% hObject    handle to LFPz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPz1 as text
%        str2double(get(hObject,'String')) returns contents of LFPz1 as a double


% --- Executes during object creation, after setting all properties.
function LFPz1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPz2_Callback(hObject, eventdata, handles)
% hObject    handle to LFPz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPz2 as text
%        str2double(get(hObject,'String')) returns contents of LFPz2 as a double


% --- Executes during object creation, after setting all properties.
function LFPz2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPz3_Callback(hObject, eventdata, handles)
% hObject    handle to LFPz3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPz3 as text
%        str2double(get(hObject,'String')) returns contents of LFPz3 as a double


% --- Executes during object creation, after setting all properties.
function LFPz3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPz3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LFPz4_Callback(hObject, eventdata, handles)
% hObject    handle to LFPz4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LFPz4 as text
%        str2double(get(hObject,'String')) returns contents of LFPz4 as a double


% --- Executes during object creation, after setting all properties.
function LFPz4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LFPz4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPx12_Callback(hObject, eventdata, handles)
% hObject    handle to RFPx12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPx12 as text
%        str2double(get(hObject,'String')) returns contents of RFPx12 as a double


% --- Executes during object creation, after setting all properties.
function RFPx12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPx12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPx34_Callback(hObject, eventdata, handles)
% hObject    handle to RFPx34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPx34 as text
%        str2double(get(hObject,'String')) returns contents of RFPx34 as a double


% --- Executes during object creation, after setting all properties.
function RFPx34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPx34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPy14_Callback(hObject, eventdata, handles)
% hObject    handle to RFPy14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPy14 as text
%        str2double(get(hObject,'String')) returns contents of RFPy14 as a double


% --- Executes during object creation, after setting all properties.
function RFPy14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPy14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPy23_Callback(hObject, eventdata, handles)
% hObject    handle to RFPy23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPy23 as text
%        str2double(get(hObject,'String')) returns contents of RFPy23 as a double


% --- Executes during object creation, after setting all properties.
function RFPy23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPy23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPz1_Callback(hObject, eventdata, handles)
% hObject    handle to RFPz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPz1 as text
%        str2double(get(hObject,'String')) returns contents of RFPz1 as a double


% --- Executes during object creation, after setting all properties.
function RFPz1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPz1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPz2_Callback(hObject, eventdata, handles)
% hObject    handle to RFPz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPz2 as text
%        str2double(get(hObject,'String')) returns contents of RFPz2 as a double


% --- Executes during object creation, after setting all properties.
function RFPz2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPz2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPz3_Callback(hObject, eventdata, handles)
% hObject    handle to RFPz3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPz3 as text
%        str2double(get(hObject,'String')) returns contents of RFPz3 as a double


% --- Executes during object creation, after setting all properties.
function RFPz3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPz3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RFPz4_Callback(hObject, eventdata, handles)
% hObject    handle to RFPz4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RFPz4 as text
%        str2double(get(hObject,'String')) returns contents of RFPz4 as a double


% --- Executes during object creation, after setting all properties.
function RFPz4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RFPz4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FP4.
function FP4_Callback(hObject, eventdata, handles)
% hObject    handle to FP4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of FP4
