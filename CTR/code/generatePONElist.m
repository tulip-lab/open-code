function finalitemPONE = generatePONElist(itemOneSupp,groups,postiveitem,negativeitem)

[rowitemOneSupp, colitemOneSupp] = size(itemOneSupp);
    
 finalitemPONE = {};
    for ite = 1:rowitemOneSupp
        examiningitem{1,1} = itemOneSupp{ite,1};
        finalitemPONE{ite,1} = examiningitem;
       
        for dataset = 1:length(groups)
            
            postiveitemsetinthisgroup = postiveitem{1,dataset};
            negativeitemsetinthisgroup = negativeitem{1,dataset};
            
            [rowofthisgroup, colofthisgroup] = size(postiveitemsetinthisgroup);
            [rowofingroup, colofingroup] = size(negativeitemsetinthisgroup);
            
            for row = 1:rowofthisgroup
                 examiningpositive = postiveitemsetinthisgroup{row,1};
                 if (isequal(examiningitem,examiningpositive) == 1)
                     finalitemPONE{ite,dataset+1} = 1 ;
                 end
                
            end
            
            for rowne = 1: rowofingroup
                examiningnegative = negativeitemsetinthisgroup{rowne,1};
                 if (isequal(examiningitem,examiningnegative) ==1)
                     finalitemPONE{ite,dataset+1} = 0;% table of positive and negative for each one cadidate item set
                 end
            end
        end
    end    
    return
end