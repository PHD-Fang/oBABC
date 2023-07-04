function fFitness = CalculateFitness(fObjV)
%     fFitness=zeros(size(fObjV));
%     ind=find(fObjV>=0);
%     if not(isempty(ind))
%         fFitness(ind)=1./(fObjV(ind)+1);
%     end
%     ind=find(fObjV<0);
%     if not(isempty(ind))
%         fFitness(ind)=1+abs(fObjV(ind));
%     end
    fFitness = fObjV;
end