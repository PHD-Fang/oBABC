clc 
close all
clear all

load("N40-UFLP-Function.mat");

problem_start = 1;
problem_stop = 15;

for Function_No=problem_start:problem_stop
    for o = 1:1:4
        newFunction{Function_No}.MinIter(o,:) = Function{Function_No}.MinIter(o,:);
        newFunction{Function_No}.NotUpdateTimes(o,:) = Function{Function_No}.NotUpdateTimes(o,:);
        newFunction{Function_No}.GAP(o,:) = Function{Function_No}.GAP(o,:);
        newFunction{Function_No}.Convergence{o} = Function{Function_No}.Convergence{o};
        newFunction{Function_No}.F_RUNS(o,:) = Function{Function_No}.F_RUNS(o,:);
        newFunction{Function_No}.OBJ_BEST_fits(o,:) = Function{Function_No}.OBJ_BEST_fits(o,:);
        newFunction{Function_No}.F_RUNS(o,:) = Function{Function_No}.F_RUNS(o,:);
        newFunction{Function_No}.BestSolution{o} = Function{Function_No}.BestSolution{o};
    end

    o = 6;
    s = 5;
    newFunction{Function_No}.MinIter(s,:) = Function{Function_No}.MinIter(o,:);
    newFunction{Function_No}.NotUpdateTimes(s,:) = Function{Function_No}.NotUpdateTimes(o,:);
    newFunction{Function_No}.GAP(s,:) = Function{Function_No}.GAP(o,:);
    newFunction{Function_No}.Convergence{s} = Function{Function_No}.Convergence{o};
    newFunction{Function_No}.F_RUNS(s,:) = Function{Function_No}.F_RUNS(o,:);
    newFunction{Function_No}.OBJ_BEST_fits(s,:) = Function{Function_No}.OBJ_BEST_fits(o,:);
    newFunction{Function_No}.F_RUNS(s,:) = Function{Function_No}.F_RUNS(o,:);
    newFunction{Function_No}.BestSolution{s} = Function{Function_No}.BestSolution{o};

    o = 8;
    s = 6;
    newFunction{Function_No}.MinIter(s,:) = Function{Function_No}.MinIter(o,:);
    newFunction{Function_No}.NotUpdateTimes(s,:) = Function{Function_No}.NotUpdateTimes(o,:);
    newFunction{Function_No}.GAP(s,:) = Function{Function_No}.GAP(o,:);
    newFunction{Function_No}.Convergence{s} = Function{Function_No}.Convergence{o};
    newFunction{Function_No}.F_RUNS(s,:) = Function{Function_No}.F_RUNS(o,:);
    newFunction{Function_No}.OBJ_BEST_fits(s,:) = Function{Function_No}.OBJ_BEST_fits(o,:);
    newFunction{Function_No}.F_RUNS(s,:) = Function{Function_No}.F_RUNS(o,:);
    newFunction{Function_No}.BestSolution{s} = Function{Function_No}.BestSolution{o};

end

clear Function;
Function = newFunction;
fileName = ['test/','N40-UFLP-Function.mat'];
save(fileName,'Function');

