function output = field_grad(grad,point)
tmp=grad(point);
output = sum(cell2mat(tmp));
end