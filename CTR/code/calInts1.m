function itemInts = calInts1(L,targetSupp,record)
% calculate interestingness of (X->Y)

temp = {};
[len,dimL] = size(L{1,1});
lenL = length(L);
lenT = length(targetSupp);

% get attList for X
for i = 1:lenL
    for j = 1:(dimL-1)
        temp{i,j} = L{i,j};
    end
end

xSupp = calSupp(record,temp);       % calculate support value for X

% get support value for Y
count = 1;
for i = 1:lenL
    for j = 1:lenT
        if (L{i,dimL} == targetSupp{j,1})
            ySupp{count,1} = targetSupp{j,1};
            ySupp{count,2} = targetSupp{j,2};
            ySupp{count,3} = targetSupp{j,3};
            count = count + 1;
        end
    end
end

for i = 1:lenL
    itemInts{i,1} = abs(L{i,2}-xSupp{i,3}*ySupp{i,3});
end
return

