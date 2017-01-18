function output = field_normalize(dataset,gamma)

m=size(dataset,1);
tmp=zeros(m,1);
for i=1:m
    Xi=dataset(i,:);
    Xim=repmat(Xi,m,1);
    tmp(i)=sum(exp(-sum((Xim-dataset).^2,2)./(2*gamma.^2)));
end
output=max(tmp);
end