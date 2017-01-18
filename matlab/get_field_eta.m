function eta = get_field_eta(datapoint,dataset,i)

m=size(dataset,1);

X=repmat(datapoint,m,1);
tmp=sum((X-dataset).^2,2);
tmp(i)=NaN;
tmp=min(tmp);
eta=sqrt(tmp);

end