function founddecomposition = findDecomposition(FSDeviation, examingCand)

founddecomposition={};
[rowSD, colSD] = size(FSDeviation);
numberofsuprisingdeviation = 1;

for colCan =1:length(examingCand)-1
    result{1,colCan} = 0;
end
%find the decomposition of examining itemset from foundeviation such that
%union of decomposition is that itemset, larger itemset have higher
%priority.
while colSD>0
    levelofFSD = FSDeviation{1,colSD};
    [rowlevel,collevel] = size(levelofFSD);
    for rowsd = 1:rowlevel
        examingSD = levelofFSD{rowsd,1};
        t = ismember(examingSD,examingCand);
        numberoft0 = 0;
        for tt = 1:length(t)
            if (t(1,tt) == 0)
                numberoft0 = numberoft0 +1;
            end
        end
        
        if (numberoft0==0)
            for examSD= 1:length(examingSD)-1
                for examCD = 1:length(examingCand)-1
                    itemsSD = examingSD{1,examSD};
                    itemsCD = examingCand{1,examCD};
                    if(isequal(itemsSD,itemsCD)==1 && result{1,examCD} == 0)
                        result{1,examCD} = 1;
                        founddecomposition{numberofsuprisingdeviation,1}= examingSD;
                        numberofsuprisingdeviation = numberofsuprisingdeviation +1;
                    end
                end
            end
        end

    end
    colSD=colSD-1;
end
return
