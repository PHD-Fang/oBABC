function Vi = NBABCNeighborhood(Xi,Xk)
global Bees Parameters

max_flips = 0.1;
num_dim = ceil(max_flips*Parameters.D);

Vi=Bees(Xi).Solution;

indx = randperm(Parameters.D);
for j = 1:1:num_dim
    i = indx(j);
    Vi(i) = Bees(Xk).Solution(i);
end

if(sum(Vi)<1)
    Vi = GenerateRandomSolution(Parameters.D);
    fprintf("NBABCNeighborhood all 0.\r\n");
end

end
