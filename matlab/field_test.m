function output = field_test(dataset,gamma,eta,tol)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm Implementation
tic;

[m,n]=size(dataset);
tmp=gamma_estimate(dataset);

%initialization phase
tol_label=tmp(2);

if ~exist('tol','var'), tol=0.0001; end
if ~exist('gamma','var')
    gamma=(tmp(2)+tmp(3))/4
else
    if ~(tmp(2)<gamma && tmp(3)>gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end
if ~exist('eta','var'), eta=gamma; end

X=dataset;
grad=zeros(m,n);
mark=zeros(m,1);
zero=zeros(1,n);
one=ones(m,1);

normal=field_normalize(dataset,gamma);

% gradient descent phase
while true
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

%labelling phase
[output1,output2,k]=field_label(X,tol_label);
output=output1;
fprintf('cluster number is %d\n',k);

%visualization phase
if n==2
    scatter(dataset(:,1),dataset(:,2),10,output2,'filled');
end

toc;
end