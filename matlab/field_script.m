function output = field_script(dataset,n,fname)
% plot a number of cluster which correspond a gamma in esimated interval

if ~exist('n','var'), n=1000; end

tmp=gamma_estimate(dataset);
int_min=tmp(2);
int_max=tmp(3);
fprintf('interval is (%f,%f)\n',int_min,int_max);

X=linspace(int_min,int_max,n);
Y=zeros(1,n);
tic;
tmp=0;
for i=1:n
    fprintf('%d / %d phase done\n',i,n);
    Y(i)=field_clust_module(dataset,X(i)); 
    if Y(i)==1
        tmp=i;
        break;
    end
    if Y(i)==6
        fprintf('if dataset is the music.mat, it may be appropriate gamma\n %f\n',X(i));
    end
end
toc;
if tmp~=0
    for i=tmp:n
        Y(i)=1;
    end
end

plot(X,Y);
print(gcf,sprintf(fname), '-depsc');  
close

output=Y;
end