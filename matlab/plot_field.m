function []= plot_field(dataset,gamma)

[m,n]=size(dataset);

tmp=min(dataset,[],1);
xmin=tmp(1);
ymin=tmp(2);
tmp=max(dataset,[],1);
xmax=tmp(1);
ymax=tmp(2);
x=linspace(xmin-1,xmax+1,300);
y=linspace(ymin-1,ymax+1,300);
[X,Y]=meshgrid(x,y);
field=0;
for i=1:m
    field=field-exp(-((X-dataset(i,1)).^2+(Y-dataset(i,2)).^2)/(2*gamma.^2));
end
    
while 1
    mesh(X,Y,field);
    pause;
    scatter(dataset(:,1),dataset(:,2),10);
    pause
end

end