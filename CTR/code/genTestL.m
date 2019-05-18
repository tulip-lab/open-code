function L = genTestL(candL,itemInts,itemConf)

[lenCL,dimCL] = size(candL);
count = 1;
L={};
    
for i = 1:lenCL
        L{count,1} = candL{i,1};
        L{count,2} = candL{i,2};
        L{count,3} = itemInts{i,1};
        L{count,4} = itemConf{i,4};
        count = count + 1;
end
return