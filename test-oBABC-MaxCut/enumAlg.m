function [Best_Obj ,Best_Sol] = enumAlg(Function_Name)
    global Bees FuncEval Parameters
    problem=strcat('text/',Function_Name,'.txt');
    global matris

    matris=dosya2mat(problem);
    CostFunction= @(bees) objective(bees);     % Cost Function
    bee = ones(1,Parameters.D);
    Best_Obj = CostFunction(bee);
    Best_Sol = bee;
    for i = 1:1:(2^Parameters.D-1)
        val = i;
        for j=1:1:Parameters.D
            bee(j) = mod(val,2);
            val = fix(val/2);
        end
        obj_val = CostFunction(bee);
        if obj_val < Best_Obj
            Best_Obj = obj_val;
            Best_Sol = bee;
        end
    end
end