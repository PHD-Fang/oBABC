function vi = ABCbinNeighborhood(Xi,Xk)
    global Bees Parameters
    Param2Change = randi(Parameters.D);
    vi = Bees(Xi).Solution;

    vi(Param2Change)=vi(Param2Change) + (vi(Param2Change)-Bees(Xk).Solution(Param2Change))*(rand-0.5)*2;
    
    temp = vi(Param2Change);
    vi(Param2Change)=mod(round(mod(abs(temp), 2)),2);

    if(vi(Param2Change) ~= mod(round(abs(temp)),2))
        fprintf("ABCbin anlysis Error: %.2f %d %d.\r\n",temp,vi(Param2Change),round(abs(temp)));
    end
    
%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("ABCbinNeighborhood all 0.");
%     end
end