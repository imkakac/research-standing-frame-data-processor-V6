%Header for Selected Devices
function ColumnHeader = HeaderofSelectedDevices (DeviceInfo)
CommonHeader = 'RESEARCH STANDING FRAME DATA\nSCAN_RATE: 2000.0000\nSAMPLE_PER_PULSE: 250\n\n';
if DeviceInfo == [0 0 0 0 0]
    SuffixHeader = 'No device is selected!'; %0
elseif DeviceInfo == [0 0 0 1 0]
    SuffixHeader = 'RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%1
elseif DeviceInfo == [0 0 1 0 0]
    SuffixHeader = 'LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz';%2
elseif DeviceInfo == [0 0 1 1 0]
    SuffixHeader = 'LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%3
elseif DeviceInfo == [0 1 0 0 0]
    SuffixHeader = 'RLC-X,RLC-Y,RLC-Z';%4
elseif DeviceInfo == [0 1 0 1 0]
    SuffixHeader = 'RLC-X,RLC-Y,RLC-Z,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%5
elseif DeviceInfo == [0 1 1 0 0]
    SuffixHeader = 'RLC-X,RLC-Y,RLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz';%6
elseif DeviceInfo == [0 1 1 1 0]
    SuffixHeader = 'RLC-X,RLC-Y,RLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%7
elseif DeviceInfo == [1 0 0 0 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z';%8    
elseif DeviceInfo == [1 0 0 1 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%9
elseif DeviceInfo == [1 0 1 0 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz';%10
elseif DeviceInfo == [1 0 1 1 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%11
elseif DeviceInfo == [1 1 0 0 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z';%12
elseif DeviceInfo == [1 1 0 1 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%13
elseif DeviceInfo == [1 1 1 0 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz';%14
elseif DeviceInfo == [1 1 1 1 0]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z,LFP-X COP,LFP-Y COP,LFP-Fx,LFP-Fy,LFP-Fz,RFP-X COP,RFP-Y COP,RFP-Fx,RFP-Fy,RFP-Fz';%15
elseif DeviceInfo == [0 0 0 0 1]
    SuffixHeader = 'FP4-X COP,FP4-Y COP,FP4-Fx,FP4-Fy,FP4-Fz';%17
elseif DeviceInfo == [1 1 0 0 1]
    SuffixHeader = 'LLC-X,LLC-Y,LLC-Z,RLC-X,RLC-Y,RLC-Z, FP4-X COP,FP4-Y COP,FP4-Fx,FP4-Fy,FP4-Fz';%18
else
    SuffixHeader = 'Invalid selection!'; %19
end
    ColumnHeader = [CommonHeader SuffixHeader '\n'];