function [c,i,vi] = pAXorBased(Xi,Xk)
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

    if vi(i) == Bees(Xi).Solution(i)
        c = 0;
    elseif (Bees(Xi).Solution(i) - vi(i)) == 1
        c = 1;
    else
        c = 2;
    end

%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("pAXorBased all 0.");
%     end
end