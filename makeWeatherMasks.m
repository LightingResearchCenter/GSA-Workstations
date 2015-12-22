function [sunnyMask,cloudyMask] = makeWeatherMasks(baseMask, absTime, weatherLog)
%MAKEWEATHERMASKS Summary of this function goes here
%   Detailed explanation goes here
% TRUE = remove, FALSE = keep

sunny  = isSunny(absTime, weatherLog); % True = sunny
cloudy = isCloudy(absTime,weatherLog); % True = cloudy
noWeather = ~(sunny | cloudy);

if any(noWeather(baseMask))
    warning('Weather log missing for some records.');
end

sunnyMask  = ~sunny  | baseMask;
cloudyMask = ~cloudy | baseMask;

end

