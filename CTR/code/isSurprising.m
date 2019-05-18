function suprisinglist = isSurprising(CandiSupp,ESupportsofDecom,SurpThreshold)

% examiningCand=examingcandidate;
 %dataset=groupsdataset;
%ESupportsofDecom= expectedSupports;
%SurpThreshold=m_surprisingThreshold;

 average = 0;
 suprisinglist = 0;
 
 for esl = 1:length(ESupportsofDecom)
     dif = ESupportsofDecom{1,esl} - CandiSupp{1,esl};
     diff = abs(dif);
     average = average+ diff;
 end
 average=average/length(ESupportsofDecom);
 
  if(average>=SurpThreshold) 
      suprisinglist = 1;
  end
return