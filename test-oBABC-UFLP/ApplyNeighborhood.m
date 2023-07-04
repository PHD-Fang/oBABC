function solution = ApplyNeighborhood(Xi,Xk,opCode)
    switch(opCode)
        case 1
            solution = sABCNeighborhood(Xi,Xk);
        case 2
            solution = ABCbinNeighborhood(Xi,Xk);
        case 3
            solution = binABCNeighborhood(Xi,Xk);
        case 4
            solution = bitABCNeighborhood(Xi,Xk);
        case 5
            solution = oBABCNeighborhood(Xi,Xk);
        otherwise
            fprintf('Unkown neighborhood.\n');
    end
end