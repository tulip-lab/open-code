function positivelist = generatePoList(itemOneSupp,finalitemPONE,value)

    numberofpositivedata = 1;
    positivelist = {};
    [rowitemOneSupp, colitemOneSupp] = size(itemOneSupp);
    for ite = 1:rowitemOneSupp
        numberofzero = 0;
        examitemset = finalitemPONE{ite,1};
        for onegroup = 1:length(value)
            
            valuePoOrNe = finalitemPONE{ite,onegroup+1};
            
            if valuePoOrNe == 0
                numberofzero= numberofzero+1;
            end 
        end
        
        if numberofzero == 0
            positivelist{numberofpositivedata,1} =  examitemset;% get only the positive item set (for all group) to generate itemset later on.
            numberofpositivedata = numberofpositivedata+1;
        end
        
    end
    return
end
