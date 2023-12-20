
% function [bestScore,bestSol,Convergence] = DPSO(Problem,Parameters, initPos)
function [minIter,notUpdateTimes,GAP, Convergence , Best_Obj , Best_Fit ,Best_Sol] = DPSO(model, initPos)

global Parameters
%% Parameters of PSO

MaxIt = Parameters.MaxFuncEval/Parameters.N;           % Maximum Number of Iterations
minIter = 0;

nPop = Parameters.N;              % Population Size (Swarm Size)  Size of the frequency list
w = 0.3;                % Intertia Coefficient
wdamp = 0.999;          % Damping Ratio of Inertia Coefficient
c1 = 2;                 % Personal Acceleration Coefficient
c2 = 2;                 % Social Acceleration Coefficient
ShowIterInfo = true;    % Flag for Showing Iteration Informatin
isfirstPrint = false;
Varsize = Parameters.D;

MaxPosition = 2;
MinPosition = -2;
MaxVelocity = 2;
MinVelocity = -2;

obj= @(bees) MaxCut(model,bees);     % Cost Function
%% Initialization

% The Particle Template
particle.Position = [];
particle.Velocity = [];
particle.Best.Position = [];
particle.Cost = [];
particle.Best.Cost = [];
GlobalBest.Cost=inf;

% Initialize Global Best
GlobalBest.Position = initPos(1,:);
GlobalBest.Cost = obj(GlobalBest.Position);

Best_Sol = GlobalBest.Position;
Best_Fit = GlobalBest.Cost;

% Initialize Population Members
for i=1:nPop

    % Generate Random Solution
    particle(i).Position = initPos(i,:);%unifrnd(MinPosition, MaxPosition, 1, Varsize);
    particle(i).Velocity = unifrnd(MinVelocity, MaxVelocity, 1,Varsize);
    
    % Evaluation
    particle(i).Cost = obj(particle(i).Position);
   
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost =  particle(i).Cost;
   
    %Maximization problem
    if particle(i).Best.Cost > GlobalBest.Cost
        GlobalBest.Position  = particle(i).Position;
        GlobalBest.Cost = particle(i).Best.Cost;
    end

end
BestCost=zeros(1,MaxIt);
BestCost(1) = GlobalBest.Cost;
notUpdateTimes = 0;

%% Main Loop of PSO
for it=2:MaxIt

    for i=1:nPop
       
        % Update Velocity
        for j = 1:Varsize
            particle(i).Velocity(j) = w*particle(i).Velocity(j) ...
                + c1*rand*(particle(i).Best.Position(j) - particle(i).Position(j)) ...
                + c2*rand*(GlobalBest.Position(j) - particle(i).Position(j));
        end
        
        % Update Position
        pos = particle(i).Position + particle(i).Velocity;

        for j = 1:Varsize
            temp = 1/(1+exp(-pos(j)));
            if temp < rand()
                pos(j) = 0;
            else
                pos(j) = 1;
            end
        end

        notUpdateTimes = notUpdateTimes + compare(particle(i).Position,particle(i).Position,pos);
        particle(i).Position = pos;
        newCost = obj(particle(i).Position);
        % Update Local Best
        if newCost > particle(i).Best.Cost
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = newCost;
            
        %  update global cost
          if GlobalBest.Cost < particle(i).Best.Cost
              GlobalBest.Cost = particle(i).Best.Cost;
              GlobalBest.Position = particle(i).Best.Position;
          end
        end
    end
    BestCost(it)=GlobalBest.Cost;
     
    % Damping Inertia Coefficient
    w = w * wdamp;
end

% save('particle.mat','particle');
Convergence = BestCost;

Best_Obj = GlobalBest.Cost;
Best_Fit = Best_Obj;
Best_Sol= GlobalBest.Position;
GAP = abs(Best_Obj - Parameters.Optimum)/Parameters.Optimum;

end