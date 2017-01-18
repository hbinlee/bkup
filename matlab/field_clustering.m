function [o1,o2] = field_clustering(dataset,gamma,tol,eta)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm Implementation
tic;

[m,n]=size(dataset);
tmp=gamma_estimate(dataset);

%initialization phase
%tol_label=tmp(2);
tol_label=0.01;

if ~exist('tol','var'), tol=0.001; end
if ~exist('gamma','var')
    gamma=(tmp(2)+tmp(3))/4
else
    if ~(tmp(2)<gamma && tmp(3)>gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end
if ~exist('eta','var'), eta=gamma; end

X=dataset;
%X=zscore(X);
grad=zeros(m,n);
mark=zeros(m,1);
zero=zeros(1,n);
one=ones(m,1);

normal=field_normalize(dataset,gamma);
count=0;
% gradient descent phase
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
        grad(i,:)=sum((Xim-dataset).*tmp./(normal*gamma.^2),1);
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
    if rem(count,100)==0
        per=10000*size(nonzeros(mark),1)/m;
        per=round(per);
        per=per/100;
        fprintf('%d percent done\n', per);
    end
end
o1=X;
%labelling phase
[output1,output2,k]=field_label(X,tol_label);
o2=output1;
fprintf('cluster number is %d\n',k);

%visualization phase
if n==2
    scatter(dataset(:,1),dataset(:,2),10,output2,'filled');
end

%tp=kmeans(X,4)
%scatter(dataset(:,1),dataset(:,2),10,tp)

hold on
tmp=zeros(m,n);
cent=zeros(k,n);
for i=1:k
    for j=1:n
        tmp(:,j)=dataset(:,j).*output1(:,i);
    end
    t=nnz(tmp)/2;
    cent(i,:)=sum(tmp)/t;
end

scatter(cent(:,1),cent(:,2),'r');
%output1

toc;
end