function [itemInts,itemConf] = calIntsConfL(candL,targetSupp,record)
% calculate interestingness of (X->Y)

temp = {};
[len,dimL] = size(candL{1,1});
[lenL,dimTT] = size(candL);
[lenT,dimT] = size(targetSupp);
count = 1;

% get attList for X
for i = 1:lenL
    for j = 1:(dimL-1)
        temp{1,j} = candL{i,1}{1,j};
    end
    tempSupp = calXSupp(record,temp);    % calculate support value for X
    xSupp(i,:) = tempSupp;
   
    % get support value for Y
    for j = 1:lenT
       if isequal(candL{i,1}{1,dimL},targetSupp{j,1})
           ySupp{count,1} = targetSupp{j,1};
           ySupp{count,2} = targetSupp{j,2};
           ySupp{count,3} = targetSupp{j,3};
           count = count + 1;
       end
    end
    
    % calculate interestingness of (X->Y)
    depend = candL{i,2}-xSupp{i,3}*ySupp{i,3}
    itemInts{i,1} = abs(depend);
    itemConf{i,1} = candL{i,2};
    itemConf{i,2} = xSupp{i,3};
    itemConf{i,3} = ySupp{i,3};
    if depend > 0
        itemConf{i,4} = depend /(xSupp{i,3}*(1-ySupp{i,3}));
    else
        itemConf{i,4} = depend /(xSupp{i,3}*ySupp{i,3});
    end
end
return
