function children = checkAllZero(parent)

children = parent;
th = 3;

if sum(parent)<1
    crossoverPoints = randperm(length(parent));
    for i = 1:1:th
        j = crossoverPoints(i);
        children(j) = 1;
    end
end

end