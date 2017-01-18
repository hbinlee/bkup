function [] = kmeans_script(X,k)
tmp=kmeans(X,k);
m=size(tmp,1);
out=zeros(m,3);
for i=1:m
    j=tmp(i,:);
        switch j
                    case 1
                        color=[0 0 1];
                    case 2
                        color=[1 0 0];
                    case 3
                        color=[0 1 0];
                    case 4
                        color=[0 0 0];
                    case 5
                        color=[0 1 1];
                    case 6
                        color=[1 0 1];
                    case 7
                        color=[1 1 0];
        end
        out(i,:)=color;
end
scatter(X(:,1),X(:,2),10,out);
end