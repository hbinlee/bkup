function output = field_clustering_cg(dataset,gamma,tol)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm Implementation with eta estimation
%Optimization was chosen as conjugate gradient method
tic;

[m,n]=size(dataset);
tmp=gamma_estimate(dataset);

%initialization phase
tol_label=tmp(2);

if ~exist('tol','var'), tol=0.001; end
if ~exist('gamma','var')
    gamma=(tmp(2)+tmp(3))/4
else
    if ~(tmp(2)<gamma && tmp(3)>gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end

xprev=zeros(m,n);
xnext=dataset;
gnext=zeros(m,n);
gprev=zeros(m,n);
mark=zeros(m,1);
one=ones(m,1);
zero=zeros(1,n);
etmp=ones(m,1);
count=0;

normal=tmp(4);%field_normalize(dataset,gamma);

% conjugate gradient phase
while (mark-one)'*(mark-one)
    count=count+1;
    % get the gradient for all datapoints
    for i=1:m
        if mark(i,:)==1
            continue;
        end
        Xi=xnext(i,:);
        Xim=repmat(Xi,m,1);
        tmp=exp(-sum((Xim-dataset).^2,2)./(2*gamma.^2));
        tmp=repmat(tmp,1,n);
        gnext(i,:)=sum((Xim-dataset).*tmp./(normal*gamma.^2),1);%(gamma.^2),1);
        tmp=norm(gnext(i,:));
        if ~mark(i,:)
            if tmp < tol
                gnext(i,:)=zero;
                mark(i,:)=1;
            end
        end
    end
    
    p=-H*grad;
    
    
    
    % get a adaptive eta for all datapoints
    for i=1:m
        if mark(i,:)==1
            etmp(i,:)=0;
            continue;
        end
        gtmp=gnext(i,:)-gprev(i,:);
        xtmp=xnext(i,:)-xprev(i,:);
        etmp(i,:)=(gtmp*xtmp')./(gtmp*gtmp');
    end
    eta=abs(repmat(etmp,1,n));
    
    % count for completion percantage
    if rem(count,10)==0
        %scatter(xprev(:,1),xprev(:,2));
        %hold on
        per=size(nonzeros(mark),1)/m;
        fprintf('%d % is done\n',per);
    end
    xprev=xnext;
    gprev=gnext;
    xnext=xprev-eta.*gprev;
end
%labelling phase
[output1,output2,k]=field_label(xprev,tol_label);
output=output1;
fprintf('cluster number is %d\n',k);

%visualization phase
if n==2
    scatter(dataset(:,1),dataset(:,2),10,output2,'filled');
    %scatter(xnext(:,1),xnext(:,2));
end

toc;
end