function solution = GenerateRandomSolution(D)
    solution = randi([0,1],1,D);
    while(sum(solution)<1)
        solution = randi([0,1],1,D);
    end
end