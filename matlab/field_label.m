function [output1,output2,k] = field_label(result,tol)
m=size(result,1);
label=uniquetol(result,tol,'ByRows',true);
scatter(label(:,1),label(:,2));
hold on
k=size(label,1);
output1=zeros(m,k);
if k<8
    output2=zeros(m,3);
else
    output2=zeros(m,1);
end

for i=1:m
    for j=1:k
        tmp=norm(result(i,:)-label(j,:));
        if tmp<=tol
            output1(i,j)=1;
            if k<8
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
                output2(i,:)=color;
            else
                output2(i)=j;
            end
        end
    end    
end
end