function [desk,windowProx,daylightExposure,orientation,wing,floor,type] = decomposeLocationID(locationID)
%DECOMPOSELOCATIONID Summary of this function goes here
%   Detailed explanation goes here

token = regexpi(locationID,'(stick|window|cabinet|desk)$','tokens');

if ~isempty(token)
    type = token{1}{1};
else
    type = '';
end

locationID = regexprep(locationID,'(stick|window|cabinet|desk)$','','ignorecase');

longCardinal = '(north|east|south|west)';
shortCardinal = '(n|e|s|w)';

deskOnly = '^([^_-]*)$';
other = ['^(\d*)-',shortCardinal,'-(\d*)-$'];
grandJunction = ['^(\d*)-',longCardinal,'-$'];
portland = ['^(\d*)-',longCardinal,'-(A|B)$'];
dc1800F = ['^(\d)-',shortCardinal,'-([a-zA-Z\d])-',shortCardinal,'-$'];
dcROBshort = '^([a-z\d-]*|desk\d*)[_-](interior)-$';
dcROBlong = ['^([\d-]*)_(a|b|c)-',shortCardinal,'-',shortCardinal,'-$'];

if any(regexpi(locationID,dcROBlong))
    locComp = regexpi(locationID,dcROBlong,'tokens');
    desk = locComp{1}{1};
    windowProx = locComp{1}{2};
    daylightExposure = locComp{1}{3};
    orientation = locComp{1}{4};
    wing = '';
    floor = '';
elseif any(regexpi(locationID,dcROBshort))
    locComp = regexpi(locationID,dcROBshort,'tokens');
    desk = locComp{1}{1};
    windowProx = locComp{1}{2};
    daylightExposure = '';
    orientation = '';
    wing = '';
    floor = '';
elseif any(regexpi(locationID,dc1800F))
    locComp = regexpi(locationID,dc1800F,'tokens');
    desk = '';
    windowProx = '';
    daylightExposure = locComp{1}{2};
    orientation = locComp{1}{4};
    wing = locComp{1}{1};
    floor = locComp{1}{3};
elseif any(regexpi(locationID,grandJunction))
    locComp = regexpi(locationID,grandJunction,'tokens');
    desk = '';
    windowProx = '';
    daylightExposure = locComp{1}{2};
    orientation = '';
    wing = '';
    floor = locComp{1}{1};
elseif any(regexpi(locationID,portland))
    locComp = regexpi(locationID,portland,'tokens');
    desk = '';
    windowProx = locComp{1}{3};
    daylightExposure = locComp{1}{2};
    orientation = '';
    wing = '';
    floor = locComp{1}{1};
elseif any(regexpi(locationID,deskOnly))
    desk = locationID;
    windowProx = '';
    daylightExposure = '';
    orientation = '';
    wing = '';
    floor = '';
elseif any(regexpi(locationID,other))
    locComp = regexpi(locationID,other,'tokens');
    desk = '';
    windowProx = '';
    daylightExposure = locComp{1}{2};
    orientation = '';
    wing = locComp{1}{1};
    floor = locComp{1}{3};
else
    warning('Unrecognized pattern.');
    desk = '';
    windowProx = '';
    daylightExposure = '';
    orientation = '';
    wing = '';
    floor = '';
end

end

