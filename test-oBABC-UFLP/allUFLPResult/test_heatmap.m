clc
clear all
% close all

cdata = [20.25	14.25	14.5	16.75	16.5	15.75;
    30	30	30	30	30	30;
    13	4	9	12	13	7;
    25	19	16	17	18	21; 
    13	4	3	8	5	5; ];
cdata = cdata;
xvalues = {'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'};%oBABC	PBABC	DABC	ABCbin	binABC	bitABC
yvalues = {'Ave','Cap134','Cap133','Cap132','Cap131'};
h = heatmap(xvalues,yvalues,cdata);

h.Title = 'Average HitTimes(100)';