function [c,p,vi] = pAStigmergic(Xi,transMatrix)
    global Bees Parameters
    p = randperm(Parameters.D,Parameters.dim);
    c = zeros(1,Parameters.dim);

    vi = Bees(Xi).Solution;
    DSP = 0.5;
    for k = 1:Parameters.dim
        if rand < DSP
            if rand < transMatrix(1,p(k))
                vi(p(k)) = 0;
            else
                vi(p(k)) = 1;
            end
        end

        if vi(p(k)) == Bees(Xi).Solution(p(k))
            c(k) = 0;
        elseif (Bees(Xi).Solution(p(k)) - vi(p(k))) == 1
            c(k) = 1;
        else
            c(k) = 2;
        end

    end
%     if(sum(vi)<1)
%         vi = GenerateRandomSolution(Parameters.D);
%         fprintf("pAStigmergic all 0.");
%     end
end