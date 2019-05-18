function f = savetofile(deviation,filename)

%filename = 't.xls';
%deviation = SurprisingPo;
save ={};
for i=1:length(deviation)
    data = deviation{1,i};
    clear save;
    
    [rowdata, coldata] = size(data);
    for l = 1:rowdata
        clear itemset;
        itemset = data{l,1};
        for g =1:length(itemset)
            save{l,g} = itemset{1,g};
        end
        
        for p =1:length(VAL)
            save{l,p+length(itemset)} = data{l,p+1}*100;
        end
       
    end
    xlswrite(filename, save,i);
end
f = 1;

return