clc 
close all
clear all

load("N40-UFLP-Function.mat");
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#FF0000','#0072BD','#0000FF','#000000','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'Cap71','Cap72','Cap73','Cap74','Cap101','Cap102','Cap103','Cap104','Cap131','Cap132','Cap133','Cap134','CapA','CapB','CapC'};
problem_start = 13;
problem_stop = 15;
NsingleVerionAlg = 7;

fileName = 'N40-UFLP-ExtraLargeScaleResult.txt';
fileID = fopen(fileName,'w');
fprintf(fileID,'Problem\toBABC\tPBABC\tDABC\tABCbin\tbinABC\tbitABC\r\n');
for Function_No = problem_start:problem_stop

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

    for i=1:1:30
        o=5;
        gapoBABC = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        o=6;
        gapPBABC = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        o=1;
        gapDABC = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        o=2;
        gapABCbin = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        o=3;
        gapbinABC = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        o=4;
        gapbitABC = 1 - abs(Function{Function_No}.F_RUNS(o,i) - Parameters.Optimum)/Parameters.Optimum;
        fprintf(fileID,"%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\r\n", ...
            Function_Name,gapoBABC,gapPBABC,gapDABC,gapABCbin,gapbinABC,gapbitABC);
    end

%     fprintf(fileID,'\r\n');
end


fprintf(fileID,'\r\nproblem\tAlg\tBest\tMean\tWorst\r\n');
for Function_No = problem_start:problem_stop
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
    
    o=5;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);
    o=6;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);
    o=1;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);
    o=2;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);
    o=3;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);
    o=4;
    mrBest = 1 - abs(min(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrMean = 1 - abs(mean(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    mrWorst = 1 - abs(max(Function{Function_No}.F_RUNS(o,:)) - Parameters.Optimum)/Parameters.Optimum;
    fprintf(fileID,"%s\t%s\t%.4f\t%.4f\t%.4f\r\n", Function_Name,ALG{o},mrBest,mrMean,mrWorst);

end

fclose(fileID);
