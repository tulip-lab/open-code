function sim = pccVectors(vectorA, vectorB)

inds = find(vectorA.*vectorB); 
if isempty(inds)
    sim = 0;
else
    avegi = sum(vectorA(inds))/length(inds);
    avegj = sum(vectorB(inds))/length(inds);

    fenzi = sum((vectorA(inds)-avegi).*(vectorB(inds)-avegj));
    fenmu = sqrt(sum((vectorA(inds)-avegi).^2))*sqrt(sum((vectorB(inds)-avegj).^2));

    if fenzi == 0 && fenmu == 0
        sim = 0;
    else
        sim = fenzi/fenmu;
    end
end

return