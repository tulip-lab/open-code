function main(M, TestData, fullM)
%%% This code is a revised version of the Adam-Fusion algorithm.
%%% M: the user-item rating matrix. This is the training set. The rows are
%%% users, and the columns are items. The entries are ratings from users
%%% on items.
%%% TestData: this is the test set, in format of [userID, itemID, ratings].
%%% fullM: the imputed M, in which all the missing values in M have been 
%%% imputed with some prediction method. This can be done with any rating 
%%% prediction algorithm, e.g. user based CF or item based CF.
%%% This fullM parameter is aiming at speed up the imputation process, 
%%% because Adam-Fusion will impute a large proportion
%%% of the overall missing values. 
%%% Please note that, not all imputed values will be used. This fullM is
%%% for efficient computation purposes only. 
%%% The code is free for academic usage. You can run it at your own risk.

feature accel on

%%% Adjust the following parameters to suit the training data.
%%% The number of neighbours.
para.neighK = 30; 
%%% The maxValue and minValue for ratings in current data set.
para.maxValue = 5;
para.minValue = 1;
%%% The lambda parameter in Adam-Fusion.
para.ourLamda = 0.4;

[W] = PearsonCorrelation(M);
itemW = PearsonCorrelation(M');

para.fullM = fullM;
clear fullM;
nanInd = find(isnan(para.fullM));
para.fullM(nanInd) = 0;
fprintf('begin to do prediction. \n');

%%% Do prediction.
testUser = size(TestData, 1);

for testUserInd = 1:testUser
    para.fullM(TestData(testUserInd, 1), TestData(testUserInd, 2)) = 0;
end

para.originalM = M;

[prediction] = adamFusion(M, W, itemW, TestData, para);

finalPre = para.ourLamda * prediction.userBased  + (1-para.ourLamda) * prediction.itemBased;

maeAll = [];

[tempNum temp] = size(finalPre);

for neighInd = 1:tempNum
    [maeValue] = MAE(TestData(:, 3)', finalPre(neighInd, :));
    maeAll = [maeAll maeValue];
end

save('maeAll', 'maeAll');
return
