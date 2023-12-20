function vi = bitABCNeighborhood(Xi,Xk)
    global Bees Parameters
    i = randi(Parameters.D);
    vi=Bees(Xi).Solution;
    temp = 0;
    if rand < 0.5
        temp = or(Bees(Xi).Solution(i),Bees(Xk).Solution(i));
    else
        temp = 0;
    end
    vi(i) = xor(Bees(Xi).Solution(i), temp);
%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("bitABCNeighborhood all 0.");
%     end
end