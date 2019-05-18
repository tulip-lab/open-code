function itemSupp=calSupp(record, itemSet)

[len,dim] = size(itemSet);
numRec = length(record);

for i = 1:len
    count = 0;
    supp = 0;
    for j = 1:numRec
        num = 0;
        [l,k] = size(itemSet);
        for m = 1:k
            if ismember(itemSet{i,m},record(j,:))
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
    itemSupp{i,1} = itemSet(i,:);
    itemSupp{i,2}=count;
    itemSupp{i,3}=supp;
end
return