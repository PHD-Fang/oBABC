function [opCode, solution] = ApplyNeighborhood(Xi,Xk,opCode)
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
            solution = iBABCNeighborhoodEmployee(Xi,Xk);
            opCode = 9;
        case 9
            solution = iBABCNeighborhoodOnlooker(Xi,Xk);
            opCode = 8;
        otherwise
            error('Error: unkown opCode %d.',opCode);
    end
end

%         case 8
%             solution = GBABCNeighborhood(Xi,Xk);