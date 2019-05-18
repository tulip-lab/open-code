function itemSCI=calSuppOne(record, itemSet)

len = length(itemSet);
numRec = length(record);

for i = 1:len
    count = 0;
    supp = 0;
    for j = 1:numRec
        num = 0;
        if ismember(itemSet{i,1},record(j,:))
            num = num +1;
        end  
        if num == 1;
            count = count +1;
        end
    end
    if count >0
        supp = count/numRec;
    end
    itemSCI{i,1}=itemSet{i,1};
    itemSCI{i,2}=count;
    itemSCI{i,3}=supp;
end
return