function [itemInts,itemConf] = calIntsConfN(candN,targetSupp,record)
% calculate interestingness of (X->Y)

temp = {};
[len,dimN] = size(candN{1,1});
[lenN,dimNN] = size(candN);
[lenT,dimT] = size(targetSupp);
count = 1;

% get attList for X
for i = 1:lenN
    for j = 1:(dimN-1)
        temp{i,j} = candN{i,1}{1,j};
    end
    tempSupp = calXSupp(record,temp);    % calculate support value for X
    xSupp(i,:) = tempSupp;
   
    % get support value for Y
    for j = 1:lenT
       if isequal(candN{i,1}{1,dimN},targetSupp{j,1})
           ySupp{count,1} = targetSupp{j,1};
           ySupp{count,2} = targetSupp{j,2};
           ySupp{count,3} = targetSupp{j,3};
           count = count + 1;
       end
    end
    
    xySupp = xSupp{i,3}-candN{i,2};
    NySupp = 1-ySupp{i,3};
    % calculate interestingness of (X->Y)
    depend = xySupp - xSupp{i,3}*NySupp
    itemInts{i,1} = abs(depend);
    itemConf{i,1} = xySupp;
    itemConf{i,2} = xSupp{i,3};
    itemConf{i,3} = NySupp;
    if depend > 0
        itemConf{i,4} = -depend /(xSupp{i,3}*(1-NySupp));
    else
        itemConf{i,4} = -depend /(xSupp{i,3}*NySupp);
    end
end
return
