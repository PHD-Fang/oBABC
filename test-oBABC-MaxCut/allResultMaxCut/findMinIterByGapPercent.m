function minIter = findMinIterByGap(data,optimum,gap)

minIter = length(data) + 1;
err = 1-abs(data-optimum)/optimum;
for i =1:length(data)
    if(err(i)>=gap)
        minIter = i;
        break;
    end
end

end