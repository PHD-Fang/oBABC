clc 
close all
clear all

fprintf('Start at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
featureVal = 'N40-';
savePath = 'rawResult/';
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC1','oBABC2','oBABC3','PBABC','BRO','BRO-SP','BRO-TP','BRO-UP'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'pw01_100','pw05_100','pw09_100'};
problem_start = 1;
problem_stop = 30;
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

algArray = [1,2,3,4,6,8];
for Function_No = problem_start:problem_stop
    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    fprintf(matFileName);
    fprintf("\r\n");
    load(matFileName);
  
    for i = 1:1:6
        o = algArray(i);
        newFunction{Function_No}.MinIter(i,:) = Function{Function_No}.MinIter(o,:);
        newFunction{Function_No}.NotUpdateTimes(i,:) = Function{Function_No}.NotUpdateTimes(o,:);
        newFunction{Function_No}.GAP(i,:) = Function{Function_No}.GAP(o,:);
        newFunction{Function_No}.Convergence{i} = Function{Function_No}.Convergence{o};
        newFunction{Function_No}.F_RUNS(i,:) = Function{Function_No}.F_RUNS(o,:);
        newFunction{Function_No}.OBJ_BEST_fits(i,:) = Function{Function_No}.OBJ_BEST_fits(o,:);
        newFunction{Function_No}.F_RUNS(i,:) = Function{Function_No}.F_RUNS(o,:);
        newFunction{Function_No}.BestSolution{i} = Function{Function_No}.BestSolution{o};
    end

    clear Function;
    Function = newFunction;
    fileName = ['Result/',featureVal,'Function','-',temp3,'.mat'];
    save(fileName,'Function');
end
