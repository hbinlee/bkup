load('cassini_200.csv')
m=size(cassini_200,1);
Y=zeros(m,1);
for i=1:m
    x=cassini_200(i,1);
    y=get_field_fval(x,cassini_200(:,1),0.2795);
    Y(i)=y;
end

scatter(cassini_200(:,1),Y)
hold on

for i=1:m
    x=cassini_200(i,2);
    y=get_field_fval(x,cassini_200(:,2),0.1);
    Y(i)=y;
end

scatter(cassini_200(:,2),Y)
hold on