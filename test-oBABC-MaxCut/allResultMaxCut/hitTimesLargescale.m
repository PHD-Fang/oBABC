clear;
clc;
close all
figure('position',[150,100,900,550])%确定图片的位置和大小，[x y width height]
%准备数据

Y=[7,5,6,6,5,9;19,20,23,17,15,25;12,13,16,9,8,16;30	30	30	30	30	30;];
X=1:4;
 %画出4组柱状图，宽度1
h=bar(X,Y,1);      
 %修改横坐标名称、字体
set(gca,'XTickLabel',{'Cap131','Cap132','Cap133','Cap134'},'FontSize',24,'FontName','Times New Roman');
% 设置柱子颜色,颜色为RGB三原色，每个值在0~1之间即可
%color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
set(h(1),'FaceColor','r')     
set(h(2),'FaceColor','g')    
set(h(3),'FaceColor','b')   
set(h(4),'FaceColor','c')  
set(h(5),'FaceColor','m') 
set(h(6),'FaceColor','k') 
ylim([0,32]);      %y轴刻度
%修改x,y轴标签
ylabel('\fontname{Times New Roman}\fontsize{24}HitTimes(%)');
% xlabel('\fontname{Times New Roman}\fontsize{14}不同组'); 
%修改图例
legend({'\fontname{Times New Roman}DABC','\fontname{Times New Roman}ABCbin' ...
    ,'\fontname{Times New Roman}binABC','\fontname{Times New Roman}bitABC' ...
    ,'\fontname{Times New Roman}PBABC','\fontname{Times New Roman}oBABC'} ...
    ,'FontSize',20);

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

xtips2 = h(3).XEndPoints;
ytips2 = h(3).YEndPoints;
labels2 = string(h(3).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = h(4).XEndPoints;
ytips2 = h(4).YEndPoints;
labels2 = string(h(4).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = h(5).XEndPoints;
ytips2 = h(5).YEndPoints;
labels2 = string(h(5).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = h(6).XEndPoints;
ytips2 = h(6).YEndPoints;
labels2 = string(h(6).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')