function transMatrix = updateTransMatrix(transMatrix,C,dim)
D = size(dim,2);
for i = 1:D
    if C(i) > 0
        transMatrix(C(i),dim(i)) = transMatrix(C(i),dim(i)) + 1;
    end
end