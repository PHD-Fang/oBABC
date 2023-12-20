clearvars; %Clear workspace
clc; clear; close all; 
global Parameters matris

addpath("algorithms\");
addpath("UFLP\");

savePath = 'result/';
featureVal = 'N40-';
ALG = {'oBABC','DABC','ABCbin','binABC','bitABC','ibinABC','NBABC','GBABC','iBABC','PBABC','DPSO'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'Cap71','Cap72','Cap73','Cap74','Cap101','Cap102','Cap103','Cap104','Cap131','Cap132','Cap133','Cap134','CapA','CapB','CapC'};
problem_start = 1;
problem_stop = 15;
rng(1216);

for Function_No=problem_start:problem_stop
    
    switch Function_No
       case 1  , Function_Name= 'Cap71';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum =  932615.75;
       case 2  , Function_Name= 'Cap72';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum =  977799.40;
       case 3  , Function_Name= 'Cap73';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum = 1010641.45;
       case 4  , Function_Name= 'Cap74';    Parameters.D= 16;     Parameters.N=  16;    Parameters.Optimum = 1034976.975;%1034976.98;
       case 5  , Function_Name= 'Cap101';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  796648.4375;%796648.44;
       case 6  , Function_Name= 'Cap102';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  854704.20;
       case 7  , Function_Name= 'Cap103';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  893782.1125;%893782.11;
       case 8  , Function_Name= 'Cap104';   Parameters.D= 25;     Parameters.N=  25;    Parameters.Optimum =  928941.75;
       case 9  , Function_Name= 'Cap131';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  793439.5625;%793439.56;
       case 10 , Function_Name= 'Cap132';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  851495.325;%851495.33;
       case 11 , Function_Name= 'Cap133';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  893076.7125;%893076.71;
       case 12 , Function_Name= 'Cap134';   Parameters.D= 50;     Parameters.N=  50;    Parameters.Optimum =  928941.75;%e-10
       case 13 , Function_Name= 'CapA';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =17156454.4783;%17156454.48;
       case 14 , Function_Name= 'CapB';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =12979071.58143;%12979071.58;
       case 15 , Function_Name= 'CapC';     Parameters.D= 100;    Parameters.N=  100;   Parameters.Optimum =11505594.33;
       otherwise , fprintf('HATA\n');
    end
    
    fprintf('%s:\r\n',Function_Name);
    Parameters.N=  40;
    Parameters.Convergence=1;
    Parameters.MaxFuncEval = 80000;  

    Nr = 30;
    NsingleVerionAlg = length(ALG);%['oBABC','DABC','ABCbin','binABC','bitABC']

    OBJ_BEST_fits = zeros(1,Nr);

    for r=1:1:Nr
        %initial phase
        initPos = zeros(Parameters.N,Parameters.D);
        for i = 1:Parameters.N
            initPos(i,:) = GenerateRandomSolution(Parameters.D);
        end

        for  o = 1:NsingleVerionAlg - 2 %'oBABC','DABC','ABCbin','binABC','bitABC'
            tStart = tic;
            [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
                Function{Function_No}.GAP(o,r),Function{Function_No}.Convergence{o}.data(r,:) ,...
                Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) ,...
                Function{Function_No}.BestSolution{o}.data(r,:)] = ZABC(Function_Name, initPos, o);
            Function{Function_No}.runTime(o,r) = toc(tStart);
            sol = Function{Function_No}.BestSolution{o}.data(r,:);
            F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
            F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
            F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
            fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o ,ALG{o}, Function{Function_No}.runTime(o,r), r, Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
        end

        %PA algrithom
        o = NsingleVerionAlg - 1;
        tStart = tic;
        [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
            Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:) ,...
            Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) ,...
            Function{Function_No}.BestSolution{o}.data(r,:)] = PA(Function_Name,initPos);
        Function{Function_No}.runTime(o,r) = toc(tStart);
        sol = Function{Function_No}.BestSolution{o}.data(r,:);
        F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
        F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
        F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
        fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o , ALG{o}, Function{Function_No}.runTime(o,r), r, Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
   
        %DPSO algrithom
        o = NsingleVerionAlg;
        tStart = tic;
        [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
            Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:) ,...
            Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) ,...
            Function{Function_No}.BestSolution{o}.data(r,:)] = DPSO(Function_Name,initPos);
        Function{Function_No}.runTime(o,r) = toc(tStart);
        sol = Function{Function_No}.BestSolution{o}.data(r,:);
        F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
        F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
        F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
        fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o, ALG{o}, Function{Function_No}.runTime(o,r), r, Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
    
    end
end

fileName = [savePath,featureVal,'UFLP-Function.mat'];
save(fileName,'Function','ALG');
