function [W] = ssiUpdateSimMatrixActiveUser(impM, W, userKNN, testUser, para)

userKNNLen = length(userKNN);

[newWVector] = pccVectorActUser(testUser, userKNN, impM);

W(testUser, userKNN) = newWVector;
W(userKNN, testUser) = newWVector;

return