function vi = fBABCNeighborhood(Xi,Xk)
    global Bees Parameters

    vi = Bees(Xi).Solution;

    costXi = Bees(Xi).Cost;%objective(Bees(Xi).Solution);
    costXk = Bees(Xk).Cost;%objective(Bees(Xk).Solution);

    th = 2;
    bitOne = xor(Bees(Xi).Solution,Bees(Xk).Solution);
    if ((costXk < costXi) && (sum(bitOne) >= th))
        bitIndx = find(bitOne==1);
        Param2Change=bitIndx(fix(rand*sum(bitOne))+1);
    elseif ((costXk >= costXi) && (sum(bitOne) < th))
        bitIndx = find(bitOne==0);
        Param2Change=bitIndx(fix(rand*sum(bitOne))+1);
    else
        Param2Change = randi(Parameters.D);
    end

    vi(Param2Change)=not(vi(Param2Change));

%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("oBABC3Neighborhood all 0.");
%     end
end