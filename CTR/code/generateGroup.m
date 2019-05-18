function [groups,value,record] = generateGroup(data,index,numData,dimData)

record = {}; 

for i = 1:numData-1                              
    record(i,:) = {data{i+1,2:dimData}};
end

[numRec, dimRec] = size(record);            % total numbers of the data instances & dimensions

% extract the data of each group-------------------------------------------

[numYear, dimYear] = size(index);
 numberofYear = 1;
 value{1,1}=index(1,:);
 yearValue = index(1,:);
    for k= 2:numYear
        if(isequal(yearValue,index(k,:))==0)
            yearValue=index(k,:);                                              
            numberofYear = numberofYear+1;
            value{1,numberofYear}=index(k,:); 
        end
    end

  groups = {};
   for inde = 1:length(value)
         countyearrecord = 1;
         group = {};
         for yearindex=1:numYear
                 if index(yearindex,1) == value{1,inde}
                    group(countyearrecord,:) = {record{yearindex,1:dimRec}}; 
                    countyearrecord = countyearrecord + 1;
                 end
         end 
         groups(1,inde) = {group};  %this is the data of each group seperated
         clear group;
   end
   
return
end