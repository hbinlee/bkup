function [output] = field_const_sym(dataset,gamma)
%% symbolic function version
if nargin > 3
    error('input arguments must be less than 4');
end

[m,n]=size(dataset);

if ~exist('gamma','var'), gamma=gamma_estimate(dataset); end

X=sym('x',[1 n]);
f=cell(1,m);
for i=1:m
    f{i}=symfunc(-exp(-((X-dataset(i))*(X-dataset(i))')/(2*gamma^2)),X(:));
end

% not complete

output=field;
end