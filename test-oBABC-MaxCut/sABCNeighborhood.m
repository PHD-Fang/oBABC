function vi = sABCNeighborhood(Xi,Xk)
    global Bees Parameters
    Param2Change = randi(Parameters.D);
    vi = Bees(Xi).Solution;

    vi(Param2Change)=vi(Param2Change) + (vi(Param2Change)-Bees(Xk).Solution(Param2Change))*(rand-0.5)*2;
    
    vi(Param2Change)=1/(1+exp(-vi(Param2Change)));

    %  /*if generated parameter value is out of boundaries, it is shifted onto the boundaries*/
    if vi(Param2Change) > rand()
        vi(Param2Change) = 1;
    else
        vi(Param2Change) = 0;
    end
    
%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("sABCNeighborhood all 0.");
%     end
end