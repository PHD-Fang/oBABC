function children1 = twoPointMutation(parent1)

% Generate two random crossover points
crossoverPoints = randperm(length(parent1));

p1 = crossoverPoints(1);
p2 = crossoverPoints(2);


% Create the offspring by swapping the genes between the crossover points
children1 = parent1;
children1(p1) = parent1(p2);
children1(p2) = parent1(p1);

end