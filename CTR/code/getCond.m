function [cond,label] = getCond(candR)

cond = {};
label = {};
temp = {};


[len, dim] = size(candR);

for i = 1:len
    [lenR,dimR] = size(candR{i,1});
    count = 1;
    for j = 1:lenR
        lenN = length(candR{i,1}{j,1});
        for n = 1:(lenN-1)
        temp{count,n}=candR{i,1}{j,1}{1,n};
        end
        temp{count,lenN+1} = candR{i,1}{j,1}{1,lenN};
        temp{count,lenN+2} = candR{i,1}{j,4};
        count = count +1;
    end
    
end
return