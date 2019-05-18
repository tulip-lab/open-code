function item=writeXitem(attValue,x,count)

k = x;

for i = 1: length(attValue{k,1})
    item{count,1} = attValue{k,1}{1,i};
    count = count+1;
end
