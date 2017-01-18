function [min_dist,max_dist] = get_dist_mat(dataset)
X=dataset;
[m,n]=size(X);

tmpX=zeros(m,3*n); tmpY=zeros(m,3*n);

for i=1:n
    tmpX(:,(3*i-2):(3*i)) = [ones(m,1),-2*X(:,i), X(:,i).^2];
    tmpY(:,(3*i-2):(3*i)) = [X(:,i).^2, X(:,i), ones(m,1)];
end

dist_mat=tmpX*tmpY';

for i=1:m
    dist_mat(i,i)=NaN;
end

dist_mat=sqrt(dist_mat);
min_dist=min(dist_mat)';
max_dist=max(dist_mat)';


end