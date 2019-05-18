function [candL,candN] = selectItem(itemCand,itemSupp,minSupp)

[len,dim] = size(itemCand);
countL = 1;
countN = 1;
candL = {};
candN = {};

for i = 1: len
    if (itemSupp{i,3}>=minSupp)
        for j = 1:dim
           tempL{1,j} = itemCand{i,j};
        end
        candL{countL,1} = tempL;
        candL{countL,2} = itemSupp{i,3};
        countL = countL + 1;
    else
        for j = 1:dim
            tempN{1,j} = itemCand{i,j};
        end
        candN{countN,1} = tempN;
        candN{countN,2} = itemSupp{i,3};
        countN = countN + 1;
    end
end
return