function output = field_clust_module(dataset,gamma,tol, eta)
%% field_clustering
[m,n]=size(dataset);

tmp=gamma_estimate(dataset);
tol_label=0.001;


if ~exist('tol','var'), tol=0.0001; end
if ~exist('gamma','var')
    gamma=tmp(2);
else
    if ~(tmp(2)<=gamma && tmp(3)>=gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end
if ~exist('eta','var'), eta=tmp(2); end

X=dataset;
grad=zeros(m,n);
mark=zeros(m,1);
zero=zeros(1,n);
one=ones(m,1);
tic;
normal=field_normalize(dataset,gamma);

% gradient descent phase
count=0;
while count<50000
    count=count+1;
    for i=1:m
         if mark(i,:)==1
             continue;
         end
        Xi=X(i,:);
        Xim=repmat(Xi,m,1);
        tmp=exp(-sum((Xim-dataset).^2,2)./(2*gamma.^2));
        tmp=repmat(tmp,1,n);
        if mark(i,:)==1
           grad(i,:)=zero;
        else
            grad(i,:)=sum((Xim-dataset).*tmp./(normal*gamma.^2),1);
        end
        tmp=norm(grad(i,:));
        if ~mark(i,:)
            if tmp < tol
                grad(i,:)=zeros(1,n);
                mark(i,:)=1;
            end
        end
    end
    if norm(mark-one)==0
        break;
    end
    X=X-eta.*grad;
end
toc;
[output1,output2,k]=field_label(X,tol_label);
output=k;
end