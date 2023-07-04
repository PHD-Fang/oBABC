function matris = dosya2mat(problem)
%     display(problem)
    data = readlines(problem);
    
    indx = 1;
    temp = strsplit(strip(data(1)),' ');
    numOfFactories = str2num(temp(1)); %num Of Factories
    numOfCustomers = str2num(temp(2)); %num Of Customers
    fixCost = zeros(1,numOfFactories);
    capacity = zeros(1,numOfFactories);
    demands = zeros(1,numOfCustomers);
    costAlloc = zeros(numOfCustomers,numOfFactories);
    indx = indx + 1;
    
    for n = 1:1:numOfFactories
        temp = strsplit(strip(data(indx)),' ');
        indx = indx + 1;
    
        if temp(1) ~= 'capacity'
            capacity(n) = str2num(temp(1));
        end
        fixCost(n) = str2double(temp(2));
    end

    n = 1; %customers 
    for n = 1:1:numOfCustomers
        demands(n) = str2num(data(indx));
        indx = indx + 1;

        count = 1;
        while count <= numOfFactories
            temp = str2double(strsplit(strip(data(indx)),' '));
            indx = indx + 1;
            num = size(temp,2);
            costAlloc(n,count:count+num-1) = temp;
            count = count+num;
        end
    end

    matris.numOfCustomers = numOfCustomers;
    matris.numOfFactories = numOfFactories;
    matris.capacity = capacity;
    matris.fixCost = fixCost;
    matris.demands = demands;
    matris.costAlloc = costAlloc;
end