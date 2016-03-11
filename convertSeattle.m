function [absTime, relTime, epoch, light, activity, masks, locationID, deviceSN] = convertSeattle(rawTable,filePath)
%CONVERTSEATTLE Summary of this function goes here
%   Detailed explanation goes here

% Decompose file name
[~,fileName,~] = fileparts(filePath);
deviceSN = regexprep(fileName,'\D*(\d*)\D*','$1');
locationID = deviceSN;

% Convert the time to custom time classes
t = datevec(rawTable.Time);
absTime = absolutetime(t,'datevec',false,-8,'hours');
relTime = relativetime(absTime);

% Find the most frequent sampling rate.
epochSeconds = mode(diff(relTime.seconds));

% Create a samplingrate object called epoch.
epoch = samplingrate(epochSeconds,'seconds');

% Prepare light data

illuminance = rawTable.Lux;
illuminance(illuminance<0) = 0;
cla = rawTable.CLA;
cla(cla<0) = 0;

% Create an instance of lightmetrics
light = lightmetrics('illuminance',illuminance,'cla',cla);

% Reassign activity as a vertical array
activity = rawTable.Activity;


observation = true(size(absTime.localDateNum));
compliance = true(size(absTime.localDateNum));
bed = false(size(absTime.localDateNum));

% Create eventmasks object called masks.
masks = eventmasks('observation',observation,'compliance',compliance,...
    'bed',bed);

end

