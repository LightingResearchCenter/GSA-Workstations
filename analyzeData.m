function analyzeData
%ANALYZEDATA Summary of this function goes here
%   Detailed explanation goes here

csThreshold = 0.005;
luxThreshold = 0.005;

h_i = 8;
h_f = 5 + 12;

[githubPath,~,~] = fileparts(pwd);
circadianPath = fullfile(githubPath,'circadian');
addpath(circadianPath);

% Load preprocessed data from file
temp = load('data.mat');
data = temp.data;
weatherLog = temp.weatherLog;

% Preallocate variables
nLoc = numel(data.locationID);
varNames = {'building','session','locationID','deviceSN',...
    'desk','windowProx','daylightExposure','orientation','wing','floor','type',...
    'ariMean_allLux','geoMean_allLux','ariMean_allCs',...
    'ariMean_sunnyLux','geoMean_sunnyLux','ariMean_sunnyCs',...
    'ariMean_cloudyLux','geoMean_cloudyLux','ariMean_cloudyCs'};
a = NaN(nLoc,h_f-h_i);
b = cell(nLoc,1);
result = table(data.building,data.session,data.locationID,data.deviceSN,...
    b,b,b,b,b,b,b,...
    a,a,a,a,a,a,a,a,a,'VariableNames',varNames);

% Analyze data
for iLoc = 1:nLoc
    absTime = data.absTime{iLoc};
    light = data.light{iLoc};
    masks = data.masks{iLoc};
    building = data.building{iLoc};
    session = data.session{iLoc};
    logID = data.logID(iLoc);
    thisWeatherLog = weatherLog(weatherLog.logID==logID,:);
    
    % Apply threshold to CS and illuminance
    light.cs(light.cs < csThreshold) = csThreshold;
    light.illuminance(light.illuminance < luxThreshold) = luxThreshold;
    
    % TRUE = remove, FALSE = keep
    baseMask = makeBaseMask(masks, absTime, building, session);
    [sunnyMask,cloudyMask] = makeWeatherMasks(baseMask, absTime, thisWeatherLog, building, session);
    
    % All data summary
    result.ariMean_allLux(iLoc,:) = hourlySummary(absTime,light.illuminance,baseMask,@mean,h_i,h_f);
    result.geoMean_allLux(iLoc,:) = hourlySummary(absTime,light.illuminance,baseMask,@geomean,h_i,h_f);
    result.ariMean_allCs(iLoc,:)  = hourlySummary(absTime,light.cs,baseMask,@mean,h_i,h_f);
    
    % Sunny data summary
    result.ariMean_sunnyLux(iLoc,:) = hourlySummary(absTime,light.illuminance,sunnyMask,@mean,h_i,h_f);
    result.geoMean_sunnyLux(iLoc,:) = hourlySummary(absTime,light.illuminance,sunnyMask,@geomean,h_i,h_f);
    result.ariMean_sunnyCs(iLoc,:)  = hourlySummary(absTime,light.cs,sunnyMask,@mean,h_i,h_f);
    
    % Cloudy data summary
    result.ariMean_cloudyLux(iLoc,:) = hourlySummary(absTime,light.illuminance,cloudyMask,@mean,h_i,h_f);
    result.geoMean_cloudyLux(iLoc,:) = hourlySummary(absTime,light.illuminance,cloudyMask,@geomean,h_i,h_f);
    result.ariMean_cloudyCs(iLoc,:)  = hourlySummary(absTime,light.cs,cloudyMask,@mean,h_i,h_f);
    
    [result.desk{iLoc}, result.windowProx{iLoc}, result.daylightExposure{iLoc},...
        result.orientation{iLoc}, result.wing{iLoc}, result.floor{iLoc}, result.type{iLoc}] = ...
        decomposeLocationID(data.locationID{iLoc});
end

% Find and remove window data
windowIdx = strcmpi(result.type,'window');
result(windowIdx,:) = [];

% Save analysis results
save('result.mat','result');

end

