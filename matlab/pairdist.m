function output = pairdist(X,Y,mode)

if size(X,2)~=size(Y,2)
    error('X and Y must have a same dimension!\n');
end

n=size(X,2); mx=size(X,1); my=size(Y,1);
tmpX=zeros(mx,3*n); tmpY=zeros(my,3*n);

for i=1:n
    tmpX(:,(3*i-2):(3*i)) = [ones(mx,1),-2*X(:,i), X(:,i).^2];
    tmpY(:,(3*i-2):(3*i)) = [Y(:,i).^2, Y(:,i), ones(my,1)];
end

output=tmpX*tmpY';

if exist('mode','var')
    if mode==1
        for i=1:mx
            output(i,i)=NaN;
        end
    end
end

output=sqrt(output);
end