function analyzeData
%ANALYZEDATA Summary of this function goes here
%   Detailed explanation goes here

[githubPath,~,~] = fileparts(pwd);
circadianPath = fullfile(githubPath,'circadian');
addpath(circadianPath);

% Load preprocessed data from file
temp = load('data.mat');
data = temp.data;

% Find and remove window data
windowIdx = ~cellfun(@isempty,regexp(data.locationID,'.*WINDOW'));
data(windowIdx,:) = [];

% Preallocate variables
nLoc = numel(data.locationID);
varNames = {'building','session','locationID','deviceSN',...
    'ariMean_allLux','geoMean_allLux','ariMean_allCs'};
c = NaN(nLoc,24);
result = table(data.building,data.session,data.locationID,data.deviceSN,...
    c,c,c,'VariableNames',varNames);

% Analyze data
for iLoc = 1:nLoc
    absTime = data.absTime{iLoc};
    light = data.light{iLoc};
    masks = data.masks{iLoc};
    mask = ~masks.observation; % TRUE = remove, FALSE = keep
    
    [~,result.ariMean_allLux(iLoc,:)] = hourlySummary(absTime,light.illuminance,mask,@mean);
    [~,result.geoMean_allLux(iLoc,:)] = hourlySummary(absTime,light.illuminance,mask,@geomean);
    [~,result.ariMean_allCs(iLoc,:)]  = hourlySummary(absTime,light.cs,mask,@mean);
end

% Save analysis results
save('result.mat','result');

end

