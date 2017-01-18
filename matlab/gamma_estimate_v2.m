function output = gamma_estimate_v2(dataset)

[m,n]=size(dataset);
m_norm=zeros(m,1);
sigma=zeros(n,n);
tic;
for i=1:m
    for j=1:m
        tmp=(dataset(j,:)-dataset(i,:))'*(dataset(j,:)-dataset(i,:));
        sigma=sigma+tmp;
    end
    m_norm(i)=sqrt(norm(sigma));
end
output1=min(m_norm)/m;
output2=max(m_norm)/m;
toc;

output=[output1,output2];

end