function gvec = get_field_gvec(datapoint,dataset,gamma)
% column vector
x=datapoint';
[m,n]=size(dataset);

X=repmat(x,m,1);
tmp=exp(-sum((X-dataset).^2,2)./(2*gamma.^2));
tmp=repmat(tmp,1,n);
gvec=sum((X-dataset).*tmp./(gamma.^2),1)';

end