function [BioRadioName, macID, ok] = find_device(deviceManager)

dlghandle = helpdlg('Searching for devices...');

try
    BioRadioList = deviceManager.DiscoverBluetoothDevices;
    numavail = BioRadioList.Length; 
catch
    numavail = 0;
end

close(dlghandle)

% Check available BioRadio devices
if numavail<1
    BioRadioName = [];
    macID = [];
    ok = [];
    return
end

availableBioRadios = cell(numavail,1);
macIDs = cell(numavail,1);

for i=1:numavail
    availableBioRadios{i} = char(BioRadioList(i).DeviceId); % Device name
    macIDs{i} = hex2dec(char(BioRadioList(i).MacId)); % MAC ID
end

[selection, ok] = listdlg('PromptString','Select a BioRadio:',...
    'SelectionMode','single','ListString',availableBioRadios); % Select

% Check selection flag
if ok==0
    BioRadioName = [];
    macID = [];
    ok = [];
    return
else
    BioRadioName = availableBioRadios{selection};
    macID = macIDs{selection};
end

end