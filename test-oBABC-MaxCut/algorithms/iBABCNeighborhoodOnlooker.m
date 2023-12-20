%Dissimilarity, Privacy-preserving in association rule mining using an 
%improved discrete binary artificial bee colony
function Vi = iBABCNeighborhoodOnlooker(Xi,Xk)
global Bees Parameters

SN = Parameters.N/2;
disVal = 2;
for i=1:1:SN
    if i == Xi
        continue;
    end
    rSol = Bees(i).Solution;
    M11 = sum((Bees(Xi).Solution==1) & (rSol==1));
    M01 = sum((Bees(Xi).Solution==0) & (rSol==1));
    M10 = sum((Bees(Xi).Solution==1) & (rSol==0));
    DisXii = 1 - M11/(M01+M10+M11);
    if DisXii < disVal
        disVal = DisXii;
        Xn = rSol;
    end
end

rSol = Xn;

M11 = sum((Bees(Xi).Solution==1) & (rSol==1));
M01 = sum((Bees(Xi).Solution==0) & (rSol==1));
M10 = sum((Bees(Xi).Solution==1) & (rSol==0));
Similarity = M11/(M01+M10+M11);
DisXik = 1 - Similarity;
omega = rand() * DisXik;
n1 = sum(Bees(Xi).Solution);
n0 = size(Bees(Xi).Solution,2) - n1;
minVal = 1;
bestM = [M11,M01,M10];
for i = 0:1:n1
    M11 = i;
    M01 = n1 - i;
    for j = 0:1:n0
        M10 = j;
        temp = abs(1 - M11/(M01+M10+M11) -omega);
        if temp<minVal
            minVal = temp;
            bestM = [M11,M01,M10];
        end
    end
end

[GlobalBestCost,indx] = max([Bees.Fitness]);
Xbest = Bees(indx).Solution;

Vi = Bees(Xi).Solution & rSol;
M11 = bestM(1);
Vin1 = sum(Vi);
if Vin1 > M11
    indx1 = find(Vi == 1);
    indx2 = randperm(Vin1);
    Vi = zeros(size(rSol));
    for i = 1:1:M11
        indx = indx1(indx2(i));
        Vi(indx) = 1;
    end
elseif Vin1 < M11
    Vt = (Bees(Xi).Solution & Xbest) & (~Vi);
    Vtn1 = sum(Vt);
    if Vtn1 >= (M11-Vin1)
        indx1 = find(Vt == 1);
        indx2 = randperm(Vtn1);
        for i = 1:1:(M11-Vin1)
            indx = indx1(indx2(i));
            Vi(indx) = 1;
        end
    else
        Vi = Vi | Vt;
    end

    Vin1 = sum(Vi);
    if Vin1<M11
        Vt = (Bees(Xi).Solution) & (~Vi);
        Vtn1 = sum(Vt);
        indx1 = find(Vt == 1);
        indx2 = randperm(Vtn1);
        for i = 1:1:(M11-Vin1)
            indx = indx1(indx2(i));
            Vi(indx) = 1;
        end
    end
    if(sum(Vi)<M11)
        error("iBABC err.")
    end
end

M10 = bestM(3);
temp = find(Bees(Xi).Solution==0);
indx = randperm(n0);
for i =1:1:M10
    Vi(temp(indx(i))) = 1;
end

% if(sum(Vi)<1)
%     Vi = GenerateRandomSolution(Parameters.D);
%     fprintf("oBABC2Neighborhood all 0.");
% end

end
