function A = genItem(attValue)


A = {};
len = length(attValue{1,1});
for i = 1:len
	A{i,1}=[attValue{1,1}(1,i)];
end
count = length(A);
dim = length(attValue);
for i = 2:dim
	lenA = length(A);
	leni = length(attValue{i,:});
	for j = 1:lenA
		for k = 1:leni
			A{end+1,:}=[A{j,1}(1,:),attValue{i,1}(1,k)];
			count = count +1
		end
	end
end