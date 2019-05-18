function [prediction] = MakePredictionC(ActiveVector, neighborhood, TestData, neigh_w, i, maxValue, minValue)

if length(find(neigh_w)) == 0
    if length(find(ActiveVector)) == 0
        prediction = 0;
    else
        prediction = sum(ActiveVector)/length(find(ActiveVector));
    end
else

    MissItem = TestData(i,2);

    Mean_ActiveUser = sum(ActiveVector)/length(find(ActiveVector));

    denominator = sum(abs(neigh_w));

    [n m] = size(neighborhood);
    if m < MissItem
        NeighMissItem = neighborhood(:, end);
        neighborhood(:,end) = 0;
    else
        NeighMissItem = neighborhood(:, MissItem);
        neighborhood(:,MissItem) = 0;
    end


    
    MeanNeighbor = zeros(1, n);
    for k = 1:n
        SingleNeigh = neighborhood(k,:);
        LenInds = length(find(SingleNeigh));
        if LenInds~=0
            MeanNeighbor(k) = sum(SingleNeigh)/LenInds;
        end
    end

    numerator = sum((neigh_w .* (NeighMissItem' - MeanNeighbor)));

    prediction = Mean_ActiveUser + numerator/denominator;
    
    if prediction > maxValue
        prediction = maxValue;
    end
    if prediction < minValue
        prediction = minValue;
    end
    
end

return