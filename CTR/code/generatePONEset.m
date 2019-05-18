function [positiveset,negativeset] = generatePONEset(value,groups,itemCand,minSupp,minInts,targetSupp,k)
        
         positiveset = {};
         negativeset = {};
         %find positive and negative itemset from generated itemsets.
         for dataset = 1:length(value)
             eachgroup = groups{1,dataset};
             %calculate support each item set for each group.
             clear itemSupp; 
             itemSupp = calSupp(eachgroup,itemCand);
             %save group support in a list.
             
             clear candL;
             clear candN;
             %base on support value find positive and negative items
             [candL,candN]=selectItem(itemCand,itemSupp,minSupp);
             
             
          % calculate interestingness for each itemset
          clear itemIntsL;
          clear itemIntsN;
          clear itemConfL;
          clear itemConfN;
          if(isempty(candL) ==0)
             [itemIntsL,itemConfL] = calIntsConfL(candL,targetSupp,eachgroup);
          else
              itemIntsL = {};
              itemConfL = {};
          end
          if(isempty(candN) == 0)
             [itemIntsN,itemConfN] = calIntsConfN(candN,targetSupp,eachgroup);
          else
              itemIntsN = {};
              itemConfN = {};
          end
            % select interested itemsets
            clear L;
            clear N;
             L = genL(candL,itemIntsL,itemConfL,minInts);
             N = genL(candN,itemIntsN,itemConfN,minInts);
             %save positive and negative for each group is a list.
             positiveset(k-1,dataset) = {L};
             negativeset(k-1,dataset) = {N};
         end
return
end
