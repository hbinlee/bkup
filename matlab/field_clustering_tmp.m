function output = field_clustering_tmp(dataset,gamma,tol)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm, steepest descent adopted.

tic;

[m,n]=size(dataset);

[min_dist,max_dist]=get_dist_mat(dataset);



tmp=gamma_estimate(dataset);

%initialization phase
tol_label=min(min_dist);

if ~exist('tol','var'), tol=10^-4; end
if ~exist('gamma','var')
    gamma=(median(min_dist)+min(max_dist))/(4*sqrt(2))
else
    if ~(tmp(2)<gamma && tmp(3)>gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end

xprev=zeros(m,n);
xnext=dataset;
gnext=zeros(m,n);
fnext=zeros(m,1);
mark=zeros(m,1);
one=ones(m,1);
zero=zeros(1,n);
etmp=ones(m,1);
count=0;

%normal=tmp(4);%field_normalize(dataset,gamma);

% optimization phase
while true
    count=count+1;
    % get the gradient for all datapoints
    for i=1:m
        if mark(i,:)==1
            continue;
        end
        %fprintf('%d \n', i);
        Xi=xnext(i,:);
        fnext(i,:)=get_field_fval(Xi,dataset,gamma);
        gnext(i,:)=get_field_gval(Xi,dataset,gamma);%(gamma.^2),1);
        gnext(i,:);
        tmp=norm(gnext(i,:));
        if ~mark(i,:)
            if tmp < tol
                gnext(i,:)=zero;
                mark(i,:)=1;
            end
        end
    end
    if norm(mark-one)==0
        break;
    end
    
    
    % inexact line search
    for i=1:m
        if mark(i,:)==1
            etmp(i,:)=0;
            continue;
        end
        %gtmp=gnext(i,:)-gprev(i,:);
        %xtmp=xnext(i,:)-xprev(i,:);
        
        % backtracking line search
        etmp(i,:)=btl_search(xnext(i,:),dataset,gamma,gamma);
        
        %etmp(i,:)=min_dist(i,:)/(2*norm(gnext(i,:)));
    end
    eta=repmat(etmp,1,n);
    
    % count for completion percantage
    if rem(count,100)==0
        %scatter(xprev(:,1),xprev(:,2));
        %hold on
        per=(size(nonzeros(mark),1)/m)*100;
        fprintf('%d percent done \n',per);
    end
    xprev=xnext;
    gprev=gnext;
    xnext=xprev-eta.*gprev;
end
fprintf('done\n');
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