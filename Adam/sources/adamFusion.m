function [predictionAll] = adamFusion(M, W, itemW, testSet, para)

k = para.neighK;
maxValue = para.maxValue;
minValue = para.minValue;

fprintf('Adam-Fusion Imputation Function \n');

testUserNum = size(testSet, 1);

predictionFinal = [];
predictionFinalICF = [];

for testUserInd = 1:testUserNum
   
    if mod(testUserInd, 200) == 0
        fprintf([int2str(testUserInd) ' predicted. \n']);
    end
    
    testUser = testSet(testUserInd, 1);
    testItem = testSet(testUserInd, 2);
    
    impM = M;
    impMICF = M;
    
    [userKNN itemKNN] = findKNNDirect(M, testUser, testItem);
    [itemKNNICF userKNNICF] = findKNNDirect(M', testItem, testUser);
    
    impArea = M(userKNN, itemKNN);
    impAreaFull = para.fullM(userKNN, itemKNN);
    
    impAreaInd = find(impArea == 0);
    impArea(impAreaInd) = impAreaFull(impAreaInd);
    
    impM(userKNN, itemKNN) = impArea;
    
    impArea = M(userKNNICF, itemKNNICF);
    impAreaFull = para.fullM(userKNNICF, itemKNNICF);
    
    impAreaInd = find(impArea == 0);
    impArea(impAreaInd) = impAreaFull(impAreaInd);
    
    impMICF(userKNNICF, itemKNNICF) = impArea;
    
    impM(testUser, testItem) = 0;
    impMICF(testItem, testUser) = 0;

    %%% Update the impW
    [impW] = ssiUpdateSimMatrixActiveUser(impM, W, userKNN, testUser, para);
    
    [impWICF] = ssiUpdateSimMatrixActiveUser(impMICF', itemW, itemKNNICF, testItem, para);
    
    curUserPreRecord = [];
    curUserPreRecordICF = [];
    for neighInd = 1:k
        [curPrediction] = MemBasedCF(impM, [testUser testItem], impW, neighInd, maxValue, minValue);
        [curPredictionICF] = MemBasedCF(impMICF', [testItem testUser], impWICF, neighInd, maxValue, minValue);
        
        curUserPreRecord = [curUserPreRecord; curPrediction];
        curUserPreRecordICF = [curUserPreRecordICF; curPredictionICF];
    end
    
    predictionFinal = [predictionFinal curUserPreRecord];
    predictionFinalICF = [predictionFinalICF curUserPreRecordICF];
end

predictionAll.userBased = predictionFinal;
predictionAll.itemBased = predictionFinalICF;

return