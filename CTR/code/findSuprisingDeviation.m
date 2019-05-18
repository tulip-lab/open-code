function SuprisingDeviation = findSuprisingDeviation(candidateitemset,groupsdataset,m_surprisingThreshold,VAL)

% candidateitemset = NeGaTiveList;
% groupsdataset=groups;
% m_surprisingThreshold=SurprisingThreshold;
% VAL =value;


[rowCan,colCan] = size(candidateitemset);
foundedSuprisingDeviation =  {candidateitemset{1,1}};
forlevel1 = foundedSuprisingDeviation{1,1};

for eachcan = 1:length(forlevel1)
    eachcandi = forlevel1{eachcan,1};
    Level1SD{eachcan,1} = eachcandi;
     for p =1:length(VAL)
      eGdataset = groupsdataset{1,p};
      ecSupp = calSupp(eGdataset,eachcandi);
      Level1SD{eachcan,p+1} = ecSupp{1,3};
     end 
     
end

SuprisingDeviation{1,1} = Level1SD;
%for each level of the candidateitemset
for n =2: rowCan
    clear levelcandidate;
    levelcandidate =  candidateitemset{n,1};
    [rowLev,colLev] = size(levelcandidate);
    numberofselected = 1;
    %for each candidate in each level of candiateitemset
    selectedCandidate = {0};
    for l = 1:rowLev
        examingcandidate = levelcandidate{l,1};
        clear decomposition;
        decomposition = findDecomposition(foundedSuprisingDeviation,examingcandidate);
        
        [rowdecom,columdecom] = size(decomposition);
        
        %calculate support value for this examining item set for each group
            for p =1:length(VAL)

                eGdataset = groupsdataset{1,p};

                ecSupp = calSupp(eGdataset,examingcandidate);
                esSuppingvalue{1,p} = ecSupp{1,3};
            end
        %--------------------------------------------------------------    
         %if there is some decomposition of this examiming candidate we check to decide if it is
        %surprising or not. if there is no decomposition then it is
        %surprising
       
        if (isempty(decomposition)==0)
            for p =1:length(VAL)
                expectedSupports{1,p} = 1;
            end
            
            %calculate expected support for the decomposition of each
            %groups
            for p =1:length(VAL)
                eachGroup = groupsdataset{1,p};

                for decom = 1:rowdecom
                    eachcomposition = decomposition{decom,1};
                    eachCompoSupp=  calSupp(eachGroup,eachcomposition);

                    expectedSupports{1,p} = expectedSupports{1,p} * eachCompoSupp{1,3};
                end
            end
            isSurprisingList = isSurprising(esSuppingvalue,expectedSupports,m_surprisingThreshold);
        else
            isSurprisingList=1;
        end
       %-------------------------------------------------------------
        if (isSurprisingList==1)
             selectedCandidate{numberofselected,1} = examingcandidate;
             
              for p =1:length(VAL)
                   eachrecord = groupsdataset{1,p};
                   confidence = calConfidence(eachrecord, examingcandidate);
                   selectedCandidate{numberofselected,p+1} = confidence;
              end
             numberofselected=numberofselected+1;
        end
    end
    
    
    SuprisingDeviation{1,n} = selectedCandidate;
    foundedSuprisingDeviation(1,n) = {selectedCandidate(:,1)};

end

return
