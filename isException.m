function exceptionMask = isException(absTime,building,session)
%ISEXCEPTION Summary of this function goes here
%   Detailed explanation goes here

exceptionMask = false(size(absTime.localDateNum));

% Crop DC December 2014
if strcmpi(building,'Washington, D.C. - 1800F') && strcmpi(session,'winter')
    exceptionMask = ~(absTime.localDateNum > datenum(2014,12,4) & absTime.localDateNum < datenum(2014,12,20));
end

end

