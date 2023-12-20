function [children1, children2] = twoPointCrossover(parent1, parent2)

% Generate two random crossover points
crossoverPoints = randperm(length(parent1));
crossoverPoints = crossoverPoints(1:2);

if crossoverPoints(1)<crossoverPoints(2)
    st = crossoverPoints(1);
    sp = crossoverPoints(2);
else
    st = crossoverPoints(2);
    sp = crossoverPoints(1);
end

% Create the offspring by swapping the genes between the crossover points
children1 = parent1;
children1(st:sp) = parent2(st:sp);
children2 = parent2;
children2(st:sp) = parent1(st:sp);

end