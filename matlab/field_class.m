function output = field_class(dataset,gamma, field, grad, eta, tol_conv, tol_cent)
m=size(dataset,1);
centroid=[];
ground_C=zeros(m,1);

for i=1:m
    tic;
    tmp=dataset(i,:);
    tmp_grad=field_grad(grad,tmp);
    while norm(tmp_grad) > tol_conv
        tmp=tmp-eta*tmp_grad;
        tmp_grad=field_grad(grad,tmp);
    end
    if size(centroid,1)==0
        centroid=[tmp];
        ground_C(i)=1;
    else
        k=size(centroid,1);
        tmp_mat=repmat(tmp,k,1);
        tmp_clust=sum(sqrt((centroid-tmp_mat).^2),2);
        [M,I]=min(tmp_clust);
        if M<tol_cent
            ground_C(i)=I;
            %data is i-th cluster
        else
            centroid=[centroid;tmp];
            k=k+1;
            ground_C(i)=k;
        end
    end
    toc;
end
output=cell(1,2);
output{1}=centroid; output{2}=ground_C;
end