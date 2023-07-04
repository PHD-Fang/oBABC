clearvars; %Clear workspace
clc; clear; close all; 
global Parameters matris

savePath = 'UFLPResult/';
featureVal = 'N40-';
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'Cap71','Cap72','Cap73','Cap74','Cap101','Cap102','Cap103','Cap104','Cap131','Cap132','Cap133','Cap134','CapA','CapB','CapC'};
problem_start = 1;
problem_stop = 1;
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
    Parameters.MaxFuncEval = 8000;  

    Nr = 30;
    NsingleVerionAlg = 5;%['DABC','ABCbin','binABC','bitABC','oBABC']

    OBJ_BEST_fits = zeros(1,Nr);

    for r=1:1:Nr
        %initial phase
        initPos = zeros(Parameters.N,Parameters.D);
        for i = 1:Parameters.N
            initPos(i,:) = GenerateRandomSolution(Parameters.D);
        end

        for  o=1:NsingleVerionAlg %'DABC','ABCbin','binABC','bitABC','oBABC'
            tic
            [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
                Function{Function_No}.GAP(o,r),Function{Function_No}.Convergence{o}.data(r,:) ,...
                Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) ,...
                Function{Function_No}.BestSolution{o}.data(r,:)] = ZABC(Function_Name, initPos, o);
            toc
            sol = Function{Function_No}.BestSolution{o}.data(r,:);
            F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
            F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
            F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
            fprintf('%d %d %s Run = %d opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o ,ALG{o}, r, Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
        end

        %PA algrithom
        o = NsingleVerionAlg + 1;
        tic
        [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
            Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:) ,...
            Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r) ,...
            Function{Function_No}.BestSolution{o}.data(r,:)] = PA(Function_Name,initPos);
        toc
        sol = Function{Function_No}.BestSolution{o}.data(r,:);
        F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
        F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
        F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
        fprintf('%d %d PA Run = %d opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o , r, Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
    end
end

for Function_No=problem_start:problem_stop
    h = figure();
    o = NsingleVerionAlg + 1;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',1,'color',color{o}); hold on
    for o=1:(NsingleVerionAlg-1)
        plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',1,'color',color{o});hold on
    end
    o = NsingleVerionAlg;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'LineWidth',1,'color',color{o});hold on
    hold off
    title([featureVal Fun_Name{Function_No}]);
    xlabel('Iter');
    ylabel('Cost');
    legend('PBABC','DABC','ABCbin','binABC','bitABC','oBABC');
    set(gca,'FontSize',24,'Fontname','Times New Roman');
    fileName = [savePath,featureVal,Fun_Name{Function_No},'.fig'];
    savefig(h,fileName);
    close(h);
end

fileName = [savePath,featureVal,'UFLP-Function.mat'];
save(fileName,'Function');
