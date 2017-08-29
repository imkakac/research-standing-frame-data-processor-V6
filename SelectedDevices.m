%Selected Devices
function DeviceLabel = SelectedDevices (DeviceInfo)
if DeviceInfo == [0 0 0 0 0]
    DeviceLabel = 'No device is selected!'; %0
elseif DeviceInfo == [0 0 0 1 0]
    DeviceLabel = 'Right force plate is selected';%1
elseif DeviceInfo == [0 0 1 0 0]
    DeviceLabel = 'Left force plate is selected';%2
elseif DeviceInfo == [0 0 1 1 0]
    DeviceLabel = 'Left & right right force plates are selected';%3
elseif DeviceInfo == [0 1 0 0 0]
    DeviceLabel = 'Right load cell is selected';%4
elseif DeviceInfo == [0 1 0 1 0]
    DeviceLabel = 'Right load cell and right force plate are selected';%5
elseif DeviceInfo == [0 1 1 0 0]
    DeviceLabel = 'Right load cell and left force plate are selected';%6
elseif DeviceInfo == [0 1 1 1 0]
    DeviceLabel = 'Right load cell and left & right force plates are selected';%7
elseif DeviceInfo == [1 0 0 0 0]
    DeviceLabel = 'Left load cell is selected';%8    
elseif DeviceInfo == [1 0 0 1 0]
    DeviceLabel = 'Left load cell and right force plate are selected';%9
elseif DeviceInfo == [1 0 1 0 0]
    DeviceLabel = 'Left load cell and left force plate are selected';%10
elseif DeviceInfo == [1 0 1 1 0]
    DeviceLabel = 'Left load cell and left & right force plates are selected';%11
elseif DeviceInfo == [1 1 0 0 0]
    DeviceLabel = 'Left & right load cells are selected';%12
elseif DeviceInfo == [1 1 0 1 0]
    DeviceLabel = 'Left & right load cells and right force plate are selected';%13
elseif DeviceInfo == [1 1 1 0 0]
    DeviceLabel = 'Left & right load cells and left force plate are selected';%14
elseif DeviceInfo == [1 1 1 1 0]
    DeviceLabel = 'Left & right load cells and left & right force plates are selected';%15
elseif DeviceInfo == [0 0 0 0 1]
    DeviceLabel = 'Force plate 4 is selected';%16
elseif DeviceInfo == [1 1 0 0 1]
    DeviceLabel = 'Left & right load cells and force plate 4 is selected';%17
else 
    DeviceLabel = 'Invalid selection!';%18
    h = msgbox('Invalid selection!', 'Error','error');
    set(handles.text2, 'String',Status);
end


