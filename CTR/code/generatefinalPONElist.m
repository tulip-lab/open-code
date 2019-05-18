function finalitemPONElist = generatefinalPONElist(itemCand,groups,positiveset,negativeset,k)

       finalitemPONElist = {};
       [rowitemOneSupp, colitemOneSupp] = size(itemCand);
       for ite = 1:rowitemOneSupp
           examiningitemsets= {itemCand{ite,:}};
           finalitemPONElist(ite,1) = {examiningitemsets};
            postiveitemsets = {};
            negativeitemsets = {};
           for dataset = 1:length(groups)
                   finalitemPONElist(ite,dataset + 1) = {'x'};
                   
                   postiveitemsets = positiveset{k-1,dataset};
                   negativeitemsets = negativeset{k-1,dataset};

                   [rowofthisgroup, colofthisgroup] = size(postiveitemsets);
                   [rowofingroup, colofingroup] = size(negativeitemsets);
                   if (~isempty(postiveitemsets))
                       for row = 1:rowofthisgroup
                           examiningpositiveset = postiveitemsets{row,1};
                           if (isequal(examiningitemsets,examiningpositiveset) == 1)
                               finalitemPONElist(ite,dataset+1) = {1} ;
                           end

                       end
                   end
                   if (~isempty(negativeitemsets))
                       for rowne = 1: rowofingroup
                           examiningnegativeset = negativeitemsets{rowne,1};
                           if (isequal(examiningitemsets,examiningnegativeset) ==1)
                               finalitemPONElist(ite,dataset+1) = {0};% table of positive and negative for each one cadidate item set
                           end
                       end     
                   end   
           end
       end
return
end
