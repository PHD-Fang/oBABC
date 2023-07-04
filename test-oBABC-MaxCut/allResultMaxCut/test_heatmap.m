clc
clear all
close all

cdata = [17	17	18.75	15.5	14.5	20;
    30	30	30	30	30	30;
    16	8	12	13	16	9;
    25	15	19	20	23	17; 
    9	5	7	5	6	6; ];
cdata = cdata;
xvalues = {'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'};%oBABC	PBABC	DABC	ABCbin	binABC	bitABC
yvalues = {'Ave','Cap134','Cap133','Cap132','Cap131'};
h = heatmap(xvalues,yvalues,cdata);

h.Title = 'HitTimes';
h.XLabel = 'Algorithm';
h.YLabel = 'Dataset';

figure()
cdata = [17.25	16	13.5	16.25	14.5	16;
    30	26	30	30	29	30;
    12	11	5	8	7	4;
    22	22	14	21	11	22;
    5	5	5	6	11	8; ];
cdata = cdata;
xvalues = {'oBABC','PBABC','DABC','ABCbin','binABC','bitABC'};%oBABC	PBABC	DABC	ABCbin	binABC	bitABC
yvalues = {'Ave','Cap134','Cap133','Cap132','Cap131'};
h = heatmap(xvalues,yvalues,cdata);

h.Title = 'HitTimes';
h.XLabel = 'Algorithm';
h.YLabel = 'Dataset';