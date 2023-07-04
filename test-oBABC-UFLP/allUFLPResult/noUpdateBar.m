clear;
clc;
close all
figure('position',[150,100,900,550])%确定图片的位置和大小，[x y width height]
%准备数据

Y=[0,0;0,0.651663142;0.5575,0.56865795;0.75,0.9256534;0.5,0.500224383;0.625,0.818777083;];
X=1:6;
 %画出4组柱状图，宽度1
h=bar(X,Y,1);      
 %修改横坐标名称、字体
set(gca,'XTickLabel',{'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'},'FontSize',24,'FontName','Times New Roman');
% 设置柱子颜色,颜色为RGB三原色，每个值在0~1之间即可
set(h(1),'FaceColor',[30,150,252]/255)     
set(h(2),'FaceColor',[162,214,249]/255)    
ylim([0,1]);      %y轴刻度
%修改x,y轴标签
ylabel('\fontname{Times New Roman}\fontsize{24}IUR(%)');
% xlabel('\fontname{Times New Roman}\fontsize{14}不同组'); 
%修改图例
legend({'\fontname{Times New Roman}Theoretical Estimation','\fontname{Times New Roman}Experimental Result'},'FontSize',20);

xtips2 = h(1).XEndPoints;
ytips2 = h(1).YEndPoints;
labels2 = string(h(1).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = h(2).XEndPoints;
ytips2 = h(2).YEndPoints;
labels2 = string(h(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
