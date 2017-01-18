function output = gamma_estimate_v4(dataset)
m=size(dataset,1);
mean_vec=sum(dataset,1)/m;
tmp=dataset.^2;
tmp=sum(sum(tmp));
output=2*(tmp/m - sum(mean_vec.^2));

end