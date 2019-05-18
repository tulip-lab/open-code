function [candL,candN] = addItemSupp(itemCandL,itemCandN,itemSuppL,itemSuppN)

[lenL,dimL] = size(itemCandL);
[lenN,dimN] = size(itemCandN);
countL = 1;
countN = 1;
candL = {};
candN = {};

for i = 1: lenL
	for j = 1:dimL
    	tempL{1,j} = itemCandL{i,j};
    end
	candL{countL,1} = tempL;
	candL{countL,2} = itemSuppL{i,3};
	countL = countL + 1;
end
for i = 1:lenN
	for j = 1:dimN
    	tempN{1,j} = itemCandN{i,j};
    end
	candN{countN,1} = tempN;
	candN{countN,2} = itemSuppN{i,3};
	countN = countN + 1;
end
return