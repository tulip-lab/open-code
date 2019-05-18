function itemSupp=calXSupp(record, itemSet)

numRec = length(record);
    count = 0;
    supp = 0;
    for j = 1:numRec
        num = 0;
        [l,k] = size(itemSet);
        for m = 1:k
            if ismember(itemSet{l,m},record(j,:))
                num = num +1;
            end  
        end
        if num == k;
            count = count +1;
        end
    end
    if count >0
        supp = count/numRec;
    end
    itemSupp{1,1} = itemSet(1,:);
    itemSupp{1,2}=count;
    itemSupp{1,3}=supp;

return