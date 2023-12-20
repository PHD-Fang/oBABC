function Vi = GBABCNeighborhood(Xi,Xk)
global Bees Parameters
model = Parameters.model;

NB = Parameters.N/2;
temp = randperm(NB);
Xj = temp(1);
if Xj == Xi
    Xj = temp(3);
end
Xk = temp(2);
if Xk == Xi
    Xk = temp(3);
end
[GlobalBestCost,indx] = max([Bees.Fitness]);
Xbest = indx;


Xi = Bees(Xi).Solution;
Xj = Bees(Xj).Solution;
Xk = Bees(Xk).Solution;
Xbest = Bees(Xbest).Solution;
V0 = zeros(1,Parameters.D);

parent = [Xi;Xj;Xk;Xbest;V0];
Num = 5;
one2one = randperm(Num);

cNum = 10;
children = zeros(cNum,Parameters.D);
for i = 1:1:Num
    j = one2one(i);
%     [i,j]
    k = 2*(i-1) + 1;
    [children(k,:), children(k+1,:)] = twoPointCrossover(parent(i,:), parent(j,:));
end
for i = 1:1:cNum
    children(i,:) = checkAllZero(children(i,:));
end

gNum = 10;
grandchildren = zeros(gNum,Parameters.D);
for i = 1:1:gNum
    grandchildren(i,:) = twoPointMutation(children(i,:));
end

sol = [children;grandchildren];
sNum = cNum + gNum;
fit = MaxCut(model, sol(1,:));
indx = 1;
for i = 1:1:sNum
    temp = MaxCut(model, sol(i,:));
    if(fit < temp)
        indx = i;
        fit = temp;
    end
end
Vi = sol(indx,:);

% if(sum(Vi)<1)
%     Vi = GenerateRandomSolution(Parameters.D);
%     fprintf("GBABCNeighborhood all 0.\r\n");
% end

end
