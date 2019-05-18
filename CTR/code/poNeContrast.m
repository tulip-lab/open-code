function f = poNeContrast(workbook, worksheet, numTarget, minSupp, minInts, surprisingThreshold, maxLevel)

% load data set from excel file -------------------------------------------

% load dataset
[index, data] = xlsread(workbook, worksheet);

% get attribute names
header = {data{1,:}};                              

% total numbers of the data instances & dimensions
[numData, dimData] = size(data);            

% generate groups data and value of the year 
[groups, value, record] = generateGroup(data,index,numData,dimData);

% get user input values for minSupp, minConf and minInts -----------------------------------
%numTarget = 2; % the number of target attributes you have
%minSupp = 0.05;
%minInts = 0.005;
%surprisingThreshold = 0.01;
% minSupp = input('Please give a minimum support value [0,1]:\n');           
% minConf = input('Please give a minimum confidence value [0,1]:\n');
% minInts = input('Please give a minimum interestingness value [0,1]:\n');

% extract attribute values --------------------------------------------------------------
[attValue, numValue] = getAttValue(record); % call getAttValue function
[numRec, dimRec] = size(record); 
att = {};
target = {};
for i = 1:dimRec
    if (i>numTarget)
        % set the attribute for candidate itemset
        att{i-1,1} = attValue{i,1}; 
    else
        % set the target attribute
        target{i,1} = attValue{i,1}; 
    end
end

% generate all possible 1-item candidate sets --------------------------------------------
itemCandOne = genItemCandOne(att);
targetList = genItemCandOne(target);

% calculate support value for each 1-itemset
itemOneSuppinGroups = {};
targetSuppinGroups = {};
for dataset = 1:length(groups)
    % get data for each group
    eachgroup = groups{1,dataset};  
    % calculate support for each group's item                        
    itemOneSupp = calSuppOne(eachgroup,itemCandOne);     
    % calculate support for each group's target   
    targetSupp = calSuppOne(eachgroup,targetList); 
    
    itemOneSuppinGroups(1, dataset) = {itemOneSupp};
    targetSuppinGroups(1,dataset) = {targetSupp};
end  
   
% select itemsets into positive and negative datasets 
% based on their support value
postiveitem = {};
negativeitem = {};
for dataset = 1:length(groups)   
     itemOneSupport= itemOneSuppinGroups{1,dataset};
     [L1,N1] = selectItem(itemCandOne, itemOneSupport,minSupp);
     postiveitem(1,dataset) = {L1}; % positive item set of all groups
     negativeitem(1,dataset) = {N1}; % negative item set of all groups.
end
    
% check for positive and negative in each group for each itemset.
finalitemPONE = generatePONElist(itemOneSupp,groups,postiveitem,negativeitem);

% get only positive dataset for generating further rules later on
positivelist = generatePoList(itemOneSupp,finalitemPONE,value);

% already have positive dataset, now we generate item set from 2 items
%----------------------------------------------------------------------------------------
k=2;
numL = 1; 
numN = 1;

% 1-itemset
lenL1 = length(positivelist);
attList = {};
for i = 1:lenL1
  attList(i,1) = positivelist{i,1};
end

unionofalltheset = {};
while (k<maxLevel+1)
    clear itemCand;
    clear finalitemPONElist;
    clear postiveitemsets;
    clear negativeitemsets;
    clear GROUPpositivelist;
    clear GROUPnegativelist;
    clear GROUPpone;
    % generate candidate itemsets
    itemCand = genItemCand(attList,targetList,k);

    % get postive and negative itemset from the generated itemCand list
    % filter all candidate that is not interesting
    [positiveset,negativeset] = generatePONEset(value,groups,itemCand,minSupp,minInts,targetSupp,k);

    % create a table of Po and Ne for each group of each itemset.
    finalitemPONElist = generatefinalPONElist(itemCand,groups,positiveset,negativeset,k);

    % itemset that is positive in all group is added together
    % itemset that is negative in all gorup is added together
    % itemset positive and negative in diffirent group is added
    % together
    [GROUPpositivelist,GROUPnegativelist,GROUPpone] = generateLIST(itemCand,value,finalitemPONElist);

    unionofalltheset(k-1,1) = {GROUPpositivelist};
    unionofalltheset(k-1,2) = {GROUPnegativelist};
    unionofalltheset(k-1,3) = {GROUPpone};

    clear attList;
    attList = getAttList(GROUPpositivelist);

    k = k+1;
end
PoSiTiveList = unionofalltheset(:,1);
NeGaTiveList = unionofalltheset(:,2);
PONELIST = unionofalltheset(:,3);

SurprisingPo = findSuprisingDeviation(PoSiTiveList,groups,surprisingThreshold,value);
SurprisingNe = findSuprisingDeviation(NeGaTiveList,groups,surprisingThreshold,value);
SurprisingPONE = findSuprisingDeviation(PONELIST,groups,surprisingThreshold,value);

% save extracted rules to excel file
savetofile(SurprisingPo,'PoDeviation.xls',value);
savetofile(SurprisingNe,'NeDeviation.xls',value);
savetofile(SurprisingPONE,'PoNeDeviation.xls',value);
f = 1;
return