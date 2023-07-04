clc 
close all
clear all

load("N40-UFLP-Function.mat");
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#FF0000','#0072BD','#0000FF','#000000','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'Cap71','Cap72','Cap73','Cap74','Cap101','Cap102','Cap103','Cap104','Cap131','Cap132','Cap133','Cap134','CapA','CapB','CapC'};
problem_start = 1;
problem_stop = 15;
NsingleVerionAlg = 5;

fileName = 'N40-UFLP-algNotUpdateRatesSummaryForUFLPALL.txt';
fileID = fopen(fileName,'w');
fprintf(fileID,'notUpdateRates:\r\n');
fprintf(fileID,'Problem');
for o=1:(NsingleVerionAlg + 1)
    fprintf(fileID,'\t%s',ALG{o});
end
fprintf(fileID,'\r\n');

for Function_No=problem_start:problem_stop
    fprintf(fileID,'%s\t',Fun_Name{Function_No});
    for o=1:(NsingleVerionAlg + 1)
        notUpdateRate = mean(Function{Function_No}.NotUpdateTimes(o,:));
        fprintf(fileID,'\t%d',notUpdateRate);
    end
    fprintf(fileID,'\r\n');
end
fclose(fileID);