function name = getMaxCutName(Function_No)
    Fun_Name = {'pw01_100','pw05_100','pw09_100'};
    class = floor((Function_No-1)/10)+1;
    temp1 = replace(Fun_Name{class},'_','-');
    temp2 = mod(Function_No-1,10);
    Fun_Name_all{Function_No} = strcat(temp1,'.',num2str(temp2));

end