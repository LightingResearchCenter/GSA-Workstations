function exportResult
%EXPORTRESULT Summary of this function goes here
%   Detailed explanation goes here

temp = load('result.mat','result');
result = temp.result;

filePath = 'result.xlsx';

sheetNames = result.Properties.VariableNames(5:end);

nSheet = numel(sheetNames);

hourLabels = {'t0000_0059',...
              't0100_0159',...
              't0200_0259',...
              't0300_0359',...
              't0400_0459',...
              't0500_0559',...
              't0600_0659',...
              't0700_0759',...
              't0800_0859',...
              't0900_0959',...
              't1000_1059',...
              't1100_1159',...
              't1200_1259',...
              't1300_1359',...
              't1400_1459',...
              't1500_1559',...
              't1600_1659',...
              't1700_1759',...
              't1800_1859',...
              't1900_1959',...
              't2000_2059',...
              't2100_2159',...
              't2200_2259',...
              't2300_2359'};

metaData = result(:,1:4);
for iSheet = 1:nSheet
    tempArray = table2array(result(:,iSheet+5));
    tempTable = array2table(tempArray,'VariableNames',hourLabels);
    
    thisTable = [metaData,tempTable];
    thisCell = [thisTable.Properties.VariableNames;table2cell(thisTable)];
    
    xlswrite(filePath,thisCell,sheetNames{iSheet});
end


end

