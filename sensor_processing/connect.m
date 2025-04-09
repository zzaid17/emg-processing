function [myDevice, flag] = connect(deviceManager, macID, BioRadioName)

myDevice = [];
flag = false;

try
    myDevice = deviceManager.GetBluetoothDevice(macID);
catch
    errordlg(['Failed to connect to ' BioRadioName '.'])
    return
end

flag = true;

end