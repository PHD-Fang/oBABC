function [minIter, notUpdateTimes, GAP, Convergence , Best_Obj , Best_Fit ,Best_Sol] = PA(model,initPos)
    global Bees FuncEval Parameters
    global matris
    Parameters.Counters = ones(1,20);
    Parameters.phiMax = 0.9;
    Parameters.phiMin = 0.5;
    Parameters.qStart = 0.3;
    Parameters.qEnd = 0.1;
    
    CostFunction= @(model,bees) MaxCut(model,bees);     % Cost Function
    Convergence = [];
    
    NB = Parameters.N/2;
    limit = (NB*Parameters.D)*2.5;
    transMatrix = zeros(2,Parameters.D); %transMatrix(1,:) record 1 to 0; transMatrix(2,:) record 0 to 1.
    notUpdateTimes = 0;

    for i=1:NB
        Bees(i).Solution = initPos(i,:);%GenerateRandomSolution(Parameters.D);
        Bees(i).Cost = CostFunction(model, Bees(i).Solution);
        Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
        Bees(i).Trial = 0;
    end

    initPAFit = [Bees.Cost];

    minIter = round(Parameters.MaxFuncEval/Parameters.N);
    firstFlag = 0;
    
    FuncEval = Parameters.N;
    [GlobalBestCost,indx] = max([Bees.Cost]);
    GlobalBestSol = Bees(indx).Solution;
    Parameters.maxIter = Parameters.MaxFuncEval/NB;
    Convergence(1) = GlobalBestCost;
    Parameters.dim = round(0.1*Parameters.D);%rand()*4 + exp(-4*(Parameters.t/Parameters.maxIter)*(0.1*Parameters.D)+1);
    if Parameters.dim < 1
        Parameters.dim = 1;
    end
while FuncEval < Parameters.MaxFuncEval
    Parameters.t = FuncEval/Parameters.N;
    
%     [Parameters.dim]
    for i=1:NB
        neighbor = tournement_selection(NB);
        while neighbor==i
            neighbor = tournement_selection(NB);
        end
        [C, dim, NewSolution.Solution] = pAXorBased(i,neighbor); %vi = XorBased(Xi,Xk)
        notUpdateTimes = notUpdateTimes + compare(Bees(i).Solution,Bees(neighbor).Solution,NewSolution.Solution);
        NewCost = CostFunction(model, NewSolution.Solution);
        if NewCost < Bees(i).Cost
            Bees(i).Trial=Bees(i).Trial+1;
        else
            Bees(i).Solution = NewSolution.Solution;
            Bees(i).Cost = NewCost;
            Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
            Bees(i).Trial=0;
            transMatrix = updateTransMatrix(transMatrix,C,dim);
        end
    end
    Probs = [Bees.Fitness];
    maxFit = max(Probs);
    probs = (Probs.* 0.9)/maxFit+0.1;
    i=1;
    t=0;
    while t<NB
        if rand<probs(i)
            t=t+1;
            neighbor = tournement_selection(NB);
            while neighbor==i
                neighbor = tournement_selection(NB);
            end
            [C,dim, NewSolution.Solution] = pAStigmergic(i,transMatrix);
            notUpdateTimes = notUpdateTimes + compare(Bees(i).Solution,Bees(neighbor).Solution,NewSolution.Solution);
            NewCost = CostFunction(model, NewSolution.Solution);
            if NewCost < Bees(i).Cost
                Bees(i).Trial=Bees(i).Trial+1;
            else
                Bees(i).Solution = NewSolution.Solution;
                Bees(i).Cost = NewCost;
                Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
                Bees(i).Trial=0;
                transMatrix = updateTransMatrix(transMatrix,C,dim);
            end
        end
        i=i+1;
        if i>NB
            i=1;
        end
    end
    for i=1:NB
        if Bees(i).Trial>limit
            Bees(i).Solution = GenerateRandomSolution(Parameters.D);
            Bees(i).Cost = CostFunction(model, Bees(i).Solution);
            Bees(i).Fitness = CalculateFitness(Bees(i).Cost);
            Bees(i).Trial = 0;
            break;
        end
    end
    [BestCost,indx] = max([Bees.Cost]);
   	if GlobalBestCost < BestCost
        GlobalBestCost = BestCost;
        GlobalBestSol = Bees(indx).Solution;
    end
    FuncEval = FuncEval+ Parameters.N;
%     fprintf('iter: %d Cost: %f GAP:%f \n',FuncEval/Parameters.N,GlobalBestCost,Parameters.Optimum-GlobalBestCost);
    Convergence(FuncEval/Parameters.N) = GlobalBestCost;
    GAP = abs(GlobalBestCost - Parameters.Optimum)/Parameters.Optimum;
    if GAP < 0.001 && firstFlag < 1
        minIter = FuncEval/Parameters.N;
        firstFlag = 1;
    end
end
    Best_Obj = GlobalBestCost;
    Best_Fit = CalculateFitness(GlobalBestCost);
    Best_Sol= GlobalBestSol;
    GAP = abs(GlobalBestCost - Parameters.Optimum)/Parameters.Optimum;
%     notUpdateTimes = notUpdateTimes/Parameters.MaxFuncEval;
end