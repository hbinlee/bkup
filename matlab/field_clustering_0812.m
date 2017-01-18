function output = field_clustering_0812(dataset,gamma,tol)
% 0812 version

tic;


[m,n]=size(dataset);

tic;
[min_dist,max_dist]=get_dist_mat(dataset);
toc;


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

beta=1.5;
X=dataset;
g=zeros(m,n);
mark=zeros(m,1);
one=ones(m,1);
zero=zeros(1,n);
count=0;
etmp=zeros(m,1);

% optimization phase
tic;
while true

    count=count+1;
    % get the gradient for all datapoints
    for i=1:m
        if mark(i,:)==1
            continue;
        end
        Xi=X(i,:);
        gi=get_field_gval(Xi,dataset,gamma);
        norm_g=norm(gi);
        
        if norm_g < tol % stop when gradient is close to zero
           gi=zero;
           mark(i,:)=1;
        else
            if norm_g > min_dist(i)
                gi=gi/norm_g; % unit directional vector
            end
        end
        
        g(i,:)=gi;
        
        alpha=min_dist(i)/2;
        xprev=Xi;
        xnext=Xi-alpha*gi;
        fprev=get_field_fval(xprev,dataset,gamma);
        fnext=get_field_fval(xnext,dataset,gamma);
        while fprev >= fnext
            alpha=beta*alpha;
            xprev=xnext;
            xnext=Xi-alpha*gi;
            fprev=get_field_fval(xprev,dataset,gamma);
            fnext=get_field_fval(xnext,dataset,gamma);
        end
        
        etmp(i)=alpha/beta;
    end
    
    if norm(mark-one)==0
        break;
    end
    
    
    % inexact line search
    
    eta=repmat(etmp,1,n);
    
    
    % count for completion percantage
    if rem(count,100)==0
        toc;
        scatter(X(:,1),X(:,2));
        hold on
        per=(size(nonzeros(mark),1)/m)*100;
        fprintf('%d percent done \n',per);
        tic;
    end
    
    X=X-eta.*g;
    
end
toc;

fprintf('done\n');
%labelling phase
[output1,output2,k]=field_label(X,tol_label);
output=output1;
fprintf('cluster number is %d\n',k);

%visualization phase
if n==2
    %scatter(dataset(:,1),dataset(:,2),10,output2,'filled');
end

toc;
end