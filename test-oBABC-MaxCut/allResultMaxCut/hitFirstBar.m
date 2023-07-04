clear;
clc;
close all
figure('position',[150,100,900,550])%确定图片的位置和大小，[x y width height]
%准备数据

%[25.43	33.9	21.27	28.7	16.43	11.53	8.17	8.73;]
% Y = [34.73;39.7;26.13;27.5;19.43;13.77;9.1;10.13;]
% Y = [25.43	33.9	21.27	28.7	16.43	11.53	8.17	8.73];
Y = [111.73 	291.93 	367.17 	464.80 	236.43 	391.10 ];
%     1666.73	1676.3	1676.83	1592.37	1217.8	1568.43	1406.53	1442.57;
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
X=1:size(Y,2);
 %画出4组柱状图，宽度1
h=bar(X,Y);      
 %修改横坐标名称、字体
set(gca,'XTickLabel',{'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'},'FontSize',24,'FontName','Times New Roman');
xtips2 = h(1).XEndPoints;
ytips2 = h(1).YEndPoints;
labels2 = string(h(1).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom','fontname','Times New Roman','FontSize',24)
% 设置柱子颜色,颜色为RGB三原色，每个值在0~1之间即可
% set(h(1),'FaceColor',[30,150,252]/255)     
% set(h(2),'FaceColor',[162,214,249]/255)    
ylim([0,fix(max(Y))+10]);      %y轴刻度
%修改x,y轴标签
ylabel('\fontname{Times New Roman}\fontsize{24}Iterations');
% xlabel('\fontname{Times New Roman}\fontsize{14}不同组'); 
%修改图例
% legend({'\fontname{Times New Roman}DABC', ...
%     '\fontname{Times New Roman}ABCbin', ...
%     '\fontname{Times New Roman}binABC',...
%     '\fontname{Times New Roman}bitABC',...
%     '\fontname{Times New Roman}PBABC',...
%     '\fontname{Times New Roman}OBABC/1',...
%     '\fontname{Times New Roman}OBABC/2',...
%     '\fontname{Times New Roman}OBABC/3'},...
%     'FontSize',16);

