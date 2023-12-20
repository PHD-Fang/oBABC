function cost = objective(bees)
global matris
if(sum(bees)<1)
%     display('Sol is all zeros.');
    cost = Inf;
else
    cost = sum(matris.fixCost.*bees);
    costAlloc = matris.costAlloc;
    for i = 1:1:matris.numOfCustomers
        cost = cost + min(costAlloc(i,find(bees>0)));
    end
end
end