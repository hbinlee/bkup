function grad = field_grad_batch_sub(x,dataset,gamma)
%% anonymous function version
m=size(dataset,1);
n=size(dataset,2);

tic;
X=repmat(x,m,1);
tmp=-sum((X-dataset).^2,2)./(2*gamma.^2);
tmp=repmat(tmp,1,n);
grad=sum((X-dataset).*tmp./(gamma.^2),1);
toc;

end