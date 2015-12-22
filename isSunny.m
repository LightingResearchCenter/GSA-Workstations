function sunny = isSunny(absTime, weatherLog)
%ISSUNNY Summary of this function goes here
%   Detailed explanation goes here

% Extract sunny dates from log
idxSunny = strcmpi('Sunny',weatherLog.condition{1});
sunnyDates = weatherLog.date{1}(idxSunny);

% Preallocate
nDate = numel(sunnyDates);
nTime = numel(absTime.localDateNum);
tempSunny = false(nTime,nDate);
floorTime = floor(absTime.localDateNum);

for iDate = 1:nDate
    thisDate = sunnyDates(iDate);
    tempSunny(:,iDate) = floorTime == thisDate;
end

sunny = any(tempSunny,2);

end

