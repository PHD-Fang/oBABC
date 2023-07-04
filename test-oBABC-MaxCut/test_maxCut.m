 clearvars; %Clear workspace
clc; clear; close all; 
global Parameters matris

fprintf('Start at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
featureVal = 'N40-';
savePath = 'Result/';
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'pw01_100','pw05_100','pw09_100'};
problem_start = 1;
problem_stop = 1;
rng(1216);
Fun_Name_all = {};
for Function_No = 1:30
    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    Fun_Name_all{Function_No} = strcat(temp1,'.',num2str(temp2));
end
optimum_All = [2019,2060,2032,2067,2039,2108,2032,2074,2022,2005,...
               8190,8045,8039,8139,8125,8169,8217,8249,8199,8099,...
               13585,13417,13461,13656,13514,13574,13640,13501,13593,13658];

for Function_No = problem_start:problem_stop
    class = floor((Function_No-1)/10)+1;
    Function_Name = strcat(Fun_Name{class},'.',num2str(mod(Function_No-1,10)));
    model = creat_model(Function_Name);
    Parameters.D= model.Nnode;
    fprintf('%s:\r\n',Function_Name);
    Parameters.N=  40;
    Parameters.Convergence=1;
    Parameters.MaxFuncEval = 2000;
    Parameters.Optimum = optimum_All(Function_No);

    Nr = 30;
    NsingleVerionAlg = 5;%['DABC','ABCbin','binABC','bitABC','oBABC1','oBABC2','oBABC3']

    OBJ_BEST_fits = zeros(1,Nr);

    for r=1:1:Nr

        initPos = zeros(Parameters.N,Parameters.D);
        for i = 1:Parameters.N
            initPos(i,:) = GenerateRandomSolution(Parameters.D);
        end

        for  o=1:NsingleVerionAlg %'DABC','ABCbin','binABC','bitABC','oBABC'
            tic
            [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
                Function{Function_No}.GAP(o,r),Function{Function_No}.Convergence{o}.data(r,:),...
                Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r),...
                Function{Function_No}.BestSolution{o}.data(r,:)] = ZABC(model, initPos, o);
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
            Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:),...
            Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r),...
            Function{Function_No}.BestSolution{o}.data(r,:)] = PA(model,initPos);
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
    o = NsingleVerionAlg+1;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',1,'color',color{o}); hold on
    for o=1:NsingleVerionAlg-1
        plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',1,'color',color{o});hold on
    end
    o=NsingleVerionAlg;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'LineWidth',1,'color',color{o});hold on
    hold off
    title([Fun_Name_all{Function_No}]);
    xlabel('Iter');
    ylabel('Max-Cut')
    legend('PBABC','DABC','ABCbin','binABC','bitABC','oBABC');
    set(gca,'FontSize',24,'Fontname','Times New Roman');
    fileName = [savePath,featureVal,Fun_Name_all{Function_No},'.fig'];
    savefig(h,fileName);
%     close(h);
end

class = floor((Function_No-1)/10)+1;
temp1 = replace(Fun_Name{class},'_','-');
temp2 = mod(Function_No-1,10);
temp3 = strcat(temp1,'-',num2str(temp2));

fileName = [savePath,featureVal,temp3,'-','algPerformanceSummary.txt'];
fileID = fopen(fileName,'w');
for o=1:NsingleVerionAlg+1
    fprintf(fileID,'%s:\r\n',ALG{o});%'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'
    fprintf(fileID,'Problem\tBest\tWorst\tMean\tStd.Dev.\tGAP\tHitTimes\tHit90\r\n');
    for Function_No = problem_start:problem_stop
        problem = Fun_Name_all{Function_No};
        Best = max(Function{Function_No}.F_RUNS(o,:));
        worst = min(Function{Function_No}.F_RUNS(o,:));
        meanVal = mean(Function{Function_No}.F_RUNS(o,:));
        stdDev = std(Function{Function_No}.F_RUNS(o,:));
        Gap = mean(Function{Function_No}.GAP(o,:))*100;
        HitTimes = sum(Function{Function_No}.GAP(o,:)<0.00001);
        Hit90 = mean(Function{Function_No}.MinIter(o,:));
        fprintf(fileID,'%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%d\t%.2f\r\n',problem,Best,worst,meanVal,stdDev,Gap,HitTimes,Hit90);
    end
    fprintf(fileID,'\r\n');
end
fclose(fileID);

class = floor((Function_No-1)/10)+1;
temp1 = replace(Fun_Name{class},'_','-');
temp2 = mod(Function_No-1,10);
temp3 = strcat(temp1,'-',num2str(temp2));

fileName = [savePath,featureVal,temp3,'-','algNotUpdateRatesSummary.txt'];
fileID = fopen(fileName,'w');
fprintf(fileID,'notUpdateRates:\r\n');
fprintf(fileID,'Problem');
for o=1:(NsingleVerionAlg + 1)
    fprintf(fileID,'\t%s',ALG{o});
end
fprintf(fileID,'\r\n');
for Function_No=problem_start:problem_stop
    fprintf(fileID,'%s',Fun_Name_all{Function_No});
    for o=1:(NsingleVerionAlg + 1)
        notUpdateRate = mean(Function{Function_No}.NotUpdateTimes(o,:));
        fprintf(fileID,'\t%d',notUpdateRate);
    end
    fprintf(fileID,'\r\n');
end

fclose(fileID);

class = floor((Function_No-1)/10)+1;
temp1 = replace(Fun_Name{class},'_','-');
temp2 = mod(Function_No-1,10);
temp3 = strcat(temp1,'-',num2str(temp2));
fileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
Function{Function_No}.Parameters.problem_start = problem_start;
Function{Function_No}.Parameters.problem_start = problem_start;
Function{Function_No}.Parameters.N = Parameters.N;
Function{Function_No}.Parameters.MaxFuncEval = Parameters.MaxFuncEval;
save(fileName,'Function');
fprintf('Stop at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
