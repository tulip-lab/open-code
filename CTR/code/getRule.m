function c = getRule(a)

count = 1;
c = {};
len = length(a);

for i = 1:len
    [lenR,dimR] = size(a{i,1});
    for j = 1:lenR
        lenN = length(a{i,1}{j,1});
        for n = 1:(lenN-1)
        c{count,n}=a{i,1}{j,1}{1,n};
        end
        c{count,lenN}='->';
        c{count,lenN+1} = a{i,1}{j,1}{1,lenN};
        c{count,lenN+2}=a{i,1}{j,4};
        count = count +1;
    end
end
return