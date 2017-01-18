function output = field_gradient(field,x,dataset,gamma)
tic;
m=size(dataset,1);
output=(repmat(x,m,1)-dataset).*field(x)./(gamma.^2);
toc;
end