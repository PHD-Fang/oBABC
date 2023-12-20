function [opCode,solution] = ApplyNeighborhood(Xi,Xk,opCode)
    switch(opCode)
        case 1
            solution = oBABCNeighborhood(Xi,Xk);            
        case 2
            solution = sABCNeighborhood(Xi,Xk);            
        case 3
            solution = ABCbinNeighborhood(Xi,Xk);            
        case 4
            solution = binABCNeighborhood(Xi,Xk);            
        case 5
            solution = bitABCNeighborhood(Xi,Xk);
        case 6
            solution = ibinABCNeighborhood(Xi,Xk);
        case 7
            solution = NBABCNeighborhood(Xi,Xk);
        case 8
            solution = GBABCNeighborhood(Xi,Xk);
        case 9
            solution = iBABCNeighborhoodEmployee(Xi,Xk);
            opCode = 10;
        case 10
            solution = iBABCNeighborhoodOnlooker(Xi,Xk);
            opCode = 9;
        otherwise
            fprintf('Unkown neighborhood.\n');
    end
end