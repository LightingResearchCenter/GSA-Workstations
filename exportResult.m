function exportResult
%EXPORTRESULT Summary of this function goes here
%   Detailed explanation goes here

temp = load('result.mat','result');
result = temp.result;

timestamp = datestr(now,'yyyy-mm-dd_HHMM');
filePath = ['GSA hourly summary ',timestamp,'.xlsx'];

sheetNames = result.Properties.VariableNames(12:end);

nSheet = numel(sheetNames);

hourNames = {'t0800_0859',...
             't0900_0959',...
             't1000_1059',...
             't1100_1159',...
             't1200_1259',...
             't1300_1359',...
             't1400_1459',...
             't1500_1559',...
             't1600_1659'};
hourLabels = regexprep(regexprep(hourNames,'t',''),'_','-');

metaData = result(:,1:11);
for iSheet = 1:nSheet
    tempArray = table2array(result(:,iSheet+11));
    tempTable = array2table(tempArray,'VariableNames',hourNames);
    
    thisTable = [metaData,tempTable];
    thisCell = [[metaData.Properties.VariableNames,hourLabels];table2cell(thisTable)];
    
    xlswrite(filePath,thisCell,sheetNames{iSheet});
end

winopen(filePath);

end

