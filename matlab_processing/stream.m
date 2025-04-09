function BioRadioData = stream(myDevice, duration, BioRadio_Name)

% Initialize
if myDevice.BioPotentialSignals.Count == 0
    myDevice.Disconnect;
    BioRadioData = [];
    errordlg('No biopotential channels programmed. Reconnect to the device and program the channels.');
    return
end

sampleRate = double(myDevice.BioPotentialSignals.SamplesPerSecond);
plotWindow = 5;
channelIndex = 0;  % 0-based indexing for first channel

BioPotentialData = [];

% Initialize plot
figure;
title([char(BioRadio_Name)]);
ylabel([char(myDevice.BioPotentialSignals.Item(channelIndex).Name) ' (V)']);
xlabel('Time (s)');
hold on;

% Start acquisition
myDevice.StartAcquisition;
elapsedTime = 0;
tic;

while elapsedTime < duration
    pause(0.08);
    
    % Retrive data
    newData = myDevice.BioPotentialSignals.Item(channelIndex).GetScaledValueArray.double';
    BioPotentialData = [BioPotentialData; newData];
    
    % Plot
    if length(BioPotentialData) > plotWindow * sampleRate
        t = ((length(BioPotentialData) - plotWindow * sampleRate + 1):length(BioPotentialData)) / sampleRate;
        plot(t, BioPotentialData(end - plotWindow * sampleRate + 1:end));
        xlim([t(1), t(end)]);
    else
        t = (0:(length(BioPotentialData) - 1)) / sampleRate;
        plot(t, BioPotentialData);
        xlim([0, plotWindow]);
    end
    
    % Print to CSV
    if length(BioPotentialData) >= 200
        emg_window = BioPotentialData(end - 199:end);
        writematrix(emg_window, 'data/live_data.csv');
    end

    elapsedTime = elapsedTime + toc;
    tic;
end

% Stop
myDevice.StopAcquisition;
BioRadioData = BioPotentialData;

end