function weekendMask = isWeekend(absTime)
%ISWEEKEND Summary of this function goes here
%   Detailed explanation goes here

t = datetime(absTime.localDateVec);

weekendMask = isweekend(t);


end

