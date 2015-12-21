function analyzeData
%ANALYZEDATA Summary of this function goes here
%   Detailed explanation goes here

[githubPath,~,~] = fileparts(pwd);
circadianPath = fullfile(githubPath,'circadian');
addpath(circadianPath);

% Load preprocessed data from file
temp = load('data.mat');
data = temp.data;

% Preallocate variables
nLoc = numel(data.locationID);
varNames = {'building','session','locationID','deviceSN',...
    'desk','windowProx','daylightExposure','orientation','wing','floor','type',...
    'ariMean_allLux','geoMean_allLux','ariMean_allCs'};
a = NaN(nLoc,24);
b = cell(nLoc,1);
result = table(data.building,data.session,data.locationID,data.deviceSN,...
    b,b,b,b,b,b,b,...
    a,a,a,'VariableNames',varNames);

% Analyze data
for iLoc = 1:nLoc
    absTime = data.absTime{iLoc};
    light = data.light{iLoc};
    masks = data.masks{iLoc};
    holidayMask = isHoliday(absTime);
    weekendMask = isWeekend(absTime);
    mask = ~masks.observation | holidayMask | weekendMask; % TRUE = remove, FALSE = keep
    
    [~,result.ariMean_allLux(iLoc,:)] = hourlySummary(absTime,light.illuminance,mask,@mean);
    [~,result.geoMean_allLux(iLoc,:)] = hourlySummary(absTime,light.illuminance,mask,@geomean);
    [~,result.ariMean_allCs(iLoc,:)]  = hourlySummary(absTime,light.cs,mask,@mean);
    
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

