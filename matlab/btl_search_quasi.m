function alpha = btl_search_quasi(x,dataset,gamma,p,rho)

f=get_field_fval(x',dataset,gamma);
g=get_field_gvec(x,dataset,gamma);

if ~exist('rho','var'), rho=0.99; end
c1=10^-4;
c2=0.9;


% column vector implementation

alpha=1;
xprev=x;
xnext=xprev+alpha.*p;
fnext=get_field_fval(xnext',dataset,gamma);
gnext=get_field_gvec(xnext,dataset,gamma);
norm_g=norm(gnext);

while fnext > f+c1*alpha*(g'*p) %|| abs(gnext'*p) > c2*abs(g'*p) % abs(gnext'*p) > gamma
    %if alpha*rho <= eps
    %    alpha
    %    break;
    %end
    alpha=alpha*rho;
    xnext=xprev+alpha.*p;
    fnext=get_field_fval(xnext',dataset,gamma);
    gnext=get_field_gvec(xnext,dataset,gamma);
    norm_g=norm(gnext);
end

end