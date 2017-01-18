function output = field_clustering_for(dataset,gamma,tol)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm, steepest descent adopted.
%parfor, statistics and machine learning toolbox

tic;

[m,n]=size(dataset);

[min_dist,max_dist]=get_dist_mat(dataset);

%scatter(dataset(:,1),dataset(:,2))
%hold on

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

X=zeros(m,n);
for i=1:m
    x=dataset(i,:);
    g=get_field_gval(x,dataset,gamma);
    norm_g=norm(g);
    while norm_g>tol
        alpha=btl_search(x,dataset,gamma);
        x=x-alpha*g;
        g=get_field_gval(x,dataset,gamma);
        norm_g=norm(g)
    end
    X(i,:)=x;    
end
X;
scatter(X(:,1),X(:,2));
hold on
[output1,output2,k]=field_label_tmp(X,tol_label);
output=output1;
fprintf('cluster number is %d\n',k);

%visualization phase
if n==2
    scatter(dataset(:,1),dataset(:,2),10,output2,'filled');
end

toc;
end