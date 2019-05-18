function [userKNN itemKNN] = findKNNDirect(M, testUser, testItem)

userKNN = find(M(:, testItem)');

selNeiHood = M([testUser userKNN], :);
selNeiHoodInd = find(selNeiHood);
selNeiHood(selNeiHoodInd) = 1;

numEachItem = sum(selNeiHood, 1);

itemKNN = find(numEachItem);

userKNN = [userKNN testUser];
itemKNN = itemKNN;

return