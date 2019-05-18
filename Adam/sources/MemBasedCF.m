function [prediction]=MemBasedCF(M, TestData, W, k, maxValue, minValue)

[user_num item_num] = size(M);

T_inds = ones(1, user_num);

[user_num temp] = size(TestData);
prediction = zeros(1, user_num);

for i = 1: user_num
    
    ActiveVector = M(TestData(i,1),:);
    
    MisItem = TestData(i,2);
    Active_user = TestData(i,1);
    
    neigh_inds = find(T_inds .* M(:, MisItem)');
    
    LenNeighInds = length(neigh_inds);
    
    if LenNeighInds == 0
        neigh_w = 0;
        neighborhood = [];
    elseif LenNeighInds < k
        neighborhood = M(neigh_inds, :);
        neigh_w = W(Active_user, neigh_inds);
    else
        
        All_neigh_w = W(Active_user, neigh_inds);
        [Sort_all_neigh_w Sort_all_neigh_inds] = sort(All_neigh_w, 'descend');
        neighborhood = M(neigh_inds(Sort_all_neigh_inds(1:k)), :);
        neigh_w = Sort_all_neigh_w(1:k);
    end
        
    prediction(i) = MakePredictionC(ActiveVector, neighborhood, TestData, neigh_w, i, maxValue, minValue);
end

return