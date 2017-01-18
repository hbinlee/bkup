function output = field_clust_batch(dataset,gamma,tol,eta)
%% anonymous function version
[m,n]=size(dataset);
if ~exist('gamma','var') || ~exist('eta','var')
    tmp=gamma_estimate(dataset);
    if ~exist('gamma','var')
        gamma=tmp(1)
    end
    if ~exist('eta','var')
        eta=tmp(2)
    end
end
if ~exist('tol','var'), tol=0.001; end

X=dataset;
scatter(X(:,1),X(:,2))
hold on
grad=zeros(m,n);
mark=zeros(m,1);
zero=zeros(1,n);
count=0; % for trace
tic;
while true
    count=count+1;
    for i=1:m
        if mark(i,:)==1
            continue;
        end
        Xi=X(i,:);
        Xim=repmat(Xi,m,1);
        tmp=exp(-sum((Xim-dataset).^2,2)./(2*gamma.^2));
        tmp=repmat(tmp,1,n);
        %if mark(i,:)==1
        %    grad(i,:)=zero;
        %else
            grad(i,:)=sum((Xim-dataset).*tmp./(gamma.^2),1);
        %end
        %tmp=norm(grad(i,:));
        if rem(count,1000)==0
            scatter(X(:,1),X(:,2))
            hold on
        end
        if ~mark(i,:)
            if tmp < tol
                grad(i,:)=zeros(1,n);
                mark(i,:)=1;
            end
        end
    end
    M=max(sqrt(sum(grad.^2,2)))
    if M<tol
        break;
    end
    X=X-eta.*grad;
end
toc;
output=X;
scatter(output(:,1),output(:,2))

end