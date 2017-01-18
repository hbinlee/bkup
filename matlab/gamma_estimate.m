function output = gamma_estimate(dataset)
X=dataset;

dist_mat=pairdist(X,X,1);
dist_mat=real(dist_mat);

d_max=min(max(dist_mat))/(sqrt(2));
d_min=median(min(dist_mat))/sqrt(2);
output=[d_min,d_max];
end