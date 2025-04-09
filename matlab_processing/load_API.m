function [deviceManager , flag] = load_API(filepath)

switch nargin
    case 0 % If filepath not provided, prompt user to select dll
        [filename,pathname] = uigetfile('*.dll','Select the API dll file.');
        try
            asmInfo = NET.addAssembly([pathname filename]);
            deviceManager = GLNeuroTech.Devices.BioRadio.BioRadioDeviceManager;
            flag = true;
        catch
            errordlg('Invalid file selection.')
            flag = false;
            deviceManager = [];
            return
        end
    case 1 % If filepath provided, use user input to select dll
        try
            asmInfo = NET.addAssembly(filepath);
            deviceManager = GLNeuroTech.Devices.BioRadio.BioRadioDeviceManager;
            flag = true;
            return
        catch
            errordlg('Invalid file selection.')
            flag = false;
            deviceManager = [];
            return
        end
    otherwise % if more than two inputs provided, error out
        errordlg('Invalid file selection.')
        flag = false;
        deviceManager = [];
        return
end

end