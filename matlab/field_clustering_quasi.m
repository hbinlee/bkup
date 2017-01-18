function output = field_clustering_quasi(dataset,gamma,tol)
%Written by Hanbin Lee (mafp12@skku.edu)
%Field Clustering Algorithm Implementation with eta estimation
%Optimization was chosen as quasi-newton method (BFGS)
tic;

[m,n]=size(dataset);
tmp=gamma_estimate(dataset);

%initialization phase
tol_label=tmp(2)

if ~exist('tol','var'), tol=0.001; end
if ~exist('gamma','var')
    gamma=(tmp(2)+tmp(3))/4
else
    if ~(tmp(2)<gamma && tmp(3)>gamma)
        fprintf('gamma is not in valid interval. Therefore, result may not be valid\n');
    end
end


H=eye(n); % H0=I\
B=eye(n);
alpha=zeros(m,1);
X=dataset';

% optimization phase

%% BFGS, H ver

for i=1:m
    x=X(:,i);
    p=-get_field_gvec(x,dataset,gamma); % p0=-H*g0
    norm_g=norm(p);
    while norm_g>tol
        tmp=get_field_gvec(x,dataset,gamma); %gk
        p=-H*tmp; %pk=-H*gk
        alpha(i)=btl_search_quasi(x,dataset,gamma,p); % backtracking line search
        s=alpha(i)*p; % sk=ak*pk
        x=x+s; % xk+1 = xk + ak*pk = xk+sk
        g=get_field_gvec(x,dataset,gamma);
        y=g-tmp; % yk=gk+1 - gk
        rho=y'*s % rk = sk^T * yk (inner product)
        if isnan(rho)
            break;
        end
        H=(eye(n)-(s*y'/rho))*H*(eye(n)-(y*s'/rho))+(s*s'/rho); % BFGS
        norm_g=norm(g);
    end
    X(:,i)=x;
end

%% BFGS, B ver

% for i=1:m
%     x=X(:,i);
%     p=-get_field_gvec(x,dataset,gamma); % p0=-H*g0
%     norm_g=norm(p);
%     while norm_g>tol
%         tmp=get_field_gvec(x,dataset,gamma); %gk
%         p=-B\tmp %pk=-H*gk
%         alpha(i)=btl_search_quasi(x,dataset,gamma,p); % backtracking line search
%         s=alpha(i)*p; % sk=ak*pk
%         x=x+s; % xk+1 = xk + ak*pk = xk+sk
%         g=get_field_gvec(x,dataset,gamma);
%         y=g-tmp; % yk=gk+1 - gk
%         rho=y'*s; % rk = sk^T * yk (inner product)
%         B=B+(y*y'/rho)-(B*(s*s')*B)/(s'*B*s); % BFGS
%         norm_g=norm(g);
%     end
%     X(:,i)=x;
% end


X;


toc;
end