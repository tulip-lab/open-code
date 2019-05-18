function itemCandOne = genItemCandOne(attValue)
% generate 1-item candidate set 

count = 0;
lenA = length(attValue);

for i = 1:lenA
    numAttVal= length(attValue{i,1});
    temp=attValue{i,1};
    for j = 1:numAttVal
        count = count +1;
    	itemCandOne(count,:) = {temp{1,j}};   
    end
end
return