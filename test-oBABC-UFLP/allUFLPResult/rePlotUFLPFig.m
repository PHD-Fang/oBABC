clc 
% close all
clear all

savePath = 'Fig/';
load("N40-UFLP-Function.mat");
% ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
% color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#FF0000','#0072BD','#0000FF','#000000','#FF6100','#292421','#6A5ACD','#385E0F'};
ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#000000','#FF0000','#0000FF','#A39480','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
Fun_Name = {'Cap71','Cap72','Cap73','Cap74','Cap101','Cap102','Cap103','Cap104','Cap131','Cap132','Cap133','Cap134','CapA','CapB','CapC'};
problem_start = 1;
problem_stop = 15;
NsingleVerionAlg = 5;

for Function_No=problem_start:problem_stop
    h = figure();
    o = NsingleVerionAlg + 1;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',2,'color',color{o}); hold on

    for o=1:NsingleVerionAlg-1
        plot(mean(Function{Function_No}.Convergence{o}.data,1),'--','LineWidth',2,'color',color{o});hold on
    end
    o = 5;
    plot(mean(Function{Function_No}.Convergence{o}.data,1),'LineWidth',2,'color',color{o});hold on

    hold off
    title(Fun_Name{Function_No});
    xlabel('Iteration');
    ylabel('Cost');
    legend('PBABC','DABC','ABCbin','binABC','bitABC','oBABC');
    set(gca,'FontSize',24,'Fontname','Times New Roman');
    fileName = [savePath,Fun_Name{Function_No},'.fig'];
    savefig(h,fileName);
%     close(h);
end
