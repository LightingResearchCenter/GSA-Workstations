function dataSummary = hourlySummary(absTime,dataArray,maskArray,functionHandle,h_i,h_f)
%HOURLYSUMMARY Summary of this function goes here
%   Detailed explanation goes here

% Extract hour from time
hourOfDay = absTime.localDateVec(:,4);

% Apply mask
hourOfDay(maskArray) = [];
dataArray(maskArray) = [];

% Find unique hours
hourArray = (h_i:h_f-1)';

% Preallocate variables
nHour = numel(hourArray);
dataSummary = NaN(1,nHour);

% Apply summary function to each hour of the day
for iHour = 1:nHour
    thisHour = hourArray(iHour);
    idx = hourOfDay == thisHour;
    if ~isempty(dataArray(idx))
        dataSummary(iHour) = functionHandle(dataArray(idx));
    end
end

end

