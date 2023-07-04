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

gap = 0.95;

fileName = [savePath,'N40-Max-Cut-MinIter95.txt'];

fileID = fopen(fileName,'w');
fprintf(fileID,'Problem\toBABC\tPBABC\tDABC\tABCbin\tbinABC\tbitABC\r\n');
for Function_No = problem_start:problem_stop
    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    clear Function;
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);

    algArray = [5,6,1,2,3,4];
    data=zeros(6,30);
    for i=1:1:30
        o=5;
        gapoBABC = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(1,i) = gapoBABC;

        o=6;
        gapPBABC = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(2,i) = gapPBABC;

        o=1;
        gapDABC = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(3,i) = gapDABC;

        o=2;
        gapABCbin = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(4,i) = gapABCbin;

        o=3;
        gapbinABC = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(5,i) = gapbinABC;

        o=4;
        gapbitABC = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        data(6,i) = gapbitABC;

        fprintf(fileID,"%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\r\n", ...
            Fun_Name_all{Function_No},gapoBABC,gapPBABC,gapDABC,gapABCbin,gapbinABC,gapbitABC);
    end

end

fprintf(fileID,'\r\nave:\r\n');
fprintf(fileID,'Problem\toBABC\tPBABC\tDABC\tABCbin\tbinABC\tbitABC\r\n');
for Function_No = problem_start:problem_stop

    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    clear Function;
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);

    data=zeros(6,30);
    for i=1:1:30
        o=5;
        data(1,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=6;
        data(2,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=1;
        data(3,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=2;
        data(4,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=3;
        data(5,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=4;
        data(6,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
    end


    gapoBABC = mean(data(1,:));
    gapPBABC = mean(data(2,:));
    gapDABC = mean(data(3,:));
    gapABCbin = mean(data(4,:));
    gapbinABC = mean(data(5,:));
    gapbitABC = mean(data(6,:));
    fprintf(fileID,"%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\r\n", ...
        Fun_Name_all{Function_No},gapoBABC,gapPBABC,gapDABC,gapABCbin,gapbinABC,gapbitABC);

%     fprintf(fileID,'\r\n');
end

fprintf(fileID,'\r\naveForRank:\r\n');
for Function_No = problem_start:problem_stop

    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    clear Function;
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);

    data=zeros(6,30);
    for i=1:1:30
        o=5;
        data(1,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=6;
        data(2,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=1;
        data(3,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=2;
        data(4,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=3;
        data(5,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
        o=4;
        data(6,i) = findMinIterByGapPercent(Function{Function_No}.Convergence{o}.data(i,:),Parameters.Optimum,gap);
    end

    gapoBABC = mean(data(1,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{5},gapoBABC);
    gapPBABC = mean(data(2,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{6},gapPBABC);

    gapDABC = mean(data(3,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{1},gapDABC);
    gapABCbin = mean(data(4,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{2},gapABCbin);
    gapbinABC = mean(data(5,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{3},gapbinABC);
    gapbitABC = mean(data(6,:));
    fprintf(fileID,"%s\t%s\t%.4f\r\n", Fun_Name_all{Function_No},ALG{4},gapbitABC);

%     fprintf(fileID,'\r\n');
end

fprintf(fileID,'\r\nMinIter in Mean curves:\r\n');
fprintf(fileID,'Problem\toBABC\tPBABC\tDABC\tABCbin\tbinABC\tbitABC\r\n');
for Function_No = problem_start:problem_stop

    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [savePath,featureVal,'Function','-',temp3,'.mat'];
    clear Function;
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);

    o=5;       
    gapoBABC = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%gapoBABC = mean(data(1,:));
    o=6;      
    gapPBABC = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%gapPBABC = mean(data(2,:));
    o=1;   
    gapDABC = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%gapDABC = mean(data(3,:));
    o=2;
    gapABCbin = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%mean(data(4,:));
    o=3;
    gapbinABC = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%mean(data(5,:));
    o=4;
    gapbitABC = findMinIterByGapPercent(mean(Function{Function_No}.Convergence{o}.data,1),Parameters.Optimum,gap);%mean(data(6,:));
    fprintf(fileID,"%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\r\n", ...
        Fun_Name_all{Function_No},gapoBABC,gapPBABC,gapDABC,gapABCbin,gapbinABC,gapbitABC);


%     fprintf(fileID,'\r\n');
end

fclose(fileID);
