%Header for Selected Devices
function [FinalData, FileSuffix, StatusText] = DataofSelectedDevices (DeviceInfo, L_LC, R_LC, L_FP, R_FP)
% CommonHeader = 'RESEARCH STANDING FRAME DATA\nSCAN_RATE: 2000.0000\nSAMPLE_PER_PULSE: 250\n\n';
transferMatrix = [0 -1; 1 0];
if DeviceInfo == [0 0 0 0 0]%0
    FinalData = nan;
    FileSuffix = nan;
    StatusText = nan;
elseif DeviceInfo == [0 0 0 1 0]%1
    R_FP_COP = COPcal_V2 (R_FP);
    R_FP_COP(:,1:2) = R_FP_COP(:,1:2)*transferMatrix;
    FinalData = [R_FP_COP];
    FileSuffix = '_RFP.txt';
    StatusText = 'Saving right force plate data... ';
elseif DeviceInfo == [0 0 1 0 0]%2
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    FinalData = L_FP_COP;
    FileSuffix = '_LFP.txt';
    StatusText = 'Saving left force plate data... ';
elseif DeviceInfo == [0 0 1 1 0]%3
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    R_FP_COP = COPcal_V2 (R_FP);
    R_FP_COP(:,1:2) = R_FP_COP(:,1:2)*transferMatrix;
    FinalData = [L_FP_COP R_FP_COP];
    FileSuffix = '_L&RFP.txt';
    StatusText = 'Saving left & right force plate data... ';
elseif DeviceInfo == [0 1 0 0 0]%4
    FinalData = R_LC;
    FileSuffix = '_RLC.txt';
    StatusText = 'Saving right load cell data... ';
elseif DeviceInfo == [0 1 0 1 0]%5
    R_FP_COP = COPcal_V2 (R_FP);
    FinalData = [R_LC R_FP_COP];
    FileSuffix = '_RLC_RFP.txt';
    StatusText = 'Saving right load cell and right force plate data... ';
elseif DeviceInfo == [0 1 1 0 0]%6
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    FinalData = [R_LC L_FP_COP];
    FileSuffix = '_RLC_LFP.txt';
    StatusText = 'Saving right load cell and left force plate data... ';
elseif DeviceInfo == [0 1 1 1 0]%7
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    R_FP_COP = COPcal_V2 (R_FP);
    R_FP_COP(:,1:2) = R_FP_COP(:,1:2)*transferMatrix;
    FinalData = [R_LC L_FP_COP R_FP_COP];
    FileSuffix = '_RLC_L&RFP.txt';
    StatusText = 'Saving right load cell and left & right force plate data... ';
elseif DeviceInfo == [1 0 0 0 0]%8   
    FinalData = L_LC; 
    FileSuffix = '_LLC.txt';
    StatusText = 'Saving left load cell data... ';
elseif DeviceInfo == [1 0 0 1 0]%9
    R_FP_COP = COPcal_V2 (R_FP);
    FinalData = [L_LC R_FP_COP];
    FileSuffix = '_LLC_RFP.txt';
    StatusText = 'Saving left load cell and right force plate data... ';
elseif DeviceInfo == [1 0 1 0 0]%10
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    FinalData = [L_LC L_FP_COP];
    FileSuffix = '_LLC_RFP.txt';
    StatusText = 'Saving left load cell and left force plate data... ';
elseif DeviceInfo == [1 0 1 1 0]%11
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    R_FP_COP = COPcal_V2 (R_FP);
    R_FP_COP(:,1:2) = R_FP_COP(:,1:2)*transferMatrix;
    FinalData = [L_LC L_FP_COP R_FP_COP];
    FileSuffix = '_LLC_L&RFP.txt';
    StatusText = 'Saving left load cell and left & right force plate data... ';
elseif DeviceInfo == [1 1 0 0 0]%12
    FinalData = [L_LC R_LC];
    FileSuffix = '_L&RLC.txt';
    StatusText = 'Saving left & right load cell data... ';
elseif DeviceInfo == [1 1 0 1 0]%13
    R_FP_COP = COPcal_V2 (R_FP)*transferMatrix;
    FinalData = [L_LC R_LC R_FP_COP];
    FileSuffix = '_L&RLC_RFP.txt';
    StatusText = 'Saving left & right load cell and right force plate data... ';
elseif DeviceInfo == [1 1 1 0 0]%14
    L_FP_COP = COPcal_V2 (L_FP);
    FinalData = [L_LC R_LC L_FP_COP];
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    FileSuffix = '_L&RLC_LFP.txt';
    StatusText = 'Saving left & right load cell and left force plate data... ';
elseif DeviceInfo == [1 1 1 1 0]%15
    L_FP_COP = COPcal_V2 (L_FP);
    L_FP_COP(:,1:2) = L_FP_COP(:,1:2)*transferMatrix;
    R_FP_COP = COPcal_V2 (R_FP);
    R_FP_COP(:,1:2) = R_FP_COP(:,1:2)*transferMatrix;
    FinalData = [L_LC R_LC L_FP_COP R_FP_COP];
    FileSuffix = '_L&RLC_L&RFP.txt';
    StatusText = 'Saving left & right load cell and left & right force plate data... ';
elseif DeviceInfo == [0 0 0 0 1]%16
    R_FP_COP = COPcal_V2 (R_FP);
    FinalData = [R_FP_COP];
    FileSuffix = '_FP4.txt';
    StatusText = 'Saving force plate 4 data... ';
elseif DeviceInfo == [1 1 0 0 1]%17
    R_FP_COP = COPcal_V2 (R_FP);
    FinalData = [L_LC R_LC R_FP_COP];
    FileSuffix = '_L&RLC_FP4.txt';
    StatusText = 'Saving left & right load cell and force plate 4 data... ';
else
    FinalData = nan;
    FileSuffix = nan;
    StatusText = 'Invalid selection! ';
end