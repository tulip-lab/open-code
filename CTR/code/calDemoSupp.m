function itemSCI=calDemoSupp(record, itemSet)

len = length(itemSet);
numRec = length(record);

for i = 4:len
    count = 0;
    supp = 0;
    for j = 1:numRec
        num = 0;
        k = length(itemSet{i,1});
        for m = 2:k
            if ismember(itemSet{i,1}{1,m},record(j,:))
                num = num +1;
            end  
        end
        if num == (k-1);
            count = count +1;
        end
    end
    if count >0
        supp = count/numRec;
    end
    itemSCI{i,3}=count;
    itemSCI{i,4}=supp;
    i
end
return