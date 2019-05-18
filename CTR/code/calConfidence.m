function confidence = calConfidence(eachgroupdata, examiningcandidate)

    if isempty(examiningcandidate)
    confidence = {};
    return;
    end
    
numRec = length(eachgroupdata);
[lenL,dimL] = size(examiningcandidate);

temp = {};
for i = 1:dimL-1
   temp{1,i} = examiningcandidate{1,i};
end

 CountCondiItem = 0;
 Countitem = 0;
  for j = 1:numRec
        num = 0;
        for m = 1:dimL
            if ismember(examiningcandidate{1,m},eachgroupdata(j,:))
                num = num +1;
            end  
        end
        if num == dimL;
            Countitem = Countitem +1;
        end
        
        [f,s] = size(temp);
        number = 0;
        for n = 1:s
             if ismember(temp{1,n},eachgroupdata(j,:))
                number = number +1;
             end 
            if number == s;
                CountCondiItem = CountCondiItem +1;
            end
        end
  end
   
  confidence = Countitem/CountCondiItem;



return
end
