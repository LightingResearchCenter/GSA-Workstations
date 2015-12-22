function [sunnyMask,cloudyMask] = makeWeatherMasks(baseMask, absTime, weatherLog)
%MAKEWEATHERMASKS Summary of this function goes here
%   Detailed explanation goes here
% TRUE = remove, FALSE = keep

sunny  = isSunny(absTime, weatherLog); % True = sunny
cloudy = isCloudy(absTime,weatherLog); % True = cloudy
noWeather = ~(sunny | cloudy);
noWeather = noWeather(~baseMask);

if any(noWeather)
    dates = absTime.localDateNum(~baseMask);
    noWeatherDates = dates(noWeather);
    warning('Weather log missing for some records.');
    display(datestr(noWeatherDates));
end

sunnyMask  = ~sunny  | baseMask;
cloudyMask = ~cloudy | baseMask;

end

