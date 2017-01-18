function fval = get_field_fval(datapoint,dataset,gamma)

m=size(dataset,1);

X=repmat(datapoint,m,1);
fval=exp(-sum((X-dataset).^2,2)./(2*gamma.^2));
fval=-sum(fval);

end