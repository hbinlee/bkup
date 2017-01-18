function output=field_function(x,dataset,gamma)


m=size(dataset,1);
G=gamma.^2;
tmp_val=zeros(m,1);

for i=1:m
    tmp=dataset(i,:);
    tmp=repmat(tmp,m,1);
    tmp=(tmp-dataset).^2;
    tmp=-sum(tmp,2)./G;
    tmp=exp(tmp);
    tmp=sum(tmp,1);
    tmp_val(i)=tmp;
end

[maxval,Mi]=max(tmp_val)
[minval,mi]=min(tmp_val)

X=repmat(x,m,1);
tmp=(X-dataset).^2;
tmp=-sum(tmp,2)./G;
tmp=exp(tmp);

output=sum(tmp,1);

end