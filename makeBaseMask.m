function baseMask = makeBaseMask(masks, absTime, building, session)
%MAKEBASEMASK Summary of this function goes here
%   Detailed explanation goes here
% TRUE = remove, FALSE = keep

if ~isempty(masks.observation)
    nonObservationMask = ~masks.observation;
else
    nonObservationMask = false(size(absTime.localDateNum));
end

if ~isempty(masks.compliance)
    nonComplianceMask = ~masks.compliance;
else
    nonComplianceMask = false(size(absTime.localDateNum));
end

holidayMask     = isHoliday(absTime);
weekendMask     = isWeekend(absTime);
exceptionMask	= isException(absTime,building,session);

baseMask = nonObservationMask | nonComplianceMask | holidayMask | weekendMask | exceptionMask;

end

