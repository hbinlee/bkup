function alpha = btl_search(x,dataset,gamma,tol,d,rho,c)

f=get_field_fval(x,dataset,gamma);
g=get_field_gval(x,dataset,gamma);

if ~exist('d','var'), d=-g; end
if ~exist('rho','var'), rho=0.5; end
if ~exist('c','var'), c=10^-4; end

% row vector implementation

alpha=1;
xprev=x;
xnext=xprev+alpha.*d;
fnext=get_field_fval(xnext,dataset,gamma);

while fnext > f+c*alpha*(g*d')
    alpha=alpha*rho;
    xnext=xprev+alpha.*d;
    fnext=get_field_fval(xnext,dataset,gamma);
end


end