clear;
clc;
close all
figure('position',[150,100,900,550])%确定图片的位置和大小，[x y width height]
%准备数据

ALG = {'DABC','ABCbin','binABC','bitABC','oBABC','PBABC'};
color = {'#77AC30','#22FF33','#7E2F8E','#A39480','#000000','#FF0000','#0000FF','#0072BD','#FF6100','#292421','#6A5ACD','#385E0F'};
% Y=[0,0;0,0.651663142;0.5575,0.56865795;0.75,0.9256534;0.5,0.500224383;0.625,0.818777083;];
Y = [26.87 	54.60 	156.60 	148.70 	100.57 	116.60;
    25.30 	51.87 	153.40 	145.33 	89.20 	112.63;
    24.20 	46.13 	147.93 	129.03 	91.57 	100.37; 
    23.70 	46.47 	166.40 	138.13 	98.60 	98.73;];
X=1:4;
 %画出4组柱状图，宽度1
h=bar(X,Y,1);      
 %修改横坐标名称、字体
set(gca,'XTickLabel',{'Cap131','Cap132','Cap133','Cap134'},'FontSize',24,'FontName','Times New Roman');
% 设置柱子颜色,颜色为RGB三原色，每个值在0~1之间即可
set(h(1),'FaceColor',color{6})     
set(h(2),'FaceColor',color{7})    
set(h(3),'FaceColor',color{1})     
set(h(4),'FaceColor',color{2})    
set(h(5),'FaceColor',color{3})     
set(h(6),'FaceColor',color{8})    
% ylim([0,250]);      %y轴刻度
%修改x,y轴标签
ylabel('\fontname{Times New Roman}\fontsize{24}HitFirst(100)');
% xlabel('\fontname{Times New Roman}\fontsize{14}不同组'); 
%修改图例
legend({'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'},'fontname','Times New Roman','FontSize',20);
