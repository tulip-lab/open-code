function [GROUPpositivelist,GROUPnegativelist,GROUPpone] = generateLIST(itemCand,value,finalitemPONElist)

         numberofpositivedata = 1;
         numterofnegativedata = 1;
         numberofpone = 1;
         [rowitemOneSupp, colitemOneSupp] = size(itemCand);
         GROUPpositivelist = {'x'};
         GROUPnegativelist = {'x'};
         GROUPpone = {'x'};
        for ite = 1:rowitemOneSupp
             numberofnone1 = 0;
             numberofnone0 = 0;
             numberofx=0;
             examitemset = finalitemPONElist{ite,1};
                 %get the positive list
             for onegroup = 1:length(value)
            
                    valuePoOrNe = finalitemPONElist{ite,onegroup+1};
            
                    if valuePoOrNe == 0 || valuePoOrNe == 'x'
                         numberofnone1= numberofnone1+1;
                    end 
                    if valuePoOrNe == 'x'
                        numberofx =numberofx +1;
                    end
             end
        
             if numberofnone1 == 0
               GROUPpositivelist{numberofpositivedata,1} =  examitemset;% get only the positive item set (for all group) to generate itemset later on.
               numberofpositivedata = numberofpositivedata+1;
             end
              %get the negative list
             for onegroup = 1:length(value)
            
                    valuePoOrNe = finalitemPONElist{ite,onegroup+1};
            
                    if valuePoOrNe == 1 || valuePoOrNe == 'x'
                         numberofnone0= numberofnone0+1;
                    end 
                    if valuePoOrNe == 'x'
                        numberofx =numberofx +1;
                    end
                    
             end
        
             if numberofnone0 == 0
               GROUPnegativelist{numterofnegativedata,1} =  examitemset;% get only the positive item set (for all group) to generate itemset later on.
               numterofnegativedata = numterofnegativedata+1;
             end
             
             
             if (numberofnone0>0 &&  numberofnone1>0)
                 if (numberofx == 0)
                     GROUPpone{numberofpone,1} = examitemset;
                     numberofpone = numberofpone+1;
                 end
             end
             
             
        end 
        return
end