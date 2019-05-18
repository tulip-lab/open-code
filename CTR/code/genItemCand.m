function itemCand = genItemCand(attList,targetList,k)


temp = {};
index = 0;
n = k-1;

list = nchoosek(attList,n);

len = length(list);
for i = 1:len
    count = 0;
    for j = 1:n-1
        if (isequal(list{i,j}(1,1),list{i,j+1}(1,1)))
            count = count + 1;
        end
    end
    if count == 0
        index = index +1;
        temp(index,:)=list(i,:);
    end
end


% if ((k-1)>1)
%     for i = 1:(len-k+2) 
%         for j = (i+1):len
%             temp{count,1}=attList{i,1};
%             for n = 2:k-1
%                 temp{count,n}=attList{j,1};
%             end
%             count = count + 1;
%         end
%         
%     end
% else 
%     temp = attList;
% end

lenTg = length(targetList);
[rowtem,coltem] = size(temp);
lenTp = rowtem;
num = 1;
itemCand = {};
for i = 1:lenTg
%     for j = 1:(lenTp-1)
%     	for n = 1:(k-1)
%             itemCand{num,n}=temp{j,n};
%         end
%         itemCand{num,k}= targetList{i,1};
%         num = num + 1;
%     end
    for j = 1:(lenTp)
        for m = 1:n
            itemCand{num,m} = temp{j,m};
        end
        itemCand{num,k} = targetList{i,1};
        num = num+1;
    end

end

return
