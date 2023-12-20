function Vi = ibinABCNeighborhood(Xi,Xk)
global Bees Parameters
% [Parameters.dim, Parameters.q]

Vi=Bees(Xi).Solution;

th = 0;
if Bees(Xi).Fitness > Bees(Xk).Fitness
    th = Parameters.q;
end

indx = randperm(Parameters.D);
for j = 1:1:Parameters.dim
    i = indx(j);
    if rand < th
        temp = ~(xor(Bees(Xi).Solution(i),Bees(Xk).Solution(i)));
    else
        temp = (xor(Bees(Xi).Solution(i),Bees(Xk).Solution(i)));
    end
    Vi(i) = xor(Bees(Xi).Solution(i), temp);
end

if(sum(Vi)<1)
    Vi = GenerateRandomSolution(Parameters.D);
    fprintf("ibinABCNeighborhood all 0.\r\n");
end

end
