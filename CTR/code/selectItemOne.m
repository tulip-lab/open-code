function [L1,N1] = selectItemOne(itemCandOne, itemOneSupp,minSupp)

len = length(itemCandOne);
countL = 1;
countN = 1;

for i = 1: len
    if (itemOneSupp{i,2}>=minSupp)
        L1{countL,1} = itemCandOne{i,1};
        L1{countL,2} = itemOneSupp{i,2};
        countL = countL + 1;
    else
        N1{countN,1} = itemCandOne{i,1};
        N1{countN,2} = itemOneSupp{i,2};
        countN = countN + 1;
    end
end
return