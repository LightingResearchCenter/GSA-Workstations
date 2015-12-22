function cloudy = isCloudy(absTime,weatherLog)
%ISCLOUDY Summary of this function goes here
%   Detailed explanation goes here

% Extract cloudy dates from log
idxCloudy = strcmpi('Cloudy',weatherLog.condition{1});
cloudyDates = weatherLog.date{1}(idxCloudy);

% Preallocate
nDate = numel(cloudyDates);
nTime = numel(absTime.localDateNum);
tempCloudy = false(nTime,nDate);
floorTime = floor(absTime.localDateNum);

for iDate = 1:nDate
    thisDate = cloudyDates(iDate);
    tempCloudy(:,iDate) = floorTime == thisDate;
end

cloudy = any(tempCloudy,2);

end

