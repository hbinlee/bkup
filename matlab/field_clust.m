function [output] = field_clust(X,dense,g,mode)
%% array approximation version
m=size(X,1); n=size(X,2);
dist=ones(m,m);
min_vec=min(X);
max_vec=max(X);
x_tol=(max_vec(1)-min_vec(1)+2)./(2.*(dense-1));
y_tol=(max_vec(2)-min_vec(2)+2)./(2.*(dense-1));
tol=[x_tol,y_tol];
x1=linspace(min_vec(1)-1,max_vec(1)+1,dense);
y1=linspace(min_vec(2)-1,max_vec(2)+1,dense);
[x,y]=meshgrid(x1,y1);

for i=1:m
    for j=1:m
        dist(i,j)=sqrt((X(i,:)-X(j,:))*(X(i,:)-X(j,:))');
        if dist(i,j)==0
            dist(i,j)=NaN;
        end
    end
end
theta=0.1;

d_min=max(min(dist));
d_max=min(max(dist));

if g==0
    gamma=d_max/(2*sqrt(2*log(2/theta)));
else
    gamma=g;
end
gamma_min=d_min/sqrt(2);
gamma_max=gamma
[gamma_min,gamma_max]
field=0;

for i = 1:m
    field=field-exp(-((x-X(i,1)).^2+(y-X(i,2)).^2)/(2*gamma.^2));
end

[z_max,i_max,z_min,i_min]=extrema2(field)
[I,J]=ind2sub(size(field),i_min');
centroid=[x1(J)',y1(I)']
k=size(centroid,1);
k
%%% gradient descent phase %%%
eta=0.2;
[del_f_x,del_f_y]=gradient(field);
%del_f=[del_f_x,del_f_y];
%del_tmp=del_f(:);

%%% point estimate phase %%%
n_iter=100;
label=zeros(m,1);
descent_tolerance=0.02;
tmp_val=zeros(1,n);
tmp_ind=zeros(1,n);
for p=1:m
    init=X(p,:);
    temp_label=zeros(k,1);
    temp_norm=zeros(k,1);
    %dim=size(X,2); 나중에 n-dim으로 확장할 때 이용
    for j=1:n_iter
        tmp_val(1)=init(1);
        tmp_val(2)=init(2);
        tmp_ind(1)=find(abs(x1-tmp_val(1))<tol(1));
        tmp_ind(2)=find(abs(y1-tmp_val(2))<tol(2)); %tmp_val값이 0이면 문제 발생. 왜?
        % initialize for computation
        tmp=tmp_val(1)-eta.*del_f_x(tmp_ind(1),tmp_ind(2));
        tmp_val(2)=tmp_val(2)-eta.*del_f_y(tmp_ind(1),tmp_ind(2));
        tmp_val(1)=tmp;
        tmp_ind(1)=find(abs(x1-tmp_val(1))<tol(1));
        tmp_ind(2)=find(abs(y1-tmp_val(2))<tol(2));
        % inexact line search
        temp_norm=zeros(k,1);
        for q=1:k
            temp_norm(q)=norm(centroid(q,:)-[x1(tmp_ind(1)),y1(tmp_ind(2))]);
        end
        temp=find(temp_norm==min(temp_norm));
        temp_label(temp)=temp_label(temp)+1;
    end
    label(p)=temp;
end

%%%%%%%%%%%%%%%%%%%%%%%%
k;
tmp=[X,label];

if mode==0
    mesh(x,y,field);
    figure;
    contour(x,y,field);
    figure;
    scatter(tmp(:,1),tmp(:,2),10,tmp(:,3));
end

if mode==1
    fprintf('press any key for next figure, if you want to exit, CTRL+C \n');
    while 1
        mesh(x,y,field);
        pause;
        scatter(tmp(:,1),tmp(:,2),10,tmp(:,3));
        pause
        contour(x,y,field);
        pause
    end
end
        