function dataPaths = initDataPaths(dirPaths)
%INITDATAPATHS Map paths for GSA worstation Daysimeter data
%   Detailed explanation goes here

nDir = size(dirPaths,1);

template = cell(nDir,1);
tempPath = template;
tempBuilding = template;
tempSession = template;
tempLogID = template;

for iDir = 1:nDir
    thisDirPath = dirPaths.path{iDir};
    thisBuilding = dirPaths.building{iDir};
    thisSession = dirPaths.session{iDir};
    thisLogID = dirPaths.logID(iDir);
    
    thisListing = dir(fullfile(thisDirPath,'*.cdf'));
    if isempty(thisListing) % If no CDFs found look for Excel files
        thisListing = dir(fullfile(thisDirPath,'*Cropped.xlsx'));
        if isempty(thisListing) % If no Excel files found return error
            error('Data files not detected');
        end
    end
    
    tempPath{iDir} = fullfile(thisDirPath,{thisListing.name}');
    
    tempBuilding{iDir} = repmat({thisBuilding},size(tempPath{iDir}));
    tempSession{iDir} = repmat({thisSession},size(tempPath{iDir}));
    tempLogID{iDir} = repmat(thisLogID,size(tempPath{iDir}));
end

tempPath = vertcat(tempPath{:});
tempBuilding = vertcat(tempBuilding{:});
tempSession = vertcat(tempSession{:});
tempLogID = vertcat(tempLogID{:});

varNames = {'path','building','session','logID'};
dataPaths = table(tempPath,tempBuilding,tempSession,tempLogID,'VariableNames',varNames);
end

