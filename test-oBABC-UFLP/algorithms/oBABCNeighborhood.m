function vi = oBABCNeighborhood(Xi,Xk)
    global Bees Parameters

    th = 2;
    vi = Bees(Xi).Solution;
    bitOne = xor(Bees(Xi).Solution,Bees(Xk).Solution);
    if sum(bitOne) < th
        bitIndx = find(bitOne==0);
        Param2Change=bitIndx(fix(rand*sum(bitOne))+1);
    else
        bitIndx = find(bitOne==1);
        Param2Change=bitIndx(fix(rand*sum(bitOne))+1);
    end

    vi(Param2Change)=not(vi(Param2Change));

    if(sum(vi)<1)
        vi = GenerateRandomSolution(Parameters.D);
        fprintf("oBABCNeighborhood all 0.\r\n");
    end
end