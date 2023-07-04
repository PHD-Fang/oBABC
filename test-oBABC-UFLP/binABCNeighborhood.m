function vi = binABCNeighborhood(Xi,Xk)
    global Bees Parameters
    i = randi(Parameters.D);
    vi=Bees(Xi).Solution;
    temp = 0;
    if rand < 0.5
        temp = ~(xor(Bees(Xi).Solution(i),Bees(Xk).Solution(i)));
    else
        temp = (xor(Bees(Xi).Solution(i),Bees(Xk).Solution(i)));
    end
    vi(i) = xor(Bees(Xi).Solution(i), temp);
    if(sum(vi)<1)
        vi = GenerateRandomSolution(Parameters.D);
        fprintf("binABCNeighborhood all 0.");
    end
end