function [sunnyMask,cloudyMask] = makeWeatherMasks(baseMask, absTime, weatherLog, building, session)
%MAKEWEATHERMASKS Summary of this function goes here
%   Detailed explanation goes here
% TRUE = remove, FALSE = keep

sunny  = isSunny(absTime, weatherLog); % True = sunny
cloudy = isCloudy(absTime,weatherLog); % True = cloudy
noWeather = ~(sunny | cloudy);
noWeather2 = noWeather(~baseMask);

if any(noWeather2)
    dates = absTime.localDateNum(~baseMask);
    noWeatherDates = dates(noWeather2);
    unqNoWeatherDates = unique(floor(noWeatherDates));
    warning('Weather log missing for some records.');
    display(building);
    display(session);
    display(datestr(unqNoWeatherDates));
end

sunnyMask  = ~sunny  | baseMask | noWeather;
cloudyMask = ~cloudy | baseMask | noWeather;

end

