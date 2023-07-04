function result = compare(Xi,Xk,Vi)

result = 0;
d = sum(abs(Vi-Xi)) * sum(abs(Vi - Xk));
if d<1
    result = 1;
else
    result = 0;
end

end