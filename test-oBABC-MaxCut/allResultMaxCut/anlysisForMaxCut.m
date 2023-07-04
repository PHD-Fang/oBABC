clc 
close all
clear all

fprintf('Start at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
featureVal = 'N40-';
savePath = 'Result/';
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#000000','#FF0000','#0000FF','#A39480','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
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

fileName = [savePath,'N40-Max-Cut-ALL.txt'];
fileID = fopen(fileName,'w');
fprintf(fileID,'Problem\tAlgorithm\tBest\tWorst\tMean\tStd.Dev\tMR(Best)\tMR(Worst)\tMR(Mean)\tHitTimes(100)\tHitTimes(99)\tMeanHit99\tBestHit99\r\n');
algArray = [5,6,1,2,3,4];
for Function_No = problem_start:problem_stop
    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);


    for i = 1:1:6
        o = algArray(i);
        problem = Fun_Name_all{Function_No};
        Best = max(Function{Function_No}.F_RUNS(o,:));
        worst = min(Function{Function_No}.F_RUNS(o,:));
        meanval = mean(Function{Function_No}.F_RUNS(o,:));
        stdDev = std(Function{Function_No}.F_RUNS(o,:));
        MRbest = 1-abs(Parameters.Optimum - Best)/Parameters.Optimum;
        MRworst = 1-abs(Parameters.Optimum - worst)/Parameters.Optimum;
        MRmean = 1-abs(Parameters.Optimum - meanval)/Parameters.Optimum;
        HitTimes100 = sum(abs(Function{Function_No}.F_RUNS(o,:)-Parameters.Optimum)<1);
        HitTimes99 = sum((1 - abs(Function{Function_No}.F_RUNS(o,:)-Parameters.Optimum)/Parameters.Optimum)>=0.99);
        MeanHit99 = (MRmean>=0.99); 
        BestHit99 = (MRbest>=0.99); 
        fprintf(fileID,'%s\t%s\t%.2f\t%.2f\t%.2f\t%.2f\t%.4f\t%.4f\t%.4f\t%d\t%d\t%d\t%d\r\n', ...
            problem,ALG{o},Best,worst,meanval,stdDev,MRbest,MRworst,MRmean,HitTimes100,HitTimes99,MeanHit99,BestHit99);
    end

end

% fprintf(fileID,'Problem\toBABC\tPBABC\tDABC\tABCbin\tbinABC\tbitABC\r\n');
fclose(fileID);