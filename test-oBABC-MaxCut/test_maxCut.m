 clearvars; %Clear workspace
clc; clear; close all; 

addpath("algorithms\");
addpath("maxcut\");

global Parameters matris

fprintf('Start at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));

featureVal = 'N40-';
savePath = 'result/';
ALG = {'oBABC','DABC','ABCbin','binABC','bitABC','ibinABC','NBABC','iBABC','PBABC','DPSO'};%,'GBABC'
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'pw01_100','pw05_100','pw09_100'};
problem_start = 1;
problem_stop = 6;

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

NsingleVerionAlg = length(ALG);%['DABC','ABCbin','binABC','bitABC','fBABC']

for Function_No = problem_start:problem_stop
    rng(1216);
    clear Function;
    class = floor((Function_No-1)/10)+1;
    Function_Name = strcat(Fun_Name{class},'.',num2str(mod(Function_No-1,10)));
    model = creat_model(Function_Name);
    Parameters.D= model.Nnode;
    fprintf('%s:\r\n',Function_Name);
    Parameters.N=  40;
    Parameters.Convergence=1;
    Parameters.MaxFuncEval = 20000;
    Parameters.Optimum = optimum_All(Function_No);

    Nr = 30;

    for r=1:1:Nr

        initPos = zeros(Parameters.N,Parameters.D);
        for i = 1:Parameters.N
            initPos(i,:) = GenerateRandomSolution(Parameters.D);
        end

        for  o=6:8%(NsingleVerionAlg-2) %'oBABC','DABC','ABCbin','binABC','bitABC'
            tStart = tic;
            [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
                Function{Function_No}.GAP(o,r),Function{Function_No}.Convergence{o}.data(r,:),...
                Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r),...
                Function{Function_No}.BestSolution{o}.data(r,:)] = ZABC(model, initPos, o);
            Function{Function_No}.runTime(o,r) = toc(tStart);
            sol = Function{Function_No}.BestSolution{o}.data(r,:);
            F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
            F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
            F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
            fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o ,ALG{o}, r, Function{Function_No}.runTime(o,r), Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
        end

%         %PA algrithom
%         o = NsingleVerionAlg - 1;
%         tStart = tic;
%         [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
%             Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:),...
%             Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r),...
%             Function{Function_No}.BestSolution{o}.data(r,:)] = PA(model,initPos);
%         Function{Function_No}.runTime(o,r) = toc(tStart);
%         sol = Function{Function_No}.BestSolution{o}.data(r,:);
%         F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
%         F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
%         F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
%         fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o ,ALG{o}, r, Function{Function_No}.runTime(o,r), Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
%     
        %DPSO algrithom
        o = NsingleVerionAlg;
        tStart = tic;
        [Function{Function_No}.MinIter(o,r),Function{Function_No}.NotUpdateTimes(o,r),...
            Function{Function_No}.GAP(o,r), Function{Function_No}.Convergence{o}.data(r,:),...
            Function{Function_No}.F_RUNS(o,r) , Function{Function_No}.OBJ_BEST_fits(o,r),...
            Function{Function_No}.BestSolution{o}.data(r,:)] = DPSO(model,initPos);
        Function{Function_No}.runTime(o,r) = toc(tStart);
        sol = Function{Function_No}.BestSolution{o}.data(r,:);
        F_RUNS(Function_No,r) = Function{Function_No}.F_RUNS(o,r);
        F_GAPs(Function_No,r) = Function{Function_No}.GAP(o,r);
        F_NUP(Function_No,r) = Function{Function_No}.NotUpdateTimes(o,r);
        fprintf('%d %d %s Run = %d, Elapsed = %.4f opt = %.2f OBJ_BEST_fit=%.2f F_GAP=%2.6f F_NUP=%0.2f MinIter = %d \r\n',Function_No, o ,ALG{o}, r, Function{Function_No}.runTime(o,r), Parameters.Optimum, F_RUNS(Function_No,r),F_GAPs(Function_No,r),F_NUP(Function_No,r),Function{Function_No}.MinIter(o,r));
    end

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
end
