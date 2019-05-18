function itemcandL = getCand(candPosR,n)

itemcandL = {};

[len,dim]=size(candPosR{n,1});

for i = 1:len
    for j = 1:(n+1)
        itemcandL{i,j} = candPosR{n,1}{i,1}{1,j};
    end
end

return