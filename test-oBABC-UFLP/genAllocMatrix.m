function allocMatrix = genAllocMatrix(bees)
    global matris
    if(sum(bees)<1)
        display(Bees);
    end
    
    allocMatrix = zeros(size(matris.costAlloc));
    cost = sum(matris.fixCost.*bees);
    costAlloc = matris.costAlloc;
    alloc = repmat(bees,matris.numOfCustomers,1);
    costAlloc = alloc.*costAlloc;
    for i = 1:1:matris.numOfCustomers
        a = costAlloc(i,find(costAlloc(i,:)>0));
%         costAlloc(i,:)
%         find(costAlloc(i,:)>0)
        [val,indx] = min(costAlloc(i,find(costAlloc(i,:)>0)));
        cost = cost + val;
        allocMatrix(i,indx)=1;
    end
end