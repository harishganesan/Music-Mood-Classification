function confMat=myconfusionmat(v,pv)

yu=unique(v);
confMat=zeros(length(yu));
for i=1:length(yu)
    for j=1:length(yu)
        confMat(i,j)=sum(v==yu(i) & pv==yu(j));
    end
end