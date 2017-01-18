function [output] = field_const_arr(dataset,gamma,dense)
%% array approximation version
if nargin > 3
    error('input arguments must be less than 4');
end

[m,n]=size(dataset);

if ~exist('gamma','var'), gamma=gamma_estimate(dataset); end
if ~exist('dense','var'), dense=200; end

X=cell(1,n); dom=cell(1,n);
for i=1:n
    X{i}=linspace(min(dataset(:,i))-1,max(dataset(:,i))+1,dense);
end
tic;
[dom{:}]=ndgrid(X{:});
toc;
field=0;
for i=1:m
    tmp=0;
    for j=1:n
        tmp=tmp+(dom{j}-dataset(i,j)).^2;            
    end
    field=field-exp(-tmp/(2*gamma^2));
end

if n==2
    mesh(dom{1},dom{2},field);
end

[z_max,i_max,z_min,i_min]=extrema2(field);
z_min
[I,J]=ind2sub(size(field),i_min');
x=dom{1}; y=dom{2}';
centroid=[x(I)',y(J)']

output=field;
end