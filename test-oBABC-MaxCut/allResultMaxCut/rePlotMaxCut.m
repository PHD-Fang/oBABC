clc 
close all
clear all

fprintf('Start at %s.\r\n',datetime('now','TimeZone','local','Format','d-MMM-y HH:mm:ss Z'));
featureVal = 'N40-';
savePath = 'Plot/';
dataPath = 'Result/';
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
% algArray = [6,8,1,2,3,4];
NsingleVerionAlg = 5;

for Function_No=problem_start:problem_stop

    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    temp3 = strcat(temp1,'-',num2str(temp2));
    matFileName = [dataPath,featureVal,'Function','-',temp3,'.mat'];
    clear Function;
    load(matFileName);
    Parameters.Optimum = optimum_All(Function_No);

    h = figure();
    o = NsingleVerionAlg + 1;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',2,'color',color{o}); hold on

    for o=1:NsingleVerionAlg-1
        plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',2,'color',color{o});hold on
    end
    o = NsingleVerionAlg;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'LineWidth',2,'color',color{o});hold on

    hold off
    title(Fun_Name_all{Function_No});
    xlabel('Iteration');
    ylabel('Max-Cut');
    legend('PBABC','DABC','ABCbin','binABC','bitABC','oBABC');
    set(gca,'FontSize',24,'Fontname','Times New Roman');
    fileName = [savePath,Fun_Name_all{Function_No},'.fig'];
    savefig(h,fileName);
%     close(h);
end