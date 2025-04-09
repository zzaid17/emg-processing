% Load BioRadio API
current_dir = cd;

[deviceManager , flag] = load_API([current_dir '\BioRadioSDK.dll']);
% The DLL can be found on the Great Lakes NeuroTechnologies as part of the
% BioRadio SDK.

% Test for API flag
if ~flag
    return
end

% Search for sensors
[deviceName, macID, ok] = find_device(deviceManager);

% Test for sensor flag
if ~ok
    errordlg('Please select your device.')
    return
end

% Initialize BioRadio object
[myDevice, flag] = connect(deviceManager, macID, deviceName);

% Test for collection flag
if ~flag
    return
end

% Begin streaming data
duration = 100; % Stream for 100 seconds
BioRadioData = stream(myDevice, duration, deviceName);

% Disconnect
disconnect_device(myDevice)