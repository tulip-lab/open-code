function [W] = PearsonCorrelation(M)

[m n] = size (M);
W = zeros(m);

for i = 1:m-1
    if mod(i, 100)== 0 fprintf('%d finished \n', i); end
    for j = i+1:m
        inds = find(M(i,:).*M(j,:)); 
        if isempty(inds)
            W(i,j) = 0;
            W(j,i) = 0;
        else
            userIVector = M(i, :);
            userJVector = M(j, :);
            
            sim = pccVectors(userIVector(inds), userJVector(inds));
            W(i,j) = sim;
            W(j,i) = W(i,j);
        end
    end
end

end