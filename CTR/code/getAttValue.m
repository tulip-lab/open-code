function [attValue, numValue] = getAttValue(record)
% get attribute value function
% input: data records
% output: attribute values

[numRec, dimRec] = size(record); 

numValue = 0;

for i =1:dimRec
    count = 1;
    clear Att;
    for j = 1:numRec
        if(~strcmp(record{j,i},'NaN'))
            temp = record{j,i};
            Att(1,count)={temp};
            count = count +1;
        end
    end

    num = 1;
    temp=Att{1,1};
    value(1,1)={temp};
    for k=2:length(Att)
        if(isequal(temp,Att{1,k})==0 && ismember(Att{1,k},value)==0)
            temp=Att{1,k};
            if ~strcmp(temp,'NaN')                                                    % discard 'NaN' value
                num = num+1;
                value(1,num)={temp};
            end    
        end
    end
 
value = sort(value);
attValue(i,1)={value};
clear value;
numValue = numValue + count;
end
return