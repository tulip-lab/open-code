function C = getItemSet(A,B)

lenA = length(A);
lenB = length(B);

count = 1;
for i = 1:lenA
    for j = 1:lenB
        temp=B{1,j};
        C{count,1}=[A{i,1},temp];
        count = count+1;
    end
end
