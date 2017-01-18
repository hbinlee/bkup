function output = gamma_estimate_v3(dataset)
m=size(dataset,1);
mean_vec=sum(dataset,1)/m;
tmp=repmat(mean_vec,m,1);
tmp=tmp-dataset;
tmp=tmp.^2;
tmp=sum(tmp,2);
[minimum,index]=min(tmp);


dist_mat=pairdist(dataset,dataset,1);

lb=min(min(dist_mat))/2;
for i=1:m
    dist_mat(i,i)=0;
end
tmp=dist_mat(index,:);
tmp=sum(tmp,2);
ub=2*tmp/m;
output=[lb,ub];
end