function convertData
%CONVERTDATA Summary of this function goes here
%   Detailed explanation goes here

datenumOffset = 693960;

[githubPath,~,~] = fileparts(pwd);
circadianPath = fullfile(githubPath,'circadian');
addpath(circadianPath);

% Map paths
dirPaths = initDirPaths;
dataPaths = initDataPaths(dirPaths);

% Read logs
nLog = numel(dirPaths.log);
tempLogID = dirPaths.logID;
tempDate = cell(nLog,1);
tempCondition = cell(nLog,1);
varNames = {'logID','date','condition'};
for iLog = 1:nLog
    thisLogPath = dirPaths.log{iLog};
    thisLog = readtable(thisLogPath);
    idxEmpty = cellfun(@isempty,thisLog{:,2});
    thisLog(idxEmpty,:) = [];
    tempDate{iLog} = thisLog{:,1} + datenumOffset;
    tempCondition{iLog} = thisLog{:,2};
end
weatherLog = table(tempLogID,tempDate,tempCondition,'VariableNames',varNames);

% Preallocate variables
nPath = numel(dataPaths.path);
template = cell(size(dataPaths.path));
absTime     = template;
relTime     = template;
epoch       = template;
light       = template;
activity    = template;
masks       = template;
locationID  = template;
deviceSN    = template;

% Read CDFs
for iPath = 1:nPath
    thisPath = dataPaths.path{iPath};
    
    cdfData = daysimeter12.readcdf(thisPath);
    [absTime{iPath}, relTime{iPath}, epoch{iPath}, ...
        light{iPath}, activity{iPath}, masks{iPath}, ...
        locationID{iPath}, deviceSN{iPath}] = daysimeter12.convertcdf(cdfData);
end


building = dataPaths.building;
session = dataPaths.session;
logID = dataPaths.logID;

% Create data table
data = table(absTime,relTime,epoch,light,activity,masks,locationID,deviceSN,building,session,logID);

% Save data table
save('data.mat','data','weatherLog');

end

