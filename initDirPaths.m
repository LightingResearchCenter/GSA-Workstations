function dirPaths = initDirPaths
%INITDIRPATHS Map paths for GSA worstation Daysimeter directories
%   Detailed explanation goes here

projectPath = [filesep,fullfile('Users','geoff','Desktop','GSA_Daysimeter')];

grandJunction = fullfile(projectPath,'GrandJunction_Colorado_site_data','Daysimeter_Stationary_Data');
grandJunction_winter = fullfile(grandJunction,'winterEditedData');
grandJunction_summer = fullfile(grandJunction,'summerEditedData');

portland = fullfile(projectPath,'Portland_Oregon_site_data','Daysimeter_Stationary_Data');
portland_winter = fullfile(portland,'winterEditedData');
portland_summer = fullfile(portland,'summerEditedData');

% seattle = fullfile(projectPath,'Seattle_Washington','Daysimeter_Stationary_Data','Original and Corrected Files');

dc1800F = fullfile(projectPath,'WashingtonDC','Daysimeter_Stationary_Data');
dc1800F_winter = fullfile(dc1800F,'winterEditedData');
dc1800F_summer = fullfile(dc1800F,'summerEditedData');
dc1800F_november = fullfile(dc1800F,'novemberEditedData');

dcROB = fullfile(projectPath,'WashingtonDC-RegionalOfficeBldg-7th&Dstreet','Daysimeter_Stationary_Data');
dcROB_summer = fullfile(dcROB,'summerEditedData');

varNames = {'path','building','session','log','logID'};
rowNames = {'grandJunction_winter';...
            'grandJunction_summer';...
            'portland_winter';...
            'portland_summer';...
            'dc1800F_winter';...
            'dc1800F_summer';...
            'dc1800F_november';...
            'dcROB_summer'};
tempPath = {grandJunction_winter;...
            grandJunction_summer;...
            portland_winter;...
            portland_summer;...
            dc1800F_winter;...
            dc1800F_summer;...
            dc1800F_november;...
            dcROB_summer};
building = {'Grand Juction, CO';...
            'Grand Juction, CO';...
            'Portland, OR';...
            'Portland, OR';...
            'Washington, D.C. - 1800F';...
            'Washington, D.C. - 1800F';...
            'Washington, D.C. - 1800F';...
            'Washington, D.C. - ROB'};
session  = {'winter';...
            'summer';...
            'winter';...
            'summer';...
            'winter';...
            'summer';...
            'November';...
            'summer'};
tempLog = regexprep(tempPath,'EditedData',['Logs',filesep,'weatherLog.xlsx']);
logID = (1:numel(tempLog))';
dirPaths = table(tempPath,building,session,tempLog,logID,'VariableNames',varNames,'RowNames',rowNames);

end
