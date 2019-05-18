function [newWVector] = pccVectorActUser(testUser, userKNN, M)

userNum = length(userKNN);

activeUserVector = M(testUser, :);

newWVector = zeros(1, userNum);

for userInd = 1:userNum
    tempW = 0;
    curUser = userKNN(userInd);
    
    if curUser ~= testUser
        curUserVector = M(curUser, :);
        
        inds = find(activeUserVector .* curUserVector);
        if isempty(inds)
            tempW = 0;
        else
            tempW = pccVectors(activeUserVector(inds), curUserVector(inds));
        end
    end
    newWVector(userInd) = tempW;
end


return