function [field,grad] = field_const_fh(dataset,gamma)
%% anonymous function version
m=size(dataset,1);

f=cell(1,m);
g=cell(m,1);
tic;
for i=1:m
    f{i}=@(x)(-exp(-(sum((x-dataset(i,:)).^2))/(2*gamma.^2)));
    g{i}=@(x)((x-dataset(i,:)).*f{i}(x)./(gamma.^2));
end
toc;
field=@(x)sum(cellfun(@(y) y(x), f));
grad=@(x)(cellfun(@(y) y(x), g,'UniformOutput',0));

end