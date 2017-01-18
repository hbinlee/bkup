function gval = get_field_gval(datapoint,dataset,gamma)

[m,n]=size(dataset);

X=repmat(datapoint,m,1);
tmp=exp(-sum((X-dataset).^2,2)./(2*gamma.^2));
tmp=repmat(tmp,1,n);
gval=sum((X-dataset).*tmp./(gamma.^2),1);

end