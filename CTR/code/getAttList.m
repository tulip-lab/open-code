function attList = getAttList(L)

if isempty(L)
    attList = {};
    return;
end

[lenL,dimL] = size(L);
temp = {};
attList = {};
for i = 1:lenL
    lenA = length(L{i,1});
    for j = 1:(lenA-1)
        temp(i,j)=L{i,1}(1,j);
    end
end


[lenV,dimV] = size(temp);
for i = 1:dimV
    attList(i,1)={temp{1,i}};
end
count = dimV;

for i = 2:lenV
    for j = 1:dimV
        if (~ismember(temp{i,j},attList))
        	count = count +1;
            attList(count,1)={temp{i,j}};
        end
    end
end
attList = sort(attList);

% tempAtt = getAttValue(temp);
% lenV = length(tempAtt{1,1});


% 
% countR = 1;
% countC = 1;
% attList{1,1}={tempAtt{1,1}{1,1}};
% for i = 2:lenV
%     if ~isequal(tempAtt{1,1}{1,i-1}(1,1),tempAtt{1,1}{1,i}(1,1))
%         countR = countR + 1;
%         attList{countR,1}{1,1}=tempAtt{1,1}{1,i};
%         countC = 1;
%     else
%         countC = countC + 1;
%         attList{countR,1}{1,countC}=tempAtt{1,1}{1,i};
%     end
% end


return

